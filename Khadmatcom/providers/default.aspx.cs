using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Data.Model;
using Khadmatcom.Services;

namespace Khadmatcom.providers
{
    public partial class _default : PageBase
    {
        private readonly ServiceRequests _serviceRequests;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public _default()
        {
            _serviceRequests = new ServiceRequests();
        }
        public IQueryable<ServiceRequest> GetServiceRequests()
        {
            return (CurrentUser != null) ? _serviceRequests.GetProviderRequests(CurrentUser.Id).AsQueryable() : null;
        }

        protected void lvServiceRequest_OnItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateModel")
            {
                int id = int.Parse(e.CommandArgument.ToString());
                int status = int.Parse(Request.Form["status"]);
                string reason = Request.Form["txtReason" + id.ToString()];
                decimal price = decimal.Parse(Request.Form["txtPrice" + id.ToString()]);
                int duration = int.Parse(Request.Form["txtDuration"] + id.ToString());
                _serviceRequests.UpdateProviderRequest(id, CurrentUser.Id, status, reason, price, duration);
            }
        }

        protected void OnClick(object sender, EventArgs e)
        {

        }

        protected string GetExpiryTime(DateTime expiryTime)
        {
            DateTime expiry = expiryTime;
            float serverTimeOffeset = float.Parse(DateTimeOffset.Now.Offset.ToString().Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries)[0]);

            if (serverTimeOffeset != 0)
                expiry = expiryTime.AddHours(-serverTimeOffeset).AddHours(3);
            //  ClientTimeOffeset
            return string.Format("{0:yyy/MM/dd hh:mm:ss}", expiry);
        }
    }
}