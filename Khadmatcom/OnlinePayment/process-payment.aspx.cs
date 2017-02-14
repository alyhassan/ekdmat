using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Services;

namespace Khadmatcom.OnlinePayment
{
    public partial class process_payment : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperPayClient.PaymentManager paymentManager = new HyperPayClient.PaymentManager();
            string id = Request.QueryString["id"];
            string code = paymentManager.GetPaymentStatus(id)["result"]["code"];
            string accesptedCodesstring = "000.000.100,000.100.110, 000.100.111,000.100.112";
            List<string> acceptedCodes = accesptedCodesstring.Split(',').ToList();
            string url;
            string message;
            NotificationType notificationType;
            if (acceptedCodes.Contains(code))
            {
                //accept the payment
                int transactionId = paymentManager.GetTransactionId(id);
                ServiceRequests serviceRequests = new ServiceRequests();
                serviceRequests.PayRequest(transactionId);

                url = GetLocalizedUrl("clients/services-requests/inprogress-requests");
                message = "تم التأكد من عملية الدفع وطلبك جارى تنفيذه...";
                notificationType = NotificationType.Success;
            }
            else
            {
                url = GetLocalizedUrl("clients/services-requests/approved-requests");
                message = "حدث خطأ اثناء عملية الدفع رجاءاَ قم بالإتصال بالإدارة.";
                notificationType = NotificationType.Error;
            }

            RedirectAndNotify(url, message, "", notificationType);
        }
    }
}