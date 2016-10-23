function searchTicket() {
    var ticketNo = $("#ticket_number_search").val();
    if (ticketNo == "") {
        swal("Error", "Please enter your ticket number", "error");
        return false;
    }

    var obj = {
        'TicketNo': ticketNo,
    };
    $.ajax({
        url: 'Ticket/SearchTicketById',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(obj),
        error: function (data) {
            swal("Error", data.responseText, "error");
        },
        success: function (result) {
            console.log(result);
            $("#TicketList").html("");
            var html = "";
            $.each(result, function (k) {
                html += '<div class="flight-result">';
                html += '<div class="row">';
                html += '<div class="col-md-2 vcenter">' + result[k]['TicketNo'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Original'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Destination'] + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToJavaScriptDate(result[k]['CreatedDate']) + '</div>';
                html += '<div class="col-md-2 vcenter">' + ToCurrencyFormat(result[k]['Price']) + '</div>';
                html += '<div class="col-md-2 vcenter">' + result[k]['Status'] + '</div>';
                html += '</div>';
                html += '</div>';
            })
            $("#TicketList").html(html);
        }
    });
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