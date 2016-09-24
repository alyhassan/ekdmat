
function createMap(latitude, longitude, mapContainerId, zoom, mapType) {
    /// <summary>create Google map in the passed mapContainerId element</summary>
    /// <param name="latitude" type="double">Latitude</param>
    /// <param name="longitude" type="double">longitude</param>
    /// <param name="mapContainerId" type="string">Html Element ID that will contain the map</param>
    /// <param name="zoom" type="int">Zoom value from 1 till 22</param>
    /// <param name="mapType" type="string">one of the following values: roadMap, terrain, hybrid, satellite</param>
    /// <returns type="object">Returns a reference to created map object</returns>

    // Enable the visual refresh
    google.maps.visualRefresh = true;
    var googleMapType;
    switch (mapType) {
        case "roadmap":
            googleMapType = google.maps.MapTypeId.ROADMAP;
            break;
        case "terrain":
            googleMapType = google.maps.MapTypeId.TERRAIN;
            break;
        case "hybrid":
            googleMapType = google.maps.MapTypeId.HYBRID;
            break;
        case "satellite":
        default:
            googleMapType = google.maps.MapTypeId.SATELLITE;
            break;

    }
    var mapOptions = {
        zoom: zoom,
        center: new google.maps.LatLng(latitude, longitude), //24.886436490787712, -70.2685546875
        mapTypeId: googleMapType
    };

    map = new google.maps.Map(document.getElementById(mapContainerId), //map-canvas
        mapOptions);

    return map;
};


function createMarker(map, latitude, longitude, dragabble, draggingCallBack, markerIconUrl) {
/// <summary></summary>
/// <param name="map" type="Object"></param>
/// <param name="latitude" type="Object"></param>
/// <param name="longitude" type="Object"></param>
/// <param name="dragabble" type="Object"></param>
/// <param name="draggingCallBack" type="Object"></param>
/// <param name="markerIconUrl" type="Object"></param>

    var markerOptions = {
        map: map,
        position: new google.maps.LatLng(latitude, longitude),
        dragabble : dragabble == null ? false: dragabble,
        icon: markerIconUrl.length > 0 ? markerIconUrl : ""
    };

    var marker = new google.maps.Marker(markerOptions);

    if (dragabble && draggingCallBack != null) {
        google.maps.event.addListener(marker, 'dragend', function () {
            callback(marker.getPosition());
        });
    }
        
    return marker;
};


function drawingOptions(strokeColor, strokeOpacity, strokeWeight, fillColor, fillOpacity) {
    /// <summary>creates drwaing option object with (strokeColor, strokeOpacity, strokeWeight, fillColor, fillOpacity)</summary>
    /// <param name="strokeColor" type="string">A hexadecimal notation (HEX) for the desired stroke Color</param>
    /// <param name="strokeOpacity" type="float">represtents the Opacity desired for the stroke line (from 0 to 1)</param>
    /// <param name="strokeWeight" type="int">specifies the weight of the line's stroke in pixels</param>
    /// <param name="fillColor" type="string">A hexadecimal notation (HEX) for the desired fill Color</param>
    /// <param name="fillOpacity" type="float">represtents the Opacity desired for the fill (from 0 to 1)</param>

    this.strokeColor = strokeColor == null ? '#FF0000' : strokeColor;
    this.strokeOpacity = strokeOpacity == null ? 0.8 : strokeOpacity;
    this.strokeWeight = strokeWeight == null ? 2 : strokeWeight;
    this.fillColor = fillColor == null ? '#FF0000' : fillColor;
    this.fillOpacity = fillOpacity == null ? 0.35 : fillOpacity;

    return this;
}

