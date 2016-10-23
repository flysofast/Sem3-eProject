$(document).ready(function () {
    //Set default hide return date
    $("#returnDateForm").hide();
    $("#lblReturnClass").hide();
    $("#returnClass").hide();
    $("#step1-result").hide();
    //Check ticket type, show/hide input return date
    $("input[name=optFlight]:radio").change(function () {
        if ($('#optFlightReturn').is(':checked')) {
            $("#returnDateForm").show("slow");
            $("#lblReturnClass").show("slow");
            $("#returnClass").show("slow");
        } else {
            $("#returnDateForm").hide();
            $("#lblReturnClass").hide();
            $("#returnClass").hide();
        }
    });
    $("#aboutUsPage").hide();
    $("#registerFormMain").hide();
    $("#forgotPasswordFormMain").hide();

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