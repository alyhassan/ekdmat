using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Khadmatcom
{
    public partial class Default : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect(GetLocalizedUrl("business/categories"),true);
            //RedirectAndNotify(GetLocalizedUrl("personal/categories"), "اهلا وسهلا بك ايه الزائر", "تم تحويلك ", NotificationType.Info);
        }


    }
}