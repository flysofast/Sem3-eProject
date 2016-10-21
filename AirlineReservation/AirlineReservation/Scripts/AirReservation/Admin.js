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
            $("#formPersonalInformation").show("slide");
            initAdministratorList();
            break;
        case "ticket":
            hideAllDiv();
            $("#card-row-index").hide("slide");
            if ($("#float-button-group").css('display') == 'none') {
                $("#float-button-group").show("slide")
            };
            initFlightList();
            initRouteFlighOption();
            $("#formTicket").show("slide");
            break;
        case "log":
            hideAllDiv();
            $("#card-row-index").hide("slide");
            if ($("#float-button-group").css('display') == 'none') {
                $("#float-button-group").show("slide")
            };
            $("#formLog").show("slide");
            break;
        default:
            hideAllDiv();
            $("#card-row-index").show("slide");
            break;
    }
}

function initRouteFlighOption() {
    $.ajax({
        url: 'Admin/GetAllRoute',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            $("#admin-flight-register-routeID").html();
            var html = "";
            $.each(result, function (k) {
                html += '<option value='+ result[k]['RouteID'] +'>'+ result[k]['RouteID'] +'</option>';
            });
            $("#admin-flight-register-routeID").html(html);
        }
    });
}

function initFlightList() {
    $.ajax({
        url: 'Admin/GetAllFlight',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            $("#FlightList").html();
            var html = "";
            $.each(result, function (k) {
                html += '<div class="flight-result">';
                html += '<div class="row">';
                html += '<div class="col-md-2 vcenter">' + result[k]['FlightNo'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['CurrentPrice'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToJavaScriptDate(result[k]['DepartureTime']) + '</div>';
                html += '<div class="col-md-1 vcenter">' + result[k]['RouteID'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['CancellationFee'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Duration'] + '</div>';
                html += '<div class="col-md-1 vcenter"><button class="btn btn-danger btn-xs" onclick="editFlight(\'' + result[k]['FlightNo'] + '\')">Edit</button></div>';
                html += '</div>';
                html += '</div>';
                //console.log(result[k]);
            });
            $("#FlightList").html(html);
        }
    });
}
function editFlight(flightNo) {
    //Init value to update
    $("#updateFlightBtn").show();
    var obj = {
        'FlightNo': flightNo,
    };
    $.ajax({
        url: 'Admin/GetFlightByFlightNo',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            
            $("#admin-flight-register-flightNo-choose").val(result['FlightNo']);
            $("#admin-flight-register-flightNo").val(result['FlightNo']);
            $("#admin-flight-register-price").val(result['CurrentPrice']);
            document.getElementById("admin-flight-register-departureTime").valueAsDate = new Date(ToJavaScriptDate(result['DepartureTime']));
            $("#admin-flight-register-routeID").val(result['RouteID']);
            $("#admin-flight-register-cancellationFee").val(result['CancellationFee']);
            $("#admin-flight-register-duration").val(result['Duration']);
        }
    });
    //End
}

function updateFlight() {
    var flightNo = $("#admin-flight-register-flightNo-choose").val();
    var price = $("#admin-flight-register-price").val();
    var departureTime = $("#admin-flight-register-departureTime").val();
    var routeID = $("#admin-flight-register-routeID").val();
    var cancellationFee = $("#admin-flight-register-cancellationFee").val();
    var duration = $("#admin-flight-register-duration").val();
    if (flightNo == "" || price == "" || departureTime == "" || routeID == "" || cancellationFee == "" || duration == "") {
        swal("Error", "Please fill all field", "error");
        return false;
    }
    var obj = {
        'FlightNo': flightNo,
        'Price': price,
        'DepartureTime': departureTime,
        'RouteID': routeID,
        'CancellationFee': cancellationFee,
        'Duration': duration,
    };
    $.ajax({
        url: 'Admin/UpdateFlight',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            if (result == "1") {
                swal("OK", "Updated flight", "success");
                initFlightList();
            } else {
                swal("Error", "Cannot update", "error");
            }
        }
    });
}

function initAdministratorList() {
    $.ajax({
        url: 'Admin/GetAdministratorList',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            $("#administratorList").html();
            var html = "";
            $.each(result, function (k) {
                html += '<div class="flight-result">';
                html += '<div class="row">';
                html += '<div class="col-md-2 vcenter">' + result[k]['UserID'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['FirstName'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['LastName'] + '</div>';
                var gender = result[k]['Sex'] == true ? "Male" : "Female";
                html += '<div class="col-md-1 vcenter">' + gender + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Email'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['PhoneNumber'] + '</div>';
                html += '<div class="col-md-1 vcenter"><button class="btn btn-danger btn-xs" onclick="removeAdmin(\'' + result[k]['UserID'] + '\')">Remove</button></div>';
                html += '</div>';
                html += '</div>';
                //console.log(result[k]);
            });
            $("#administratorList").html(html);
        }
    });
}
function removeAdmin(userID) {
    var obj ={
        'UserID' : userID,
        'IsAdmin' : false
    };
    $.ajax({
        url: 'Admin/UpdateAdmin',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            if (result == "1") {
                swal("OK", "This user no longer admin", "success");
                initAdministratorList();
            } else {
                swal("Error", "Cannot change", "error");
            }
        }
    });
}

function addAdmin(userID) {
    var obj = {
        'UserID': userID,
        'IsAdmin': true
    };
    $.ajax({
        url: 'Admin/UpdateAdmin',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            if (result == "1") {
                swal("OK", "Added new Admin", "success");
                addAdministrator();
                initAdministratorList();
            } else {
                swal("Error", "Cannot change", "error");
            }
        }
    });
}

