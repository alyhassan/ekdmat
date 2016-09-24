using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Services;
using Khadmatcom.Services.Model;
using Khadmatcom.Services.Services;

namespace Khadmatcom
{
    public partial class Site : MasterBase
    {

        public int LanguageId
        {
            get
            {
                return Thread.CurrentThread.CurrentUICulture.LCID;
            }
        }

        public string IsoName => GetUiCulture().ToLower();

        public string TwoLetterISOLanguageName
        {
            get
            {
                string isoName = IsoName;
                return isoName == "ar" ? string.Empty : isoName;
            }
        }

        StringBuilder sb = new StringBuilder();
        protected Data.Model.User CurrentUser;
        string emptyLink = "javascript:{}";
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;
        private SettingServices _settingServices;

        public Site()
        {
            _settingServices = new SettingServices();
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            //Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack && Request.Form[ddlLanguages.UniqueID] != null)
            {
                ddlLanguages.SelectedValue = Request.Form[ddlLanguages.UniqueID];
                mainCss.Href = $"/Content/site-{ ddlLanguages.SelectedValue}.css";
                string culture = "ar-SA";
                if (ddlLanguages.SelectedValue == "en")
                    culture = "en-GB";
                Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(culture);
                Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(culture);
                Response.Cookies["SelectedCulture"].Value = culture;
                Response.Cookies["SelectedCulture"].Expires = DateTime.Today.AddYears(1);
            }
            else
            {
                ddlLanguages.SelectedValue = IsoName;
                mainCss.Href = $"/Content/site-{IsoName}.css";
            }
            UserServices userServices = new UserServices();
            MembershipUser membershipUser = Membership.GetUser();
            var providerUserKey = membershipUser?.ProviderUserKey;
            if (providerUserKey != null)
                CurrentUser = userServices.GetUser((Guid)providerUserKey);
        }

        public override void ShowNotifier(string message, string title, NotificationType notificationType)
        {
            //Show Toaster Notification
            string jsMethodName = "<script language='javascript'> $(document).ready(function(){toastr." + notificationType.ToString().ToLower() + "('" + message + "','" + title + "'); }) </script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "notyScript", jsMethodName);
        }

        protected string GetUiCulture()
        {
            return Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName;
        }

        public List<Faq> GetFaqs()
        {
            return _settingServices.GetFaqs(LanguageId);
        }

        public List<AttachmentCategory> GetAttachmentCategories()
        {
            return _settingServices.GetAttachmentCategories(LanguageId);
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
                // return the same path un translated if no resources found
                return path;
            }
        }

        protected string GetSocialLinkUrl(string name)
        {
            SettingServices settingServices = new SettingServices();
            var key = settingServices.GetSocailKey(name);
            return key != null ? key.Value : "";
        }

        protected void ddlLanguages_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            // get the url of other language flags
            StringBuilder url = new StringBuilder(Request.RawUrl.ToLower());
            url = url.Replace("/en/", string.Empty);
            mainCss.Href = $"/Content/site-{IsoName}.css";
            string queryString = Request.Url.Query;

            //remove any query string
            string pathToTranslate = url.ToString();
            int i = pathToTranslate.IndexOf('?');
            if (i > -1)
            {
                pathToTranslate = pathToTranslate.Substring(0, i);
            }
            if (Request.IsLocal)
            {
                pathToTranslate = pathToTranslate.Replace(".aspx", string.Empty).Replace("default", string.Empty);
            }
            queryString = (queryString.Length > 0) ? "?" + queryString.Replace("?", "") : string.Empty;
            //if (pathToTranslate.Replace("/", string.Empty).Length != 2)
            //{
            //    lnkEnglish.HRef = $"~/en/{pathToTranslate}{queryString}";
            //    lnkArabic.HRef = $"~/{pathToTranslate}{queryString}";
            //}
            string redirectPath = "";
            if (ddlLanguages.SelectedValue == "ar")
            {
                redirectPath = $"~/{pathToTranslate}{queryString}";
            }
            else
            {
                redirectPath = $"~/en/{pathToTranslate}{queryString}";
            }


            Response.Redirect(redirectPath);
        }
    }
}