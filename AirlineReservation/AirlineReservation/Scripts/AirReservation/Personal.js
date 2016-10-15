$(document).ready(function () {
    hideAllDiv();
})

function hideAllDiv() {
    $("#float-button-group").hide("fast");
    $("#formPersonalInformation").hide("fast");
    $("#formTicket").hide("fast");
    $("#formLog").hide("fast");
}
function changePage(mode) {
    //$("#float-button-group").show();
    switch (mode) {
        case "information":
            hideAllDiv();
            $("#card-row-index").hide("fast");
            $("#float-button-group").show("fast");
            $("#formPersonalInformation").show("fast");
            break;
        case "ticket":
            hideAllDiv();
            $("#card-row-index").hide("fast");
            $("#float-button-group").show("fast");
            $("#formTicket").show("fast");
            break;
        case "log":
            hideAllDiv();
            $("#card-row-index").hide("fast");
            $("#float-button-group").show("fast");
            $("#formLog").show("fast");
            break;
        default:
            hideAllDiv();
            $("#card-row-index").show("fast");
            break;
    }
}
