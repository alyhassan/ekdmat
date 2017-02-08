using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Data.Model;
using Khadmatcom.Services;

namespace Khadmatcom.providers
{
    public partial class inprogress_requests : PageBase
    {
        private readonly ServiceRequests _serviceRequests;


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public inprogress_requests()
        {
            _serviceRequests = new ServiceRequests();
        }
        public IQueryable<ServiceRequest> GetServiceRequests()
        {
            //if (CurrentUser.Id > 0)
                return
                   (CurrentUser != null) ? _serviceRequests.GetProviderRequests(CurrentUser.Id, (int) RequestStatus.InProgress, false)
                        .AsQueryable():null;
            //else return null;
        }

        protected void btnSave_OnClick(object sender, EventArgs e)
        {
            try
            {
                int requestId = int.Parse(currentId.Value);
                List<string> fileNames = new List<string>();
                List<string> errorsList = new List<string>();
                string path = Server.MapPath("~/Attachments/");
                if (fupAttachment.HasFiles)
                {
                    foreach (HttpPostedFile file in fupAttachment.PostedFiles)
                    {
                        bool fileError = false;
                        var fileExtension = System.IO.Path.GetExtension(file.FileName).ToLower();
                        var fileName = string.Format("{0}_{1}{2}", Servston.Utilities.GetRandomString(5, true), System.IO.Path.GetFileNameWithoutExtension(file.FileName), fileExtension);
                        //Is the file too big to upload?
                        int fileSize = file.ContentLength;
                        if (fileSize > (6*1024*1024))
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


                if (errorsList.Count > 0)
                {
                    RedirectAndNotify(GetLocalizedUrl("providers/services-requests/inprogress-requests"), string.Join("\r\n", errorsList.ToArray()), "حدث خطأ أثناء الطلب", NotificationType.Error);
                    //Notify(string.Join("\r\n", errorsList.ToArray()), "حدث خطأ أثناء الطلب", NotificationType.Error);
                }
                else
                {
                    if (fileNames.Count > 0)
                    {
                        _serviceRequests.AddRequestAttchments(fileNames, requestId,true);
                    }
                    _serviceRequests.CloseProviderRequest(requestId);
                    RedirectAndNotify(GetLocalizedUrl("providers/services-requests/inprogress-requests"), "تم تفيذ الخدمة");
                    //Server.Transfer(GetLocalizedUrl("providers/services-requests/inprogress-requests")+ "?msg=تم تفيذ الخدمة&msgtype=0");
                }


            }
            catch (Exception ex)
            {
                Server.ClearError();
                RedirectAndNotify(GetLocalizedUrl("providers/services-requests/inprogress-requests"), "حدث خطأ أثناء الطلب", "", NotificationType.Error);
            }
        }

        protected void lvServiceRequest_OnItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateModel")
            {
                int id = int.Parse(e.CommandArgument.ToString());
                int duration = int.Parse(Request.Form["txtDuration"]);
                _serviceRequests.IncreaceRequestDuration(id, duration);
            }
        }

        protected void OnClick(object sender, EventArgs e)
        {

        }
    }
}