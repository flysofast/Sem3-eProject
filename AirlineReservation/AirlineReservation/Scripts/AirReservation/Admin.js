$(document).ready(function () {
    hideAllDiv();
})

function hideAllDiv() {
    //$("#float-button-group").hide("fast");
    $("#formPersonalInformation").hide("fast");
    $("#formTicket").hide("fast");
    $("#formLog").hide("fast");
    $("#formSeatInformation").hide("fast");
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
            initCityList();
            initRouteList();
            initCityOption();
            $("#formLog").show("slide");
            break;
        case "seat":
            hideAllDiv();
            $("#card-row-index").hide("slide");
            if ($("#float-button-group").css('display') == 'none') {
                $("#float-button-group").show("slide")
            };
            initSeatOfClass();
            $("#formSeatInformation").show("slide");
            break;
        default:
            hideAllDiv();
            $("#card-row-index").show("slide");
            break;
    }
}
function initSeatOfClass() {
    $.ajax({
        url: 'Admin/GetAllSeat',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            $("#seat_business_class").html("");
            $("#seat_club_class").html("");
            $("#seat_first_class").html("");
            $("#seat_non_smoking_class").html("");
            $("#seat_smoking_class").html("");

            $.each(result, function (k, item) {
                if (item['Class'] == 'Business class') {
                    $("#seat_business_class").append(item["SeatID"] + ",");
                }
                if (item['Class'] == 'Club class') {
                    $("#seat_club_class").append(item["SeatID"] + ",");
                }
                if (item['Class'] == 'First class') {
                    $("#seat_first_class").append(item["SeatID"] + ",");
                }
                if (item['Class'] == 'Non-smoking class') {
                    $("#seat_non_smoking_class").append(item["SeatID"] + ",");
                }
                if (item['Class'] == 'Smoking class') {
                    $("#seat_smoking_class").append(item["SeatID"] + ",");
                }
            });
            $("#seat_business_class").html($("#seat_business_class").html().slice(0, -1));
            $("#seat_club_class").html($("#seat_club_class").html().slice(0, -1));
            $("#seat_first_class").html($("#seat_first_class").html().slice(0, -1));
            $("#seat_non_smoking_class").html($("#seat_non_smoking_class").html().slice(0, -1));
            $("#seat_smoking_class").html($("#seat_smoking_class").html().slice(0, -1));
            
        }
    });
}

function initCityOption() {
    $.ajax({
        url: 'Admin/GetAllCity',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            $("#admin-route-register-originalcity").html();
            $("#admin-route-register-destinatecity").html();
            var html = "";
            $.each(result, function (k, item) {
                html += '<option value=\'' + item['CityID'] + '\'>' + item['CityName'] + '</option>';                
            });
            $("#admin-route-register-originalcity").html(html);
            $("#admin-route-register-destinatecity").html(html);
        }
    });
}

function createCity() {
    var cityID = $("#admin-city-register-id").val();
    var cityName = $("#admin-city-register-name").val();
    var inService = $("#admin-city-register-inservice").is(":checked");
    if (cityID == "" || cityName == "") {
        swal("Error", "Please fill all field", "error");
        return false;
    }
    var obj = {
        'CityID': cityID,
        'CityName': cityName,
        'InService': inService,
    };
    $.ajax({
        url: 'Admin/CreateCity',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            if (result == "1") {
                initCityList();
                initCityOption();
                swal("OK", "Added new City", "success");
            } else {
                swal("Error", "Cannot change", "error");
            }
        }
    });
}

function createRoute() {
    //var routeID = $("#admin-route-register-routeID").val();
    var originalCity = $("#admin-route-register-originalcity").val();
    var destinationCity = $("#admin-route-register-destinatecity").val();
    var distance = $("#admin-route-register-distance").val();
    var inService = $("#admin-route-register-inservice").is(":checked");
    if (originalCity == "" || destinationCity == "" || distance == "") {
        swal("Error", "Please fill all field", "error");
        return false;
    }
    /*$(".routeID_check").each(function (index) {
        if (parseInt(routeID) == parseInt($(this).text())) {
            swal("Error", "This route ID already in database, Please enter another one", "error");
            return false;
        }
    });*/
    if (originalCity == destinationCity) {
        swal("Error", "Please select another destination city", "error");
        return false;
    }
    var obj = {
        'OriginalCityID': originalCity,
        'DestinateCityID': destinationCity,
        'Distance': distance,
        'InService': inService,
    };
    $.ajax({
        url: 'Admin/CreateRoute',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            if (result == "1") {
                swal("OK", "Added new Route", "success");
                initRouteList();
            } else {
                swal("Error", "Cannot change", "error");
            }
        }
    });
}

function initCityList() {
    $.ajax({
        url: 'Admin/GetAllCity',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            $("#cityList").html();
            var html = "";
            $.each(result, function (k, item) {
                html += '<div class="flight-result">';
                html += '<div class="row">';
                html += '<div class="col-md-3 vcenter">' + item['CityID'] + '</div>';
                html += '<div class="col-md-3 vcenter">' + item['CityName'] + '</div>';
                html += '<div class="col-md-3 vcenter">' + item['InService'] + '</div>';
                html += '<div class="col-md-3 vcenter"><button class="btn btn-danger btn-xs" onclick="editCity(\'' + item['CityID'] + '\')">Edit</button></div>';
                html += '</div>';
                html += '</div>';
            });
            $("#cityList").html(html);
        }
    });    
}

