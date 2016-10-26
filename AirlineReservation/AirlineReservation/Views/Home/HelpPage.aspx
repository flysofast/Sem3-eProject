<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>HelpPage</title>
    <link rel="stylesheet" type="text/css" href="../../Content/HelpPage/jquery.fullPage.css" />
    <link rel="stylesheet" type="text/css" href="../../Bootstrap/css/bootstrap.min.css" />

    <script src="../../Scripts/jquery-2.0.0.min.js"></script>
    <script src="../../Bootstrap/js/bootstrap.min.js"></script>

    <!-- This following line is only necessary in the case of using the plugin option `scrollOverflow:true` -->
    <script type="text/javascript" src="../../Scripts/HelpPage/scrolloverflow.min.js"></script>

    <script type="text/javascript" src="../../Scripts/HelpPage/jquery.fullPage.min.js"></script>
    <style>
        @CHARSET "ISO-8859-1";
/* Reset CSS
 * --------------------------------------- */
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,
form,fieldset,input,textarea,p,blockquote,th,td {
    padding: 0;
    margin: 0;
}
a{
	text-decoration:none;
}
table {
    border-spacing: 0;
}
fieldset,img {
    border: 0;
}
address,caption,cite,code,dfn,em,strong,th,var {
    font-weight: normal;
    font-style: normal;
}
strong{
	font-weight: bold;
}
ol,ul {
    list-style: none;
    margin:0;
    padding:0;
}
caption,th {
    text-align: left;

}
h1,h2,h3,h4,h5,h6 {
    font-weight: normal;
    font-size: 100%;
    margin:0;
    padding:0;
    color:#444;
}
q:before,q:after {
    content:'';
}
abbr,acronym { border: 0;
}


/* Custom CSS
 * --------------------------------------- */
