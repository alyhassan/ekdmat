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
    public partial class online : PageBase
    {
        private Banks CurrentBank;
        private AdminServices adminServices;
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        public online()
        {
            adminServices = new AdminServices();
        }

        public IQueryable<ServiceRequest> GetServiceRequests()
        {
            return (CurrentUser != null) ? adminServices.GetProviderOnlineRequests().AsQueryable() : null;
        }

        
    }
}