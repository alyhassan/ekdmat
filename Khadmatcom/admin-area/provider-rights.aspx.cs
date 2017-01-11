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
    public partial class provider_rights : PageBase
    {
        private AdminServices adminServices;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public provider_rights()
        {
            adminServices = new AdminServices();
        }

        public IQueryable<ServiceRequest> GetServiceRequests()
        {
            if (CurrentUser == null) return null;
            return adminServices.GetTransactions((int)RequestStatus.Accomplished).AsQueryable();
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
            var provider = adminServices.GetProvider(CurrentRequest.ServiceId,CurrentRequest.CurrentProvider.Value);
            if (provider == null) return 0;
            return provider.SiteCommission != null && (provider.SiteCommission.Value > 0)
                ? ServicePrice * (1-provider.SiteCommission.Value/100)
                : ServicePrice;
        }
    }

    
}