using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using Khadmatcom.Services.Services;

namespace Khadmatcom
{
    public class ControlBase : System.Web.UI.UserControl
    {

        protected string FrontEndPhysicalPath
        {
            get
            {
                return WebConfigurationManager.AppSettings["FrontEndPhysicalPath"];
            }
        }

        public Khadmatcom.Data.Model.User CurrentUser { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            SetLoogedUserInfo();
        }
        public void SetLoogedUserInfo()
        {

            UserServices userServices = new UserServices();
            MembershipUser membershipUser = Membership.GetUser();
            var providerUserKey = membershipUser?.ProviderUserKey;
            if (providerUserKey != null)
                CurrentUser = userServices.GetUser((Guid)providerUserKey);
            else
            {
                CurrentUser = new Khadmatcom.Data.Model.User() { FullName = "زائر" };
            }
        }

        protected string FrontEndVirtualPath
        {
            get
            {
                return WebConfigurationManager.AppSettings["FrontEndVirtualPath"];
            }
        }

        public int LanguageId => System.Threading.Thread.CurrentThread.CurrentUICulture.LCID;

        public void Notify(string message, string title = "", NotificationType notificationType = NotificationType.Success)
        {
            ((MasterBase)this.Page.Master).ShowNotifier(message, title, notificationType);
        }

        protected void RedirectAndNotify(string redirectUrl, string message,
          string title = "", NotificationType notificationType = NotificationType.Success, bool endResponse = false)
        {
            StringBuilder sb = new StringBuilder(redirectUrl);
            sb.AppendFormat("?msg={0}", HttpUtility.UrlEncode(message));
            if (!string.IsNullOrEmpty(title))
            {
                sb.AppendFormat("&msgtitle={0}", HttpUtility.UrlEncode(title));
            }
            sb.AppendFormat("&msgtype={0}", (int)notificationType);
            Response.Redirect(sb.ToString(), endResponse);
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

        protected  void InitializeCulture()
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
                    break;
                case "en":
                    culture = "en-GB";
                    break;
                default:
                    culture = "ar-SA";
                    break;
            }

            Page.Culture = Page.UICulture = culture;
            Page.LCID = new CultureInfo(culture).LCID;
            Thread.CurrentThread.CurrentCulture = new CultureInfo(culture);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            Response.Cookies["SelectedCulture"].Value = culture;
            Response.Cookies["SelectedCulture"].Expires = DateTime.Today.AddYears(1);
        }
    }

}