using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading;
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
        protected Khadmatcom.Data.Model.User CurrentUser;

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
    }

}