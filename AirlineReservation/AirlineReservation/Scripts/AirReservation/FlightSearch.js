//------------------------------------STEP 1------------------------------------------
var _selectedRoute;//[{<CityID>,<CityName>},{...},...{...}]

//Get the shortest possible schedule for a route
function GetPossibleFlightSchedule() {
    var original = $('#fromLocation').val();
    var destination = $('#toLocation').val();
    if (original == null || destination == null) {
        swal("Please select Original and Destination City", "Both of these information are required", "warning");
        return;
    }

    var obj = {
        OriginalCityID: original,
        DestinationCityID: destination
    }

    $.ajax({
        url: 'Home/GetPossibleFlightScheduleAPI',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
            $('#btStep1Submit').prop('disabled', true);
        },
        success: function (result) {
            if (result == 0) {
                swal("No route found between these cities", "", "warning");
                $('#btStep1Submit').prop('disabled', true);
            }
            else {
                //swal("See more in console!", result + '\nSee more details in console', "success");
                //console.log(result);
                var routeDetails = result[0].CityID + " (" + result[0].CityName + ")";
                for (var i = 1; i < result.length; i++) {
                    routeDetails += " &rarr; " + result[i].CityID + " (" + result[i].CityName + ")";
                }
                $("#foundRouteDetails").html(routeDetails);
                $("#step1-result").show("slow");

                _selectedRoute = result;
                $('#btStep1Submit').prop('disabled', false);
            }
        }
    });
}

//Get the nearest under service city of a city and suggest user to use that if the selected user is not available
function SetNearestAvailable(dropdownControl) {
    var obj = {
        cityID: dropdownControl.val()
    }

    if (obj.cityID == null) {
        return;
    }

    $.ajax({
        url: 'Home/GetNearestAvailableAPI',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            var span = dropdownControl.siblings(".suggestion-text").first();

            //The selected city is not under service
            if (result.CityID != dropdownControl.val()) {
                span.show('slow');
                var a = span.find("a").first();
                var detailsSpan = span.find(".alter-city-details").first();
                detailsSpan.html("(" + result.CityName + " - " + result.Distance + "km)");

                //Bind handler for the "Click here" button
                a.unbind("click").bind("click", function () {
                    dropdownControl.val(result.CityID);
                    dropdownControl.trigger('change');
                    span.hide('slow');
                });
            } else {
                span.hide();
            }
        }
    });
}

//Get the list of cities
function GetCityList(dropdownControl, ex) {
    var obj = {
        exclusion: ex
    }
    $.ajax({
        url: 'Home/GetCityListAPI',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            dropdownControl.html('');
            $.each(result, function (index, i) {
                dropdownControl.append('<option  value=' + i.CityID + '>' + i.CityName + '</option>');
            });

            dropdownControl.trigger('change');
        }
    });
}

//Swap the original and destination
function swapLocation() {
    var from = $("#fromLocation").val();
    var to = $("#toLocation").val();
    if (from == "" || to == "") {
        alert("Please select from and to location");
        return false;
    }

    var fromLocations = $('#fromLocation');
    var toLocations = $('#toLocation');

    fromLocations.val(to);
    toLocations.val(from);

    fromLocations.trigger("change");
    toLocations.trigger("change");
}

$(document).ready(function () {
    //$('#fromLocation').append('<option  value=' + item.ClassTypeID + '>' + item.ClassType + '</option>');
    $('#btStep1Submit').prop('disabled', true);

    var fromLocations = $('#fromLocation');
    var toLocations = $('#toLocation');
    GetCityList(fromLocations);

    fromLocations.on('change', function () {
        GetCityList(toLocations, fromLocations.val());
        SetNearestAvailable($(this))
    });

    toLocations.on('change', function () {
        SetNearestAvailable($(this))
    });
});

