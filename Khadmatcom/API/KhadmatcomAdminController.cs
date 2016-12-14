using MailChimp;
using MailChimp.Helper;
using MailChimp.Lists;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.Serialization;
using System.Threading;
using System.Web.Configuration;
using System.Web.Http;
using Khadmatcom.Services;
using HyperPayClient;

namespace Khadmatcom.API
{


    public class KhadmatcomAdminController : ApiController
    {
        [HttpGet]
        [ActionName("Transfare")]
        public bool Transfare(int id,  string code)
        {
            try
            {
                AdminServices adminServices = new AdminServices();
                adminServices.TransfareToProvider(id,  code);
                return true;
            }
            catch (Exception ex)
            {
                // todo:log the exception
                return false;

            }
        }

        [HttpGet]
        [ActionName("ShipTransaction")]
        public bool ShipTransaction(int id)
        {
            try
            {
                AdminServices adminServices = new AdminServices();
                adminServices.ToNextShippingStatus(id);
                return true;
            }
            catch (Exception ex)
            {
                // todo:log the exception
                return false;

            }
        }

        [HttpGet]
        [ActionName("ConfirmRequest")]
        public bool ConfirmRequest(int id,bool dummy,int x)
        {
            try
            {
                AdminServices adminServices = new AdminServices();
                adminServices.ConfirmRequest(id);
                return true;
            }
            catch (Exception ex)
            {
                // todo:log the exception
                return false;

            }
        }
        
    }
}
