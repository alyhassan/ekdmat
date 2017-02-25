/*============================ MailList subscription ================================================================*/
function signupNewsletter(name, email) {
    showLoading();
    var regEmail = /^.+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3}|[0-9]{1,3})(\]?)$/;

    if (email == '' || email.length == 0 || !regEmail.test(email)) {
        hideLoading();
        toastr.error("Email is missing or invalid", "Error");
        return;
    }

    if (name == '' || name == null || name == undefined) {
        hideLoading();
        toastr.error("Name is missing or invalid", "Error");
        return;
    }
    var data = {
        name: name,
        email: email
    };
    $.getJSON("/api/Newsletter/SignupNewsletter", data, function (res) {
        if (res) {
            hideLoading();
            toastr.success("Your email has been added successfully from our mailing list", "Sorry");
        }
        else {
            hideLoading();
            toastr.error("Error processing your request , please try again later or contact us if the problem persists.", "Error");
        }
    });
}

function unsubscribeNewsletter(email) {
    showLoading();
    var regEmail = /^.+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3}|[0-9]{1,3})(\]?)$/;

    if (email == '' || email.length == 0 || !regEmail.test(email)) {
        hideLoading();
        toastr.error("Email is missing or invalid", "Error");
        return;
    }

    var data = { "email": email };
    $.getJSON("/api/Newsletter/UnsubscribeNewsLetter", data, function (res) {
        if (res) {
            hideLoading();
            toastr.success("Your email has been removed successfully from our mailing list", "Sorry");
        }
        else {
            hideLoading();
            toastr.error("Error processing your request , please try again later or contact us if the problem persists.", "Error");
        }
    });
}

/*============================ Validation Engine ================================================================*/
function validateForm(containerSelector, lan) {
    // initialize validation
    if (lan === 'ar')
        $(containerSelector).validationEngine('attach', { promptPosition: "topLeft" });
    else
        $(containerSelector).validationEngine('attach', { promptPosition: "topRight" });

    var result = $(containerSelector).validationEngine('validate');
    return result;
}

/*============================ Navigation ================================================================*/
//replace menuSelector and activeClass according to site Css
//var menuSelector = ".menu";
//var activeClass = "button th-yellow active";
//replace array elements with supported languages, if not a localized site, just set languages = []
//var languages = ["ru"];
function setNavigationActiveItem(menuSelector, activeClass, languages) {

    var path = window.location.pathname;
    path = decodeURIComponent(path);
    path = path.replace(/\/$/, "");


    var segments = path.split("/");
    while (segments.indexOf("") > -1) { //clean up empty segments
        segments.splice(segments.indexOf(""), 1);
    }

    //check if url starts with a locale
    var isUrlLocalized = false;
    for (var i = 0; i < languages.length; i++) {
        if (segments[0] == languages[i]) {
            isUrlLocalized = true;
            break;
        }
    }

    var match;
    var menu = $(menuSelector);
    if (path == "") {
        menu.children("li").eq(0).addClass(activeClass); //home page
        return;
    }
    for (var i = 0; i < languages.length; i++) {
        if (path == "/" + languages[0]) {
            menu.children("li").eq(0).addClass(activeClass);
            return;
        }
    }


    //try root level pages (/contact-us, /about-us, etc.)
    if ((segments.length == 1 && isUrlLocalized === false) ||
        (segments.length == 2 && isUrlLocalized === true)) {
        match = $(menuSelector + ' a[href="' + path + '"]').parent(); //to get the container li
        if (match.length > 0) {
            match.addClass(activeClass);
            return;
        }
    }

    //try subsequent levels (2nd and further pages)
    match = $(menuSelector + ' a[href="' + path + '"]').parent();
    if (match.length > 0) {
        match.addClass(activeClass);
        return;
    }

    //no root level match found, check for submenu items' parent elments
    match = $(menuSelector + ' a[href^="' + path + '"]').closest("ul").prev().parent(); //to get the container li
    if (match.length > 0) {
        match.addClass(activeClass);
        return;
    }

    //TODO: add support for custom mappings here
    console.log("No active menu item match found!");
}

/*============================ Loading ================================================================*/
function showLoading(message) {
    $.blockUI({
        message: '<img src="/images/loading.gif" />',
        css: {
            border: 'none',
            backgroundColor: '#fff',
            '-webkit-border-radius': '10px',
            'border-radius': '10px',
            opacity: .8,
        }
    });
}

function hideLoading() {
    $.unblockUI();
}

/*============================ Magnific Popup ================================================================*/
//function openMagnificPopup(containerSelector, showCloseBtn, callBacksObject) {
//    $.magnificPopup.open({
//        items: {
//            type: 'inline',
//            src: containerSelector,
//        },
//        prependTo: "form",
//        closeBtnInside: true,
//        enableEscapeKey: true,
//        showCloseBtn: showCloseBtn,
//        callbacks: callBacksObject
//    }, 0);
//}

//function closeMagnificPopup() {
//    $.magnificPopup.close();
//}

/*==================================== clear form data ===============================================*/
function clearFormData(containerSelector) {
    $(containerSelector + ' input').not($(containerSelector + ' input:submit')).add($(containerSelector + ' textarea')).val('');
    $(containerSelector + ' select').val('');
}
/*============================ Weather ================================================================*/
function getWeather(city, format, daysCount, localTime, apikey) {
    var weekday = new Array(7);
    weekday[1] = "Sun"; //"Sunday";
    weekday[2] = "Mon"; //"Monday";
    weekday[3] = "Tue"; //"Tuesday";
    weekday[4] = "Wed"; //"Wednesday";
    weekday[5] = "Thu"; //"Thursday";
    weekday[6] = "Fri"; //"Friday";
    weekday[0] = "Sat"; //"Saturday";

    $.ajax({
        type: "GET",
        url: 'http://api.worldweatheronline.com/free/v1/weather.ashx?q=' + city + '&format=' + format + '&num_of_days=' + daysCount + '&key=' + apikey,
        contentType: "application/json; charset=utf-8",
        dataType: "jsonp",
        error: function (msg) {
            alert(msg);
        },
        success: function (msg) {
            $("#temp_C").html(msg.data.current_condition[0].temp_C + "&deg; C");
            $("#local_time").html('Local Time: <br />' + localTime);
            //$("#local_time").text(msg.data.current_condition[0].observation_time);
            $("#weatherDesc").text(msg.data.current_condition[0].weatherDesc[0].value);
            $("#windspeedKmph").html("Wind Speed: <br />" + msg.data.current_condition[0].windspeedKmph + ' Km/h');
            //$("#winddir16Point").text("Wind Direction: " + msg.data.current_condition[0].winddir16Point);
            $("#imgWeatherFlag").attr("src", msg.data.current_condition[0].weatherIconUrl[0].value.replace("http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_", "/images/weather-icons/wsymb8_"));
            $("#imgWeatherFlag").attr("alt", msg.data.current_condition[0].weatherDesc[0].value);

            var forcasting = "";
            var currentDate;
            if (daysCount > 5) {
                alert("maximum 5 forcasting days");
                daysCount = 5;
                return;
            }
            for (var i = 1; i < daysCount; i++) {
                currentDate = new Date(msg.data.weather[i].date);
                forcasting += "<div><h3>" + weekday[currentDate.getDay()] + "</h3><img src='" + msg.data.weather[i].weatherIconUrl[0].value + "' alt='" + msg.data.weather[i].weatherDesc[0].value + "' /> <h4>" + msg.data.weather[i].tempMaxC + " C</h4></span>";
            }
            $("#nextday").html(forcasting);
        }
    });
}

function doSomthing(functionName) {
    functionName;
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}