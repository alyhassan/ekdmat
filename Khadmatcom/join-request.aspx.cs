using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Services;
using Khadmatcom.Services.Model;
using System.Web.ModelBinding;

namespace Khadmatcom
{
    public partial class join_request : PageBase
    {
        private readonly AreasServices _areasServices;
        private readonly ServicesServices _servicesServices;
        public join_request()
        {
            _areasServices = new AreasServices();
            _servicesServices = new ServicesServices();
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack&& Request.Form[ddlCategories.UniqueID]!=null)
            {
                ddlCategories.SelectedValue = Request.Form[ddlCategories.UniqueID];
            }
        }

        public IQueryable<Region> GetRegions()
        {

            return _areasServices.GetRegions(LanguageId).AsQueryable();
        }

        public IQueryable<ServiceCategory> GetCategories()
        {
            return _servicesServices.GetCategoriesList(LanguageId).AsQueryable();
        }

        public IQueryable<ServiceSubcategory> GetSubcategories([Control]int? ddlCategories)
        {
            return ddlCategories.HasValue?
             _servicesServices.GetSubcategoriesList(LanguageId, ddlCategories.Value).Where(s=>s.Services.Any()).OrderBy(s=>s.ServiceCategory.Id).AsQueryable() : _servicesServices.GetSubcategoriesList(LanguageId).Where(s => s.Services.Any()).OrderBy(s => s.ServiceCategory.Id).AsQueryable();
        }

        public IQueryable<Service> GetServices()
        {
            return _servicesServices.GetServicesList(LanguageId).AsQueryable();
        }
    }
}