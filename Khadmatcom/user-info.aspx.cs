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
    public partial class user_info : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Membership.GetUser() == null)
                Response.Redirect(GetLocalizedUrl(""), true);

            if (!IsPostBack)
            {
                txtName.Value = CurrentUser.FullName;
                txtMobileNumber.Value = CurrentUser.MobielNumber;
                ddlGroup.Value = CurrentUser.UserType.ToString();
            }
            txtEmail.Value = Membership.GetUser().Email.ToLower();
        }

        protected void btnRegister_OnClick(object sender, EventArgs e)
        {
            UserServices userServices = new UserServices();
            string _out = userServices.UpdateUser(CurrentUser.Id, txtName.Value,
                   txtMobileNumber.Value, short.Parse(ddlGroup.Value));
            if (string.IsNullOrEmpty(_out))
                Notify("تم تحديث البيانات بنجاح", "", NotificationType.Success);
            else
                Notify(_out, "", NotificationType.Error);
        }

        protected void btnUpdatePassword_OnClick(object sender, EventArgs e)
        {
            if (Membership.ValidateUser(txtEmail.Value, txtOldPassword.Value))
            {
                if (Membership.GetUser().ChangePassword(txtOldPassword.Value, txtPassword.Value))
                    Notify("تم تحديث كلمة المرور بنجاح", "", NotificationType.Success);
                else
                    Notify("حدث خطأ أثناء تحديث كلمة المرور....فضلا حاول مرة اخري", "", NotificationType.Error);
            }
            else
                Notify("كلمة المرور القديمة غير صحيحة", "", NotificationType.Error);
        }
    }
}