using MailChimp;
using MailChimp.Helper;
using MailChimp.Lists;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.Serialization;
using System.Threading;
using System.Web.Configuration;
using System.Web.Http;
using Khadmatcom.Services;
using HyperPayClient;
using Khadmatcom.Services.Services;

namespace Khadmatcom.API
{


    public class KhadmatcomController : ApiController
    {
        /*
         name: $('#txtContactEmail').val(),
                        email: $('#txtContactName').val(),
                        phone: $('#txtPhone').text(),
                        subject: $('select[id$=ddlSubject] :selected').val(),
                        message: $('#txtMessage').val(),
             */

        [HttpGet]
        [ActionName("ContactUs")]
        public bool ContactUs(string name, string email, string phone, string subject, string message)
        {
            Dictionary<string, string> keysValues = new Dictionary<string, string>
            {
                {"name", name},
                {"email", email},
                {"phone", phone},
                {"subject", subject},
                {"message", message}
            };
            string toAddress = WebConfigurationManager.AppSettings["ContactUsEmail"];
            string adminEmail = WebConfigurationManager.AppSettings["AdminEmail"];
            string siteMasterEmail = WebConfigurationManager.AppSettings["SiteMasterEmail"];
            try
            {
                Servston.MailManager.SendMail("contact-us.html", keysValues, "New Contact Request: " + subject,
                    toAddress, adminEmail, email, new List<string>() { siteMasterEmail });

                return true;
            }
            catch (Exception ex)
            {
                // todo:log the exception
                return false;

            }
        }


        [HttpGet]
        [ActionName("Checkout")]
        public string Checkout(decimal amount, int transactionId, int attempt, string userIp)
        {

            try
            {
                PaymentManager paymentManager = new PaymentManager();
                var _return = paymentManager.Checkout(amount, transactionId, attempt, userIp);

                return _return["id"];//.Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries)[0];
            }
            catch (Exception ex)
            {
                // todo:log the exception
                return "-";

            }
        }
        [HttpGet]
        [ActionName("JoinRequest")]
        public string JoinRequest(string companyName, string providerEmail, string contactName, string providerPhoneNumber, int cityId, int mainCategoryId, string servicesJsonData)
        {
            string result = "";
            try
            {
                JoinRequestService joinRequestService = new JoinRequestService();
                int addResult = joinRequestService.AddRequest(cityId, companyName, contactName, providerEmail, mainCategoryId,
                    providerPhoneNumber, servicesJsonData);

                if (addResult == -1)
                    result = ("هذا الإيميل قد تم إنشاء طلب له من قبل ...فضلا راجع إدارة البوابة");
                else if (addResult == 0)
                    result = ("حدث خطأ أثناء إرسال طلبك ...فضلا حاول مرة أخري لاحقا");
                else
                {
                    //send the notification email
                    Dictionary<string, string> keysValues = new Dictionary<string, string>
                    {
                        { "companyName", companyName},
                        { "email", providerEmail},
                        { "contactName", contactName},
                        { "phone", providerPhoneNumber},
                        { "id", addResult.ToString()}
                    };
                    string toAddress = WebConfigurationManager.AppSettings["ContactUsEmail"];
                    string adminEmail = WebConfigurationManager.AppSettings["AdminEmail"];
                    string siteMasterEmail = WebConfigurationManager.AppSettings["SiteMasterEmail"];
                    Servston.MailManager.SendMail("join-request.html", keysValues, "New Join Request: " + companyName,
                             toAddress, adminEmail, providerEmail, new List<string>() { siteMasterEmail });


                }

            }
            catch (Exception ex)
            {
                // todo:log the exception
                result = "حدث خطأ أثناء إرسال طلبك ...فضلا حاول مرة أخري لاحقا";

            }
            return result;
        }

        [HttpGet]
        [ActionName("UpdateProviderRequest")]
        public bool UpdateProviderRequest(int userId, int id, int status, string reason, decimal price, int duration = 0)
        {
            try
            {
                ServiceRequests _serviceRequests = new ServiceRequests();
                _serviceRequests.UpdateProviderRequest(id, userId, status, reason, price, duration);
                return true;
            }
            catch (Exception ex)
            {
                // todo:log the exception
                return false;

            }

        }

