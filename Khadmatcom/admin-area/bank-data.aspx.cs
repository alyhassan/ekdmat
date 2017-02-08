using System;
using System.Collections.Generic;
using System.Globalization;
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
                    RedirectAndNotify(Request.RawUrl, "تم تأكيد لدفع للطلب");
                }
                catch (Exception)
                {
                    RedirectAndNotify(Request.RawUrl, "خطا اثناء عملية التاكيد حاول لاحقا", "", NotificationType.Error);
                    throw;
                }

            }
        }

        protected void OnClick(object sender, EventArgs e)
        {

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
            if (CurrentRequest.CurrentProvider.HasValue && CurrentRequest.CurrentProvider.Value > 0)
                provider = adminServices.GetProvider(CurrentRequest.ServiceId, CurrentRequest.CurrentProvider.Value);
            return provider == null ? 0 : ServicePrice;
        }
        //public string GetGregorian(int y,int m,int d)
        //{
        //    var hijri = new UmAlQuraCalendar();
        //    var cal = new GregorianCalendar();

        //    var hijriDate = new DateTime(y, m, d, hijri);
        //    ////var y = cal.GetYear(hijriDate);
        //    ////var m = cal.GetMonth(hijriDate);
        //    ////var d = cal.GetDayOfMonth(hijriDate);
        //    return string.Format("{0}/{1}/{2}", cal.GetYear(hijriDate), cal.GetMonth(hijriDate), cal.GetDayOfMonth(hijriDate));
        //   // return  DateTime.ParseExact(date, "dd/MM/yyyy hh:mm tt",CultureInfo.InvariantCulture);
        //}
    }
}