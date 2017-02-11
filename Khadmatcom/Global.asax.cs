using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Http;

namespace Khadmatcom
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            GlobalConfiguration.Configure(WebApiConfig.Register);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        void Application_Error2(object sender, EventArgs e)
        {
            //Exception TheError = Server.GetLastError();
            //Server.ClearError();

            //// Avoid IIS7 getting in the middle
            //Response.TrySkipIisCustomErrors = true;

            //if (TheError is HttpException && ((HttpException)TheError).GetHttpCode() == 404)
            //{
            //    Response.Redirect("~/404.aspx");
            //}
            //else
            //{
            //    Response.Redirect("~/500.aspx");
            //}
            // Code that runs when an unhandled error occurs

            // Get the exception object.
            Exception exc = Server.GetLastError();

            // Handle HTTP errors
            if (exc.GetType() == typeof(HttpException))
            {
                // The Complete Error Handling Example generates
                // some errors using URLs with "NoCatch" in them;
                // ignore these here to simulate what would happen
                // if a global.asax handler were not implemented.
                if (exc.Message.Contains("NoCatch") || exc.Message.Contains("maxUrlLength"))
                    return;

                //Redirect HTTP errors to HttpError page
                Server.Transfer("~/error/generic.aspx");
            }

            // For other kinds of errors give the user some information
            // but stay on the default page
            //Response.Write("<h2>Global Page Error</h2>\n");
            //Response.Write(
            //    "<p>" + exc.Message + "</p>\n");
            //Response.Write("Return to the <a href='~/'>" +
            //    "الصفحة الرئيسية</a>\n");

            // Log the exception and notify system operators
            ExceptionUtility.LogException(exc, Request.Url.ToString());
            ExceptionUtility.NotifySystemOps(exc);

            // Clear the error from the server
            Server.ClearError();
            //Redirect HTTP errors to HttpError page
            Server.Transfer("~/error/generic.aspx");
        }
    }
}