body{
	font-family: arial,helvetica;
	color: #333;
	color: rgba(0,0,0,0.5);
}
.wrap{
	margin-left: auto;
	margin-right: auto;
	width: 960px;
	position: relative;
}
h1{
	font-size: 6em;
}
p{
	font-size: 2em;
}
.intro p{
	width: 50%;
	margin: 0 auto;
	font-size: 1.5em;
}
.section{
	text-align:center;
}
#menu li {
	display:inline-block;
	margin: 10px;
	color: #000;
	background:#fff;
	background: rgba(255,255,255, 0.5);
	-webkit-border-radius: 10px;
            border-radius: 10px;
}
#menu li.active{
	background:#666;
	background: rgba(0,0,0, 0.5);
	color: #fff;
}
#menu li a{
	text-decoration:none;
	color: #000;
}
#menu li.active a:hover{
	color: #000;
}
#menu li:hover{
	background: rgba(255,255,255, 0.8);
}
#menu li a,
#menu li.active a{
	padding: 9px 18px;
	display:block;
}
#menu li.active a{
	color: #fff;
}
#menu{
	position:fixed;
	top:0;
	left:0;
	height: 40px;
	z-index: 70;
	width: 100%;
	padding: 0;
	margin:0;
}
.twitter-share-button{
	position: fixed;
	z-index: 99;
	right: 149px;
	top: 9px;
}
#download{
	margin: 10px 0 0 0;
	padding: 15px 10px;
	color: #fff;
	text-shadow: 0 -1px 0 rgba(0,0,0,0.25);
	background-color: #49afcd;
	background-image: -moz-linear-gradient(top, #5bc0de, #2f96b4);
	background-image: -ms-linear-gradient(top, #5bc0de, #2f96b4);
	background-image: -webkit-gradient(linear,0 0,0 100%,from( #5bc0de),to( #2f96b4));
	background-image: -webkit-linear-gradient(top, #5bc0de, #2f96b4);
	background-image: -o-linear-gradient(top, #5bc0de, #2f96b4);
	background-image: linear-gradient(top, #5bc0de, #2f96b4);
	background-repeat: repeat-x;
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#5bc0de', endColorstr='#2f96b4', GradientType=0);
	border-color: #2f96b4 #2f96b4 #1f6377;
	border-color: rgba(0,0,0,.1) rgba(0,0,0,.1) rgba(0,0,0,.25);
	filter: progid:DXImageTransform.Microsoft.gradient(enabled=false);

	-webkit-border-radius: 6px;
	-moz-border-radius: 6px;
	border-radius: 6px;
	vertical-align: middle;
	cursor: pointer;
	display: inline-block;
	-webkit-box-shadow: inset 0 1px 0 rgba(255,255,255,0.2),0 1px 2px rgba(0,0,0,0.05);
	-moz-box-shadow: inset 0 1px 0 rgba(255,255,255,0.2),0 1px 2px rgba(0,0,0,0.05);
	box-shadow: inset 0 1px 0 rgba(255,255,255,0.2),0 1px 2px rgba(0,0,0,0.05);
}
#download a{
	text-decoration:none;
	color:#fff;
}
#download:hover{
	text-shadow: 0 -1px 0 rgba(0,0,0,.25);
	background-color: #2F96B4;
	background-position: 0 -15px;
	-webkit-transition: background-position .1s linear;
	-moz-transition: background-position .1s linear;
	-ms-transition: background-position .1s linear;
	-o-transition: background-position .1s linear;
	transition: background-position .1s linear;
}
#infoMenu{
	height: 20px;
	color: #f2f2f2;
	position:fixed;
	z-index:70;
	bottom:0;
	width:100%;
	text-align:right;
	font-size:0.9em;
	padding:8px 0 8px 0;
}
#infoMenu ul{
	padding: 0 40px;
}
#infoMenu li a{
	display: block;
	margin: 0 22px 0 0;
	color: #333;
}
#infoMenu li a:hover{
	text-decoration:underline;
}
#infoMenu li{
	display:inline-block;
	position:relative;
}
#examplesList{
	display:none;
	background: #282828;
	-webkit-border-radius: 6px;
	-moz-border-radius: 6px;
	border-radius: 6px;
	padding: 20px;
	float: left;
	position: absolute;
	bottom: 29px;
	right: 0;
	width:638px;
	text-align:left;
}
#examplesList ul{
	padding:0;
}
#examplesList ul li{
	display:block;
	margin: 5px 0;
}
#examplesList ul li a{
	color: #BDBDBD;
	margin:0;
}
#examplesList ul li a:hover{
	color: #f2f2f2;
}
#examplesList .column{
	float: left;
	margin: 0 20px 0 0;
}
#examplesList h3{
	color: #f2f2f2;
	font-size: 1.2em;
	margin: 0 0 15px 0;
	border-bottom: 1px solid rgba(0, 0, 0, 0.4);
	-webkit-box-shadow: 0 1px 0 rgba(255, 255, 255, 0.1);
	-moz-box-shadow: 0 1px 0 rgba(255,255,255,0.1);
	box-shadow: 0 1px 0 rgba(255, 255, 255, 0.1);
	padding: 0 0 5px 0;
}



/* Demos Menu
 * --------------------------------------- */
 #demosMenu{
	position:fixed;
	bottom: 10px;
	right:10px;
	z-index: 999;
 }


    </style>
</head>
<body>
    <script>
        $(document).ready(function () {
            $(document).ready(function () {
                $('#fullpage').fullpage({
                    sectionsColor: ['#f2f2f2', '#4BBFC3', '#7BAABE', 'whitesmoke', '#ccddff']
                });
            });
        });
    </script>
    <!-- Loading spins -->
    <div class="se-pre-con"></div>

    <div class="se-pre-con-2" style="display: none"></div>
    <!-- End -->

    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand page-scroll" href="/">
                    <img src="../Images/feather.png" alt="logo" style="display: inline-block" align="middle" />
                    <span>Airline Reservation System</span></a>
            </div>

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a class="page-scroll" href="Flight">Close</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div id="fullpage">
	<div class="section active" id="section0"><h1>fullPage.js</h1></div>
	<div class="section" id="section1">
	    <div class="slide "><h1>Simple Demo</h1></div>
	    <div class="slide active"><h1>Only text</h1></div>
	    <div class="slide"><h1>And text</h1></div>
	    <div class="slide"><h1>And more text</h1></div>
	</div>
	<div class="section" id="section2"><h1>No wraps, no extra markup</h1></div>
	<div class="section" id="section3"><h1>Just the simplest demo ever</h1></div>
</div>
</body>
</html>