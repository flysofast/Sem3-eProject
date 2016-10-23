$(document).ready(function () {
    hideAllDiv();
})

function hideAllDiv() {
    //$("#float-button-group").hide("fast");
    $("#formPersonalInformation").hide("fast");
    $("#formTicket").hide("fast");
    $("#formLog").hide("fast");
}
function changePage(mode) {
    //$("#float-button-group").show();
    switch (mode) {
        case "information":
            hideAllDiv();
            $("#card-row-index").hide("slide");
            if ($("#float-button-group").css('display') == 'none') {
                $("#float-button-group").show("slide")
            };
            initPersonalInfor();
            $("#formPersonalInformation").show("slide");
            break;
        case "ticket":
            hideAllDiv();
            $("#card-row-index").hide("slide");
            if ($("#float-button-group").css('display') == 'none') {
                console.log("aaa"); $("#float-button-group").show("slide")
            };
            initPersonalTicketList();
            $("#formTicket").show("slide");
            break;
        case "log":
            hideAllDiv();
            $("#card-row-index").hide("slide");
            if ($("#float-button-group").css('display') == 'none') {
                console.log("aaa"); $("#float-button-group").show("slide")
            };
            $("#formLog").show("slide");
            break;
        default:
            hideAllDiv();
            $("#card-row-index").show("slide");
            break;
    }
}

function initPersonalInfor() {
    $.ajax({
        url: 'Personal/GetCurrentUserInfor',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            $("#personal-username").val(result['UserID']);
            $("#personal-firstname").val(result['FirstName']);
            $("#personal-lastname").val(result['LastName']);
            $("#personal-email").val(result['Email']);
            $("#personal-phone").val(result['PhoneNumber']);
            $("#personal-gender").val(result['Sex'].toString());
            document.getElementById("personal-dob").valueAsDate = new Date(ToJavaScriptDate(result['DateOfBirth']));
            $("#personal-creditcard").val(result['CreditcardNumber']);
        }
    });
}

function initPersonalTicketList() {
    $('.se-pre-con-2').show();
    $.ajax({
        url: 'Personal/GetCurrentUserTicketList',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            $('.se-pre-con-2').fadeOut('slow');

            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            $("#currentlyTicketList").html();
            var html = "";
            $.each(result, function (k, item) {
                html += '<div class="flight-result">';
                html += '<div class="row">';
                html += '<div class="col-md-2 vcenter">' + item['TicketNo'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToJavaScriptDate(item['CreatedDate']) + '</div>';
                html += '<div class="col-md-2 vcenter">' + item['Price'].toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + " VND" + '</div>';
                html += '<div class="col-md-2 vcenter">' + item['Status'] + '</div>';

                if (item['StatusCode'] == 3) //Blocked code
                    html += '<div class="col-md-1 vcenter"><button class="btn btn-default btn-success" onclick="confirmTicket(' + item['TicketNo'] + ')">Confirm</button></div>';
                html += '<div class="col-md-1 vcenter"><button class="btn btn-default btn-danger" onclick="cancelTicket(' + item['TicketNo'] + ')">Cancel</button></div>';
                html += '</div>';
                html += '</div>';
                //console.log(result[k]);
            });
            $("#currentlyTicketList").html(html);
            $('.se-pre-con-2').fadeOut('slow');
        }
    });
}

function confirmTicket(ticketNo) {
    swal({
        title: "Are you sure?", text: "Do you really want to buy this ticket? You will be charged by your provided credit card number.", type: "warning", showCancelButton: true,
        confirmButtonColor: "#DD6B55", confirmButtonText: "Yes, buy it!", closeOnConfirm: false
    },
       function () {
           var obj = {
               'ticketNo': ticketNo,
               'actionCode': 1, //Confirm code
           };
           $.ajax({
               url: 'Personal/TakeActionForTicket',
               contentType: "application/json; charset=utf-8",
               dataType: 'json',
               type: 'POST',
               data: JSON.stringify(obj),
               error: function (data) {
                   swal("Error", data.responseText, "error");
               },
               success: function (result) {
                   swal("Succeeded", "The ticket has successfully confirmed", "success");
                   initPersonalTicketList();
               }
           });
       });
}

function ToCurrencyFormat(number) {
    return number.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + " VND";
}

