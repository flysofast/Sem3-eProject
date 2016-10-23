<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Template.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script src="../../Scripts/AirReservation/Ticket.js"></script>
<script>
    $(window).load(function () {
        setTimeout(function () {
            $('.se-pre-con').fadeOut('slow', function () {
            });
        }, 1000); // set the time here
    });
    </script>
<div class="container" id="formTicket" style="height: 600px; display: block;">
        <h2>Search ticket information</h2>
        <div class="flight-result" style="padding: 25px; width: 90%">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group row">
                        <label for="example-text-input" class="col-xs-3 col-form-label">Your ticket number:</label>
                        <div class="col-xs-7">
                            <input class="form-control" type="number" id="ticket_number_search" />
                        </div>
                    </div>
                </div>                
            </div>
            <div class="row">
                <div class="col-md-12">
                    <a href="#" class="btn btn-primary btn-lg" onclick="searchTicket()">Search</a>
                </div>
            </div>
        </div>
        <div class="container" style="height: 300px; display: block; overflow-y: scroll; overflow-x: hidden;">
            <div class="row">
                <div class="col-md-2 vcenter">Ticket No</div>
                <div class="col-md-2 vcenter">Original City</div>
                <div class="col-md-2 vcenter">Destination City</div>
                <div class="col-md-2 vcenter">Created Date</div>
                <div class="col-md-2 vcenter">Price</div>
                <div class="col-md-2 vcenter">Status</div>
            </div>
            <div id="TicketList"></div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
