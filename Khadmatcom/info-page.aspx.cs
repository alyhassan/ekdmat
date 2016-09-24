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
    public partial class info_page : PageBase
    {
        private readonly SettingServices _settingServices;
        private string _pageName = "";
        protected SitePage CurrentPage;
        public info_page()
        {
            _settingServices = new SettingServices();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!TryGetRouteParameter("UrlName", out _pageName))
                RedirectAndNotify(GetLocalizedUrl(""), "خطأ فى الصفحة المطلوبة");
          
            CurrentPage = _settingServices.GetPage(_pageName, LanguageId);
  if(CurrentPage==null)
                RedirectAndNotify(GetLocalizedUrl(""), "الصفحة المطلوبة غير موجودة!");
            this.Title = string.IsNullOrEmpty(CurrentPage.MetaTitle) ? CurrentPage.Title : CurrentPage.MetaTitle;
            this.MetaDescription = CurrentPage.MetaDescription;
        }
    }
}