using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.UI;

namespace Khadmatcom
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkID=303951
        public static void RegisterBundles(BundleCollection bundles)
        {

            bundles.Add(new ScriptBundle("~/bundles/masterjs").Include(
                "~/scripts/jquery-{version}.js",
                "~/scripts/bootstrap.js",
                "~/scripts/tether.js",
                "~/scripts/jquery.validationEngine.js",
                "~/scripts/toastr.min.js",
                "~/scripts/jquery.blockUI.min.js",
                "~/scripts/jquery.magnific-popup.min.js",
                "~/scripts/jquery.mask.js",
                "~/scripts/functions.js",
                "~/scripts/site-query.js"
                ));

            ScriptManager.ScriptResourceMapping.AddDefinition(
                "respond",
                new ScriptResourceDefinition
                {
                    Path = "~/Scripts/respond.min.js",
                    DebugPath = "~/Scripts/respond.js",
                });
        }
    }
}