//Submit the data in step 1
function SubmitStep1() {
    InitStep2();
}
//------------------------------------STEP 2------------------------------------------
var _passengers;//[<AdultsNumber>, <ChildrenNumber>, <SeniorCitizensNumber>]
var _dates;//[ <DepartureDate> [,ReturningDate] ]  if (dates.length==2): returning flight, otherwise one way flight
var _classes;//[ <DepartureClass> [,ReturningClass] ] Ex: ["First class", "Any"]
var _isReturning = false;

//Get the list of classes
function GetClassList(dropdownControl) {
    $.ajax({
        url: 'Home/GetClassListAPI',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            dropdownControl.html('');
            dropdownControl.append('<option value=\"Any\">Any</option>');
            $.each(result, function (index, i) {
                dropdownControl.append('<option  value=\"' + i.Class + '\">' + i.Class + '</option>');
            });

            dropdownControl.trigger('change');
        }
    });
}

//Initialize the step 2
function InitStep2() {
    document.getElementById("inputDepartureDate").valueAsDate = new Date();
    document.getElementById("inputReturnDate").valueAsDate = new Date()

    //Retrieve class list
    GetClassList($('.class-list'));
}

//Submit the collected data in step 2
function SubmitStep2() {
    _passengers = [$("#adultsNo").val(), $("#childrenNo").val(), $("#elderNo").val()];

    var departureDate = new Date($('#inputDepartureDate').val());
    var departureClass = $("#DepartureClass").val();

    //If it's returning flight
    _isReturning = document.getElementById("optFlightReturn").checked;
    if (_isReturning) {
        var returningDate = new Date($('#inputReturnDate').val());
        var returningClass = $("#ReturningClass").val();
        _dates = [departureDate, returningDate];
        _classes = [departureClass, returningClass];
    }
    else {
        _dates = [departureDate];
        _classes = [departureClass];
    }

    InitStep3();
    GetFlights();
}

//------------------------------------------STEP 3---------------------------
var _selectedFlightNumber;//[{Departure:<DepartureFlight>,Return:<ReturnFlight>}]
var _selectedSeat = [];//[{<DepartureFlight>,<Seat>},{<ReturnFlight>,<Seat>} ]

function InitStep3() {
    $("#routeTitle").html(_selectedRoute[0].CityID + " (" + _selectedRoute[0].CityName + ") &rarr; "
        + _selectedRoute[_selectedRoute.length - 1].CityID + " (" + _selectedRoute[_selectedRoute.length - 1].CityName + ")");

    var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric', hour: 'numeric', minute: 'numeric' };

    $("#routeInfo").html(_dates[0].toLocaleString([], options) + "<h4> Adults: " + _passengers[0] + " Children: "
        + _passengers[1] + " Senior citizens: " + _passengers[2] + "</h4>");
}

