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
    public partial class approved_reuests : PageBase
    {
        private readonly ServiceRequests _serviceRequests;


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public approved_reuests()
        {
            _serviceRequests = new ServiceRequests();
        }
        public IQueryable<ServiceRequest> GetServiceRequests()
        {
            return _serviceRequests.GetProviderRequests(CurrentUser.Id, (int)RequestStatus.Approved, false).AsQueryable();
        }
    }
}