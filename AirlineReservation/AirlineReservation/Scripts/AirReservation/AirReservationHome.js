$(document).ready(function () {
    //Set default hide return date
    $("#returnDateForm").hide();
    $("#lblReturnClass").hide();
    $("#returnClass").hide();
    //Check ticket type, show/hide input return date 
    $("input[name=optFlight]:radio").change(function () {
        if ($('#optFlightReturn').is(':checked')) {
            $("#returnDateForm").show();
            $("#lblReturnClass").show();
            $("#returnClass").show();
        } else {
            $("#returnDateForm").hide();
            $("#lblReturnClass").hide();
            $("#returnClass").hide();
        }
    });
});

function swapLocation() {
    var from = $("#fromLocation").val();
    var to = $("#toLocation").val();
    if (from == "" || to == "") {
        alert("Please select from and to location");
        return false;
    }
    $("#fromLocation").val(to);
    $("#toLocation").val(from);
}