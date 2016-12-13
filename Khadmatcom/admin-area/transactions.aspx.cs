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
        private RequestStatus CurrentStatus;
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

    }
}