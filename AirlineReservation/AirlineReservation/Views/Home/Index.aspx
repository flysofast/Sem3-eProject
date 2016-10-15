<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Template.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/Airplant.css" rel="stylesheet" />
    <script src="../Scripts/modernizr.js"></script>
    <script src="../../Scripts/AirReservation/ChooseSeat.js"></script>

    <script>
        $(window).load(function () {
            setTimeout(function () {
                $('.se-pre-con').fadeOut('slow', function () {
                });
            }, 1000); // set the time here
        });
    </script>
    <div class="container" style="width: 100%">
        <h2 style="font-weight: bolder;">BOOKING ONLINE.</h2>
        <h3>It's Fast, Easy and Secure</h3>
        <div class="stepwizard">
            <div class="stepwizard-row setup-panel">
                <div class="stepwizard-step">
                    <a href="#step-1" type="button" class="btn btn-primary btn-circle">1</a>
                    <p>Search Route</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled style="opacity: 1">2</a>
                    <p>Ticket Requirement</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled style="opacity: 1">3</a>
                    <p>Select flight</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-4" type="button" class="btn btn-default btn-circle" disabled style="opacity: 1">4</a>
                    <p>Check Login/ Register</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-5" type="button" class="btn btn-default btn-circle" disabled style="opacity: 1">5</a>
                    <p>Summary</p>
                </div>
            </div>
        </div>
        <form role="form" action="" method="post" class="form-horizontal">
            <div class="row setup-content" id="step-1">
                <div class="col-xs-12">
                    <div class="col-md-12">
                        <h3 style="font-weight: bold;">Form search</h3>
                        <div class="row" style="padding-top: 34px">
                            <div class="col-xs-6 col-md-4">
                                <div class="form-group">
                                    <label class="control-label col-sm-2" for="From">From:</label>
                                    <div class="col-sm-10">
                                        <select class="form-control input-xlarg" id="fromLocation">
                                        </select>
                                        <span class="suggestion-text">This city is not under service.<br />
                                            <a>Click here </a>to choose the nearest available city instead <span class="alter-city-details"></span></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-2"></div>
                                    <div class="col-sm-10">
                                        <img src="../../Images/group.png" onclick="swapLocation()" style="cursor: pointer" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2" for="To">To:</label>
                                    <div class="col-sm-10">
                                        <select class="form-control input-xlarg" id="toLocation">
                                        </select>
                                        <span class="suggestion-text" style="display: none">This city is not under service.<br />
                                            <a>Click here </a>to choose the nearest available city instead <span class="alter-city-details"></span></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-2 col-md-2 columnForm">
                                <input type="button" class="btn btn-success" value="SEARCH" onclick="GetPossibleFlightSchedule()" />
                            </div>
                            <div class="col-xs-4 col-md-6">
                                <div id="step1-result" style="clear: both">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-11">
                                                <span>Flight schedule</span><br />
                                                <span class="suggestion-text">This the shortest path between the 2 cities at the moment</span>
                                            </div>
                                            <%--<div class="col-md-3"></div>--%>
                                            <%--<div class="col-md-3">Select</div>--%>
                                        </div>
                                    </div>

                                    <div class="flight-result" style="margin-top: 0px;">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="col-md-11 vcenter"><span id="foundRouteDetails"></span></div>
                                                <%--<div class="col-md-3 vcenter"></div>--%>
                                                <%--   <div class="col-md-3">
                                                    <input type="radio" name="optReturnFlight" />
                                                </div>--%>
                                            </div>
                                        </div>
                                    </div>

                                    <%--  <div class="flight-result" style="margin-top: 0px;">
                                      <div class="row">
                                                <div class="col-md-12">
                                                    <div class="col-md-5 vcenter">Hanoi (HN) -> Hue (Hue) -> Ho Chi Minh (HCM)</div>
                                                    <div class="col-md-3 vcenter">Direct</div>
                                                    <div class="col-md-3">
                                                         <input type="radio" name="optReturnFlight">
                                                    </div>
                                                </div>
                                          </div>
                                      </div>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <button id="btStep1Submit" class="btn btn-primary nextBtn btn-lg pull-right" type="button" onclick="SubmitStep1()">Next</button>
                </div>
            </div>
            <div class="row setup-content" id="step-2">
                <div class="col-md-4 columnForm">
                    <div class="form-group">
                        <label class="control-label col-md-3" for="To">Departure:</label>
                        <div class="col-md-9">
                            <input id="inputDepartureDate" type="date" required="required" class="form-control" style="margin-left: 5px;" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" for="To">Type:</label>
                        <div class="col-sm-9">
                            <label class="radio-inline">
                                <input type="radio" id="optFlightOneWay" name="optFlight" checked="checked" />One-way</label>
                            <label class="radio-inline">
                                <input type="radio" id="optFlightReturn" name="optFlight" />Return</label>
                        </div>
                    </div>
                    <div class="form-group" id="returnDateForm">
                        <label class="control-label col-md-3" for="To">Return:</label>
                        <div class="col-md-9">
                            <input id="inputReturnDate" type="date" required="required" class="form-control" style="margin-left: 5px;" />
                        </div>
                    </div>
                </div>
                <div class="col-md-4 columnForm">
                    <div class="form-group">
                        <label class="control-label col-md-3" for="To">Class:</label>
                        <div class="col-md-9">
                            <select class="form-control class-list">
                            </select>
                        </div>
                    </div>
                    <div class="form-group" id="lblReturnClass">
                        <label class="control-label col-sm-12" for="To" style="text-align: center">Return class</label>
                    </div>
                    <div class="form-group" id="returnClass">
                        <label class="control-label col-md-3" for="To">Class:</label>
                        <div class="col-md-9">
                            <select class="form-control class-list">
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="control-label col-sm-3" for="To">Adults:</label>
                        <div class="col-sm-9">
                            <input id="adultsNo" type="number" class="form-control" value="1" style="width: 30%" />
                            <%-- <select class="form-control" style="width: 56px">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>--%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" for="To">Children:</label>
                        <div class="col-sm-9">
                            <input id="childrenNo" type="number" class="form-control" value="1" style="width: 30%" />
                            <%--<select class="form-control" style="width: 56px">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>--%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" for="To">Senior citizens:</label>
                        <div class="col-sm-9">
                            <input id="elderNo" type="number" class="form-control" value="1" style="width: 30%" />
                            <%-- <select class="form-control" style="width: 56px">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>--%>
                        </div>
                    </div>
                </div>
                <button id="btStep2Submit" class="btn btn-primary nextBtn btn-lg pull-right" type="button" onclick="SubmitStep2()">Next</button>
            </div>
            <div class="row setup-content" id="step-3">
                <div class="col-xs-12">
                    <div class="col-md-12">
                        <h3>Select Flight</h3>
                        <h4>Hanoi (HAN) → Ho Chi Minh City (SGN)</h4>
                        <h4>Monday, October 3, 20161 Adult</h4>

                        <ul class="nav nav-tabs" style="margin-bottom: 22px">
                            <li class="active">
                                <a data-toggle="tab" href="#departureFlight">Departure Flight</a>
                            </li>
                            <li>
                                <a data-toggle="tab" href="#returnFlight">Return Flight</a>
                            </li>
                        </ul>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-2">Airline</div>
                                <div class="col-md-2">Depart</div>
                                <div class="col-md-2">Arrive</div>
                                <div class="col-md-2">Duration</div>
                                <div class="col-md-2">Price per person</div>
                                <div class="col-md-2">Select</div>
                            </div>
                        </div>
                        <div class="tab-content">
                            <!-- Departure Flight-->
                            <div id="departureFlight" class="tab-pane fade in active">
                                <div class="flight-result">
                                    <div class="row" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                                        <div class="col-md-12">
                                            <div class="col-md-2 vcenter">VietName Airline</div>
                                            <div class="col-md-2 vcenter">15:00 (Hanoi)</div>
                                            <div class="col-md-2 vcenter">17:00 (HCM)</div>
                                            <div class="col-md-2 vcenter">02:00 (Transhipped)</div>
                                            <div class="col-md-2 vcenter">1.000.000</div>
                                            <div class="col-md-2">
                                                <input type="radio" name="optDepartureFlight">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="collapse" id="collapseExample" style="border-top: 1px solid">
                                            <div class="card card-block" style="padding: 20px;">
                                                <div class="row">
                                                    <div class="col-sm-6 col-md-4">
                                                        <div class="thumbnail">
                                                            From Ha Noi(HN) To Hue (HUE)
                                                      <div class="caption">
                                                          <h3>Detail</h3>
                                                          <p class="card-description">
                                                              Depart: 13:00<br />
                                                              Arrive: 13:30<br />
                                                              Duration: 00:30<br />
                                                              Seat: <span id="seatChoose"></span>
                                                              <br />
                                                              <button onclick="selectSeatWithFlightID(1)">click</button>
                                                          </p>
                                                      </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6 col-md-4">
                                                        <div class="thumbnail">
                                                            From Hue(HUE) To Ho Chi Minh (HCM)
                                                      <div class="caption">
                                                          <h3>Detail</h3>
                                                          <p class="card-description">
                                                              Depart: 14:00<br />
                                                              Arrive: 14:30<br />
                                                              Duration: 00:30<br />
                                                          </p>
                                                      </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Departure Flight -->

                            <!-- Return Flight-->
                            <div id="returnFlight" class="tab-pane fade">
                                <div class="flight-result">
                                    <div class="row" data-toggle="collapse" data-target="#Div3" aria-expanded="false" aria-controls="Div3">
                                        <div class="col-md-12">
                                            <div class="col-md-2 vcenter">VietName Airline</div>
                                            <div class="col-md-2 vcenter">15:00 (Hanoi)</div>
                                            <div class="col-md-2 vcenter">17:00 (HCM)</div>
                                            <div class="col-md-2 vcenter">02:00 (Direct)</div>
                                            <div class="col-md-2 vcenter">1.000.000</div>
                                            <div class="col-md-2">
                                                <input type="radio" name="optReturnFlight">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="collapse" id="Div3">
                                            <div class="card card-block">
                                                <div class="card card-block" style="padding: 20px;">
                                                    <div class="row">
                                                        <div class="col-sm-6 col-md-4">
                                                            <div class="thumbnail">
                                                                From Ha Noi(HN) To Hue (HUE)
                                                      <div class="caption">
                                                          <h3>Detail</h3>
                                                          <p class="card-description">
                                                              Depart: 13:00<br />
                                                              Arrive: 13:30<br />
                                                              Duration: 00:30<br />
                                                          </p>
                                                      </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6 col-md-4">
                                                            <div class="thumbnail">
                                                                From Hue(HUE) To Ho Chi Minh (HCM)
                                                      <div class="caption">
                                                          <h3>Detail</h3>
                                                          <p class="card-description">
                                                              Depart: 14:00<br />
                                                              Arrive: 14:30<br />
                                                              Duration: 00:30<br />
                                                          </p>
                                                      </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Return Flight -->
                        </div>
                        <button class="btn btn-primary nextBtn btn-lg pull-right" type="button">Next</button>
                    </div>
                </div>
            </div>
            <div class="row setup-content" id="step-4">
                <div class="col-xs-12">
                    <div class="col-md-12">
                        <h3>Login/Register</h3>
                        <ul class="nav nav-tabs" style="margin-bottom: 22px">
                            <li class="active">
                                <a data-toggle="tab" href="#alreadyRegisted">Already Registed</a>
                            </li>
                            <li>
                                <a data-toggle="tab" href="#register" id="registerFormToggle">Register</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <!-- Already Registed-->
                            <div id="alreadyRegisted" class="tab-pane fade in active">
                                <div class="flight-result" style="padding: 25px; width: 80%">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label for="example-text-input" class="col-xs-3 col-form-label">Username</label>
                                                <div class="col-xs-7">
                                                    <input class="form-control" type="text" id="example-text-input">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="example-search-input" class="col-xs-3 col-form-label">Password</label>
                                                <div class="col-xs-7">
                                                    <input class="form-control" type="password" id="example-search-input">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-xs-12">
                                                    <button type="submit" class="btn btn-primary">Login</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h4>Don't have account yet </h4>
                                                    <a href="#" onclick="$('#registerFormToggle').click()">Register here</a>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h4>Forget your account</h4>
                                                    <a href="#" onclick="$('#registerFormToggle').click()">Recovery your account here</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Already Registed -->

                            <!-- Register-->
                            <div id="register" class="tab-pane fade">
                                <div class="flight-result" style="padding: 25px; width: 80%">
                                    <div class="row">
                                        <div class="col-md-6">
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
                                        </div>
                                        <div class="col-md-6">
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
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Register -->
                            <button class="btn btn-primary nextBtn btn-lg pull-right" type="button">Next</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row setup-content" id="step-5">
                <div class="col-xs-12">
                    <div class="col-md-12">
                        <h3>Confirm Personal information</h3>
                        <div class="flight-result" style="padding: 25px; width: 80%">
                            <div class="card card-block">
                                <div class="card card-block" style="padding: 20px;">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-4">
                                            <div class="thumbnail">
                                                Customer Information
                                        <div class="caption">
                                            <h3>Thai Bao Nguyen</h3>
                                            <p class="card-description">
                                                <table class="table" style="text-align: left;">
                                                    <tr>
                                                        <td>First Name</td>
                                                        <td>Thai Bao</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Last Name</td>
                                                        <td>Nguyen</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Email</td>
                                                        <td>bao@gmail.com</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Phone number</td>
                                                        <td>0123456789</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Gender</td>
                                                        <td>male</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Day of Birth</td>
                                                        <td>01/01/1992</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Credit Card</td>
                                                        <td>00233342343</td>
                                                    </tr>
                                                </table>
                                            </p>
                                        </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-md-4">
                                            <div class="thumbnail">
                                                Ticket Detail
                                        <div class="caption">
                                            <h3>Detail</h3>
                                            <p class="card-description">
                                                <table class="table" style="text-align: left;">
                                                    <tr>
                                                        <td colspan="2">Departure Flight</td>
                                                    </tr>
                                                    <tr>
                                                        <td>From</td>
                                                        <td>Ha Noi</td>
                                                    </tr>
                                                    <tr>
                                                        <td>To</td>
                                                        <td>Ho Chi Minh</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Departure date:</td>
                                                        <td>15/10/2016</td>
                                                    </tr>
                                                </table>
                                                <table class="table" style="text-align: left;">
                                                    <tr>
                                                        <td colspan="2">Return Flight</td>
                                                    </tr>
                                                    <tr>
                                                        <td>From</td>
                                                        <td>Ha Noi</td>
                                                    </tr>
                                                    <tr>
                                                        <td>To</td>
                                                        <td>Ho Chi Minh</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Return date:</td>
                                                        <td>20/10/2016</td>
                                                    </tr>
                                                </table>
                                            </p>
                                        </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-md-4">
                                            <div class="thumbnail">
                                                Customer Information
                                        <div class="caption">
                                            <h3>Passenger and Cost</h3>
                                            <p class="card-description">
                                                <table class="table" style="text-align: left;">
                                                    <tr>
                                                        <td>Adult:</td>
                                                        <td>1</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Senior:</td>
                                                        <td>1</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Infant:</td>
                                                        <td>1</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Total:</td>
                                                        <td>100000</td>
                                                    </tr>
                                                </table>
                                            </p>
                                        </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button class="btn btn-primary nextBtn btn-lg pull-right" type="button">Next</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script src="../../Scripts/AirReservation/FlightSearch.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>