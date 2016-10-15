<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Template.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script src="../Scripts/modernizr.js"></script>
<script src="../../Scripts/AirReservation/Personal.js"></script>
<script>
    $(window).load(function () {
        setTimeout(function () {
            $('.se-pre-con').fadeOut('slow', function () {
            });
        }, 1000); // set the time here
    });

</script>
    <div class="float-button-container" id="float-button-group">
        <div class="float-button" style="background-image:url(../../Images/job-search_small.png)" onclick="changePage('information')"></div>
        <div class="float-button" style="background-image:url(../../Images/ticket_small.png)" onclick="changePage('ticket')"></div>
        <div class="float-button" style="background-image:url(../../Images/notebook_small.png)" onclick="changePage('log')"></div>
    </div>


<div class="container-fluid cards-row" id="card-row-index">
<div class="container">
<div class="row">

  <div class="col-sm-6 col-md-4">
    <div class="thumbnail" onclick="changePage('information')">
      <img src="../../Images/job-search.png" alt="Bootstrap Thumbnail Customization">
      <div class="caption">
        <h3>Personal Information</h3>
        <p class="card-description">View/Edit your personal information</p>
      </div>
    </div>
  </div>
  
    <div class="col-sm-6 col-md-4">
    <div class="thumbnail"  onclick="changePage('ticket')">
      <img src="../../Images/ticket.png" alt="Bootstrap Thumbnail Customization">
      <div class="caption">
        <h3>View/Edit your ticket</h3>
        <p class="card-description">View/Edit your personal information</p>
      </div>
    </div>
  </div>
  
    <div class="col-sm-6 col-md-4">
    <div class="thumbnail" onclick="changePage('log')">
      <img src="../../Images/notebook.png" alt="Bootstrap Thumbnail Customization">
      <div class="caption">
        <h3>History</h3>
        <p class="card-description">Show your history log</p>
      </div>
    </div>
  </div>
  
</div>
</div>
</div>

    <div class="container" id="formPersonalInformation" style="min-height: 300px;">
        <h2>Your personal information</h2>  
        <div class="form-group row">
            <label for="example-text-input" class="col-xs-3 col-form-label">Username</label>
            <div class="col-xs-7">
                <input class="form-control" type="text" id="Text1">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Password</label>
            <div class="col-xs-7">
                <input class="form-control" type="password" id="Password1">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-text-input" class="col-xs-3 col-form-label">First Name</label>
            <div class="col-xs-7">
                <input class="form-control" type="text" id="Text2">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Last Name</label>
            <div class="col-xs-7">
                <input class="form-control" type="text" id="Password2">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Email</label>
            <div class="col-xs-7">
                <input class="form-control" type="email" id="Text3">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Phone Number</label>
            <div class="col-xs-7">
                <input class="form-control" type="text" id="Text4">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Gender</label>
            <div class="col-xs-7">
                <input class="form-control" type="text" id="Text5">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Day Of Birth </label>
            <div class="col-xs-7">
                <input class="form-control" type="date" id="Text6">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Credit card </label>
            <div class="col-xs-7">
                <input class="form-control" type="text" id="Date2">
            </div>
        </div>
        <div class="form-group row">
            <button class="btn btn-primary nextBtn btn-lg" type="button">Update your personal information</button>
        </div>
    </div>

    <div class="container" id="formTicket" style="min-height: 300px;">
        <h2>Your currently ticket</h2>  
        <div class="row">
            <div class="col-md-2 vcenter">Ticket Code</div>
            <div class="col-md-2 vcenter">From</div>
            <div class="col-md-2 vcenter">To</div>
            <div class="col-md-2 vcenter">Date Booking</div>
            <div class="col-md-2 vcenter">Status</div>
            <div class="col-md-2 vcenter">Action</div>
        </div>
        <div class="flight-result">
            <div class="row">
                <div class="col-md-2 vcenter">T0001</div>
                <div class="col-md-2 vcenter">Hanoi</div>
                <div class="col-md-2 vcenter">Hue</div>
                <div class="col-md-2 vcenter">2016/02/02</div>
                <div class="col-md-2 vcenter">Block</div>
                <div class="col-md-1 vcenter">
                    <button>Confirm</button>
                </div>
                <div class="col-md-1 vcenter">
                    <button>Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container" id="formLog" style="min-height: 300px;">
       <h2>Your Log ticket</h2>  
        <div class="row">
            <div class="col-md-2 vcenter">Ticket Code</div>
            <div class="col-md-2 vcenter">From</div>
            <div class="col-md-2 vcenter">To</div>
            <div class="col-md-2 vcenter">Date Booking</div>
            <div class="col-md-2 vcenter">Status</div>
        </div>
        <div class="flight-result">
            <div class="row">
                <div class="col-md-2 vcenter">T0001</div>
                <div class="col-md-2 vcenter">Hanoi</div>
                <div class="col-md-2 vcenter">Hue</div>
                <div class="col-md-2 vcenter">2016/02/02</div>
                <div class="col-md-2 vcenter">Done</div>
            </div>
        </div>
    </div>
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
