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
        <div class="float-button" style="background-image:url(../../Images/job-search_small.png)" ></div>
        <div class="float-button" style="background-image:url(../../Images/ticket_small.png)"></div>
        <div class="float-button" style="background-image:url(../../Images/notebook_small.png)" ></div>
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

    <div class="container" id="formPersonalInformation">
        Form
    </div>

    <div class="container" id="formTicket">
        Form
    </div>

    <div class="container" id="formLog">
        Form<br />
        Form<br />
        Form<br />
        Form<br />Form<br />Form<br />Form<br />Form<br />Form<br />Form<br />Form<br />Form<br />Form<br />Form<br />Form<br />
        Form<br />
    </div>
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
