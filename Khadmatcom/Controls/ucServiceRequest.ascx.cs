using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
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
        private IQueryable<City> cities;
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

            cities = _areasServices.GetCities(LanguageId).Where(c => c.Shown).AsQueryable();
            return cities;
        }
        public IQueryable<Service> GetServices()
        {
            return PageServices ?? _servicesServices.GetServicesList(LanguageId).AsQueryable();
        }

        protected void btnProceed_OnClick(object sender, EventArgs e)
        {
            //string culture = "en-GB";
            //Page.Culture = Page.UICulture = culture;
            //Page.LCID = new System.Globalization.CultureInfo(culture).LCID;
            //System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(culture);
            //System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(culture);
            //SetLoogedUserInfo();
            try
            {
                ServiceRequests request = new ServiceRequests();
                var requestData = new Khadmatcom.Data.Model.ServiceRequest()
                {
                    MemberId = CurrentUser.Id,
                    Details = txtDetails.Value,
                    Count = ddlCount.SelectedIndex,
                    CreatedDate = Servston.Utilities.GetCurrentClientDateTime(),
                    CreatedBy = CurrentUser.Id,
                    RequestDate = Servston.Utilities.GetCurrentClientDateTime(),
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

                request.AddRequest(requestData);

                // save uploaded attachment
                List<string> fileNames = new List<string>();
                List<string> errorsList = new List<string>();
                SaveUploadedFile(fup1, fileNames, errorsList);
                SaveUploadedFile(fup2, fileNames, errorsList);
                SaveUploadedFile(fup3, fileNames, errorsList);
                SaveUploadedFile(fup4, fileNames, errorsList);
                if (errorsList.Count > 0)
                {
                    Notify(string.Join("\r\n", errorsList.ToArray()), "حدث خطأ أثناء رفع المرفقات", NotificationType.Error);
                }
                else
                {
                    if (fileNames.Count > 0)
                        request.AddRequestAttchments(fileNames, requestData.Id, false);
                }
                
                //InitializeCulture();

                //send notifications
                Dictionary<string, string> keysValues = new Dictionary<string, string>
                {
                    { "name", CurrentUser.FullName},
                    { "no", requestData.Id.ToString()},
                    { "city", GetCities().First(x=>x.CityId==requestData.CityId).Name},
                    { "ServiceName", GetServices().First(x=>x.Id==int.Parse(hfServiceId.Value)).Name}
                };
                
                string replyToAddress = WebConfigurationManager.AppSettings["ContactUsEmail"];
                string adminEmail = WebConfigurationManager.AppSettings["AdminEmail"];
                string siteMasterEmail = WebConfigurationManager.AppSettings["SiteMasterEmail"];
                try
                {
                    Servston.MailManager.SendMail("client/new-request.html", keysValues, "طلب خدمة جديد ببوابة خدماتكم",
                        CurrentUser.Email, adminEmail, replyToAddress, new List<string>() { siteMasterEmail });

                }
                catch (Exception ex)
                {
                }
                //finsh session
                RedirectAndNotify(Request.RawUrl, "تم طلب الخدمة");
            }
            catch (Exception ex)
            {
                Server.ClearError();
                //InitializeCulture();
                //if (ex.InnerException != null)
                //    Notify(ex.InnerException.Message, "حدث خطأ أثناء الطلب", NotificationType.Error);
                Notify("فضلا حاول فى وقت لاحق", "حدث خطأ أثناء الطلب", NotificationType.Error);
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
                    answer = ddlContainer.Value;
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
                case 97:
                    answer = ddlCompany8000.Value;
                    break;
                case 98:
                    answer = ddlCompany3000.Value;
                    break;
                case 99:
                    answer = ddlAirportsName.Value;
                    break;
                case 100:
                    answer = ddlIqamaType.Value;
                    break;
                case 101:
                    answer = ddlLicenceType.Value;
                    break;
                case 102:
                    answer = chkNeedCommarceReviews.Checked.ToString();
                    break;
                case 103:
                    answer = chkNeedBaldyaReviews.Checked.ToString();
                    break;
                case 104:
                    answer = chkMore40.Checked.ToString();
                    break;
                case 105:
                    answer = chkInIndustrailSection.Checked.ToString();
                    break;
                case 106:
                    answer = chkElectronic.Checked.ToString();
                    break;
                case 107:
                    answer = ddlSex.Value;
                    break;
                case 108:
                    answer = ddlContractType.Value;
                    break;
                case 109:
                    answer = ddlKhazan.Value;
                    break;
                case 110:
                    answer = ckhHasFood.Checked.ToString();
                    break;
                case 111:
                    answer = ddlCompanyType.Value;
                    break;
                case 112:
                    answer = chkBankRejection.Checked.ToString();
                    break;
                case 113:
                    answer = txtLoanReason.Value;
                    break;
                case 114:
                    answer = ddlLoanType.Value;
                    break;
                case 115:
                    answer = txtLoanAmount.Value;
                    break;
                case 116:
                    answer = ddlTsreahaType.Value;
                    break;
                case 118:
                    answer = chkImport.Checked.ToString();
                    break;
                case 120:
                    answer = chkBadrom.Checked.ToString();
                    break;
                //case 119:
                //answer = chkGadwa.Checked.ToString();
                //break;
                //case 117:
                //answer = chkGadwa.Checked.ToString();
                //break;
                case 121:
                    answer = chkSabaha.Checked.ToString();
                    break;
                case 122:
                    answer = txtUserName.Value;
                    break;
                case 123:
                    answer = txtPassword.Value;
                    break;
                case 124:
                    answer = txtSize.Value;
                    break;
                case 125:
                    answer = chkCompany.Checked.ToString();
                    break;
                case 126:
                    answer = chk1Item.Checked.ToString();
                    break;
                case 127:
                    answer = chkGadwa.Checked.ToString();
                    break;
                case 128:
                    answer = chk5Years.Checked.ToString();
                    break;
                case 129:
                    answer = txtWH.Value;
                    break;
                case 130:
                    answer = txtWeight.Value;
                    break;
                case 131:
                    answer = txtSamaka.Value;
                    break;
                case 132:
                    answer = txtQuantity.Value;
                    break;
                case 133:
                    answer = chkMore15.Checked.ToString();
                    break;
                case 134:
                    answer = chkAds.Checked.ToString();
                    break;
                case 135:
                    answer = txtPagesCount.Value;
                    break;
                //case 136:
                //answer = chkGadwa.Checked.ToString();
                // break;
                //case 137:
                //answer = chkGadwa.Checked.ToString();
                //break;
                case 138:
                    answer = txtHieght.Value;
                    break;
                case 139:
                    answer = txtDesignSize.Value;
                    break;
                case 140:
                    answer = txtDuration.Value;
                    break;
                case 141:
                    answer = txtResearchName.Value;
                    break;
                case 142:
                    answer = txtFinishDate.Value;
                    break;
                case 143:
                    answer = txtProjectSubject.Value;
                    break;
                case 144:
                    answer = txtMarketName.Value;
                    break;
                case 145:
                    answer = txtIqamaNo.Value;
                    break;
                case 146:
                    answer = ddlAdviceType.Value;
                    break;
                case 147:
                    answer = chkGadwa.Checked.ToString();
                    break;
                case 148:
                    answer = chk5Years.Checked.ToString();
                    break;
                //case 149:
                //answer = chkSteam.Checked.ToString();
                //break;
                case 150:
                    answer = chkSteam.Checked.ToString();
                    break;
                case 151:
                    answer = txtHairTall.Value;
                    break;
                case 152:
                    answer = txtLevelNo.Value;
                    break;
                //case 153:
                //answer =ddlAirportsName.Value;
                //break;
                //case 154:
                //answer = chkGadwa.Checked.ToString();
                //break;
                case 155:
                    answer = txtQa3aName.Value;
                    break;
                case 156:
                    answer = txtBuilddingAge.Value;
                    break;
                case 157:
                    answer = txtTarget.Value;
                    break;
                case 158:
                    answer = txtBudget.Value;
                    break;
                case 159:
                    answer = ddlAdsType.Value;
                    break;
                case 160:
                    answer = txtCampanDuration.Value;
                    break;
                case 161:
                    answer = chkMarketingDesign.Checked.ToString();
                    break;
                case 162:
                    answer = ddlVideoTypes.Value;
                    break;
                case 163:
                    answer = txtContainerNo.Value;
                    break;
                case 164:
                    answer = txtContainersCount.Value;
                    break;
                case 165:
                    answer = chkUserName.Checked.ToString();
                    break;
                case 166:
                    answer = chkTableat.Checked.ToString();
                    break;
                case 167:
                    answer = txtWakealName.Value;
                    break;
                case 168:
                    answer = txtActivityName.Value;
                    break;
                //case 169:
                //answer = chkGadwa.Checked.ToString();
                //break;
                case 170:
                    answer = chkStructure.Checked.ToString();
                    break;
                case 171:
                    answer = chk1Band.Checked.ToString();
                    break;
                case 172:
                    answer = chkOld.Checked.ToString();
                    break;
                //case 173:
                //answer = chkGadwa.Checked.ToString();
                //break;
                //case 174:
                //    answer = chkGadwa.Checked.ToString();
                //    break;
                case 175:
                    answer = txtBaldayaName.Value;
                    break;
                case 176:
                    answer = ddlCompanyRank.Value;
                    break;
                case 177:
                    answer = chkTasneef.Checked.ToString();
                    break;
                case 178:
                    answer = chkKsaContract.Checked.ToString();
                    break;
                //case 179:
                //    answer = chkGadwa.Checked.ToString();
                //    break;
                case 180:
                    answer = txtFileType.Value;
                    break;
                case 181:
                    answer = txtPrintType.Value;
                    break;
                case 182:
                    answer = txtUniName.Value;
                    break;
                case 183:
                    answer = txtCopiesCount.Value;
                    break;
                case 184:
                    answer = ddlTagleedType.Value;
                    break;
                case 185:
                    answer = txtTagleedColor.Value;
                    break;
                case 186:
                    answer = txtStabnCount.Value;
                    break;
                case 187:
                    answer = txtDrawingCount.Value;
                    break;
                case 188:
                    answer = txtBookSubject.Value;
                    break;
                default:
                    answer = "undifened";
                    break;
            }
            return answer;
        }

        private void SaveUploadedFile(FileUpload file, List<string> fileNames, List<string> errorsList)
        {
            string path = Server.MapPath("~/Attachments/");
            if (file.HasFile)
            {

                bool fileError = false;
                string fileExtension = System.IO.Path.GetExtension(file.PostedFile.FileName).ToLower();
                var fileName = string.Format("{0}_{1}{2}", Servston.Utilities.GetRandomString(5, true), System.IO.Path.GetFileNameWithoutExtension(file.FileName), fileExtension);
                //Is the file too big to upload?
                int fileSize = file.PostedFile.ContentLength;
                if (fileSize > (6 * 1024 * 1024))
                {
                    fileError = true;
                    errorsList.Add(string.Format("هذا لملف -{0} - قد تخطى الحجم المسموح به.", file.FileName));
                }

                List<string> acceptedFileTypes = new List<string>()
                        {
                            ".pdf",
                            ".doc",
                            ".docx",
                            ".jpg",
                            ".jpeg",
                            ".gif",
                            ".png"
                        };
                if (!acceptedFileTypes.Contains(fileExtension))
                {
                    fileError = true;
                    errorsList.Add(string.Format("امتداد هذا لملف -{0} - غير مسموح .", file.FileName));
                }
                if (!fileError)
                {
                    file.SaveAs(path + fileName);
                    fileNames.Add(fileName);
                }

            }
        }
    }
}