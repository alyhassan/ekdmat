using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Data.Model;
using Khadmatcom.Services;

namespace Khadmatcom.admin_area
{
    public partial class transactions : PageBase
    {
        protected RequestStatus CurrentStatus;
        private AdminServices adminServices;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public transactions()
        {
            adminServices = new AdminServices();
        }

        public IQueryable<ServiceRequest> GetServiceRequests()
        {
            if (CurrentUser == null) return null;
             string key;
            if (TryGetRouteParameter("key", out key) && !string.IsNullOrEmpty(key) &&
                Enum.TryParse(key, out CurrentStatus))
                return  adminServices.GetTransactions((int) CurrentStatus).AsQueryable();
            return adminServices.GetTransactions().AsQueryable();
        }

        public decimal GetPrice(ServiceRequest CurrentRequest)
        {
            var method = CurrentRequest.Service.ShippingMethods;
            decimal ServicePrice = 0;
            decimal ShippingPrice = 30;
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
            ServiceProvider provider = null;
            if (CurrentRequest.CurrentProvider.HasValue&& CurrentRequest.CurrentProvider.Value>0)
                provider = adminServices.GetProvider(CurrentRequest.ServiceId, CurrentRequest.CurrentProvider.Value);
            return provider == null ? 0 : ServicePrice;
        }

    }
}