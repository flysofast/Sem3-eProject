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
    <div class="float-button-container" id="float-button-group" style="display: none">
        <div class="float-button" style="background-image: url(../../Images/job-search_small.png)" onclick="changePage('information')"></div>
        <div class="float-button" style="background-image: url(../../Images/ticket_small.png)" onclick="changePage('ticket')"></div>
        <div class="float-button" style="background-image: url(../../Images/notebook_small.png)" onclick="changePage('log')"></div>
    </div>

    <style>
        /* Let's get this party started */
        ::-webkit-scrollbar {
            width: 12px;
        }

        /* Track */
        ::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
            -webkit-border-radius: 10px;
            border-radius: 10px;
        }

        /* Handle */
        ::-webkit-scrollbar-thumb {
            -webkit-border-radius: 10px;
            border-radius: 10px;
            background: rgba(30,144,255,0.8);
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
        }

            ::-webkit-scrollbar-thumb:window-inactive {
                background: rgba(30,144,255,0.4);
            }
    </style>
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
                    <div class="thumbnail" onclick="changePage('ticket')">
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

    <div class="container" id="formPersonalInformation" style="height: 600px; display: block; overflow-y: scroll; overflow-x: hidden;">
        <h2>Your personal information</h2>
        <div class="form-group row">
            <label for="example-text-input" class="col-xs-3 col-form-label">Username</label>
            <div class="col-xs-7">
                <input class="form-control" type="text" id="personal-username">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-text-input" class="col-xs-3 col-form-label">First Name</label>
            <div class="col-xs-7">
                <input class="form-control" type="text" id="personal-firstname">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Last Name</label>
            <div class="col-xs-7">
                <input class="form-control" type="text" id="personal-lastname">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Email</label>
            <div class="col-xs-7">
                <input class="form-control" type="email" id="personal-email">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Phone Number</label>
            <div class="col-xs-7">
                <input class="form-control" type="text" id="personal-phone">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Gender</label>
            <div class="col-xs-7">
                <select class="form-control" id="personal-gender">
                    <option value="true">Male</option>
                    <option value="false">Female</option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Day Of Birth </label>
            <div class="col-xs-7">
                <input class="form-control" type="date" id="personal-dob">
            </div>
        </div>
        <div class="form-group row">
            <label for="example-search-input" class="col-xs-3 col-form-label">Credit card </label>
            <div class="col-xs-7">
                <input class="form-control" type="text" id="personal-creditcard">
            </div>
        </div>
        <div class="form-group row">
            <button class="btn btn-primary nextBtn btn-lg" type="button" onclick="updateUserInfor()">Update your personal information</button>
        </div>
    </div>

    <div class="container" id="formTicket" style="height: 600px; display: block; overflow-y: scroll; overflow-x: hidden;">
        <h2>Your active tickets</h2>
        <div class="row">
            <div class="col-md-2 vcenter">Ticket Code</div>
            <div class="col-md-2 vcenter">CreatedDate</div>
            <div class="col-md-2 vcenter">Price</div>
            <div class="col-md-2 vcenter">Status</div>
            <div class="col-md-2 vcenter">Action</div>
        </div>
        <div id="currentlyTicketList"></div>
    </div>
    <div class="container" id="formLog" style="height: 600px; display: block; overflow-y: scroll; overflow-x: hidden;">
        <h2>Your Log ticket</h2>
        <div class="container" style="height: 300px; display: block; overflow-y: scroll; overflow-x: hidden;">
            <div class="row">
                <div class="col-md-2 vcenter">Ticket No</div>
                <div class="col-md-2 vcenter">Original City</div>
                <div class="col-md-2 vcenter">Destination City</div>
                <div class="col-md-2 vcenter">Created Date</div>
                <div class="col-md-2 vcenter">Price</div>
                <div class="col-md-2 vcenter">Status</div>
            </div>
            <div id="TicketList" style="display:none"></div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>