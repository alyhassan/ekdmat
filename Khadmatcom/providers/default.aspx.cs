using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Data.Model;
using Khadmatcom.Services;
using Khadmatcom.Services.Model;

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
            var item = _serviceRequests.GetProviderRequests(CurrentUser.Id).AsQueryable();

            return item;
        }

        protected void lvServiceRequest_OnItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateModel")
            {
                int id = int.Parse(e.CommandArgument.ToString());
                int status = int.Parse(Request.Form["status"]);
                string reason = Request.Form["txtReason" + id.ToString()];
                decimal price = decimal.Parse(Request.Form["txtPrice" + id.ToString()]);
                _serviceRequests.UpdateProviderRequest(id,CurrentUser.Id,status,reason,price);
            }
        }

        protected void OnClick(object sender, EventArgs e)
        {
            
        }
    }
}