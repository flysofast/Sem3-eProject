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
    $.ajax({
        url: 'Personal/GetCurrentUserTicketList',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            $("#currentlyTicketList").html();
            var html = "";
            $.each(result, function (k) {
                html += '<div class="flight-result">';
                html += '<div class="row">';
                html += '<div class="col-md-2 vcenter">' + result[k]['TicketNo'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToJavaScriptDate(result[k]['CreatedDate']) + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Price'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Status'] + '</div>';
                html += '<div class="col-md-1 vcenter">';
                html += '<button onclick="confirmTicket(\' ' + result[k]['TicketNo'] + ' \')">Confirm</button>';
                html += '</div>';
                html += '<div class="col-md-1 vcenter">';
                html += '<button>Cancel</button>';
                html += '</div>';
                html += '</div>';
                html += '</div>';
                //console.log(result[k]);
            });
            $("#currentlyTicketList").html(html);
        }
    });
}

function confirmTicket(ticketNo) {
    swal({
        title: "An input!",
        text: "Write something interesting:",
        type: "input",
        showCancelButton: true,
        closeOnConfirm: false,
        animation: "slide-from-top",
        inputPlaceholder: "Write something"
    }, function (inputValue) {
        if (inputValue === false) return false;
        if (inputValue === "") {
            swal.showInputError("You need to write something!");
            return false
        }
        //confirm code
        var obj = {
            'TicketNo': ticketNo,
            'Code': inputValue,
            'Mode': 1 //Confirmed code
        };
        $.ajax({
            url: 'Personal/CheckTicketCode',
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            type: 'POST',
            data: JSON.stringify(obj),
            error: function (data) {
                swal("Error", data.responseText, "error");
            },
            success: function (result) {
                if (result == "1") {
                    swal("OK", "Correct code", "success");
                } else {
                    swal("Error", "Wrong code", "error");
                }
            }
        });
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