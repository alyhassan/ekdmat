using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Khadmatcom.error
{
    public partial class generic : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(Request.QueryString["msg"]))
                lblErrorMessage.InnerText = Request.QueryString["msg"];
        }
    }
}