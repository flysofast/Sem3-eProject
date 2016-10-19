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
    $("#btn-step-2").removeClass("disabled");
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
    document.getElementById("inputDepartureDateFrom").valueAsDate = new Date();
    document.getElementById("inputDepartureDateTo").valueAsDate = new Date();
    document.getElementById("inputReturnDateFrom").valueAsDate = new Date();
    document.getElementById("inputReturnDateTo").valueAsDate = new Date();
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

    $("#btn-step-3").removeClass("disabled");
    InitStep3();
}

//------------------------------------------STEP 3---------------------------
var _selectedFlightNumber;//[{Departure:<DepartureFlight>,Return:<ReturnFlight>}]
var _selectedFlights;//[{<DepartureFlight>,<Seat>,<IsReturning>,<SequenceNumber>},{<DepartureFlight>,<Seat>,<IsReturning>,<SequenceNumber>} ]
var _total_ticket_price = 0;
function InitStep3() {
    $("#routeTitle").html(_selectedRoute[0].CityID + " (" + _selectedRoute[0].CityName + ") &rarr; "
        + _selectedRoute[_selectedRoute.length - 1].CityID + " (" + _selectedRoute[_selectedRoute.length - 1].CityName + ")");

    var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric', hour: 'numeric', minute: 'numeric' };

    $("#routeInfo").html(_dates[0].toLocaleString([], options));

    //Init total region
    $("#step3-adult-number").html(_passengers[0]);
    $("#step3-children-number").html(_passengers[1]);
    $("#step3-senior-number").html(_passengers[2]);

    //Disable user to move to next step
    $('#btStep3Submit').prop('disabled', true);

    CheckSelectedFlights();
    GetFlights();
}

//Called when a flight radio button is checked
function CheckSelectedFlights(flight_number) {
    //Calculate total price
    var selectedFlights = $(".flight-select:checked");

    var totalPassengers = parseInt(_passengers[0]) + parseInt(_passengers[1]) + parseInt(_passengers[2]);
    var departureTotal = 0, returningTotal = 0;

    selectedFlights.each(function () {
        var price = parseFloat($(this).attr("price"));
        var returning = $(this).attr("returning") == "1";

        if (returning) {
            returningTotal += price;
        } else {
            departureTotal += price;
        }
    });

    //Multiply by total passengers
    departureTotal *= totalPassengers;
    returningTotal *= totalPassengers;

    $("#step3-total-departure-price").html(currencyFormat(departureTotal));
    $("#step3-total-return-price").html(currencyFormat(returningTotal));
    $("#step3-grand-total-price").html("<b>" + currencyFormat(departureTotal + returningTotal) + "</b>");

    //Check if user has choosen enough flights for the schedule. If he has, enable him to move to the next step
    if (selectedFlights.length == _selectedRoute.length - 1) {
        $('#btStep3Submit').prop('disabled', false);
    }
}

function currencyFormat(number) {
    return number.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + " VND";
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
            //Init flight to Departure section
            $("#departureFlight").html("");
            var departureFlightLists = result[0];
            for (i = 0; i < departureFlightLists.length; i++) {
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
                    html += '<div class="col-md-1 vcenter">' + currencyFormat(item['Price']) + '</div>';
                    html += '<div class="col-md-1">';
                    html += '<input  name="optDepartureFlight_' + i + '" class="flight-select" price="' + item['Price'] + '" onclick="CheckSelectedFlights()" type="radio" returning="0" sequence="' + i + '" value="' + item['FlightNumber'] + '"/>';
                    html += '</div>';
                    html += '</div>';
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
                        html += '<div class="col-md-1 vcenter">' + currencyFormat(item['Price']) + '</div>';
                        html += '<div class="col-md-1">';
                        html += '<input  name="optReturningFlight_' + i + '" class="flight-select" price="' + item['Price'] + '" onclick="CheckSelectedFlights()" type="radio" returning="1" sequence="' + i + '" value="' + item['FlightNumber'] + '"/>';
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
    _selectedFlights = [];
    //Set seat and flight number
    $('.flight-select').each(function () {
        var $this = $(this),
            optRadio = $this.attr('name'),
            value = $this.attr('value');

        if ($(this).prop('checked')) {
            var seqNo = parseInt($this.attr("sequence"));
            var returning = $this.attr("returning") == "1";
            if (optRadio.indexOf("Departure") !== -1) {
                _selectedFlights.push({ 'FlightNumber': value, 'SeatList': $("#seat_" + value).html(), 'IsReturning': returning, 'SequenceNumber': seqNo });
            }
            if (optRadio.indexOf("Return") !== -1) {
                _selectedFlights.push({ 'FlightNumber': value, 'SeatList': $("#seat_" + value).html(), 'IsReturning': returning, 'SequenceNumber': seqNo });
            }
            //urls.push('<div class="' + id + '">' + url + '</div>');
        }
    });
    console.log(_selectedFlights);
    $("#btn-step-4").removeClass("disabled");
    initStep4();
}

//------------------------------------------STEP 4------------------------------
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
                $("#login-register-form-step4").html('<div class="flight-result" style="padding: 25px; width: 80%"><div class="row"><div class="col-xs-12" style="text-align:center">You are already logged, Click the button to the final step</div></div></div>');
            }
            //console.log(result);
        }
    });
}

