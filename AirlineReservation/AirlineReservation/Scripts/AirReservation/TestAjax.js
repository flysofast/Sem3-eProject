
function GetPossibleRoute() {

    console.log($('#fromLocation').val());
    console.log($('#toLocation').val())
    

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
            console.log("Error: "+ data.responseText);
        },
        success: function (result) {
            console.log(result)
        }
    });
}
