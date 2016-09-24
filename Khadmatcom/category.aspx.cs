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
    public partial class category : PageBase
    {
        private readonly ServicesServices _servicesServices;
        protected string sectionName = "";
        protected string urlName = "";
        private int? categoryId = null;
        protected string CategoryName;
        public category()
        {
            TryGetRouteParameter("CategoryId", out categoryId);
            TryGetRouteParameter("Section", out sectionName);
            TryGetRouteParameter("UrlName", out urlName);

            _servicesServices = new ServicesServices();
            CategoryName = _servicesServices.GetCategoriesList(LanguageId).First(c => c.Id == categoryId.Value).Name;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(sectionName))
                RedirectAndNotify(GetLocalizedUrl(""), "Invalid section name", "Erorr", NotificationType.Error);
        }

        public IQueryable<ServiceSubcategory> GetSubcategories()
        {
            return _servicesServices.GetSubcategoriesList(LanguageId, categoryId.Value).AsQueryable();
        }
    }
}