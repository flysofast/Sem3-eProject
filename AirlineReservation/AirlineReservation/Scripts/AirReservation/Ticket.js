function searchFlight() {
    var flightNo = $("#flight_number_search").val();
    if (flightNo == "") {
        swal("Error", "Please enter your ticket number", "error");
        return false;
    }

    var obj = {
        'FlightNo': flightNo,
    };
    $.ajax({
        url: 'Flight/SearchFlightById',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            //console.log(result);
            if (result.length == 0) {
                swal("Not found", "This Flight does not exists, please try again!", "error");
                return false;
            }
            $("#TicketList").html("");
            var html = "";
            $.each(result, function (k) {
                html += '<div class="flight-result">';
                html += '<div class="row">';
                html += '<div class="col-md-2 vcenter">' + result[k]['FlightNo'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Original'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Destination'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToJavaScriptDate(result[k]['DepartureTime']) + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToTimeFormat(result[k]['Duration']) + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToCurrencyFormat(result[k]['CurrentPrice']) + '</div>';
                html += '</div>';
                html += '</div>';
            })
            $("#TicketList").html(html);
            $("#TicketList").slideDown();
        }
    });
}

function ToTimeFormat(value) {
    var hours = Math.floor(value);
    var minutes = Math.floor((value - hours) * 60);
    return hours + "h " + minutes + "m";
}

function ToJavaScriptDate(value) {
    var pattern = /Date\(([^)]+)\)/;
    var results = pattern.exec(value);
    var dt = new Date(parseFloat(results[1]));
    return dt.getFullYear() + "-" + (dt.getMonth() + 1) + "-" + (dt.getDate() + 1 + " " + dt.getHours() + ":" + dt.getMinutes());
}

function ToTimeFormat(value) {
    var hours = Math.floor(value);
    var minutes = Math.floor((value - hours) * 60);
    return hours + "h " + minutes + "m";
}

function ToCurrencyFormat(number) {
    return number.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + " VND";
}