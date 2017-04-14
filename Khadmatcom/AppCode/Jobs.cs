using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Khadmatcom.Data.Model;
using Khadmatcom.Services;
using Quartz;

namespace Khadmatcom.AppCode
{
    public class Jobs : IJob
    {
        public void Execute(IJobExecutionContext context)
        {
            ServiceRequests requestsManager = new ServiceRequests();
            //get all the unreplaied requests and has new state
            List<RequestProvider> requests = requestsManager.GetAvalibaleRequests();

            //check if there is new requests
            if (requests.Any())
            {
                DateTime clientCurretTime = Servston.Utilities.GetCurrentClientDateTime();
                //update those requests state to expired if it has expired time
                foreach (RequestProvider request in requests.Where(request => request.ExpiryTime <= clientCurretTime))
                {
                    requestsManager.UpdateProviderRequest(request.RequestId, request.ProviderId, (int)RequestStutus.Expired,
                        "", request.Price ?? 0, 0);
                }
                /*  foreach (RequestProvider request in requests)
                  {
                      if (request.ExpiryTime <= Servston.Utilities.GetCurrentClientDateTime())
                      {
                          requestsManager.UpdateProviderRequest(request.RequestId, request.ProviderId, (int)RequestStutus.Expired, "", request.Price ?? 0, 0);
                      }
                  }*/
            }
        }
    }
}