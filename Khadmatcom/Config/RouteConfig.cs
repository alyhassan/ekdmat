using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace Khadmatcom
{
    public static class RouteConfig
    {

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.Ignore("{resource}.axd/{*pathInfo}");

            RouteValueDictionary defaultLocale = new RouteValueDictionary { { "locale", "ar" } };
            RouteValueDictionary localeConstraints = new RouteValueDictionary { { "locale", "en|ar" } };
            RouteValueDictionary typesConstraints = new RouteValueDictionary { { "types", "personal|business" } };
            #region Arabic Routes

            //RouteTable.Routes.MapPageRoute("home-personal", "personal", "~/default.aspx");
            //RouteTable.Routes.MapPageRoute("home-business", "business", "~/default.aspx");

            RouteTable.Routes.MapPageRoute("user-info", "user-info", "~/user-info.aspx");
            RouteTable.Routes.MapPageRoute("card-info", "card-info", "~/card-info.aspx");
            RouteTable.Routes.MapPageRoute("join-request", "join-request", "~/join-request.aspx");
            RouteTable.Routes.MapPageRoute("provider-join-request", "service-provider/join-request", "~/join-request.aspx");
            //categories
            RouteTable.Routes.MapPageRoute("category-personal", "{Section}/categories", "~/categories.aspx");
            RouteTable.Routes.MapPageRoute("category-business", "{Section}/categories", "~/categories.aspx");
            //sub categories
            RouteTable.Routes.MapPageRoute("sub-category-personal", "{Section}/{UrlName}/{CategoryId}/categories", "~/category.aspx");
            RouteTable.Routes.MapPageRoute("sub-category-business", "{Section}/{UrlName}/{CategoryId}/categories", "~/category.aspx");
            //sub category services
            RouteTable.Routes.MapPageRoute("services-personal", "{Section}/{CategoryUrlName}/{UrlName}/{SubcategoryId}/services", "~/services.aspx");
            RouteTable.Routes.MapPageRoute("services-business", "{Section}/{CategoryUrlName}/{UrlName}/{SubcategoryId}/services", "~/services.aspx");

            //info pages
            RouteTable.Routes.MapPageRoute("info-pages", "info/{UrlName}", "~/info-page.aspx");

            ////projects
            //RouteTable.Routes.MapPageRoute("project", "projects/{UrlName}/{ProjectId}", "~/project.aspx");
            //RouteTable.Routes.MapPageRoute("construction-progress", "construction-progress/{UrlName}/{ProjectId}", "~/construction-progress.aspx");
            //RouteTable.Routes.MapPageRoute("floor-plans", "floor-plans/{UrlName}/{ProjectId}", "~/floor-plans.aspx");

            ////properties
            //RouteTable.Routes.MapPageRoute("properties", "property-listing", "~/property-listing.aspx");
            //RouteTable.Routes.MapPageRoute("properties-for", "property-listing/{Status}", "~/property-listing.aspx");
            //RouteTable.Routes.MapPageRoute("property", "properties/{UrlName}/{PropertyId}", "~/property-details.aspx");

            //client urls
            RouteTable.Routes.MapPageRoute("clients-new-request", "clients/services-requests/", "~/clients/default.aspx");
            RouteTable.Routes.MapPageRoute("clients-new-request2", "clients/services-requests/new-requests", "~/clients/default.aspx");
            RouteTable.Routes.MapPageRoute("clients-inprogress-new request", "clients/services-requests/inprogress-requests", "~/clients/inprogress-requests.aspx");
            RouteTable.Routes.MapPageRoute("clients-refused-request", "clients/services-requests/refused-requests", "~/clients/refused-requests.aspx");
            RouteTable.Routes.MapPageRoute("clients-expired-request", "clients/services-requests/expired-requests", "~/clients/expired-requests.aspx");
            RouteTable.Routes.MapPageRoute("clients-canceled-request", "clients/services-requests/canceled-requests", "~/clients/canceled-requests.aspx");
            RouteTable.Routes.MapPageRoute("clients-approved-request", "clients/services-requests/approved-requests", "~/clients/approved-requests.aspx");
            RouteTable.Routes.MapPageRoute("clients-accomplished-request", "clients/services-requests/finished-requests", "~/clients/accomplished-requests.aspx");
            RouteTable.Routes.MapPageRoute("clients-request-details", "clients/services-requests/{Key}/request-details", "~/clients/request-details.aspx");

            //providers urls
            RouteTable.Routes.MapPageRoute("providers-new-request", "providers/services-requests/", "~/providers/default.aspx");
            RouteTable.Routes.MapPageRoute("providers-providers-new-request2", "providers/services-requests/new-requests", "~/providers/default.aspx");
            RouteTable.Routes.MapPageRoute("providers-inprogress-request", "providers/services-requests/inprogress-requests", "~/providers/inprogress-requests.aspx");
            RouteTable.Routes.MapPageRoute("providers-refused-request", "providers/services-requests/refused-requests", "~/providers/refused-requests.aspx");
            RouteTable.Routes.MapPageRoute("providers-expired-request", "providers/services-requests/expired-requests", "~/providers/expired-requests.aspx");
            RouteTable.Routes.MapPageRoute("providers-canceled-request", "providers/services-requests/canceled-requests", "~/providers/canceled-requests.aspx");
            RouteTable.Routes.MapPageRoute("providers-approved-request", "providers/services-requests/approved-requests", "~/providers/approved-requests.aspx");
            RouteTable.Routes.MapPageRoute("providers-accomplished-request", "providers/services-requests/finished-requests", "~/providers/accomplished-requests.aspx");
            RouteTable.Routes.MapPageRoute("providers-request-details", "providers/services-requests/{Key}/request-details", "~/providers/request-details.aspx");

            //managment
            RouteTable.Routes.MapPageRoute("providers-list", "managment/providers", "~/admin-area/providers.aspx");
            RouteTable.Routes.MapPageRoute("new-provider-managment", "managment/providers/new", "~/admin-area/provider.aspx");
            RouteTable.Routes.MapPageRoute("provider-managment", "managment/providers/{Key}/provider-info", "~/admin-area/provider.aspx");

            //404
            RouteTable.Routes.MapPageRoute("404", "error/404", "~/error/404.aspx");
            #endregion

            //Add Custom Routes Here
            //RouteTable.Routes.MapPageRoute("route-name", "page/{RouteParameter}", "~/page.aspx");

            //Friendly URLs
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);

            #region Localized Routes
            RouteTable.Routes.MapPageRoute("user-info-loc", "{locale}/user-info", "~/user-info.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("join-request-loc", "{locale}/join-request", "~/join-request.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("provider-join-request-loc", "{locale}/service-provider/join-request", "~/join-request.aspx", false, defaultLocale, localeConstraints);
            //Home
            //RouteTable.Routes.MapPageRoute("home-loc", "{locale}/", "~/default.aspx", false, defaultLocale, localeConstraints);
            //RouteTable.Routes.MapPageRoute("home-personal-loc", "{locale}/personal", "~/default.aspx", false, defaultLocale, localeConstraints);
            //RouteTable.Routes.MapPageRoute("home-business-loc", "{locale}/business", "~/default.aspx", false, defaultLocale, localeConstraints);
            //categories
            RouteTable.Routes.MapPageRoute("category-personal-loc", "{locale}/{Section}/categories", "~/categories.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("category-business-loc", "{locale}/{Section}/categories", "~/categories.aspx", false, defaultLocale, localeConstraints);
            //sub categories
            RouteTable.Routes.MapPageRoute("sub-category-personal-loc", "{locale}/{Section}/{UrlName}/{CategoryId}/categories", "~/category.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("sub-category-business-loc", "{locale}/{Section}/{UrlName}/{CategoryId}/categories", "~/category.aspx", false, defaultLocale, localeConstraints);
            //sub category services
            RouteTable.Routes.MapPageRoute("services-personal-loc", "{locale}/{Section}/{CategoryUrlName}/{UrlName}/{SubcategoryId}/services", "~/services.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("services-business-loc", "{locale}/{Section}/{CategoryUrlName}/{UrlName}/{SubcategoryId}/services", "~/services.aspx", false, defaultLocale, localeConstraints);


            //client urls
            RouteTable.Routes.MapPageRoute("clients-new-request-loc", "{locale}/clients/services-requests/", "~/clients/default.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("clients-new-request2-loc", "{locale}/clients/services-requests/new-requests", "~/clients/default.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("clients-inprogress-request-loc", "{locale}/clients/services-requests/inprogress-requests", "~/clients/inprogress-requests.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("clients-refused-request-loc", "{locale}/clients/services-requests/refused-requests", "~/clients/refused-requests.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("clients-expired-request-loc", "{locale}/clients/services-requests/expired-requests", "~/clients/expired-requests.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("clients-canceled-request-loc", "{locale}/clients/services-requests/canceled-requests", "~/clients/canceled-requests.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("clients-approved-request-loc", "{locale}/clients/services-requests/approved-requests", "~/clients/approved-requests.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("clients-accomplished-request-loc", "{locale}/clients/services-requests/finished-requests", "~/clients/accomplished-requests.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("clients-request-details-loc", "{locale}/clients/services-requests/{Key}/request-details", "~/clients/request-details.aspx", false, defaultLocale, localeConstraints);

            //providers urls
            RouteTable.Routes.MapPageRoute("providers-new-request-loc", "{locale}/providers/services-requests/", "~/providers/default.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("providers-providers-new-request2-loc", "{locale}/providers/services-requests/new-requests", "~/providers/default.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("providers-inprogress-request-loc", "providers/services-requests/inprogress-requests", "~/providers/inprogress-requests.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("providers-refused-request-loc", "{locale}/providers/services-requests/refused-requests", "~/providers/refused-requests.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("providers-expired-request-loc", "{locale}/providers/services-requests/expired-requests", "~/providers/expired-requests.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("providers-canceled-request-loc", "{locale}/providers/services-requests/canceled-requests", "~/providers/canceled-requests.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("providers-approved-request-loc", "{locale}/providers/services-requests/approved-requests", "~/providers/approved-requests.aspx");
            RouteTable.Routes.MapPageRoute("providers-accomplished-request-loc", "{locale}/providers/services-requests/finished-requests", "~/providers/accomplished-requests.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("providers-request-details-loc", "{locale}/providers/services-requests/{Key}/request-details", "~/providers/request-details.aspx", false, defaultLocale, localeConstraints);


            //info pages
            RouteTable.Routes.MapPageRoute("info-pages-loc", "{locale}/info/{UrlName}", "~/info-page.aspx", false, defaultLocale, localeConstraints);

            //about-us
            RouteTable.Routes.MapPageRoute("about-us-loc", "{locale}/about-us", "~/about-us.aspx", false, defaultLocale, localeConstraints);
            //contact us
            RouteTable.Routes.MapPageRoute("contact-loc", "{locale}/contact-us", "~/contact-us.aspx", false, defaultLocale, localeConstraints);

            //managment
            RouteTable.Routes.MapPageRoute("providers-list-loc", "{locale}/managment/providers", "~/admin-area/providers.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("new-provider-managment-loc", "{locale}/managment/providers/new", "~/admin-area/provider.aspx", false, defaultLocale, localeConstraints);
            RouteTable.Routes.MapPageRoute("provider-managment-loc", "{locale}/managment/providers/{Key}/provider-info", "~/admin-area/provider.aspx", false, defaultLocale, localeConstraints);

            //404
            RouteTable.Routes.MapPageRoute("404-loc", "{locale}/error/404", "~/error/404.aspx", false, defaultLocale, localeConstraints);
            #endregion
        }
        //public static void RegisterRoutes(RouteCollection routes)
        //{
        //    //Add Custom Routes Here
        //    //RouteTable.Routes.MapPageRoute("route-name", "page/{RouteParameter}", "~/page.aspx");

        //    //Friendly URLs
        //    var settings = new FriendlyUrlSettings();
        //    settings.AutoRedirectMode = RedirectMode.Permanent;
        //    routes.EnableFriendlyUrls(settings);
        //}
    }
}
