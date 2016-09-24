using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace Khadmatcom
{
    public abstract class MasterBase : System.Web.UI.MasterPage
    {
        public abstract void ShowNotifier(string message, string title, NotificationType notificationType);

        protected string ToJson<T>(T obejctToSerialize)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(obejctToSerialize);
        }
    }
}