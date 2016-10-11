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
            switch (paymentMethod)
            {
                case "1"://online payment
                    CurrentRequest.PaymentMethod = 1;
                    _serviceRequests.UpdateServiceRequest(CurrentRequest);
                    PaymentManager paymentManager = new PaymentManager();
                    string brand = hfCardBrand.Value.Length > 1 ? hfCardBrand.Value : "";
                    if (brand == "mastercard") brand = "MASTER";
                    if (CurrentRequest.CurrentPrice != null)
                    {
                       // paymentManager.Checkout(CurrentRequest.CurrentPrice.Value, CurrentRequest.Id.ToString(),1,Servston.Utilities.GetCurrentClientIPAddress());
                        var _return = paymentManager.Pay(CurrentRequest.CurrentPrice.Value, CurrentRequest.Id.ToString(), txtCardNo.Value, txtCardHolder.Value, txtExpiryDate.Value.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries)[0], "20" + txtExpiryDate.Value.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries)[1], txtCvv.Value, 1, Servston.Utilities.GetCurrentClientIPAddress(), brand.ToUpper());
                       payId = _return["id"];
                    }
                    break;
                case "2"://transfare payment...set to in progress if saved
                    CurrentRequest.PaymentMethod = 2;
                    CurrentRequest.PaymentProviderName = ddlBanks.Value;
                    CurrentRequest.PaymentDate = DateTime.Parse(txtDate.Value);
                    CurrentRequest.PaymentReferanceCode = txtRefNumber.Value;
                    CurrentRequest.StatusId = (int)RequestStatus.Paid;
                    _serviceRequests.UpdateServiceRequest(CurrentRequest);
                    break;
                default:

                    break;
            }


            if (paymentMethod == "1" && payId.Length > 3)
                Response.Redirect(HyperPayClient.MerchantConfiguration.Config.ReturnUrl, false);
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