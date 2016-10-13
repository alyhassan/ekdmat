using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Khadmatcom.Services;
using Khadmatcom.Services.Services;

namespace Khadmatcom
{
    public abstract class PageBase : System.Web.UI.Page
    {
        protected const string DATE_FORMAT = "dd-MM-yyyy";
        protected string languageIso = "ar";
        protected string EncrputionKey = "password";
        protected Khadmatcom.Data.Model.User CurrentUser;

        public PageBase()
        {
            this.EnableViewState = false;

            UserServices userServices = new UserServices();
            MembershipUser membershipUser = Membership.GetUser();
            var providerUserKey = membershipUser?.ProviderUserKey;
            if (providerUserKey != null)
                CurrentUser = userServices.GetUser((Guid)providerUserKey);

        }

        public string FrontEndPhysicalPath
        {
            get
            {
                return WebConfigurationManager.AppSettings["FrontEndPhysicalPath"];
            }
        }

        public string DomainName
        {
            get { return string.Format("http://{0}/", Request.Url.Authority); }
        }

        public string GetAnswer(string value)
        {
            string answer = value.Trim().ToLower();
            switch (answer)
            {
                case "true":
                    answer = "نعم";
                    break;
                case "false":
                    answer = "لا";
                    break;
                default:
                    answer = value;
                    break;
            }
            return answer;
        }
        public int LanguageId
        {
            get
            {
                return Thread.CurrentThread.CurrentUICulture.LCID;
            }
        }

        protected override void OnLoad(EventArgs e)
        {
            //check if notifier parameters is passed in query string
            CheckNotifierParameters();

            // continue page loading pipeline
            base.OnLoad(e);
        }

        protected override void InitializeCulture()
        {
            // uncomment the following code to set culture 
            string domain = Request.Url.GetComponents(UriComponents.Path, UriFormat.SafeUnescaped);
            string language;
            string[] fragments = domain.Split(new char[] { '/' });
            string culture = "ar-SA";
            int fragmentIndex = 0;
            if (Request.RawUrl.Contains("/www"))
                fragmentIndex = 1;
            if (Request.IsLocal)
                language = fragments.ToList()[fragmentIndex];
            else
                language = fragments.First();

            switch (language)
            {
                case "ar":
                    culture = "ar-SA";
                    languageIso = "ar";
                    break;
                case "en":
                    culture = "en-GB";
                    languageIso = "en";
                    break;
                default:
                    culture = "ar-SA";
                    languageIso = "ar";
                    break;
            }

            Page.Culture = Page.UICulture = culture;
            Page.LCID = new CultureInfo(culture).LCID;
            Thread.CurrentThread.CurrentCulture = new CultureInfo(culture);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            Response.Cookies["SelectedCulture"].Value = culture;
            Response.Cookies["SelectedCulture"].Expires = DateTime.Today.AddYears(1);
            base.InitializeCulture();
        }

        protected string GetLocalizedUrl(string path)
        {
            if (path.StartsWith("~/"))
                path = path.Replace("~/", "");
            try
            {
                string prefix = (Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName == "ar" ? string.Empty : Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName);
                if (path.Contains('/'))
                {
                    string url = "~/" + prefix + "/";
                    url += path;
                    return ResolveUrl(url);
                }
                return ResolveUrl($"~/{prefix}/{path}");

            }
            catch
            {
                // return the same path untranslated if no resources found
                return path;
            }
        }

        protected string ToJson<T>(T obejctToSerialize)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(obejctToSerialize);
        }