function drawCircle(map, latitude, longitude, radius, unit, drawingOptions, fitMapBoundsToCircle) {
    /// <summary>creates a circle object on specifec map</summary>
    /// <param name="map" type="google map">google map which contians the circle object</param>
    /// <param name="latitude" type="double">latitude of the center point</param>
    /// <param name="longitude" type="double">longitude of the center point</param>
    /// <param name="radius" type="double">radius of the circle</param>
    /// <param name="unit" type="string">the type of the radius specified values ("miles","kilometers","meters")</param>
    /// <param name="drawingOptions" type="drawingOptions">drawingOptions</param>
    /// <returns type="object">Returns a reference to created circle object</returns>

    if (isNaN(radius)) {
        alert("Invalid Radius, must be a valid number");
        return;
    }

    var circleUnit;
    switch (unit) {
        case "miles":
            radius = radius * 1609.34;
            break;
        case "kilometers":
            radius = radius * 1000;
            break;
        case "meters":
        default:
            break;
    }
    // Construct the circle for each value in map.
    // radius is in KM
    var circleOptions = {
        strokeColor: drawingOptions.strokeColor,
        strokeOpacity: drawingOptions.strokeOpacity,
        strokeWeight: drawingOptions.strokeWeight,
        fillColor: drawingOptions.fillColor,
        fillOpacity: drawingOptions.fillOpacity,
        map: map,
        center: new google.maps.LatLng(latitude, longitude),
        radius: parseInt(radius)
    };
    var circle = new google.maps.Circle(circleOptions);

    if (fitMapBoundsToCircle === true) {
        map.fitBounds(circle.getBounds());
    }

    return circle;
};

function removeCircle(circle) {
    /// <summary></summary>
    /// <param name="circle" type="Object">circle to remove</param>

    circle.setMap(null);
}

function removeMarker(marker) {
    /// <summary></summary>
    /// <param name="marker" type="google marker">marker to remove</param>

    marker.setMap(null);
}

function islocatedInsidePolygon(latitude, longitude, polygon) {
    /// <summary>checks if a certain point is licated inside a given polygon</summary>
    /// <param name="latitude" type="double">latitude of point</param>
    /// <param name="longitude" type="double">longitude of point<</param>
    /// <param name="polygon" type="google polygon">polygon<</param>
    /// <returns type="object">Returns boolean if the point is located in side</returns>
    var point = new google.maps.LatLng(latitude, longitude);
    var polygonBounds = polygon.getBounds();
    return polygonBounds.contains(point);
}

function calculateDistance(point1latitude, point1longitude, point2latitude, point2longitude, mode, callBackfunction) {
    /// <summary>Calculates Distance between two point on google map</summary>
    /// <param name="point1latitude" type="double">latitude of first point</param>
    /// <param name="point1longitude" type="double">longitude of first point<</param>
    /// <param name="point2latitude" type="double">latitude of second point<</param>
    /// <param name="point2longitude" type="double">longitude of second point</param>
    /// <param name="mode" type="string">value of "straightLine" to calculate stright line distance between the two points</param>
    /// <param name="callBackfunction" type="function">the desired function to excute at callback EX: (callback(response, status))</param>
    /// <returns type="object">in case of straight Line Returns the distance in KM fixed to two decimal points</returns>

    var point1 = new google.maps.LatLng(point1latitude, point1longitude);
    var point2 = new google.maps.LatLng(point2latitude, point2longitude);

    if (mode == "straightLine" || mode == 'undefined') {
        return (google.maps.geometry.spherical.computeDistanceBetween(point1, point2) / 1000).toFixed(2);
    }
    else {
        var service = new google.maps.DistanceMatrixService();
        service.getDistanceMatrix(
                      {
                          origins: [point1],
                          destinations: [point2],
                          travelMode: google.maps.TravelMode.DRIVING,
                          unitSystem: google.maps.UnitSystem.METRIC,
                          avoidHighways: false,
                          avoidTolls: false
                      }, callback);
    }

}

function geocodeLocation(address, callback) {
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'address': address }, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            callback(results[0].geometry.location);
        } else {
            alert('Geocode was not successful for the following reason: ' + status);
        }
    });
}

