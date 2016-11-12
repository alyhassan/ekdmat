using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Services;

using Khadmatcom.Services.Model;
using System.Web.ModelBinding;
using Khadmatcom.Controls;
using Khadmatcom.Data.Model;
using Khadmatcom.Services.Services;
using Service = System.Web.Services.Description.Service;

namespace Khadmatcom.admin_area
{
    public partial class provider : PageBase
    {
        private readonly AreasServices _areasServices;
        private readonly ServicesServices _servicesServices;
        protected int? _id;
        private readonly UserServices _userServices;
        protected User CurrentProvider;

        protected void Page_Load(object sender, EventArgs e)
        {
            TryGetRouteParameter("Key", out _id);
            if (_id.HasValue)
            {
                CurrentProvider = _userServices.GetProvider(_id.Value);
                if (!IsPostBack) LoadProviderDate();
            }
        }

        private void LoadProviderDate()
        {
           
            txtName.Value = CurrentProvider.FullName;
            txtMobileNumber.Value = CurrentProvider.MobielNumber;
            txtEmail.Value = CurrentProvider.Email;
            txtCompanyName.Value = CurrentProvider.CompanyName;
            txtBankAccountNumber.Value = CurrentProvider.BankAccountNumber;
            ddlCategories.SelectedValue = CurrentProvider.MainCategoryId.ToString();

            if (CurrentProvider.BankAccountType != null)
                ddlBanks.Value = CurrentProvider.BankAccountType.Value.ToString();
            ddlCities.SelectedValue = CurrentProvider.CityId.ToString();

            ddlCategories.Enabled = false;
            ddlCities.Enabled = false;
            txtEmail.Disabled = true;
            txtPassword.Disabled = true;
        }

        public List<ServiceProvider> GetProviderServices()
        {
            return _id.HasValue ? CurrentProvider.ServiceProviders.ToList() : null;
        }

        public provider()
        {
            _areasServices = new AreasServices();
            _servicesServices = new ServicesServices();
            _userServices = new UserServices();
        }

        public IQueryable<Khadmatcom.Services.Model.City> GetCities()
        {

            return _areasServices.GetCities(LanguageId).AsQueryable();
        }

        public IQueryable<Khadmatcom.Services.Model.ServiceCategory> GetCategories()
        {
            return _servicesServices.GetCategoriesList(LanguageId).AsQueryable();
        }

        public List<Khadmatcom.Services.Model.Service> GetServices()
        {
            if (_id.HasValue)
            {
                if (CurrentProvider.MainCategoryId != null)
                    return
                        _servicesServices.GetServicesListByCategoryId(LanguageId, CurrentProvider.MainCategoryId.Value)
                            .ToList();
            }
            return null;
        }

        protected void btnRegister_OnClick(object sender, EventArgs e)
        {
            Banks banktype;
            Enum.TryParse(ddlBanks.Value, out banktype);
            int id = _userServices.AddProvider(txtEmail.Value, txtPassword.Value, txtEmail.Value, txtName.Value,
                txtMobileNumber.Value, txtIdentityNumber.Value, int.Parse(ddlCities.SelectedValue),
                int.Parse(ddlCategories.SelectedValue), txtCompanyName.Value, banktype, txtBankAccountNumber.Value,
                "Providers", Khadmatcom.Data.Model.IdentityType.Provider);

            string _out = (id > 0) ? string.Empty : "حدث خطأ أثناء الإضافة...فضلا حاول لاحقا";
            if (!string.IsNullOrEmpty(_out))
            {
                RedirectAndNotify(GetLocalizedUrl($"managment/providers/{id}/provider-info"), "تم الإضافة بنجاح بنجاح");
            }
            else
                Notify(_out, "", NotificationType.Error);
        }

        protected void btnUpdate_OnClick(object sender, EventArgs e)
        {
        }

        protected void btnAddService_Click(object sender, EventArgs e)
        {
            try
            {


                if (hfState.Value == "0")
                    CurrentProvider.ServiceProviders.Add(new ServiceProvider()
                    {
                        CityId = int.Parse(ddlServiceCity.SelectedValue),
                        EstamaitedCost = decimal.Parse(txtCost.Text),
                        EstamaitedTime = txtTime.Text,
                        SiteCommission = decimal.Parse(txtSiteCommission.Text),
                        ServiceId = int.Parse(ddlServices.SelectedValue)
                    });
                else
                {
                    var currentService =
                        CurrentProvider.ServiceProviders.FirstOrDefault(x => x.Id == int.Parse(hfId.Value));


                    if (currentService != null)
                    {
                        currentService.CityId = int.Parse(ddlServiceCity.SelectedValue);
                        currentService.EstamaitedCost = decimal.Parse(txtCost.Text);
                        currentService.EstamaitedTime = txtTime.Text;
                        currentService.SiteCommission = decimal.Parse(txtSiteCommission.Text);
                        currentService.ServiceId = int.Parse(ddlServices.SelectedValue);
                    }
                    else
                    {
                        Notify("الخدمة غير موجودة", notificationType: NotificationType.Error);
                    }
                }
                _userServices.UpdateAndSave();
                Notify("تم الحفظ");
            }
            catch
            {
                Server.ClearError();
                Notify("حدث خطأ أثناء اخر عملية فضلا حاول لاحقا", "", NotificationType.Error);
            }
        }




        protected void OnItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    CurrentProvider.ServiceProviders.Remove(
                        CurrentProvider.ServiceProviders.FirstOrDefault(
                            x => x.Id == int.Parse(e.CommandArgument.ToString())));
                    _userServices.UpdateAndSave();
                    Notify("تم الحذف");
                }
                catch
                {
                    Server.ClearError();
                    Notify("حدث خطأ أثناء اخر عملية فضلا حاول لاحقا", "", NotificationType.Error);
                }
            }
        }
    }
}