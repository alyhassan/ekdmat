using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Data.Model;
using Khadmatcom.Services.Services;

namespace Khadmatcom.admin_area
{
    public partial class providers : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<User> GetProvidersList()
        {
            UserServices userServices = new UserServices();
            return userServices.GetProviders();
        }
    }
}