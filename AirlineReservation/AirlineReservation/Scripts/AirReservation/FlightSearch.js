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
function InitStep3() {
    $("#routeTitle").html(_selectedRoute[0].CityID + " (" + _selectedRoute[0].CityName + ") &rarr; "
        + _selectedRoute[_selectedRoute.length - 1].CityID + " (" + _selectedRoute[_selectedRoute.length - 1].CityName + ")");

    var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric', hour: 'numeric', minute: 'numeric' };

    $("#routeInfo").html(_dates[0].toLocaleString([], options) + "<h4> Adults: " + _passengers[0] + " Children: "
        + _passengers[1] + " Senior citizens: " + _passengers[2] + "<h4>");
}

//Get all possible flights for the schedule and other user's condition
function GetFlights() {
    var routes = [];

    for (var i = 0; i < _selectedRoute.length; i++) {
        route.push(_selectedRoute[i].CityID);
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
            swal("See more in console!", result + '\nSee more details in console', "success");
            console.log(result);
        }
    });
}