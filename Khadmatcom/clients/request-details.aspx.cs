using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HyperPayClient;
using Khadmatcom.Data.Model;
using Khadmatcom.Services;
using Region = Khadmatcom.Services.Model.Region;

namespace Khadmatcom.clients
{
    public partial class request_details : PageBase
    {
        protected int _id;
        private readonly ServiceRequests _serviceRequests;
        private readonly AreasServices _areasServices;
        protected ServiceRequest CurrentRequest;
        protected decimal ServicePrice = 0;
        protected decimal ShippingPrice = 30;
        protected string Summary = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string encruptedIdValue = "";
            TryGetRouteParameter("Key", out encruptedIdValue);
            _id = encruptedIdValue.DecodeNumber();

            CurrentRequest = _serviceRequests.GetRequest(_id);
            var method = CurrentRequest.Service.ShippingMethods;
            switch (method)
            {
                case ShippingMethods.None:
                    ShippingPrice = 0;
                    break;
                case ShippingMethods.OneWay:
                    ShippingPrice = 30;
                    break;
                case ShippingMethods.TwoWays:
                    ShippingPrice = ShippingPrice * 2;
                    break;
                default:
                    ShippingPrice = 0;
                    break;
            }
            if (CurrentRequest.CurrentPrice.HasValue) ServicePrice = CurrentRequest.CurrentPrice.Value - ShippingPrice;
            if (!IsPostBack)
            {
                txtShippingAddress.Value = CurrentRequest.ShippingAddress;
                txtShippingPhone.Value = CurrentRequest.ShippingPhone;
                txtShippingName.Value = CurrentRequest.ShippingName;
            }
            Summary = string.Format("عزيزيى العميل<br> ({0})<br> شكرا لكم لاختياركم خدمات كوم...<br>لقد قمت بطلب خدمة({1}) <br>والتي تبلغ قيمتها ({2} ريال) <br>ولإكمال الطلب نرجو الضغط عل زر الإرسال وللألغاء اضغط إلغاء<br> كم ونود إحاطتكم علما انه فى حال دفع قيمة الخدمة عن طريق الفيزا او الماستر كارد سيتم احتساب رسوم إضافية قدرها 2.5% من قبل البنك", CurrentUser.FullName,CurrentRequest.Service.LocalizedServices.First(l=>l.LanguageId==LanguageId).Title,CurrentRequest.CurrentPrice);
        }

        public request_details()
        {
            _serviceRequests = new ServiceRequests();
            _areasServices = new AreasServices();
        }

        public IQueryable<Region> GetRegions()
        {

            return _areasServices.GetRegions(LanguageId).AsQueryable();
        }
        public List<RequestsOptionsAnswer> GetAnswers()
        {
            return CurrentRequest.RequestsOptionsAnswers.ToList();
        }