        [HttpGet]
        [ActionName("IncreaseProviderRequest")]
        public bool IncreaseProviderRequest(int id, int duration)
        {
            try
            {
                ServiceRequests _serviceRequests = new ServiceRequests();
                _serviceRequests.IncreaceRequestDuration(id, duration);
                // send notification to the first provider

                var request = _serviceRequests.GetRequest(id);
                var client = _serviceRequests.GetRequest(id).Client;
                Dictionary<string, string> keysValues = new Dictionary<string, string>
                {
                    {"name", client.FullName},
                    {"no", id.ToString()},
                    {"ServiceName", request.Service.Name}
                };

                string replyToAddress = WebConfigurationManager.AppSettings["ContactUsEmail"];
                string adminEmail = WebConfigurationManager.AppSettings["AdminEmail"];
                string siteMasterEmail = WebConfigurationManager.AppSettings["SiteMasterEmail"];
                try
                {
                    //send email
                    Servston.MailManager.SendMail("client/request-time.html", keysValues,
                        "تم تمديد مدة تنفيذ طلبكم ببوابة خدماتكم",
                       UserManger.GetEmail(client.UserId.Value) , adminEmail, replyToAddress, new List<string>() { siteMasterEmail });


                    Servston.SMS smsManager = new Servston.SMS();
                    //send sms to client
                    string sms =
                       string.Format(
                           "تمديد مدة تنفيذ طلبكم رقم {0} الخاص ب  {1} بمدة {2}",
                           id, request.Service.Name, duration);
                    if (!string.IsNullOrEmpty(request.Client.MobielNumber) && request.Client.MobielNumber.Length > 10)
                        smsManager.Send(request.Client.MobielNumber, sms);

                    //send sms to admins
                    sms =
                        string.Format(
                            "تمديد مدة تنفيذ طلب رقم {0} الخاص بشريك الخدمة {1} بمدة {2}",
                            id, request.Provider.CompanyName, duration);

                    smsManager.SendToAdmin(sms);

                }
                catch (Exception ex)
                {
                }

                return true;
            }
            catch (Exception ex)
            {
                // todo:log the exception
                return false;

            }
        }

        [HttpGet]
        [ActionName("CloseProviderRequest")]
        public bool CloseProviderRequest(int id)
        {
            try
            {
                ServiceRequests _serviceRequests = new ServiceRequests();
                _serviceRequests.CloseProviderRequest(id);
                // send notification to the first provider

                var request = _serviceRequests.GetRequest(id);
                var client = _serviceRequests.GetRequest(id).Client;
                Dictionary<string, string> keysValues = new Dictionary<string, string>
                {
                    {"name", client.FullName},
                    {"no", id.ToString()},
                    {"duration", request.CurrentDuration.ToString()},
                    {"ServiceName", request.Service.Name}
                };

                string replyToAddress = WebConfigurationManager.AppSettings["ContactUsEmail"];
                string adminEmail = WebConfigurationManager.AppSettings["AdminEmail"];
                string siteMasterEmail = WebConfigurationManager.AppSettings["SiteMasterEmail"];
                try
                {
                    Servston.MailManager.SendMail("client/request-finished.html", keysValues,
                        "تم الاستجابة على طلبكم ببوابة خدماتكم",
                       UserManger.GetEmail(client.UserId.Value), adminEmail, replyToAddress, new List<string>() { siteMasterEmail });
                    if (!string.IsNullOrEmpty(request.Client.MobielNumber) &&
                        request.Client.MobielNumber.Length > 10)
                    {
                        string sms =
                            string.Format(
                                "عميلنا العزيز نفيدكم انه تم الإنتهاء من تنفيذ طلبكم رقم {0} شكرا لكم لإستخدامكم خدمات كوم.",
                                request.Service.Name);

                        Servston.SMS smsManager = new Servston.SMS();
                        smsManager.Send(request.Client.MobielNumber, sms);
                    }

                }
                catch (Exception ex)
                {
                }

                return true;
            }
            catch (Exception ex)
            {
                // todo:log the exception
                return false;

            }
        }

        [HttpGet]
        [ActionName("ConfirmRequest")]
        public bool ConfirmRequest(int id, bool dummy, int x)
        {
            try
            {
                AdminServices adminServices = new AdminServices();
                adminServices.ConfirmRequest(id);
                return true;
            }
            catch (Exception ex)
            {
                // todo:log the exception
                return false;

            }
        }

    }
}