        /// <summary>
        /// check if notifier parameters is passed in query string and display notification message accordingly
        /// </summary>
        private void CheckNotifierParameters()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["msg"]))
            {
                string message = Request.QueryString["msg"];
                NotificationType notificationType = NotificationType.Success;
                if (Request.QueryString["msgtype"] != null)
                {
                    Enum.TryParse<NotificationType>(Request.QueryString["msgtype"], out notificationType);
                }
                string title = Request.QueryString["msgtitle"] ?? string.Empty;
                Notify(message, title, notificationType);
            }
        }

        public void Notify(string message, string title = "", NotificationType notificationType = NotificationType.Success)
        {
            ((MasterBase)Master).ShowNotifier(message, title, notificationType);
        }

        #region Routing and Redirection Methods

        protected bool TryGetRouteParameter(string name, out int? parameterValue)
        {
            if (!Page.RouteData.Values.ContainsKey(name))
            {
                parameterValue = null;
                return false;
            }

            int parsedValue;
            if (int.TryParse(Page.RouteData.Values[name].ToString(), out parsedValue))
            {
                parameterValue = parsedValue;
                return true;
            }
            parameterValue = null;
            return false;
        }

        protected bool TryGetRouteParameter(string name, out string parameterValue)
        {
            if (!Page.RouteData.Values.ContainsKey(name))
            {
                parameterValue = null;
                return false;
            }
            parameterValue = Page.RouteData.Values[name].ToString();
            return true;
        }

        /// <summary>
        /// Redirects to another page and carries over all current 
        /// query string keys and values
        /// </summary>
        /// <param name="url"></param>
        protected void RedirectToPageWithQueryStrings(string url, bool endResponse = false)
        {
            string queryStringList = string.Empty;

            if (!string.IsNullOrEmpty(queryStringList))
            {
                // rebuild the query string list
                for (int i = 0; i < Request.QueryString.Count; i++)
                {
                    queryStringList += string.Format("{0}={1}&",
                        Request.QueryString.GetKey(i), Request.QueryString.Get(i));
                }

                // remove the erroneous ampersand
                queryStringList = queryStringList.TrimEnd(new char[] { '&' });

                // append the '?' to the beginning
                if (!string.IsNullOrEmpty(queryStringList))
                {
                    url = "?" + queryStringList;
                }

                Response.Redirect(url, endResponse);
            }
        }


        /// <summary>
        /// Redirect to a new page and append Notifier.ascx control parameters to query string
        /// Target page load event will parse those parameters and display the notification
        /// </summary>
        /// <param name="redirectUrl">Target Page</param>
        /// <param name="message">Notifier Message</param>
        /// <param name="title">Notifier Title (optional)</param>
        /// <param name="notificationType">Notification Type (Default is "Success")</param>
        protected void RedirectAndNotify(string redirectUrl, string message,
            string title = "", NotificationType notificationType = NotificationType.Success)
        {
            StringBuilder sb = new StringBuilder(redirectUrl);
            sb.AppendFormat("?msg={0}", HttpUtility.UrlEncode(message));
            if (!string.IsNullOrEmpty(title))
            {
                sb.AppendFormat("&msgtitle={0}", HttpUtility.UrlEncode(title));
            }
            sb.AppendFormat("&msgtype={0}", (int)notificationType);
            Response.Redirect(sb.ToString(), true);
        }

        #endregion


        #region Cache Methods

        /// <summary>
        /// Returns an item from the application cache
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        protected object GetCachedItem(string key)
        {
            object returnValue = null;

            try
            {
                returnValue = Cache.Get(key);
            }
            catch { }

            return returnValue;
        }

        /// <summary>
        /// Adds in item to the application cache
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        /// <param name="minutes"></param>
        protected void SetCachedItem(string key, object value, int minutes)
        {
            try
            {
                Cache.Insert(key, value, null,
                    DateTime.Now.AddMinutes(minutes), TimeSpan.Zero);
            }
            catch { }
        }

        /// <summary>
        /// Clears an item from the application cache
        /// </summary>
        /// <param name="key"></param>
        protected void ClearCachedItem(string key)
        {
            try
            {
                Cache.Remove(key);
            }
            catch { }
        }

        #endregion

        #region Error Logging

        #endregion

        protected void PageNotFound()
        {
            Response.Redirect("~/error/404.html");
        }

        protected void AccessDenied()
        {
            Response.Redirect("~/error/403.html");

        }


        /// <summary>
        /// Try to set a drop down list selected item using query string key name
        /// </summary>
        /// <param name="listControl">Name of the drop down list</param>
        /// <param name="key">Name of the Query  String Parameter</param>
        protected void SetControlValueUsingQueryStringKey(ListControl listControl, string key)
        {
            string value = Request.QueryString[key];
            if (!string.IsNullOrEmpty(value))
            {
                listControl.SelectedValue = value;
            }
        }

        //get youtube image
        public static string GetYoutubeThumbnail(string url, bool bigThumbnail = false)
        {
            try
            {
                Uri u = new Uri(url);
                Random rand = new Random((int)DateTime.Now.Ticks);
                int numIterations = rand.Next(1, 3);
                string videoCode = System.Web.HttpUtility.ParseQueryString(u.Query).Get("v");
                return bigThumbnail ? string.Format("http://img.youtube.com/vi/{0}/0.jpg", videoCode) : string.Format("http://img.youtube.com/vi/{0}/{1}.jpg", videoCode, numIterations);
            }
            catch
            {
                return string.Empty;
            }
        }

        public static string GetServiceInfo(int id,int languageId, string infohint)
        {
            ServicesServices serviceManager=new ServicesServices();
            var service=serviceManager.GetService(languageId,id);
            string value = "";
            switch (infohint)
            {
                case "title":
                    value = service.Name;
                    break;
                case "notes":
                    value = service.Notes;
                    break;
                case "category":
                    value = service.CategoryTitle;
                    break;
                case "subcategory":
                    value = service.SubCategoryTitle;
                    break;
                default:
                    value = service.Name;
                    break;
            }
            return value;
        }
    }
}