        protected void btnSave_OnClick(object sender, EventArgs e)
        {
            string paymentMethod = Request.Form["cars"];
            string payId = "";
            CurrentRequest.ModifiedDate = DateTime.Now;
            SetShippingInfo();
            // save uploaded files
            List<string> fileNames = new List<string>();
            List<string> errorsList = new List<string>();
            SaveUploadedFile(fup1, fileNames, errorsList);
            SaveUploadedFile(fup2, fileNames, errorsList);
            SaveUploadedFile(fup3, fileNames, errorsList);
            SaveUploadedFile(fup4, fileNames, errorsList);
            if (errorsList.Count > 0)
            {
                Notify(string.Join("\r\n", errorsList.ToArray()), "حدث خطأ أثناء الطلب", NotificationType.Error);
                return;
            }
            else
                if (fileNames.Count > 0)
                _serviceRequests.AddRequestAttchments(fileNames, CurrentRequest.Id, false);

            switch (paymentMethod)
            {
                case "1"://online payment
                    CurrentRequest.PaymentMethod = 1;
                    _serviceRequests.UpdateServiceRequest(CurrentRequest);
                    //PaymentManager paymentManager = new PaymentManager();
                    //string brand = hfCardBrand.Value.Length > 1 ? hfCardBrand.Value : "";
                    //if (brand == "mastercard") brand = "MASTER";
                    //if (CurrentRequest.CurrentPrice != null)
                    //{
                    //   // paymentManager.Checkout(CurrentRequest.CurrentPrice.Value, CurrentRequest.Id.ToString(),1,Servston.Utilities.GetCurrentClientIPAddress());
                    //    var _return = paymentManager.Pay(CurrentRequest.CurrentPrice.Value, CurrentRequest.Id.ToString(), txtCardNo.Value, txtCardHolder.Value, txtExpiryDate.Value.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries)[0], "20" + txtExpiryDate.Value.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries)[1], txtCvv.Value, 1, Servston.Utilities.GetCurrentClientIPAddress(), brand.ToUpper());
                    //   payId = _return["id"];
                    //}
                    break;
                case "2"://transfare payment...set to in progress if saved
                    CurrentRequest.PaymentMethod = 2;
                    CurrentRequest.PaymentProviderName = ddlBanks.Value;
                    CurrentRequest.PaymentDate = DateTime.ParseExact(txtDate.Value, "dd/MM/yyyy", new System.Globalization.CultureInfo("en-GB")); // DateTime.Parse(txtDate.Value);
                    CurrentRequest.PaymentReferanceCode = txtRefNumber.Value;
                    CurrentRequest.PaymentAccountNumber = txtBakAccountNum.Value;
                    CurrentRequest.StatusId = (int)RequestStatus.Paid;
                    _serviceRequests.UpdateServiceRequest(CurrentRequest);
                    RedirectAndNotify(GetLocalizedUrl("clients/services-requests/approved-requests"), "رجاءاَ قم بالإتصال بالإدارة للتأكد من وصول الحوالة.");
                    break;
                default:

                    break;
            }


            //if (paymentMethod == "1" && payId.Length > 3)
            //    Response.Redirect(HyperPayClient.MerchantConfiguration.Config.ReturnUrl, false);
        }

        private void SaveUploadedFile(FileUpload file, List<string> fileNames, List<string> errorsList)
        {
            string path = Server.MapPath("~/Attachments/");
            if (file.HasFile)
            {

                bool fileError = false;
                string fileExtension = System.IO.Path.GetExtension(file.PostedFile.FileName).ToLower();
                var fileName = string.Format("{0}_{1}{2}", Servston.Utilities.GetRandomString(5, true), System.IO.Path.GetFileNameWithoutExtension(file.FileName), fileExtension);
                //Is the file too big to upload?
                int fileSize = file.PostedFile.ContentLength;
                if (fileSize > (6 * 1024 * 1024))
                {
                    fileError = true;
                    errorsList.Add(string.Format("هذا لملف -{0} - قد تخطى الحجم المسموح به.", file.FileName));
                }

                List<string> acceptedFileTypes = new List<string>()
                        {
                            ".pdf",
                            ".doc",
                            ".docx",
                            ".jpg",
                            ".jpeg",
                            ".gif",
                            ".png"
                        };
                if (!acceptedFileTypes.Contains(fileExtension))
                {
                    fileError = true;
                    errorsList.Add(string.Format("امتداد هذا لملف -{0} - غير مسموح .", file.FileName));
                }
                if (!fileError)
                {
                    file.SaveAs(path + fileName);
                    fileNames.Add(fileName);
                }

            }
        }


        private void SetShippingInfo()
        {
            if (!string.IsNullOrEmpty(txtShippingAddress.Value))
                CurrentRequest.ShippingAddress = txtShippingAddress.Value;
            if (!string.IsNullOrEmpty(txtShippingName.Value))
                CurrentRequest.ShippingPhone = txtShippingName.Value;
            if (!string.IsNullOrEmpty(txtShippingPhone.Value))
                CurrentRequest.ShippingName = txtShippingName.Value;
            if (!string.IsNullOrEmpty(Request.Form["ddlCities"]))
            {
                int cityId;
                if (int.TryParse("", out cityId))
                    CurrentRequest.ShippingCity = cityId;
            }
        }
    }
}