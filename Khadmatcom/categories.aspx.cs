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
        private int typeId = 1;//2=personal 3=business
        public categories()
        {
             _servicesServices = new ServicesServices();
            TryGetRouteParameter("Section", out sectionName);
        }
       

        protected void Page_Load(object sender, EventArgs e)
        {
           if(string.IsNullOrEmpty(sectionName))
                RedirectAndNotify(GetLocalizedUrl(""),"Invalid section name","Erorr",NotificationType.Error);
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

        public IQueryable<ServiceCategory> GetCategories()
        {
            IQueryable<ServiceCategory> list;
            switch (sectionName)
            {
                case "personal":
                    list= _servicesServices.GetCategoriesList(LanguageId).Where(s => s.HasPersonalServices).AsQueryable();
                    break;
                case "business":
                    list = _servicesServices.GetCategoriesList(LanguageId).Where(s => s.HasBusinessServices).AsQueryable();
                    break;
                default:
                    list = _servicesServices.GetCategoriesList(LanguageId).Where(s => s.HasPersonalServices|| s.HasPersonalServices).AsQueryable();
                    break;
            }
            return list;// _servicesServices.GetCategoriesList(LanguageId).Where(s=>s.Sections.Contains(typeId.ToString())||s.Sections=="1").AsQueryable();
        }
    }
}