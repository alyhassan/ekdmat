using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Services.Services;

namespace Khadmatcom.Controls
{
    public partial class uclogin :ControlBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_OnClick(object sender, EventArgs e)
        {
            string userName = username.Value;
            string _password = password.Value;
            bool rememberUserName = chkRemember.Checked;

            // record validated
            if (Membership.ValidateUser(userName, _password))
            {
                // Create forms authentication ticket
                FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                1, // Ticket version
                userName, // Username to be associated with this ticket
                Servston.Utilities.GetCurrentClientDateTime(), // Date/time ticket was issued
                Servston.Utilities.GetCurrentClientDateTime().AddDays(7), // Date and time the cookie will expire
                rememberUserName, // if user has checked remember me then create persistent cookie
                "", // store the user data,
                FormsAuthentication.FormsCookiePath); // Cookie path specified in the web.config file in <Forms> tag if any.

                // To give more security it is suggested to hash it
                string hashCookies = FormsAuthentication.Encrypt(ticket);
                HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, hashCookies); // Hashed ticket

                // Add the cookie to the response, user browser
                Response.Cookies.Add(cookie);

                // Get the requested page from the url than check if it exists, if not then redirect to default page
                string returnUrl = Request.QueryString["ReturnUrl"] ?? GetLocalizedUrl("personal/categories");

                //UserServices userServices=new UserServices();
                //MembershipUser membershipUser = Membership.GetUser();
                //var providerUserKey = membershipUser?.ProviderUserKey;
                //if (providerUserKey != null)
                //    Session["CurrentUser"] = userServices.GetUser((Guid) providerUserKey);

                Response.Redirect(returnUrl);
            }

            else // wrong username and\or password
            {
                // show the failure message explicitly
                Notify( "wrong username and/or password.","An Error Occurred", NotificationType.Error);
            }
        }
    }
}