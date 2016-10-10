
$(document).ready(function () {

    function toggleChevron(e) {
        $(e.target)
            .prev('.accordion-heading')
            .find(".indi")
           .toggleClass('fa-chevron-up fa-chevron-down')
         .toggleClass('accordion-active');


        //.toggleClass('L-button');

    }
    $('#accordion,#accordion01,#accordion02, #accordion2, #accordion3, #accordion4, #accordion5,#accordion500').on('hidden.bs.collapse', toggleChevron);
    $('#accordion,#accordion01,#accordion02, #accordion2, #accordion3, #accordion4, #accordion5,#accordion500').on('shown.bs.collapse', toggleChevron);


    function toggleHas(f) {
        $(f.target)
       .prev('.fal')
       .find(".accordion-heading")
       .toggleClass('lanti200');

    }

    $("#accordion500").on('hidden.bs.collapse', toggleHas);
    $("#accordion500").on('shown.bs.collapse', toggleHas);


    $("#accordion5").on('hidden.bs.collapse', toggleHas2);
    $("#accordion5").on('shown.bs.collapse', toggleHas2);
    function toggleHas2(g) {
        $(g.target)
       .prev('.accordion-heading')
       .find(".accordion-toggle")
       .toggleClass('blue_backgroung');

    }



    function toggleHas1(g) {
        $(g.target)
       .prev('.accordion-heading')
       .find(".accordion-toggle")
       .toggleClass('chutya');

    }

    $("#accordion4").on('hidden.bs.collapse', toggleHas1);
    $("#accordion4").on('shown.bs.collapse', toggleHas1);



    $(".vdeo").click(function () {

        $(".iframeVideoHome").attr('src', 'https://www.youtube.com/embed/XGSy3_Czz8k' + '?rel=0');

    });


    //cange group event
    $('#group').change(function () {
        if ($(this).val() === '1') {

            $("#personal").show();
            $("#business").hide();

        }
        else if ($(this).val() === '2') {

            $("#business").show();
            $("#personal").hide();
        }
        else {
            $("#personal").hide();
            $("#business").hide();
        }


    });





    $('.next1').click(function () {
        $(".sub").removeClass("sub-remove");

        if ($('.alif:last').hasClass('active')) {

            $('.next1').attr('disabled', true)
        }

        else {
            $('.active').removeClass('active').next().addClass('active');


        }

    });

    $('.next2').click(function () {
        $(".sub2").removeClass("sub-remove");

        if ($('.alif:last').hasClass('active')) {

            $('.next2').attr('disabled', true)
        }

        else {
            $('.active').removeClass('active').next().addClass('active');


        }

    });


    $(".app-close").click(function () {

        //location.href = "Default.aspx";

    });


    $('.nxt').click(function () {

        if ($("#ai li:last").hasClass('active')) {
            $('.nxt').attr('disabled', true)

        }

        else {
            $("#ai").find('.active').removeClass('active').next().addClass('active');
            //$("#all").find('.active').removeClass('active').next().addClass('active');

            //$('.active').removeClass('active').next().addClass('active');
            //$('.active').removeClass('active').next().addClass('active');


        }
    });

    $('.prv').click(function () {
        if ($('#ai li').eq(0).hasClass('active')) {
            $('.prv').attr('disabled', true)
        }
        else {
            $("#ai:last").find('.active').removeClass('active').prev().addClass('active');
            //$("#all").find('.active').removeClass('active').prev().addClass('active');

        }


    });



    $('.sub').click(function () {
        $(".sub2").addClass("sub-remove");
    });

    $('.main').click(function () {


        $(".sub").addClass("sub-remove");
        $(".sub2").addClass("sub-remove");



    });






    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }


    var se = getParameterByName('se');
    if (se == 'person') {

        $(".Pslider").fadeIn();
        $(".C-slider").hide();

        //$(".prsonal").addClass("akjesa");


    }



    else if (se == 'commercial') {
        $(".P-slider").hide();
        $(".C-slider").fadeIn();

        //$(".commercial").addClass("akjesa");


    }
    else if (se == 'active-service1') {
        $("#right1").addClass("in");

        $("a[href='service.aspx?se=active-service1']").addClass("service-add");
    }

    else if (se == 'active-service2') {
        $("#right1").addClass("in");

        $("a[href='service.aspx?se=active-service2']").addClass("service-add");
    }

    else if (se == 'active-service3') {
        $("#right1").addClass("in");

        $("a[href='service.aspx?se=active-service3']").addClass("service-add");
    }

    else if (se == 'active-service4') {
        $("#right1").addClass("in");

        $("a[href='service.aspx?se=active-service4']").addClass("service-add");
    }

    else if (se == 'active-service5') {
        $("#right1").addClass("in");

        $("a[href='service.aspx?se=active-service5']").addClass("service-add");
    }

    else if (se == 'hi') {

        $("#p10").addClass("in");
        $("#p10").css({ "display": "block", "margin": "30px 0" });
        $(".modal-l").css({ "display": "block" });
    }




    $("#service").click(function () {

        $(".Pslider").css({ "display": "none", "transition": "all 0.5s" });
        $(".P-sub1").css({ "display": "block", "transition": "all 0.5s" });

    });



    $(".MobileMenu").click(function () {
        $(".A-Div").fadeIn();

    });

    $(".A-Div").click(function () {
        $(".A-Div").hide();
        $(".navbar-collapse").removeClass("in");
    });




    $("#id11").click(function () {
        $(".forgot").show();
        $(".l1").hide();
        $(".chnge").contents().last()[0].textContent = 'Forgot Password';

    });


    $("#B-login").click(function () {

        $(".forgot").hide();
        $(".l1").show();
        $(".chnge").contents().last()[0].textContent = 'Sign In';
    });




    $("input[name$='cars']").click(function () {
        var test = $(this).val();

        $(".c-card").hide();
        $("#c-card" + test).show();
    });


    $("#ll").click(function () {

        $(".ll-div").show();
        $(".chuu").hide();


    });


    $("#ll2").click(function () {

        $(".ll-div").show();
        $(".chuu").hide();


    });

    $(".lpc .accordion-body a").click(function () {

        $(".ll-div").hide();
        $(".chuu").show();


    });


    /*end*/
});




function PlayVideo() {

    $(".iframeVideoHome").attr('src', 'https://www.youtube.com/embed/XGSy3_Czz8k' + '?rel=0&autoplay=1');

}

