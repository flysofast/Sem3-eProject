<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Template.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="width:100%">
        <div class="stepwizard">
            <div class="stepwizard-row setup-panel">
              <div class="stepwizard-step">
                <a href="#step-1" type="button" class="btn btn-primary btn-circle">1</a>
                <p>Search Flight</p>
              </div>
              <div class="stepwizard-step">
                <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled>2</a>
                <p>Select Flight</p>
              </div>
              <div class="stepwizard-step">
                <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled>3</a>
                <p>Information Confirm</p>
              </div>
              <div class="stepwizard-step">
                <a href="#step-4" type="button" class="btn btn-default btn-circle" disabled>4</a>
                <p>Payment</p>
              </div>
            </div>
          </div>
        <form role="form" action="" method="post" class="form-horizontal">
            <div class="row setup-content" id="step-1">
              <div class="col-xs-12">
                <div class="col-md-12">
                  <h3>Search flight</h3>
                  <div class="form-group">
                    <label class="control-label col-sm-2" for="email">Email:</label>
                    <div class="col-sm-10">
                      <input type="email" class="form-control" id="email" placeholder="Enter email">
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label">Last Name</label>
                    <input maxlength="100" type="text" required="required" class="form-control" placeholder="Enter Last Name" />
                  </div>
                  <div class="form-group">
                    <label class="control-label">Address</label>
                    <textarea required="required" class="form-control" placeholder="Enter your address" ></textarea>
                  </div>
                  <button class="btn btn-primary nextBtn btn-lg pull-right" type="button" >Next</button>
                </div>
              </div>
            </div>
            <div class="row setup-content" id="step-2">
              <div class="col-xs-12">
                <div class="col-md-12">
                  <h3> Step 2</h3>
                  <div class="form-group">
                    <label class="control-label">Company Name</label>
                    <input maxlength="200" type="text" required="required" class="form-control" placeholder="Enter Company Name" />
                  </div>
                  <div class="form-group">
                    <label class="control-label">Company Address</label>
                    <input maxlength="200" type="text" required="required" class="form-control" placeholder="Enter Company Address"  />
                  </div>
                  <button class="btn btn-primary nextBtn btn-lg pull-right" type="button" >Next</button>
                </div>
              </div>
            </div>
            <div class="row setup-content" id="step-3">
              <div class="col-xs-12">
                <div class="col-md-12">
                  <h3> Step 3</h3>
                  <button class="btn btn-success btn-lg pull-right" type="submit">Submit</button>
                </div>
              </div>
            </div>
            <div class="row setup-content" id="step-4">
              <div class="col-xs-12">
                <div class="col-md-12">
                  <h3> Step 4</h3>
                  <button class="btn btn-success btn-lg pull-right" type="submit">Submit</button>
                </div>
              </div>
            </div>
          </form>
     </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