function loginValidation(form) {
    var flag = true;
    var error_msg = "";
    if (form == "main") {
        if ($("#main-login-username").val() == "") {
            $("#main-login-username").addClass("form-validation-error");
            flag = false;
            error_msg += "Please enter your username \n";
        } else {
            $("#main-login-username").removeClass("form-validation-error");
        }

        if ($("#main-login-password").val() == "") {
            $("#main-login-password").addClass("form-validation-error");
            flag = false;
            error_msg += "Please enter your password \n";
        } else {
            $("#main-login-password").removeClass("form-validation-error");
        }
    } else {
        if ($("#step4-login-username").val() == "") {
            $("#step4-login-username").addClass("form-validation-error");
            flag = false;
            error_msg += "Please enter your username \n";
        } else {
            $("#step4-login-username").removeClass("form-validation-error");
        }

        if ($("#step4-login-password").val() == "") {
            $("#step4-login-password").addClass("form-validation-error");
            flag = false;
            error_msg += "Please enter your password \n";
        } else {
            $("#step4-login-password").removeClass("form-validation-error");
        }
    }

    if (!flag) {
        sweetAlert("Oops...", error_msg, "error");
        return false;
    }

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

function createUserInfo(form) {
    var flag = true;
    var error_msg = "";
    if (form == "main") {
        //#Validation for register on main form
        if ($("#main-register-username").val() == "") {
            $("#main-register-username").addClass("form-validation-error");
            flag = false;
            error_msg += "Please enter your username \n";
        } else {
            $("#main-register-username").removeClass("form-validation-error");
        }

        if ($("#main-register-password").val() == "") {
            $("#main-register-password").addClass("form-validation-error");
            flag = false;
            error_msg += "Please enter your password \n";
        } else {
            $("#main-register-password").removeClass("form-validation-error");
        }

        if ($("#main-register-firstname").val() == "") {
            $("#main-register-firstname").addClass("form-validation-error");
            error_msg += "Please enter your firstname \n";
            flag = false;
        } else {
            $("#main-register-firstname").removeClass("form-validation-error");
        }

        if ($("#main-register-lastname").val() == "") {
            $("#main-register-lastname").addClass("form-validation-error");
            error_msg += "Please enter your lastname \n";
            flag = false;
        } else {
            $("#main-register-lastname").removeClass("form-validation-error");
        }

        if ($("#main-register-email").val() == "") {
            $("#main-register-email").addClass("form-validation-error");
            error_msg += "Please enter your email \n";
            flag = false;
        } else {
            $("#main-register-email").removeClass("form-validation-error");
        }

        if ($("#main-register-gender").val() == "") {
            $("#main-register-gender").addClass("form-validation-error");
            error_msg += "Please select your gender \n";
            flag = false;
        } else {
            $("#main-register-gender").removeClass("form-validation-error");
        }

        if ($("#main-register-phonenumber").val() == "") {
            $("#main-register-phonenumber").addClass("form-validation-error");
            error_msg += "Please enter your phonenumber \n";
            flag = false;
        } else {
            $("#main-register-phonenumber").removeClass("form-validation-error");
        }

        if ($("#main-register-creditcard").val() == "") {
            $("#main-register-creditcard").addClass("form-validation-error");
            error_msg += "Please enter your creditcard \n";
            flag = false;
        } else {
            $("#main-register-creditcard").removeClass("form-validation-error");
        }

        if ($("#main-register-dob").val() == "") {
            $("#main-register-dob").addClass("form-validation-error");
            error_msg += "Please select your date of birth \n";
            flag = false;
        } else {
            $("#main-register-dob").removeClass("form-validation-error");
        }
        //#end
    } else {
        //#Validation for register on step form (4)
        if ($("#step4-register-username").val() == "") {
            $("#step4-register-username").addClass("form-validation-error");
            flag = false;
            error_msg += "Please enter your username \n";
        } else {
            $("#step4-register-username").removeClass("form-validation-error");
        }

        if ($("#step4-register-password").val() == "") {
            $("#step4-register-password").addClass("form-validation-error");
            flag = false;
            error_msg += "Please enter your password \n";
        } else {
            $("#step4-register-password").removeClass("form-validation-error");
        }

        if ($("#step4-register-firstname").val() == "") {
            $("#step4-register-firstname").addClass("form-validation-error");
            error_msg += "Please enter your firstname \n";
            flag = false;
        } else {
            $("#step4-register-firstname").removeClass("form-validation-error");
        }

        if ($("#step4-register-lastname").val() == "") {
            $("#step4-register-lastname").addClass("form-validation-error");
            error_msg += "Please enter your lastname \n";
            flag = false;
        } else {
            $("#step4-register-lastname").removeClass("form-validation-error");
        }

        if ($("#step4-register-email").val() == "") {
            $("#step4-register-email").addClass("form-validation-error");
            error_msg += "Please enter your email \n";
            flag = false;
        } else {
            $("#step4-register-email").removeClass("form-validation-error");
        }

        if ($("#step4-register-gender").val() == "") {
            $("#step4-register-gender").addClass("form-validation-error");
            error_msg += "Please select your gender \n";
            flag = false;
        } else {
            $("#step4-register-gender").removeClass("form-validation-error");
        }

        if ($("#step4-register-phonenumber").val() == "") {
            $("#step4-register-phonenumber").addClass("form-validation-error");
            error_msg += "Please enter your phonenumber \n";
            flag = false;
        } else {
            $("#step4-register-phonenumber").removeClass("form-validation-error");
        }

        if ($("#step4-register-creditcard").val() == "") {
            $("#step4-register-creditcard").addClass("form-validation-error");
            error_msg += "Please enter your creditcard \n";
            flag = false;
        } else {
            $("#step4-register-creditcard").removeClass("form-validation-error");
        }

        if ($("#step4-register-dob").val() == "") {
            $("#step4-register-dob").addClass("form-validation-error");
            error_msg += "Please select your date of birth \n";
            flag = false;
        } else {
            $("#step4-register-dob").removeClass("form-validation-error");
        }
        //#region
    }

    if (!flag) {
        sweetAlert("Oops...", error_msg, "error");
        return false;
    }

    if (form == "main") {
        var obj = {
            'UserID': $("#main-register-username").val(),
            'Password': $("#main-register-password").val(),
            'FirstName': $("#main-register-firstname").val(),
            'LastName': $("#main-register-lastname").val(),
            'Email': $("#main-register-email").val(),
            'Gender': $("#main-register-gender").val(),
            'Phone': $("#main-register-phonenumber").val(),
            'DOB': $("#main-register-dob").val(),
            'CreditCard': $("#main-register-creditcard").val(),
        };
    } else {
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
    }

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

function SubmitStep4() {
    $("#btn-step-5").removeClass("disabled");
    //Fixed bug cannot move to next step by automatic
    //$("#step-4").hide('slide');
    //$("#step-5").show('slide');
}

//-----------------------STEP 5---------------------------------------------
function BlockTicket() {
    swal({
        title: "Are you sure?", text: "Do you really want to block this ticket?", type: "warning", showCancelButton: true,
        confirmButtonColor: "#DD6B55", confirmButtonText: "Yes, block it!", closeOnConfirm: false
    },
        function () {
            var obj = {
                SelectedFlights: _selectedFlights,
                Classes: _classes,
                Passengers: _passengers,
                RequestType: 3 //Block command code
            }
            $.ajax({
                url: 'Home/BookTicketAPI',
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                type: 'POST',
                data: JSON.stringify(obj),
                error: function (data) {
                    swal("Error", data.responseText, "error");
                },
                success: function (result) {
                    swal("You have successfully blocked the ticket!", "Blocking number: " + result, "success");
                }
            });
        });
}

function BuyTicket() {
    swal({
        title: "Are you sure?", text: "Do you really want to buy this ticket?", type: "warning", showCancelButton: true,
        confirmButtonColor: "#DD6B55", confirmButtonText: "Yes, buy it!", closeOnConfirm: false
    },
        function () {
            var obj = {
                SelectedFlights: _selectedFlights,
                Classes: _classes,
                Passengers: _passengers,
                RequestType: 1 //Buy command code
            }
            $.ajax({
                url: 'Home/BookTicketAPI',
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                type: 'POST',
                data: JSON.stringify(obj),
                error: function (data) {
                    swal("Error", data.responseText, "error");
                },
                success: function (result) {
                    swal("You have successfully purchased the ticket!", "Confirmation number: " + result, "success");
                }
            });
        });
}