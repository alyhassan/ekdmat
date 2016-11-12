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
    public partial class approved_requests : PageBase
    {
        private readonly ServiceRequests _serviceRequests;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        public approved_requests()
        {
            _serviceRequests = new ServiceRequests();
        }
        public IQueryable<ServiceRequest> GetServiceRequests()
        {
            return (CurrentUser != null) ? _serviceRequests.GetProviderRequests(CurrentUser.Id, (int)RequestStatus.Approved, false).AsQueryable() : null;
        }
    }
}