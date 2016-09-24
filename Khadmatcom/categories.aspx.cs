using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Services;
using Khadmatcom.Services.Model;

namespace Khadmatcom
{
    public partial class categories : PageBase
    {
        private readonly ServicesServices _servicesServices;
        protected string sectionName = "";
        public categories()
        {
             _servicesServices = new ServicesServices();
            TryGetRouteParameter("Section", out sectionName);
        }
       

        protected void Page_Load(object sender, EventArgs e)
        {
           if(string.IsNullOrEmpty(sectionName))
                RedirectAndNotify(GetLocalizedUrl(""),"Invalid section name","Erorr",NotificationType.Error);
        }

        public IQueryable<ServiceCategory> GetCategories()
        {
            return _servicesServices.GetCategoriesList(LanguageId).AsQueryable();
        }
    }
}