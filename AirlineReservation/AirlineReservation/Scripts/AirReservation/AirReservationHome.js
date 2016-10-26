$(document).ready(function () {
    //Help Page init
    //document.body.style.zoom = "90%"
    //Set default hide return date
    $("#returnDateForm").hide();
    $("#lblReturnClass").hide();
    $("#returnClass").hide();
    $("#step1-result").hide();
    //Check ticket type, show/hide input return date
    $("input[name=optFlight]:radio").change(function () {
        if ($('#optFlightReturn').is(':checked')) {
            $("#returnDateForm").slideDown("slow");
            $("#lblReturnClass").slideDown("slow");
            $("#returnClass").slideDown("slow");
        } else {
            $("#returnDateForm").slideUp();
            $("#lblReturnClass").slideUp();
            $("#returnClass").slideUp();
        }
    });
    $("#aboutUsPage").hide();
    $("#registerFormMain").hide();
    $("#forgotPasswordFormMain").hide();

    $('.btn-eclipse').click(function () {
        $(".btn-eclipse").each(function (index) {
            $(this).removeClass('active');
        });
        $(this).toggleClass('active');
    });
});

function formMain(mode) {
    switch (mode) {
        case "login":
            $("#registerFormMain").hide("fast");
            $("#forgotPasswordFormMain").hide("fast");
            $("#loginFormMain").show("fast");
            break;
        case "register":
            $("#registerFormMain").show("fast");
            $("#loginFormMain").hide("fast");
            $("#forgotPasswordFormMain").hide("fast");
            break;
        case "forgotPassword":
            $("#registerFormMain").hide("fast");
            $("#forgotPasswordFormMain").show("fast");
            $("#loginFormMain").hide("fast");
            break;
        default:
            $("#registerFormMain").hide("fast");
            $("#forgotPasswordFormMain").hide("fast");
            $("#loginFormMain").show("fast");
            break;
    }
}

function aboutUs() {
    if ($("#aboutUsPage").is(":visible")) {
        $("#aboutUsPage").slideUp("slow");
    } else {
        $("#aboutUsPage").slideDown("slow");
    }
}

function helpPage() {
    if ($("#helpPage").is(":visible")) {
        $("#helpPage").slideUp("slow");
    } else {
        $("#helpPage").slideDown("slow");
    }
}