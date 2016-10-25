<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Template.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/modernizr.js"></script>
    <script src="../../Scripts/AirReservation/Admin.js"></script>
    <script src="../../Scripts/AirReservation/ChooseSeat.js"></script>
    <script>
        $(window).load(function () {
            setTimeout(function () {
                $('.se-pre-con').fadeOut('slow', function () {
                });
            }, 1000); // set the time here
        });
    </script>
    <div class="float-button-container" id="float-button-group" style="display: none">
        <div class="float-button" style="background-image: url(../../Images/reunion_small.png)" onclick="changePage('information')"></div>
        <div class="float-button" style="background-image: url(../../Images/travel_small.png)" onclick="changePage('ticket')"></div>
        <div class="float-button" style="background-image: url(../../Images/cityscape_small.png)" onclick="changePage('log')"></div>
        <div class="float-button" style="background-image: url(../../Images/cinema-small.png)" onclick="changePage('seat')"></div>
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
                        <img src="../../Images/reunion.png" alt="Bootstrap Thumbnail Customization" />
                        <div class="caption">
                            <h3>Administrator Information</h3>
                            <p class="card-description">Add/Show Administrator list</p>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4">
                    <div class="thumbnail" onclick="changePage('ticket')">
                        <img src="../../Images/travel.png" alt="Bootstrap Thumbnail Customization" />
                        <div class="caption">
                            <h3>Flight Management</h3>
                            <p class="card-description">View/Edit flight</p>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4">
                    <div class="thumbnail" onclick="changePage('log')">
                        <img src="../../Images/cityscape.png" alt="Bootstrap Thumbnail Customization" />
                        <div class="caption">
                            <h3>City and Route Mangement</h3>
                            <p class="card-description">View/Edit City and Route</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-md-4">
                    <div class="thumbnail" onclick="changePage('seat')">
                        <img src="../../Images/cinema.png" alt="Bootstrap Thumbnail Customization" />
                        <div class="caption">
                            <h3>Seat</h3>
                            <p class="card-description">Management seat for class</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container" id="formSeatInformation" style="height: 600px; display: block; overflow-y: scroll; overflow-x: hidden;">
        <h2>Seat list</h2>
        <div class="row">
            <div class="col-md-2 vcenter">Class Type</div>
            <div class="col-md-9 vcenter">Seat List</div>
            <div class="col-md-1 vcenter"></div>
        </div>
        <!-- Result -->
        <div class="flight-result">
            <div class="row">
                <div class="col-md-2 vcenter">Business class</div>
                <div class="col-md-7 vcenter" id="seat_business_class">Club class</div>
                <div class="col-md-3 vcenter">
                    <button class="btn btn-primary" onclick="selectSeatWithClass('business')">Choose Seat</button>
                </div>
            </div>
        </div>
        <div class="flight-result">
            <div class="row">
                <div class="col-md-2 vcenter">Club class</div>
                <div class="col-md-7 vcenter" id="seat_club_class"></div>
                <div class="col-md-3 vcenter">
                    <button class="btn btn-primary" onclick="selectSeatWithClass('club')">Choose Seat</button>
                </div>
            </div>
        </div>
        <div class="flight-result">
            <div class="row">
                <div class="col-md-2 vcenter">First class</div>
                <div class="col-md-7 vcenter" id="seat_first_class"></div>
                <div class="col-md-3 vcenter">
                    <button class="btn btn-primary" onclick="selectSeatWithClass('first')">Choose Seat</button>
                </div>
            </div>
        </div>
        <div class="flight-result">
            <div class="row">
                <div class="col-md-2 vcenter">Non-smoking class</div>
                <div class="col-md-7 vcenter" id="seat_non_smoking_class"></div>
                <div class="col-md-3 vcenter">
                    <button class="btn btn-primary" onclick="selectSeatWithClass('non_smoking')">Choose Seat</button>
                </div>
            </div>
        </div>
        <div class="flight-result">
            <div class="row">
                <div class="col-md-2 vcenter">Smoking class</div>
                <div class="col-md-7 vcenter" id="seat_smoking_class"></div>
                <div class="col-md-3 vcenter">
                    <button class="btn btn-primary" onclick="selectSeatWithClass('smoking')">Choose Seat</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container" id="formPersonalInformation" style="height: 600px; display: block; overflow-y: scroll; overflow-x: hidden;">
        <h2>Administrator list</h2>
        <button type="button" class="btn btn-primary" onclick="addAdministrator()" style="margin: 10px;">Add Administrator</button>
        <div class="row">
            <div class="col-md-2 vcenter">UserID</div>
            <div class="col-md-2 vcenter">First Name</div>
            <div class="col-md-2 vcenter">Last Name</div>
            <div class="col-md-1 vcenter">Sex</div>
            <div class="col-md-2 vcenter">Email</div>
            <div class="col-md-2 vcenter">PhoneNumber</div>
            <div class="col-md-1 vcenter"></div>
        </div>
        <div id="administratorList"></div>
    </div>

    <div class="container" id="formTicket" style="height: 600px; display: block;">
        <h2>Flight Mangement</h2>
        <div class="flight-result" style="padding: 25px; width: 90%">
            <div class="row">
                <div class="col-md-3">
                    <div class="form-group row">
                        <label for="example-text-input" class="col-xs-3 col-form-label">Flight No</label>
                        <div class="col-xs-7">
                            <input class="form-control" type="hidden" id="admin-flight-register-flightNo-choose" />
                            <input class="form-control" type="text" id="admin-flight-register-flightNo" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="example-search-input" class="col-xs-3 col-form-label">Price</label>
                        <div class="col-xs-7">
                            <input class="form-control" type="text" id="admin-flight-register-price" />
                        </div>
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="form-group row">
                        <label for="example-search-input" class="col-xs-3 col-form-label">Departure Time</label>
                        <div class="col-xs-7">
                            <input class="form-control" type="datetime-local" id="admin-flight-register-departureTime" />
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="example-search-input" class="col-xs-3 col-form-label">Route</label>
                        <div class="col-xs-7">
                            <select class="form-control" id="admin-flight-register-routeID">
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group row">
                        <label for="example-search-input" class="col-xs-3 col-form-label">Cancellation Fee per day (%)</label>
                        <div class="col-xs-7">
                            <input class="form-control" value="1" type="number" id="admin-flight-register-cancellationFee" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="example-search-input" class="col-xs-3 col-form-label">Duration (hours)</label>
                        <div class="col-xs-7">
                            <input class="form-control" placeholder="E.g. 2.5" type="text" id="admin-flight-register-duration" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <a href="#" class="btn btn-primary btn-lg" onclick="createFlight()">Create new</a>
                    <a id="updateFlightBtn" style="display: none" href="#" class="btn btn-primary btn-lg" onclick="updateFlight()">Update</a>
                </div>
            </div>
        </div>
        <div class="container" style="height: 300px; display: block; overflow-y: scroll; overflow-x: hidden;">
            <div class="row">
                <div class="col-md-2 vcenter">Flight No</div>
                <div class="col-md-2 vcenter">Current Price</div>
                <div class="col-md-2 vcenter">Departure Time</div>
                <div class="col-md-2 vcenter">Route</div>
                <div class="col-md-2 vcenter">Cancellation Fee</div>
                <div class="col-md-1 vcenter">Duration</div>
                <div class="col-md-1 vcenter"></div>
            </div>
            <div id="FlightList"></div>
        </div>
    </div>
    <div class="container" id="formLog" style="height: 600px; display: block;">
        <h2>City and Route Mangement</h2>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group row">
                    <label for="example-search-input" class="col-xs-3 col-form-label">City ID</label>
                    <div class="col-xs-7">
                        <input class="form-control" type="hidden" id="admin-city-register-id-hidden" />
                        <input class="form-control" type="text" id="admin-city-register-id" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="example-search-input" class="col-xs-3 col-form-label">City Name</label>
                    <div class="col-xs-7">
                        <input class="form-control" type="text" id="admin-city-register-name" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="example-search-input" class="col-xs-3 col-form-label">In Service</label>
                    <div class="col-xs-7">
                        <label>
                            <input type="checkbox" id="admin-city-register-inservice" /></label>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group row">
                    <label for="example-search-input" class="col-xs-3 col-form-label">Route ID</label>
                    <div class="col-xs-7">
                        <input class="form-control" type="number" id="admin-route-register-routeID" disabled />
                    </div>
                </div>

                <div class="form-group row">
                    <label for="example-search-input" class="col-xs-3 col-form-label">Original City</label>
                    <div class="col-xs-7">
                        <select class="form-control" id="admin-route-register-originalcity">
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="example-search-input" class="col-xs-3 col-form-label">Destination City</label>
                    <div class="col-xs-7">
                        <select class="form-control" id="admin-route-register-destinatecity">
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="example-search-input" class="col-xs-3 col-form-label">Distance</label>
                    <div class="col-xs-7">
                        <input class="form-control" type="number" id="admin-route-register-distance" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="example-search-input" class="col-xs-3 col-form-label">In Service</label>
                    <div class="col-xs-7">
                        <label>
                            <input type="checkbox" id="admin-route-register-inservice" /></label>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <a href="#" class="btn btn-primary btn-md" onclick="createCity()">Create new</a>
                <a id="updateCityBtn" style="display: none" href="#" class="btn btn-primary btn-md" onclick="updateCity()">Update</a>
            </div>
            <div class="col-md-6">
                <a href="#" class="btn btn-primary btn-md" onclick="createRoute()">Create new</a>
                <a id="updateRouteBtn" style="display: none" href="#" class="btn btn-primary btn-md" onclick="updateRoute()">Update</a>
            </div>
        </div>

        <div class="row" style="margin-top: 10px">
            <div class="col-md-6">
                <div style="height: 240px; display: block; overflow-y: scroll; overflow-x: hidden;">
                    <div class="row">
                        <div class="col-md-3 vcenter">City ID</div>
                        <div class="col-md-3 vcenter">City Name</div>
                        <div class="col-md-3 vcenter">In service</div>
                        <div class="col-md-3 vcenter"></div>
                    </div>
                    <div id="cityList"></div>
                </div>
            </div>
            <div class="col-md-6">
                <div style="height: 240px; display: block; overflow-y: scroll; overflow-x: hidden;">
                    <div class="row">
                        <div class="col-md-2 vcenter">Route ID</div>
                        <div class="col-md-2 vcenter">Originale City</div>
                        <div class="col-md-2 vcenter">Destination City</div>
                        <div class="col-md-2 vcenter">Distance</div>
                        <div class="col-md-2 vcenter">In service</div>
                        <div class="col-md-2 vcenter"></div>
                    </div>
                    <div id="routeList"></div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <!-- Modal -->
    <div id="userListModalBox" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width: 70%;">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Modal Header</h4>
                </div>
                <div class="modal-body">
                    <div id="normalUserList">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>