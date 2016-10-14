$(document).ready(function () {
    $("#float-button-group").hide();
    $("#formPersonalInformationgroup").hide();
    $("#formTicket").hide();
    $("#formLog").hide();
})

function changePage(mode) {
    $("#float-button-group").show();
    $("#card-row-index").hide();
    $("#formLog").show();
}
