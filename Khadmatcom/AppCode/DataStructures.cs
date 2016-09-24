using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Khadmatcom
{

    public class SessionTimeOutOptions
    {
        public int SecondsToRedirect { get; set; }
        public string RedirectUrl { get; set; }
        public string LogoutUrl { get; set; }
    }

    public enum NotificationType : int
    {
        Success = 0,
        Error = 1,
        Warning = 2,
        Info = 3,
    }

    public enum RequestStatus : int
    {
        New = 1,
        Approved = 2,
        Paid = 3,
        InProgress = 4,
        Accomplished = 5,
        Refused = 6,
        Canceled = 7,
        Expired = 8
    }
    public enum DistanceUnit
        : int
    {
        Meters = 0,
        Kilometers = 1,
        Miles = 2
    }

    public enum GoogleMapType : int
    {
        RoadMap = 0,
        Terrain = 1,
        Hybrid = 2,
        Satellite = 3,
    }

}