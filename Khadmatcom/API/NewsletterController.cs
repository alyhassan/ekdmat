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

namespace Khadmatcom.API
{
    [DataContract]
    public class NameMergeVars :MergeVar
    {
        [DataMember(Name = "FNAME")]
        public string FirstName { get; set; }

        [DataMember(Name = "LNAME")]
        public string LastName { get; set; }
    }

    public class NewsletterController : ApiController
    {
        [HttpGet]
        [ActionName("SignupNewsletter")]
        public bool SignupNewsletter(string name, string email)
        {
            string newsLetterIdKeyName;
            switch (Thread.CurrentThread.CurrentUICulture.LCID)
            {
                default:
                    newsLetterIdKeyName = "NewsletterListId";
                    break;
            }

            try
            {

                MailChimpManager mc = new MailChimpManager(WebConfigurationManager.AppSettings["MailChimpApiKey"]);

                //  Create the email parameter
                EmailParameter mailChimpEmail = new EmailParameter()
                {
                    Email = email
                };

                NameMergeVars nameVars = new NameMergeVars();

                string[] nameParts = name.Trim().Split(' ');
                nameVars.FirstName = nameParts.Length > 1 ? nameParts[0] : name;
                if (nameParts.Length > 1 && nameParts[1].Length > 0)
                {
                    nameVars.LastName = nameParts[1];
                }

                EmailParameter results = mc.Subscribe(WebConfigurationManager.AppSettings[newsLetterIdKeyName], mailChimpEmail, nameVars);

                if (string.IsNullOrWhiteSpace(results.EUId))
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                // log the exception
                throw ex;
            }
        }

        [HttpGet]
        [ActionName("UnsubscribeNewsLetter")]
        public bool UnsubscribeNewsLetter(string email)
        {
            string newsLetterIdKeyName;
            switch (Thread.CurrentThread.CurrentUICulture.LCID)
            {
                default:
                    newsLetterIdKeyName = "NewsletterListId";
                    break;
            }
            try
            {
                MailChimpManager mc = new MailChimpManager(WebConfigurationManager.AppSettings["MailChimpApiKey"]);

                //  Create the email parameter
                EmailParameter mailChimpEmail = new EmailParameter()
                {
                    Email = email
                };

                UnsubscribeResult results = mc.Unsubscribe(WebConfigurationManager.AppSettings[newsLetterIdKeyName], mailChimpEmail);

                if (!results.Complete)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                // log the exception
                throw ex;
            }
        }
    }
}
