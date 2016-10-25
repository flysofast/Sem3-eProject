<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Template.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        $(window).load(function () {
            setTimeout(function () {
                $('.se-pre-con').fadeOut('slow', function () {
                });
            }, 1000); // set the time here
        });
    </script>
    <div class="container" style="width: 100%; text-align: center">
        <h2 style="font-weight: bolder;">ONLINE TICKET RESERVATION SYSTEM</h2>
        <h3>Thank you for travelling with us</h3>
        <br />
        <a href="/" class="btn btn-primary">Back to homepage</a>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>