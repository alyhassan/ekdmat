using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khadmatcom.Data.Model;
using Khadmatcom.Services;
using Region = Khadmatcom.Services.Model.Region;

namespace Khadmatcom.providers
{
    public partial class request_details : PageBase
    {

        protected int _id;
        private readonly ServiceRequests _serviceRequests;
        private readonly AreasServices _areasServices;
        protected ServiceRequest CurrentRequest;
       
        
        protected void Page_Load(object sender, EventArgs e)
        {
            string encruptedIdValue = "";
            TryGetRouteParameter("Key", out encruptedIdValue);
            _id = encruptedIdValue.DecodeNumber();

            CurrentRequest = _serviceRequests.GetRequest(_id);
        }

        public request_details()
        {
            _serviceRequests = new ServiceRequests();
            _areasServices = new AreasServices();
        }

        public IQueryable<Region> GetRegions()
        {

            return _areasServices.GetRegions(LanguageId).AsQueryable();
        }
        public List<RequestsOptionsAnswer> GetAnswers()
        {
            return CurrentRequest.RequestsOptionsAnswers.ToList();
        }
    }
}