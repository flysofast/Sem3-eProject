
function GetPossibleRoute() {
    
    var obj = {
        OriginalCityID: $('#fromLocation').val(),
        DestinationCityID: $('#toLocation').val()
    }

    $.ajax({
        url: 'TestAjax/GetPossibleRouteAPI',
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
        url: 'TestAjax/GetFlightsAPI',
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

