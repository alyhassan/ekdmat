using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Services.Services;

namespace Khadmatcom
{
    public partial class register : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_OnClick(object sender, EventArgs e)
        {
            UserServices userServices = new UserServices();
            string _out = userServices.CreateUser(txtEmail.Value, txtPassword.Value, txtEmail.Value, txtName.Value,
                   txtMobileNumber.Value, short.Parse(ddlGroup.Value));
            if (string.IsNullOrEmpty(_out))
            {
                // record validated
                if (Membership.ValidateUser(txtEmail.Value, txtPassword.Value))
                {
                    // Create forms authentication ticket
                    FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                    1, // Ticket version
                    txtEmail.Value, // Username to be associated with this ticket
                    DateTime.Now, // Date/time ticket was issued
                    DateTime.Now.AddDays(7), // Date and time the cookie will expire
                    false, // if user has checked remember me then create persistent cookie
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

                    RedirectAndNotify(returnUrl,"تم التسجيل بنجاح");
                }
                //Notify("تم التسجيل بنجاح", "", NotificationType.Success);
            }
            else
                Notify(_out, "", NotificationType.Error);
        }
    }
}