//Get all possible flights for the schedule and other user's condition
function GetFlights() {
    var routes = [];

    for (var i = 0; i < _selectedRoute.length; i++) {
        routes.push(_selectedRoute[i].CityID);
    }
    var obj = {
        routes: routes,
        classes: _classes,
        dates: _dates,
        passengers: _passengers,
        isReturning: _isReturning
    }
    $.ajax({
        url: 'Home/GetFlightsAPI',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            //swal("See more in console!", result + '\nSee more details in console', "success");
            //Init flight to Departure section
            $("#departureFlight").html("");
            var departureFlightLists = result[0];
            for (i = 0; i < departureFlightLists.length; i++) {
                //console.log(departureFlightLists[i]);
                var html = "";
                html += '<div class="flight-result">';
                html += '<div class="row" data-toggle="collapse" data-target="#collapse-departurer-' + i + '" aria-expanded="false" aria-controls="collapse-departurer-' + i + '">';
                html += '<div class="col-md-12">';
                html += '<div class="col-md-2 vcenter">Route ' + (i + 1) + '</div>';
                html += '<div class="col-md-2 vcenter">From ' + _selectedRoute[i].CityName + '</div>';
                html += '<div class="col-md-2 vcenter">To ' + _selectedRoute[i + 1].CityName + '</div>';
                html += '<div class="col-md-2 vcenter">Duration</div>';
                html += '<div class="col-md-2 vcenter">Seats</div>';
                html += '<div class="col-md-1 vcenter">Price</div>';
                html += '<div class="col-md-1 vcenter">Select</div>';
                html += '</div>';
                html += '</div>';
                html += '<div class="row">';
                html += '<div class="collapse" id="collapse-departurer-' + i + '" style="border-top: 1px solid">';
                if (departureFlightLists[i] == "") {
                    html += '<div class="col-md-12">There is no available flight for this route, Sorry!</div>';
                }
                for (j = 0; j < departureFlightLists[i].length; j++) {
                    var item = departureFlightLists[i][j];
                    html += '<div class="col-md-12">';
                    html += '<div class="col-md-2 vcenter">' + item['FlightNumber'] + '</div>';
                    html += '<div class="col-md-2 vcenter">' + item['Departure'] + '</div>';
                    html += '<div class="col-md-2 vcenter">' + item['Arrival'] + '</div>';
                    html += '<div class="col-md-2 vcenter">' + item['Duration'] + '</div>';
                    html += '<div class="col-md-2 vcenter">';
                    html += '<span style="color:blue" onclick="selectSeatWithFlightID(\'' + item['FlightNumber'] + '\')">Choose Seat</span><span id="seat_' + item['FlightNumber'] + '"></span> </div>';
                    html += '<div class="col-md-1 vcenter">' + item['Price'] + '</div>';
                    html += '<div class="col-md-1">';
                    html += '<input type="radio" name="optDepartureFlight_' + i + '" value="' + item['FlightNumber'] + '"/>';
                    //html += '<input type="radio" name="optDepartureFlight" id="optDepartureFlight_' + i + '" value="' + item['FlightNumber'] + '"/>';
                    html += '</div>';
                    html += '</div>';
                    //console.log(item);
                }
                html += '</div>';
                html += '</div>';
                html += '</div>';
                $("#departureFlight").append(html);
            }
            //End Init flight to Departure section

            //Init flight to Return section
            $("#returnFlight").html("");
            if (_isReturning) {
                var returningFlightLists = result[1];
                for (i = 0; i < returningFlightLists.length; i++) {
                    var html = "";
                    html += '<div class="flight-result">';
                    html += '<div class="row" data-toggle="collapse" data-target="#collapse-return-' + i + '" aria-expanded="false" aria-controls="collapse-return-' + i + '">';
                    html += '<div class="col-md-12">';
                    html += '<div class="col-md-2 vcenter">Route ' + (i + 1) + '</div>';
                    html += '<div class="col-md-2 vcenter">From ' + _selectedRoute[_selectedRoute.length - 1].CityName + '</div>';
                    html += '<div class="col-md-2 vcenter">To ' + _selectedRoute[0].CityName + '</div>';
                    html += '<div class="col-md-2 vcenter">Duration</div>';
                    html += '<div class="col-md-2 vcenter">Seats</div>';
                    html += '<div class="col-md-1 vcenter">Price</div>';
                    html += '<div class="col-md-1 vcenter">Select</div>';
                    html += '</div>';
                    html += '</div>';
                    html += '<div class="row">';
                    html += '<div class="collapse" id="collapse-return-' + i + '" style="border-top: 1px solid">';
                    if (returningFlightLists[i] == "") {
                        html += '<div class="col-md-12">There is no available flight for this route, Sorry!</div>';
                    }
                    for (j = 0; j < returningFlightLists[i].length; j++) {
                        var item = returningFlightLists[i][j];
                        html += '<div class="col-md-12">';
                        html += '<div class="col-md-2 vcenter">' + item['FlightNumber'] + '</div>';
                        html += '<div class="col-md-2 vcenter">' + item['Departure'] + '</div>';
                        html += '<div class="col-md-2 vcenter">' + item['Arrival'] + '</div>';
                        html += '<div class="col-md-2 vcenter">' + item['Duration'] + '</div>';
                        html += '<div class="col-md-2 vcenter">';
                        html += '<span style="color:blue" onclick="selectSeatWithFlightID(\'' + item['FlightNumber'] + '\')">Choose Seat</span><span id="seat_' + item['FlightNumber'] + '"></span> </div>';
                        html += '<div class="col-md-1 vcenter">' + item['Price'] + '</div>';
                        html += '<div class="col-md-1">';
                        html += '<input type="radio" name="optReturnFlight_' + i + '" value="' + item['FlightNumber'] + '"/>';
                        html += '</div>';
                        html += '</div>';
                    }
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                    $("#returnFlight").append(html);
                }
            }
            //End Init flight to Return section
        }
    });
}

