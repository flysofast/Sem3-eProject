
function GetPossibleRoute() {

    var obj = {
        OriginalCityID: $('#fromLocation').val(),
        DestinationCityID: $('#toLocation').val()
    }

    $.ajax({
        url: 'Home/GetPossibleRouteAPI',
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

function GetFlights(vertices) {


    $.ajax({
        url: 'Home/GetFlightsAPI',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(vertices),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            swal("See more in console!", result + '\nSee more details in console', "success");
            console.log(result);
        }
    });
}

function SetNearestAvailable(dropdownControl) {
    var cityID = {
        cityID: dropdownControl.val()
    }

    $.ajax({
        url: 'Home/GetNearestAvailableAPI',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(cityID),
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
                a.unbind("click").bind("click", function () {
                    dropdownControl.val(result.CityID);
                    span.hide('slow');
                });
            } else {
                span.hide();
            }
        }
    });
}

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


$(document).ready(function () {
    //$('#fromLocation').append('<option  value=' + item.ClassTypeID + '>' + item.ClassType + '</option>');

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

