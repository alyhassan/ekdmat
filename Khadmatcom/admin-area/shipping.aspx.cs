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
    public partial class shipping : PageBase
    {
        private AdminServices adminServices;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public shipping()
        {
            adminServices = new AdminServices();
        }

        public IQueryable<ServiceRequest> GetServiceRequests()
        {
            string key;
            ShippingStatus current=ShippingStatus.New;
            if (TryGetRouteParameter("Key", out key)&& !string.IsNullOrEmpty(key))
                Enum.TryParse(key, true, out current);
            if (CurrentUser == null) return null;
            return adminServices.GethippingTransactionsData(current).AsQueryable();
        }

        protected string GetShipButtonText(ShippingStatus shippingStatus)
        {
            string text = "";
            switch (shippingStatus)
            {
                case ShippingStatus.New:
                    text = "تحويل الطلب للبريد";
                    break;
                case ShippingStatus.SentToPostOffice:
                    text = "تأكيد الإستلام";
                    break;
                case ShippingStatus.ReceivedFromCustomer:
                    text = "تأكيد التسليم";
                    break;
                case ShippingStatus.SentToPartner:
                    text = "تم الإستلام";
                    break;
                case ShippingStatus.ReceivedFromPartner:
                    text = "تم التحويل";
                    break;
                case ShippingStatus.SentToCustomer:
                    text = "محول";
                    break;
                default:
                    text = "";
                    break;
            }
            return text;
        }
    }
}