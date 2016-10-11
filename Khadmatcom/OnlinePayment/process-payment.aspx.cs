using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Khadmatcom.OnlinePayment
{
    public partial class process_payment : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperPayClient.PaymentManager paymentManager=new HyperPayClient.PaymentManager();

           string code= paymentManager.GetPaymentStatus(Request.QueryString["id"])["result"]["code"];

            codeValue.InnerText = code;
        }
    }
}