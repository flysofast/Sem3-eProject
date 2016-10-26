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
            initAllPersonalTicket();
            $("#formLog").show("slide");
            break;
        default:
            hideAllDiv();
            $("#card-row-index").show("slide");
            break;
    }
}

function initAllPersonalTicket() {
    $.ajax({
        url: 'Personal/SearchAllTicketByUserId',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            console.log(result);
            if (result.length == 0) {
                swal("Not found", "This ticket does not exists, please try again!", "error");
                return false;
            }
            $("#TicketList").html("");
            var html = "";
            $.each(result, function (k) {
                html += '<div class="flight-result">';
                html += '<div class="row">';
                html += '<div class="col-md-2 vcenter">' + result[k]['TicketNo'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Original'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Destination'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToJavaScriptDate(result[k]['CreatedDate']) + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToCurrencyFormat(result[k]['Price']) + '</div>';
                if (result[k]['Status'] == "Confirmed") {
                    var status = result[k]['Status'] + '<button class="btn btn-primary" onclick="reschedule(\'' + result[k]["TicketNo"] + '\')">Reschedule</button>';
                } else {
                    var status = result[k]['Status'];
                }
                html += '<div class="col-md-2 vcenter">' + status + '</div>';
                html += '</div>';
                html += '</div>';
            })
            $("#TicketList").html(html);
            $("#TicketList").slideDown();
        }
    });
}

function reschedule(ticketNo) {
    window.location.href = "../Home?Reschedule=" + ticketNo;
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
        url: 'Personal/GetCurrentUserTicketList_new',
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
            console.log(result);
            var ticketList = [];

            $.each(result, function (k, item) {
                if (k != 0) {
                    if (result[k]['TicketNo'] != result[(k - 1)]['TicketNo']) {
                        ticketList.push(item['TicketNo']);
                        html += '<div class="flight-result">';
                        html += '<div class="row"  data-toggle="collapse" data-target="#personal-ticket-' + item['TicketNo'] + '" aria-expanded="false" aria-controls="personal-ticket-' + item['TicketNo'] + '">';
                        html += '<div class="col-md-2 vcenter">' + item['TicketNo'] + '</div>';
                        html += '<div class="col-md-2 vcenter">' + ToJavaScriptDate(item['CreatedDate']) + '</div>';
                        html += '<div class="col-md-2 vcenter">' + item['Price'].toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + " VND" + '</div>';
                        html += '<div class="col-md-2 vcenter">' + item['Status'] + '</div>';

                        if (item['Status'] == "Blocked") //Blocked code
                            html += '<div class="col-md-1 vcenter"><button class="btn btn-default btn-success" onclick="confirmTicket(' + item['TicketNo'] + ')">Confirm</button></div>';
                        html += '<div class="col-md-1 vcenter"><button class="btn btn-default btn-danger" onclick="cancelTicket(' + item['TicketNo'] + ')">Cancel</button></div>';
                        html += '</div>';

                        //Expand
                        html += '<div class="row" style="margin-top: 10px;">';
                        html += '<div class="collapse" id="personal-ticket-' + item['TicketNo'] + '">';
                        html += '<div class="col-md-12">';

                        html += '<div class="col-md-4">';
                        html += '<div class="thumbnail">';
                        html += ' Passengers Information';
                        html += '<div class="caption">';
                        html += '<h3>Passenger</h3>';
                        html += '<p class="card-description">';
                        html += '<table class="table" style="text-align: left;">';
                        html += '<tr><td>Adults:</td><td>' + item['NumberOfAdults'] + '</td></tr>';
                        html += '<tr><td>Children:</td><td>' + item['NumberOfChildren'] + '</td></tr>';
                        html += '<tr><td>Senior citizens:</td><td>' + item['NumberOfSeniorCitizens'] + '</td></tr>';
                        html += '<tr><td>Total:</td><td>' + item['Price'].toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + " VND" + '</td></tr>';
                        html += '</table>';
                        html += '</p>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';

                        html += '<div class="col-md-4" id="departurer-detail-' + item['TicketNo'] + '">';
                        html += '</div>';

                        html += '<div class="col-md-4" id="return-detail-' + item['TicketNo'] + '">';
                        html += '</div>';

                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                        //End
                        html += '</div>';
                    }
                }
            });
            

            $("#currentlyTicketList").html(html);

            for (var i = 0; i < ticketList.length; i++) {
                //console.log();
                var departureInfo = "";
                departureInfo += '<div class="thumbnail">';
                departureInfo += ' Ticket Information';
                departureInfo += '<div class="caption">';
                departureInfo += '<h3>Departurer</h3>';


                var returnInfo = "";
                returnInfo += '<div class="thumbnail">';
                returnInfo += ' Ticket Information';
                returnInfo += '<div class="caption">';
                returnInfo += '<h3>Return</h3>';
                $.each(result, function (k, item) {
                    if (result[k]['TicketNo'] == ticketList[i]) {
                        if (result[k]['IsReturning'] == false) {
                            departureInfo += '<p class="card-description">';
                            departureInfo += '<table class="table" style="text-align: left;">';
                            departureInfo += '<tr><td>Original City:</td><td>' + item['Original'] + '</td></tr>';
                            departureInfo += '<tr><td>Destination City:</td><td>' + item['Destination'] + '</td></tr>';
                            departureInfo += '</table>';
                            departureInfo += '</p>';
                        } else {
                            returnInfo += '<p class="card-description">';
                            returnInfo += '<table class="table" style="text-align: left;">';
                            returnInfo += '<tr><td>Original City:</td><td>' + item['Original'] + '</td></tr>';
                            returnInfo += '<tr><td>Destination City:</td><td>' + item['Destination'] + '</td></tr>';
                            returnInfo += '</table>';
                            returnInfo += '</p>';
                        }
                    }
                });
                departureInfo += '</div>';
                departureInfo += '</div>';
                returnInfo += '</div>';
                returnInfo += '</div>';
                console.log(departureInfo);
                $('#departurer-detail-' + ticketList[i]).html(departureInfo);
                $('#return-detail-' + ticketList[i]).html(returnInfo);
            }
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