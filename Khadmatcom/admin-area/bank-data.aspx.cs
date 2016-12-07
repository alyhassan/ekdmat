using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Data.Model;
using Khadmatcom.Services;

namespace Khadmatcom.admin_area
{
    public partial class bank_data : PageBase
    {
        private Banks CurrentBank;
        private AdminServices adminServices;
        protected void Page_Load(object sender, EventArgs e)
        {
            string bank = "";
            TryGetRouteParameter("Name", out bank);
            if (string.IsNullOrEmpty(bank) || !Banks.TryParse(bank, out CurrentBank))
            {
                RedirectAndNotify(GetLocalizedUrl(""), "خطأ فى اسم البنك او العنوان", "", NotificationType.Error);
            }
        }

        public bank_data()
        {
            adminServices = new AdminServices();
        }

        public IQueryable<ServiceRequest> GetServiceRequests()
        {
            return (CurrentUser != null) ? adminServices.GetProviderRequests(CurrentBank).AsQueryable() : null;
        }

        protected void lvServiceRequest_OnItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Confirm")
            {
                int id = int.Parse(e.CommandArgument.ToString());

                try
                {
                    adminServices.ConfirmRequest(id);
                    RedirectAndNotify(Request.RawUrl,"تم تأكيد لدفع للطلب");
                }
                catch (Exception)
                {
                    RedirectAndNotify(Request.RawUrl, "خطا اثناء عملية التاكيد حاول لاحقا","",NotificationType.Error);
                    throw;
                }

            }
        }

        protected void OnClick(object sender, EventArgs e)
        {

        }
    }
}