function cancelTicket(ticketNo) {
    var obj = {
        'ticketNo': ticketNo,
        'actionCode': 2, //Confirm code
    };

    $.ajax({
        url: 'Personal/GetCancellationFeeAPI',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            swal({
                title: "Are you sure?", text: "Do you really want to cancel this ticket? You will be charged " + ToCurrencyFormat(result) + " for cancellation fee!", type: "warning", showCancelButton: true,
                confirmButtonColor: "#DD6B55", confirmButtonText: "Yes, cancel it!", closeOnConfirm: false
            }, function () {
                $.ajax({
                    url: 'Personal/TakeActionForTicket',
                    contentType: "application/json; charset=utf-8",
                    dataType: 'json',
                    type: 'POST',
                    data: JSON.stringify(obj),
                    error: function (data) {
                        swal("Error", data.responseText, "error");
                    },
                    success: function (result) {
                        swal("Succeeded", "The ticket has successfully canceled", "success");
                        initPersonalTicketList();
                    }
                });
            });
        }
    });
}

function ToJavaScriptDate(value) {
    var pattern = /Date\(([^)]+)\)/;
    var results = pattern.exec(value);
    var dt = new Date(parseFloat(results[1]));
    return dt.getFullYear() + "-" + (dt.getMonth() + 1) + "-" + (dt.getDate() + 1);
}

function updateUserInfor() {
    var flag = true;
    var error_msg = "";
    if ($("#personal-username").val() == "") {
        $("#personal-username").addClass("form-validation-error");
        flag = false;
        error_msg += "Please enter your username \n";
    } else {
        $("#personal-username").removeClass("form-validation-error");
    }

    if ($("personal-password").val() == "") {
        $("#personal-password").addClass("form-validation-error");
        flag = false;
        error_msg += "Please enter your password \n";
    } else {
        $("#personal-password").removeClass("form-validation-error");
    }

    if ($("#personal-firstname").val() == "") {
        $("#personal-firstname").addClass("form-validation-error");
        error_msg += "Please enter your firstname \n";
        flag = false;
    } else {
        $("#personal-firstname").removeClass("form-validation-error");
    }

    if ($("#personal-lastname").val() == "") {
        $("#personal-lastname").addClass("form-validation-error");
        error_msg += "Please enter your lastname \n";
        flag = false;
    } else {
        $("#personal-lastname").removeClass("form-validation-error");
    }

    if ($("#personal-email").val() == "") {
        $("#personal-email").addClass("form-validation-error");
        error_msg += "Please enter your email \n";
        flag = false;
    } else {
        $("#personal-email").removeClass("form-validation-error");
    }

    if ($("#personal-gender").val() == "") {
        $("#personal-gender").addClass("form-validation-error");
        error_msg += "Please select your gender \n";
        flag = false;
    } else {
        $("#personal-gender").removeClass("form-validation-error");
    }

    if ($("#personal-phone").val() == "") {
        $("#personal-phone").addClass("form-validation-error");
        error_msg += "Please enter your phonenumber \n";
        flag = false;
    } else {
        $("#personal-phone").removeClass("form-validation-error");
    }

    if ($("#personal-creditcard").val() == "") {
        $("#personal-creditcard").addClass("form-validation-error");
        error_msg += "Please enter your creditcard \n";
        flag = false;
    } else {
        $("#personal-creditcard").removeClass("form-validation-error");
    }

    if ($("#personal-dob").val() == "") {
        $("#personal-dob").addClass("form-validation-error");
        error_msg += "Please select your date of birth \n";
        flag = false;
    } else {
        $("#personal-dob").removeClass("form-validation-error");
    }
    //#end
    if (!flag) {
        sweetAlert("Oops...", error_msg, "error");
        return false;
    }

    var obj = {
        'UserID': $("#personal-username").val(),
        'FirstName': $("#personal-firstname").val(),
        'LastName': $("#personal-lastname").val(),
        'Email': $("#personal-email").val(),
        'Gender': $("#personal-gender").val(),
        'Phone': $("#personal-phone").val(),
        'DOB': $("#personal-dob").val(),
        'CreditCard': $("#personal-creditcard").val(),
    };
    $.ajax({
        url: 'Personal/UpdateUserValidation',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            console.log(result);
            if (result == "1") {
                swal("Successfully!", "Your information was updated!", "success")
            } else {
                swal("Error!", "Cannot update your information!", "error")
            }
        }
    });
}