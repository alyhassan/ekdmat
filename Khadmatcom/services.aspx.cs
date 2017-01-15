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
    public partial class services : PageBase
    {
        private readonly ServicesServices _servicesServices;
        protected string sectionName = "";
        protected string urlName = "";
        protected string categoryUrlName = "";
        private int? subcategoryId = null;
        protected int categoryId ;
        protected string CategoryName;
        protected string SubcategoryName = "";
        private int typeId = 1;//2=personal 3=business
        public services()
        {
            TryGetRouteParameter("Section", out sectionName);
            TryGetRouteParameter("UrlName", out urlName);
            TryGetRouteParameter("CategoryUrlName", out categoryUrlName);
            TryGetRouteParameter("SubcategoryId", out subcategoryId);

            _servicesServices = new ServicesServices();
            var subCategoy = _servicesServices.GetSubcategoriesList(LanguageId).First(s=>s.Id==subcategoryId.Value);
            SubcategoryName = subCategoy.Name;
            CategoryName = subCategoy.ServiceCategory.Name;
            categoryId = subCategoy.ServiceCategory.Id;
        }
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(sectionName))
                RedirectAndNotify(GetLocalizedUrl(""), "Invalid section name", "Erorr", NotificationType.Error);
            else
            {
                switch (sectionName)
                {
                    case "personal":
                        typeId = 2;
                        break;
                    case "business":
                        typeId = 3;
                        break;
                    default:
                        typeId = 1;
                        break;
                }
                ucServiceRequest.CurrentUser = CurrentUser;
            }
           
        }

        public IQueryable<Service> GetServices()
        {
            var services= _servicesServices.GetServicesList(LanguageId, subcategoryId.Value).Where(s=>s.ServiceTypeId==typeId||s.ServiceTypeId==1).AsQueryable();
            ucServiceRequest.PageServices = services;
            hfServiceTypeName.Value = string.Format("{0} - {1}", CategoryName, SubcategoryName);
            return services;
        }
    }
}