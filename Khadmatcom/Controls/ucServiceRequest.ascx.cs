using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Data.Model;
using Khadmatcom.Services;
using City = Khadmatcom.Services.Model.City;
using Service = Khadmatcom.Services.Model.Service;

namespace Khadmatcom.Controls
{
    public partial class ucServiceRequest : ControlBase
    {
        private readonly AreasServices _areasServices;
        private readonly ServicesServices _servicesServices;

        public IQueryable<Service> PageServices { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {
        }
        public ucServiceRequest()
        {
            _areasServices = new AreasServices();
            _servicesServices = new ServicesServices();

        }
        public IQueryable<City> GetCities()
        {

            return _areasServices.GetCities(LanguageId).AsQueryable();
        }
        public IQueryable<Service> GetServices()
        {
            return PageServices ?? _servicesServices.GetServicesList(LanguageId).AsQueryable();
        }

        protected void btnProceed_OnClick(object sender, EventArgs e)
        {
            string culture = "en-GB";
            Page.Culture = Page.UICulture = culture;
            Page.LCID = new System.Globalization.CultureInfo(culture).LCID;
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(culture);
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(culture);
            SetLoogedUserInfo();
            try
            {
                ServiceRequests request = new ServiceRequests();
                var requestData = new Khadmatcom.Data.Model.ServiceRequest()
                {
                    MemberId = CurrentUser.Id,
                    Details = txtDetails.Value,
                    Count = ddlCount.SelectedIndex,
                    CreatedDate = DateTime.Now,
                    CreatedBy = CurrentUser.Id,
                    RequestDate = DateTime.Now,
                    // HijriDate = Servston.Utilities.GetHijriToday(),
                    StatusId = (int)RequestStatus.New,
                    ServiceId = int.Parse(hfServiceId.Value),
                    CityId = int.Parse(hfCityId.Value)

                };
                var options = _servicesServices.GetService(LanguageId, requestData.ServiceId).RequestOptions;

                foreach (RequestOption option in options)
                {
                    var requestOption = new RequestsOptionsAnswer() { Value = GetOptionValue(option.Id), OptionId = option.Id };
                    requestData.RequestsOptionsAnswers.Add(requestOption);
                }

                //attachment

                request.AddRequest(requestData);
                InitializeCulture();
                Notify("تم طلب الخدمة");
            }
            catch (Exception ex)
            {
                Server.ClearError();
                InitializeCulture();
                //if (ex.InnerException != null)
                //    Notify(ex.InnerException.Message, "حدث خطأ أثناء الطلب", NotificationType.Error);
                Notify("فضلا حاول فى وقت لاحق","حدث خطأ أثناء الطلب",NotificationType.Error);
            }
        }

        private string GetOptionValue(int optionId)
        {
            string answer = "";
            switch (optionId)
            {
                case 1:
                    answer = txtManagerName.Value;
                    break;
                case 2:
                    answer = txtManagerIdentityNumber.Value;
                    break;
                case 3:
                    answer = txtManagerEmail.Value;
                    break;
                case 4:
                    answer = txtManagerPhone.Value;
                    break;
                case 5:
                    answer = txtWorkOfficeNumber.Value;
                    break;
                case 6:
                    answer = txt700Number.Value;
                    break;
                case 7:
                    answer = chkMore50.Checked.ToString();
                    break;
                case 8:
                    answer = chkGarag.Checked.ToString();
                    break;
                case 9:
                    answer = chkMore50Car.Checked.ToString();
                    break;
                case 10:
                    answer = chkBus.Checked.ToString();
                    break;
                case 11:
                    answer = chkFamilyCar.Checked.ToString();
                    break;
                case 12:
                    answer = chkunicert.Checked.ToString();
                    break;
                case 13:
                    answer = chkMedcert.Checked.ToString();
                    break;
                case 14:
                    answer = ddlWorkType.Value;
                    break;
                case 15:
                    answer = txtDurationByDays.Value;
                    break;
                case 16:
                    answer = ddlCountry.Value;
                    break;
                case 17:
                    answer = txtCarModel.Value;
                    break;
                case 18:
                    answer = txtCount.Value;
                    break;
                case 19:
                    answer = chk3Mlion.Checked.ToString();
                    break;
                case 20:
                    answer = txtAddedActivatyName.Value;
                    break;
                case 21:
                    answer = txtRemovedActivatyName.Value;
                    break;
                case 22:
                    answer = chkComCert.Checked.ToString();
                    break;
                case 23:
                    answer = chkKeepCommerceRecord.Checked.ToString();
                    break;
                case 24:
                    answer = chkRecordAttached.Checked.ToString();
                    break;
                case 25:
                    answer = chkRecordModifed.Checked.ToString();
                    break;
                case 26:
                    answer = txtAssest.Value;
                    break;
                case 27:
                    answer = txtPartnerInfo.Value;
                    break;
                case 28:
                    answer = txtTravleInusranceAmount.Value;
                    break;
                case 29:
                    answer = txtTravlerCount.Value;
                    break;
                case 30:
                    answer = txtLikesCount.Value;
                    break;
                case 31:
                    answer = txtFollowersCount.Value;
                    break;
                case 32:
                    answer = txtViewsCount.Value;
                    break;
                case 33:
                    answer = txtClickCount.Value;
                    break;
                case 34:
                    answer = txtAddressInfo.Value;
                    break;
                case 35:
                    answer = txtDistrictInfo.Value;
                    break;
                case 36:
                    answer = txtBuildingNumber.Value;
                    break;
                case 37:
                    answer = txtVisitDate.Value;
                    break;
                case 38:
                    answer = txtVisitTime.Value;
                    break;
                case 39:
                    answer = chkBaldayaCert.Checked.ToString();
                    break;
                case 40:
                    answer = chkTourisame.Checked.ToString();
                    break;
                case 41:
                    answer = chkMlion.Checked.ToString();
                    break;
                case 42:
                    answer = txtWorkerCount.Value;
                    break;
                case 43:
                    answer = txtNationality.Value;
                    break;
                case 44:
                    answer = txtJob.Value;
                    break;
                case 45:
                    answer = chkKafeal.Checked.ToString();
                    break;
                case 46:
                    answer = ddlPortName.Value;
                    break;
                case 47:
                    answer = chkPrePlaning.Checked.ToString();
                    break;
                case 48:
                    answer = chkFinalPlaning.Checked.ToString();
                    break;
                case 49:
                    answer = txtEmployeesCount.Value;
                    break;
                case 50:
                    answer = txtApprovedUserCount.Value;
                    break;
                case 51:
                    answer = ddlCompanyType.Value;
                    break;
                case 52:
                    answer = chkApproveBalance.Checked.ToString();
                    break;
                case 53:
                    answer = chkSaudi.Checked.ToString();
                    break;
                case 54:
                    answer = txtContainer.Value;
                    break;
                case 55:
                    answer = txtShippingCity.Value;
                    break;
                case 56:
                    answer = chkProductType.Checked.ToString();
                    break;
                case 57:
                    answer = txtDate.Value;
                    break;
                case 58:
                    answer = txtApartmentCount.Value;
                    break;
                case 59:
                    answer = chkMore36.Checked.ToString();
                    break;
                case 60:
                    answer = ddlWorkCap.Value;
                    break;
                case 61:
                    answer = chkInvoice.Checked.ToString();
                    break;
                case 62:
                    answer = chkReview.Checked.ToString();
                    break;
                case 63:
                    answer = chkAccount.Checked.ToString();
                    break;
                case 64:
                    answer = chkAccountRecord.Checked.ToString();
                    break;
                case 65:
                    answer = txtProductType.Value;
                    break;
                case 66:
                    answer = chk7Years.Checked.ToString();
                    break;
                case 67:
                    answer = chk3Years.Checked.ToString();
                    break;
                case 68:
                    answer = txtPhone2.Value;
                    break;
                case 69:
                    answer = txtSuggested.Value;
                    break;
                case 70:
                    answer = txtProjectType.Value;
                    break;
                case 71:
                    answer = chkTourisameTravel.Checked.ToString();
                    break;
                case 72:
                    answer = chkOffice.Checked.ToString();
                    break;
                case 73:
                    answer = chkGadwa.Checked.ToString();
                    break;
                case 74:
                    answer = txtReportTo.Value;
                    break;
                case 75:
                    answer = txtReason.Value;
                    break;
                case 76:
                    answer = txtJobTo.Value;
                    break;
                case 77:
                    answer = txtLicenceNo.Value;
                    break;
                case 78:
                    answer = txtStartDate.Value;
                    break;
                case 79:
                    answer = txtFinishDate.Value;
                    break;
                case 80:
                    answer = txtTo.Value;
                    break;
                case 81:
                    answer = txtAge.Value;
                    break;
                case 82:
                    answer = chkTashera.Checked.ToString();
                    break;
                case 83:
                    answer = txtTasheraNo.Value;
                    break;
                case 84:
                    answer = txtMofodName.Value;
                    break;
                case 85:
                    answer = chkReport.Checked.ToString();
                    break;
                case 86:
                    answer = chkTasheraB4.Checked.ToString();
                    break;
                case 87:
                    answer = txtCompanyName.Value;
                    break;
                case 88:
                    answer = txtCarType.Value;
                    break;
                case 89:
                    answer = txtCarName.Value;
                    break;
                case 90:
                    answer = txtProductAddressses.Value;
                    break;
                case 91:
                    answer = txtProductPrice.Value;
                    break;
                case 92:
                    answer = txtMessageCount.Value;
                    break;
                case 93:
                    answer = txtBusCount.Value;
                    break;
                case 94:
                    answer = ddlBuildingType.Value;
                    break;
                case 95:
                    answer = txtLanguage.Value;
                    break;
                case 96:
                    answer = txtDurationByMonths.Value;
                    break;
                default:
                    answer = "undifened";
                    break;
            }
            return answer;
        }
    }
}