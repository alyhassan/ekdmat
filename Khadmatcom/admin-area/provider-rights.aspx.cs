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
    }
}