function ToJavaScriptDate(value) {
    var pattern = /Date\(([^)]+)\)/;
    var results = pattern.exec(value);
    var dt = new Date(parseFloat(results[1]));
    return dt.getFullYear() + "-" + (dt.getMonth() + 1) + "-" + (dt.getDate() + 1);
}

function addAdministrator() {
    $.ajax({
        url: 'Admin/GetNormalUserList',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            $("#normalUserList").html();
            var html = "";
            $.each(result, function (k) {
                html += '<div class="flight-result">';
                html += '<div class="row">';
                html += '<div class="col-md-1 vcenter">' + result[k]['UserID'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['FirstName'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['LastName'] + '</div>';
                var gender = result[k]['Sex'] == true ? "Male" : "Female";
                html += '<div class="col-md-2 vcenter">' + gender + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Email'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['PhoneNumber'] + '</div>';
                html += '<div class="col-md-1 vcenter"><button class="btn btn-primary btn-xs" onclick="addAdmin(\'' + result[k]['UserID'] + '\')">Add</button></div>';
                html += '</div>';
                html += '</div>';
                //console.log(result[k]);
            });
            $("#normalUserList").html(html);
        }
    });

    $('#userListModalBox').modal('show');
}

function createFlight() {
    var flightNo = $("#admin-flight-register-flightNo").val();
    var price = $("#admin-flight-register-price").val();
    var departureTime = $("#admin-flight-register-departureTime").val();
    var routeID = $("#admin-flight-register-routeID").val();
    var cancellationFee = $("#admin-flight-register-cancellationFee").val();
    var duration = $("#admin-flight-register-duration").val();
    if (flightNo == "" || price == "" || departureTime == "" || routeID == "" || cancellationFee == "" || duration == "") {
        swal("Error", "Please fill all field", "error");
        return false;
    }
    var obj = {
        'FlightNo': flightNo,
        'Price': price,
        'DepartureTime': departureTime,
        'RouteID': routeID,
        'CancellationFee': cancellationFee,
        'Duration': duration,
    };
    $.ajax({
        url: 'Admin/CreateFlight',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            if (result == "1") {
                swal("OK", "Created new flight", "success");
                initFlightList();
            } else {
                swal("Error", "Cannot create", "error");
            }
        }
    });
}