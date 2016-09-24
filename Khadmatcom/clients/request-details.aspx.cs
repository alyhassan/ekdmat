using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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

            switch (paymentMethod)
            {
                case "1"://online payment
                    CurrentRequest.PaymentMethod = 1;

                    break;
                case "2"://transfare payment...set to in progress if saved
                    CurrentRequest.PaymentMethod = 2;
                    CurrentRequest.PaymentProviderName = ddlBanks.Value;
                    CurrentRequest.PaymentDate = DateTime.Parse(txtDate.Value);
                    CurrentRequest.PaymentReferanceCode = txtRefNumber.Value;
                    CurrentRequest.StatusId = (int)RequestStatus.Paid;
                    break;
                default:

                    break;
            }
            CurrentRequest.ModifiedDate = DateTime.Now;
            SetShippingInfo();
            _serviceRequests.UpdateServiceRequest(CurrentRequest);
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