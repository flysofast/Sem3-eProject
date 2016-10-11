<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Template.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/modernizr.js"></script>

    <script>
        $(window).load(function () {
            setTimeout(function () {
                $('.se-pre-con').fadeOut('slow', function () {
                });
            }, 1000); // set the time here
        });

    </script>
    <div class="container" style="width: 100%">
        <h2 style="background-color: red; font-weight: bolder;">TEST PAGE. CHECK Global.asax</h2>
        <h3>It's Fast, Easy and Secure</h3>
        <div class="stepwizard">
            <div class="stepwizard-row setup-panel">
                <div class="stepwizard-step">
                    <a href="#step-1" type="button" class="btn btn-primary btn-circle">1</a>
                    <p>Search Flight</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled style="opacity: 1">2</a>
                    <p>Select Flight</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled style="opacity: 1">3</a>
                    <p>Check Login/ Register</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-4" type="button" class="btn btn-default btn-circle" disabled style="opacity: 1">4</a>
                    <p>Information Confirm</p>
                </div>
                <div class="stepwizard-step">
                    <a href="#step-5" type="button" class="btn btn-default btn-circle" disabled style="opacity: 1">5</a>
                    <p>Payment</p>
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
                                            <option value="HNN">Ha Noi</option>
                                            <option value="HUI">Hue</option>
                                            <option value="SGN">Ho Chi Minh</option>
                                            <option value="NYK">New York</option>
                                        </select>
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
                                            <option value="NYK">New York</option>
                                            <option value="HNN">Ha Noi</option>
                                            <option value="HUI">Hue</option>
                                            <option value="SGN">Ho Chi Minh</option>

                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-2 col-md-2 columnForm">
                                <input type="button" class="btn btn-success" value="SEARCH" onclick="searchStep1()" />
                            </div>
                            <div class="col-xs-4 col-md-6">
                                <div id="step1-result" style="clear: both">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-5">Route</div>
                                            <div class="col-md-3">Type</div>
                                            <div class="col-md-3">Select</div>
                                        </div>
                                    </div>

                                    <div class="flight-result" style="margin-top: 0px;">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="col-md-5 vcenter">Hanoi (HN) -> Ho Chi Minh (HCM)</div>
                                                <div class="col-md-3 vcenter">Direct</div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="optReturnFlight">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="flight-result" style="margin-top: 0px;">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="col-md-5 vcenter">Hanoi (HN) -> Hue (Hue) -> Ho Chi Minh (HCM)</div>
                                                <div class="col-md-3 vcenter">Direct</div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="optReturnFlight">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <button class="btn btn-primary  btn-lg pull-right" type="button" onclick="GetFlights(['HNN','HUI','SGN','NYK'])">Next</button>
                </div>
            </div>
            <div class="row setup-content" id="step-2">
                <div class="col-md-4 columnForm">
                    <div class="form-group">
                        <label class="control-label col-md-3" for="To">Departure:</label>
                        <div class="col-md-9">
                            <input type="date" required="required" class="form-control" placeholder="Enter First Name" style="margin-left: 5px;" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" for="To">Type:</label>
                        <div class="col-sm-9">
                            <label class="radio-inline">
                                <input type="radio" id="optFlightOneWay" name="optFlight" checked>One-way</label>
                            <label class="radio-inline">
                                <input type="radio" id="optFlightReturn" name="optFlight">Return</label>
                        </div>
                    </div>
                    <div class="form-group" id="returnDateForm">
                        <label class="control-label col-md-3" for="To">Return:</label>
                        <div class="col-md-9">
                            <input type="date" required="required" class="form-control" placeholder="Enter First Name" style="margin-left: 5px;" />
                        </div>
                    </div>
                </div>
                <div class="col-md-4 columnForm">
                    <div class="form-group">
                        <label class="control-label col-md-3" for="To">Class:</label>
                        <div class="col-md-9">
                            <select class="form-control">
                                <option>Eco</option>
                                <option>Bussiness</option>
                                <option>VIP</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" id="lblReturnClass">
                        <label class="control-label col-sm-12" for="To" style="text-align: center">Return class</label>
                    </div>
                    <div class="form-group" id="returnClass">
                        <label class="control-label col-md-3" for="To">Class:</label>
                        <div class="col-md-9">
                            <select class="form-control">
                                <option>Eco</option>
                                <option>Bussiness</option>
                                <option>VIP</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="control-label col-sm-3" for="To">Adults:</label>
                        <div class="col-sm-9">
                            <select class="form-control" style="width: 56px">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" for="To">Children:</label>
                        <div class="col-sm-9">
                            <select class="form-control" style="width: 56px">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" for="To">Infant:</label>
                        <div class="col-sm-9">
                            <select class="form-control" style="width: 56px">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                    </div>
                </div>
                <button class="btn btn-primary nextBtn btn-lg pull-right" type="button">Next</button>
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
                                            <div class="col-md-2 vcenter">02:00 (Direct)</div>
                                            <div class="col-md-2 vcenter">1.000.000</div>
                                            <div class="col-md-2">
                                                <input type="radio" name="optDepartureFlight">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="collapse" id="collapseExample">
                                            <div class="card card-block">
                                                Chi tiet chuyen bay
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="flight-result">
                                    <div class="row" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                                        <div class="col-md-12">
                                            <div class="col-md-2 vcenter">VietName Airline</div>
                                            <div class="col-md-2 vcenter">15:00 (Hanoi)</div>
                                            <div class="col-md-2 vcenter">17:00 (HCM)</div>
                                            <div class="col-md-2 vcenter">02:00 (Direct)</div>
                                            <div class="col-md-2 vcenter">1.000.000</div>
                                            <div class="col-md-2">
                                                <input type="radio" name="optDepartureFlight">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="collapse" id="Div1">
                                            <div class="card card-block">
                                                Chi tiet chuyen bay
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Departure Flight -->

                            <!-- Return Flight-->
                            <div id="returnFlight" class="tab-pane fade">
                                <div class="flight-result">
                                    <div class="row" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
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
                                                Chi tiet chuyen bay
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="flight-result">
                                    <div class="row" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
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
                                        <div class="collapse" id="Div4">
                                            <div class="card card-block">
                                                Chi tiet chuyen bay
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
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label for="example-text-input" class="col-xs-3 col-form-label">First Name</label>
                                        <div class="col-xs-7">
                                            <input class="form-control" type="text" id="Text7">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="example-search-input" class="col-xs-3 col-form-label">Last Name</label>
                                        <div class="col-xs-7">
                                            <input class="form-control" type="text" id="Text8">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="example-search-input" class="col-xs-3 col-form-label">Email</label>
                                        <div class="col-xs-7">
                                            <input class="form-control" type="email" id="Email1">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="example-search-input" class="col-xs-3 col-form-label">Phone Number</label>
                                        <div class="col-xs-7">
                                            <input class="form-control" type="text" id="Text9">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="example-search-input" class="col-xs-3 col-form-label">Gender</label>
                                        <div class="col-xs-7">
                                            <input class="form-control" type="text" id="Text10">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="example-search-input" class="col-xs-3 col-form-label">Day Of Birth </label>
                                        <div class="col-xs-7">
                                            <input class="form-control" type="date" id="Date1">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="example-search-input" class="col-xs-3 col-form-label">Credit card </label>
                                        <div class="col-xs-7">
                                            <input class="form-control" type="text" id="Text11">
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
    <script src="../../Scripts/AirReservation/TestAjax.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
