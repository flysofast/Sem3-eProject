<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Template.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/Airplant.css" rel="stylesheet" />
    <script src="../Scripts/modernizr.js"></script>
    <script src="../../Scripts/AirReservation/ChooseSeat.js"></script>
    <script src="../../Scripts/AirReservation/Step3.js"></script>

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
                    <p>Flight schedule</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-2" type="button" class="btn btn-default btn-circle" style="opacity: 1">2</a>
                    <p>Ticket information</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-3" type="button" class="btn btn-default btn-circle" style="opacity: 1">3</a>
                    <p>Select flights</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-4" type="button" class="btn btn-default btn-circle" style="opacity: 1">4</a>
                    <p>Check Login/ Register</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-5" type="button" class="btn btn-default btn-circle" style="opacity: 1">5</a>
                    <p>Summary</p>
                </div>
            </div>
        </div>
        <form role="form" method="post" class="form-horizontal">
            <div class="row setup-content" id="step-1">
                <div class="col-xs-12">
                    <div class="col-md-12">
                        <h3 style="font-weight: bold;">Flight scheduler</h3>
                        <div class="row" style="padding-top: 34px">
                            <div class="col-xs-6 col-md-4">
                                <div class="form-group">
                                    <label class="control-label col-sm-2" for="From">From:</label>
                                    <div class="col-sm-10">
                                        <select class="form-control input-xlarg" id="fromLocation">
                                        </select>
                                        <span class="suggestion-text" style="display: none">This city is not under service.<br />
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
                            <select id="DepartureClass" class="form-control class-list">
                            </select>
                        </div>
                    </div>
                    <div class="form-group" id="lblReturnClass">
                        <label class="control-label col-sm-12" for="To" style="text-align: center">Return class</label>
                    </div>
                    <div class="form-group" id="returnClass">
                        <label class="control-label col-md-3" for="To">Class:</label>
                        <div class="col-md-9">
                            <select id="ReturningClass" class="form-control class-list">
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
                            <input id="childrenNo" type="number" class="form-control" value="0" style="width: 30%" />
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
                            <input id="elderNo" type="number" class="form-control" value="0" style="width: 30%" />
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
                        <h4><span id="routeTitle"></span></h4>
                        <h4><span id="routeInfo"></span></h4>

                        <ul class="nav nav-tabs" style="margin-bottom: 22px">
                            <li class="active">
                                <a class="view-tab" data-toggle="tab" href="#departureFlight">Departure Flights</a>
                            </li>
                            <li>
                                <a class="view-tab" data-toggle="tab" href="#returnFlight">Returning Flights</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <!-- Departure Flight-->
                            <div id="departureFlight" class="tab-pane fade in active">
                                <div class="flight-result">
                                    <div class="row" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                                        <div class="col-md-12">
                                            <div class="col-md-2 vcenter">Route 1</div>
                                            <div class="col-md-2 vcenter">From Hanoi</div>
                                            <div class="col-md-2 vcenter">To Hue</div>
                                            <div class="col-md-2 vcenter">Duration</div>
                                            <div class="col-md-2 vcenter">Seats</div>
                                            <div class="col-md-1 vcenter">Price</div>
                                            <div class="col-md-1 vcenter">Select</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="collapse" id="collapseExample" style="border-top: 1px solid">
                                            <div class="col-md-12">
                                                <div class="col-md-2 vcenter">VietName Airline</div>
                                                <div class="col-md-2 vcenter">15:00 (Ha Noi)</div>
                                                <div class="col-md-2 vcenter">17:00 (Hue)</div>
                                                <div class="col-md-2 vcenter">02:00 </div>
                                                <div class="col-md-2 vcenter">
                                                    <button onclick="selectSeatWithFlightID(1)">Choose Seat</button><span id="seatChoose"></span> </div>
                                                <div class="col-md-1 vcenter">1.000.000</div>
                                                <div class="col-md-1">
                                                    <input type="radio" name="optDepartureFlight"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="flight-result">
                                    <div class="row" data-toggle="collapse" data-target="#Div1" aria-expanded="false" aria-controls="Div1">
                                        <div class="col-md-12">
                                            <div class="col-md-2 vcenter">Route 2</div>
                                            <div class="col-md-2 vcenter">From Hue</div>
                                            <div class="col-md-2 vcenter">To Ho Chi Minh</div>
                                            <div class="col-md-2 vcenter">Duration</div>
                                            <div class="col-md-2 vcenter">Seats</div>
                                            <div class="col-md-1 vcenter">Price</div>
                                            <div class="col-md-1 vcenter">Select</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="collapse" id="Div1" style="border-top: 1px solid">
                                            <div class="col-md-12">
                                                <div class="col-md-2 vcenter">VietName Airline</div>
                                                <div class="col-md-2 vcenter">17:30 (Hue)</div>
                                                <div class="col-md-2 vcenter">18:30 (Ho Chi Minh)</div>
                                                <div class="col-md-2 vcenter">01:00 </div>
                                                <div class="col-md-2 vcenter">
                                                    <button onclick="selectSeatWithFlightID(1)">Choose Seat</button><span id="Span1"></span> </div>
                                                <div class="col-md-1 vcenter">1.000.000</div>
                                                <div class="col-md-1">
                                                    <input type="radio" name="optDepartureFlight"/>
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
                                    <div class="row" data-toggle="collapse" data-target="#Div2" aria-expanded="false" aria-controls="Div2">
                                        <div class="col-md-12">
                                            <div class="col-md-2 vcenter">Route 1</div>
                                            <div class="col-md-2 vcenter">From Hanoi</div>
                                            <div class="col-md-2 vcenter">To Hue</div>
                                            <div class="col-md-2 vcenter">Duration</div>
                                            <div class="col-md-2 vcenter">Seats</div>
                                            <div class="col-md-1 vcenter">Price</div>
                                            <div class="col-md-1 vcenter">Select</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="collapse" id="Div2" style="border-top: 1px solid">
                                            <div class="col-md-12">
                                                <div class="col-md-2 vcenter">VietName Airline</div>
                                                <div class="col-md-2 vcenter">15:00 (Ha Noi)</div>
                                                <div class="col-md-2 vcenter">17:00 (Hue)</div>
                                                <div class="col-md-2 vcenter">02:00 </div>
                                                <div class="col-md-2 vcenter">
                                                    <button onclick="selectSeatWithFlightID(1)">Choose Seat</button><span id="Span2"></span> </div>
                                                <div class="col-md-1 vcenter">1.000.000</div>
                                                <div class="col-md-1">
                                                    <input type="radio" name="optDepartureFlight"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <!-- End Return Flight -->
                        </div>
                        <button class="btn btn-primary nextBtn btn-lg pull-right" type="button" onclick="SubmitStep3()">Next</button>
                    </div>
                </div>
            </div>
            <div class="row setup-content" id="step-4">
                <div class="col-xs-12">
                    <div class="col-md-12">
                        <h3>Login/Register</h3>
                        <ul class="nav nav-tabs" style="margin-bottom: 22px">
                            <li class="active">
                                <a class="view-tab" data-toggle="tab" href="#alreadyRegisted" id="loginFormToggle">Already Registed</a>
                            </li>
                            <li>
                                <a class="view-tab" data-toggle="tab" href="#register" id="registerFormToggle">Register</a>
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
                                                    <input class="form-control" type="text" id="step4-login-username"/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="example-search-input" class="col-xs-3 col-form-label">Password</label>
                                                <div class="col-xs-7">
                                                    <input class="form-control" type="password" id="step4-login-password"/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-xs-12">
                                                    <a href="#" class="btn btn-primary" onclick="loginValidation('step4')">Login</a>
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
                                                    <input class="form-control" type="text" id="step4-register-username" />
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="example-search-input" class="col-xs-3 col-form-label">Password</label>
                                                <div class="col-xs-7">
                                                    <input class="form-control" type="password" id="step4-register-password" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label for="example-text-input" class="col-xs-3 col-form-label">First Name</label>
                                                <div class="col-xs-7">
                                                    <input class="form-control" type="text" id="step4-register-firstname" />
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="example-search-input" class="col-xs-3 col-form-label">Last Name</label>
                                                <div class="col-xs-7">
                                                    <input class="form-control" type="text" id="step4-register-lastname" />
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="example-search-input" class="col-xs-3 col-form-label">Email</label>
                                                <div class="col-xs-7">
                                                    <input class="form-control" type="email" id="step4-register-email" />
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="example-search-input" class="col-xs-3 col-form-label">Phone Number</label>
                                                <div class="col-xs-7">
                                                    <input class="form-control" type="text" id="step4-register-phonenumber" />
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="example-search-input" class="col-xs-3 col-form-label">Gender</label>
                                                <div class="col-xs-7">
                                                    <select id="step4-register-gender" class="form-control">
                                                        <option value="true">Male</option>
                                                        <option value="false">Female</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="example-search-input" class="col-xs-3 col-form-label">Day Of Birth </label>
                                                <div class="col-xs-7">
                                                    <input class="form-control" type="date" id="step4-register-dob" />
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="example-search-input" class="col-xs-3 col-form-label">Credit card </label>
                                                <div class="col-xs-7">
                                                    <input class="form-control" type="text" id="step4-register-creditcard" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <a href="#" class="btn btn-primary btn-lg" onclick="createUserInfo()">Create new</a>
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
                                                Ticket Details
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
                                                Passengers Information
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