function SubmitStep3() {
    _selectedSeat = [];
    //Set seat and flight number
    $('input:radio').each(function () {
        var $this = $(this),
            optRadio = $this.attr('name'),
            value = $this.attr('value');

        if ($(this).prop('checked')) {
            if (optRadio.indexOf("Departure") !== -1) {
                _selectedSeat.push({ 'FlightNumber': value, 'SeatList': $("#seat_" + value).html(), 'IsReturning': value });
            }
            if (optRadio.indexOf("Return") !== -1) {
                _selectedSeat.push({ 'FlightNumber': value, 'SeatList': $("#seat_" + value).html(), 'IsReturning': value });
            }
            //urls.push('<div class="' + id + '">' + url + '</div>');
        }
    });
    console.log(_selectedFlightNumber);
    console.log(_selectedSeat);
    initStep4();
}

//------------------------------------------STEP 4---------------------------
function initStep4() {
    $.ajax({
        url: 'Home/isUserLogged',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            if (result == "true") {
                $("#step-4").html('<div class="flight-result" style="padding: 25px; width: 80%"><div class="row"><div class="col-xs-12" style="text-align:center">You are already logged, Click the button to the final step</div></div></div><button class="btn btn-primary nextBtn btn-lg pull-right" type="button">Next</button>');
            }
            //console.log(result);
        }
    });
}

function loginValidation(form) {
    if (form == "main") {
        var obj = {
            'UserID': $("#main-login-username").val(),
            'Password': $("#main-login-password").val()
        };
    } else {
        var obj = {
            'UserID': $("#step4-login-username").val(),
            'Password': $("#step4-login-password").val()
        };
    }
    $.ajax({
        url: 'Home/LoginValidation',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function () {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            if (result == "1") {
                $("#step-4").html('<div class="flight-result" style="padding: 25px; width: 80%"><div class="row"><div class="col-xs-12" style="text-align:center">You are already logged, Click the button to the final step</div></div></div><button class="btn btn-primary nextBtn btn-lg pull-right" type="button">Next</button>');
                $("#nav-menu-login").hide();
                $("#nav-menu-personal").show();
            } else {
                sweetAlert("Error", "Your account number and password combination are not correct, Please try again!", "error");
            }
        }
    });
}

function createUserInfo() {
    var obj = {
        'UserID': $("#step4-register-username").val(),
        'Password': $("#step4-register-password").val(),
        'FirstName': $("#step4-register-firstname").val(),
        'LastName': $("#step4-register-lastname").val(),
        'Email': $("#step4-register-email").val(),
        'Gender': $("#step4-register-gender").val(),
        'Phone': $("#step4-register-phonenumber").val(),
        'DOB': $("#step4-register-dob").val(),
        'CreditCard': $("#step4-register-creditcard").val(),
    };
    console.log(obj);
    $.ajax({
        url: 'Home/CreateNewUserValidation',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            if (result == "1") {
                swal("Congratulation!", "Your new account was created!, Please using your user id and password to login", "success");
                $('#loginFormToggle').click();
            }
        }
    });
}