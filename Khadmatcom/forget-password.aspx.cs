using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using HyperPayClient;
using Khadmatcom.Services;
using Khadmatcom.Services.Model;

namespace Khadmatcom
{
    public partial class forget_password : PageBase
    {
        
      
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void btnRegister_OnClick(object sender, EventArgs e)
        {
            MembershipUser user = Membership.GetUser(txtEmail.Value);
            if (user != null)
            {
                string password=user.GetPassword();

                Dictionary<string, string> keysValues = new Dictionary<string, string>
            {
                {"password", password},
                {"email", txtEmail.Value}
                
            };
                string toAddress = txtEmail.Value;
                string adminEmail = WebConfigurationManager.AppSettings["AdminEmail"];
                string siteMasterEmail = WebConfigurationManager.AppSettings["SiteMasterEmail"];
                try
                {
                    Servston.MailManager.SendMail("forget-password.html", keysValues, "كلمة مروركم فى بوابة خدماتكم",
                        toAddress, "", "", new List<string>() { siteMasterEmail });

                   RedirectAndNotify(GetLocalizedUrl(""),"تم ارسال كلمة المرور الخاصة بك على بريدك الإلكتروني المسجل لدينا");
                }
                catch (Exception ex)
                {
                    // todo:log the exception
                    Server.ClearError();
                    RedirectAndNotify(GetLocalizedUrl(""), "حدث خطأ أثناء استعادة كلمة المرور",notificationType:NotificationType.Error);

                }
            }
            else
            {
                RedirectAndNotify(GetLocalizedUrl(""), "هذا البريد غير مسجل لدينا!", notificationType: NotificationType.Error);
            }
        }

        protected void btnSend_OnClick(object sender, EventArgs e)
        {
            string url = String.Format("http://hisms.ws/api.php?send_sms&username={0}&password={1}&numbers={2}&sender={3}&message={4}", WebConfigurationManager.AppSettings["SmsUserName"], WebConfigurationManager.AppSettings["SmsPassword"],txtPhone.Value, WebConfigurationManager.AppSettings["SmsSender"],txtMessage.Value);
            //get balace//url = "http://hisms.ws/api.php?get_balance&username=966545545133&password=123456";
            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(url);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
           
            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            {
                Stream dataStream = response.GetResponseStream();
                StreamReader reader = new StreamReader(dataStream);
                var s = new JavaScriptSerializer();
                var responseString = reader.ReadToEnd();
                if (responseString.StartsWith("3"))
                {
                }
                else// hadel error message
                {
                    string errorMessage = "";
                    switch (responseString)
                    {
                        case "1":
                            errorMessage = "إسم المستخدم غير صحيح";
                            break;
                        case "2":
                            errorMessage = "كلمة المرور غير صحيحة";
                            break;
                        case "404":
                            errorMessage = "لم يتم إدخال جميع البرمترات المطلوبة";
                            break; 
                        case "403":
                            errorMessage = "تم تجاوز عدد المحاولات المسموحة";
                            break;
                        case "504":
                            errorMessage = "الحساب معطل";
                            break;
                        case "4":
                            errorMessage = "لايوجد أرقام";
                            break;
                        case "5":
                            errorMessage = "لايوجد رسالة";
                            break;
                        case "6":
                            errorMessage = "سندر خطئ";
                            break;
                        case "7":
                            errorMessage = "سندر غير مفعل";
                            break;
                        case "8":
                            errorMessage = "الرسالة تحوي كلمة ممنوعة";
                            break;
                        case "9":
                            errorMessage = "لا يوجد رصيد";
                            break;
                        case "10":
                            errorMessage = "صيغة التاريخ خاطئة";
                            break;
                        case "11":
                            errorMessage = "صيغة الوقت خاطئة";
                            break;
                        default:
                            errorMessage = "خطا تقني غير معلوم";
                            break;
                    }
                }
                reader.Close();
                dataStream.Close();
            }
        }
    }
}