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
                Notify("تم التسجيل بنجاح", "", NotificationType.Success);
            else
                Notify(_out, "", NotificationType.Error);
        }
    }
}