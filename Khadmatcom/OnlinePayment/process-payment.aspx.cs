using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
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

                //send notification
                var request = serviceRequests.GetRequest(transactionId);
                Dictionary<string, string> keysValues = new Dictionary<string, string>
                    {
                        { "name",request.Client.FullName },
                        { "no", request.Id.ToString()},
                        { "ServiceName", request.Service.Name}
                    };

                string replyToAddress = WebConfigurationManager.AppSettings["ContactUsEmail"];
                string adminEmail = WebConfigurationManager.AppSettings["AdminEmail"];
                string siteMasterEmail = WebConfigurationManager.AppSettings["SiteMasterEmail"];
                try
                {
                    //send to client
                    Servston.MailManager.SendMail("client/request-approved.html", keysValues, "بوابة خدماتكم",
                        request.Client.Email, adminEmail, replyToAddress, new List<string>() { siteMasterEmail });

                    //send sms to the client
                    string sms =
                        string.Format(
                            "عميلنا العزيز تم استلام فاتورة طلبكم رقم {0} بقيمة {1} وسيتم البدء بتنفيذها خلال المدة المتفق عليها شكرا لكم لإستخدامكم خدمات كوم.",
                            transactionId, request.CurrentPrice);

                    //send to provider
                    keysValues = new Dictionary<string, string>
                    {
                        { "name",request.Provider.FullName },
                        { "no", request.Id.ToString()},
                        { "ServiceName", request.Service.Name}
                    };

                    Servston.MailManager.SendMail("provider/request-approved.html", keysValues, "بوابة خدماتكم",
                       request.Provider.Email, adminEmail, replyToAddress, new List<string>() { siteMasterEmail });
                }
                catch (Exception ex)
                {
                }
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