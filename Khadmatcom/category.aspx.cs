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
        private int typeId = 1;//2=personal 3=business
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
            }
        }

        public IQueryable<ServiceSubcategory> GetSubcategories()
        {
            IQueryable<ServiceSubcategory> list;
            switch (sectionName)
            {
                case "personal":
                    list = _servicesServices.GetSubcategoriesList(LanguageId).Where(s => s.HasPersonalServices).AsQueryable();
                    break;
                case "business":
                    list = _servicesServices.GetSubcategoriesList(LanguageId).Where(s => s.HasBusinessServices).AsQueryable();
                    break;
                default:
                    list = _servicesServices.GetSubcategoriesList(LanguageId).Where(s => s.HasPersonalServices || s.HasPersonalServices).AsQueryable();
                    break;
            }
            return  _servicesServices.GetSubcategoriesList(LanguageId, categoryId.Value).Where(s => s.Sections.Contains(typeId.ToString()) || s.Sections == "1").AsQueryable();
        }
    }
}