function editCity(cityID) {
    //Init value to update
    $("#updateCityBtn").show();
    $("admin-city-register-id-hidden").val(cityID);
    var obj = {
        'CityID': cityID,
    };
    $.ajax({
        url: 'Admin/GetCityByCityID',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            $("#admin-city-register-id-hidden").val(result['CityID']);
            $("#admin-city-register-id").val(result['CityID']);
            $("#admin-city-register-name").val(result['CityName']);
            $("#admin-city-register-inservice").prop('checked', result['InService']);
        }
    });
    //End
}

function updateCity() {
    var cityID = $("#admin-city-register-id-hidden").val();
    var cityName = $("#admin-city-register-name").val();
    var inService = $("#admin-city-register-inservice").is(":checked");
    if (cityID == "" || cityName == "") {
        swal("Error", "Please fill all field", "error");
        return false;
    }
    var obj = {
        'CityID': cityID,
        'CityName': cityName,
        'InService': inService,
    };
    $.ajax({
        url: 'Admin/UpdateCity',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            if (result == "1") {
                initCityList();
                initCityOption();
                swal("OK", "Added new City", "success");
            } else {
                swal("Error", "Cannot change", "error");
            }
        }
    });
}

function editRoute(routeID) {
    //Init value to update
    $("#updateRouteBtn").show();
    var obj = {
        'RouteID': routeID,
    };
    $.ajax({
        url: 'Admin/GetRouteByRouteID',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            console.log(result);
            $("#admin-route-register-routeID").val(result['RouteID']);
            $("#admin-route-register-originalcity").val(result['OriginalCityID']);
            $("#admin-route-register-destinatecity").val(result['DestinationCityID']);
            $("#admin-route-register-distance").val(result['Distance']);
            $("#admin-route-register-inservice").prop('checked', result['InService']);
        }
    });
    //End
}

function updateRoute() {
    var routeID = $("#admin-route-register-routeID").val();
    var originalCity = $("#admin-route-register-originalcity").val();
    var destinationCity = $("#admin-route-register-destinatecity").val();
    var distance = $("#admin-route-register-distance").val();
    var inService = $("#admin-route-register-inservice").is(":checked");
    if (originalCity == "" || destinationCity == "" || distance == "") {
        swal("Error", "Please fill all field", "error");
        return false;
    }
    /*$(".routeID_check").each(function (index) {
        if (parseInt(routeID) == parseInt($(this).text())) {
            swal("Error", "This route ID already in database, Please enter another one", "error");
            return false;
        }
    });*/
    if (originalCity == destinationCity) {
        swal("Error", "Please select another destination city", "error");
        return false;
    }
    var obj = {
        'RouteID' : routeID,
        'OriginalCityID': originalCity,
        'DestinateCityID': destinationCity,
        'Distance': distance,
        'InService': inService,
    };
    $.ajax({
        url: 'Admin/UpdateRoute',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            if (result == "1") {
                swal("OK", "Updated Route", "success");
                initRouteList();
            } else {
                swal("Error", "Cannot change", "error");
            }
        }
    });
}

function initRouteList() {
    $.ajax({
        url: 'Admin/GetAllRoute',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            console.log(result);
            $("#routeList").html();
            var html = "";
            $.each(result, function (k, item) {
                html += '<div class="flight-result">';
                html += '<div class="row">';
                html += '<div class="col-md-2 vcenter routeID_check">' + item['RouteID'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + item['OriginalCity'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + item['DestinationCity'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + item['Distance'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + item['InService'] + '</div>';
                html += '<div class="col-md-2 vcenter"><button class="btn btn-danger btn-xs" onclick="editRoute(\'' + item['RouteID'] + '\')">Edit</button></div>';
                html += '</div>';
                html += '</div>';
            });
            $("#routeList").html(html);
        }
    });    
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
            $.each(result, function (k, item) {
                html += '<option value=' + item['RouteID'] + '>' + item['RouteID'] + ' (' + item['OriginalCity'] + ' - ' + item['DestinationCity'] + ')</option>';
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
            $.each(result, function (k, item) {
                html += '<div class="flight-result">';
                html += '<div class="row">';
                html += '<div class="col-md-2 vcenter">' + item['FlightNo'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToCurrencyFormat(item['CurrentPrice']) + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToJavaScriptDate(item['DepartureTime']) + '</div>';
                html += '<div class="col-md-2 vcenter">' + item['OriginalCity'] + '-' + item['DestinationCity'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + item['CancellationFee'] + '</div>';
                html += '<div class="col-md-1 vcenter">' + ToTimeFormat(item['Duration']) + '</div>';
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
            //document.getElementById("admin-flight-register-departureTime").value = new Date(ToJavaScriptDate(result['DepartureTime'])).toJSON().slice(0, 19);
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
    var obj = {
        'UserID': userID,
        'IsAdmin': false
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
    return dt.getFullYear() + "-" + (dt.getMonth() + 1) + "-" + (dt.getDate() + 1 + " " + dt.getHours()+":"+dt.getMinutes());
}

function ToTimeFormat(value) {
    var hours = Math.floor(value);
    var minutes = Math.floor((value - hours) * 60);
    return hours + "h " + minutes + "m";
}

function ToCurrencyFormat(number) {
    return number.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + " VND";
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