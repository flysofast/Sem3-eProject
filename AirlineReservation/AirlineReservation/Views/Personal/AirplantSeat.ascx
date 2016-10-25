﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="../../Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <title></title>
    <style>
        *, *:before, *:after {
            box-sizing: border-box;
        }

        html {
            font-size: 16px;
        }

        .plane {
            margin: 20px auto;
            max-width: 300px;
        }

        .cockpit {
            height: 250px;
            position: relative;
            overflow: hidden;
            text-align: center;
            border-bottom: 5px solid #d8d8d8;
        }

            .cockpit:before {
                content: "";
                display: block;
                position: absolute;
                top: 0;
                left: 0;
                height: 500px;
                width: 100%;
                border-radius: 50%;
                border-right: 5px solid #d8d8d8;
                border-left: 5px solid #d8d8d8;
            }

        h1 {
            width: 60%;
            margin: 100px auto 35px auto;
        }

        .exit {
            position: relative;
            height: 50px;
        }

        exit:before {
            content: "EXIT";
            font-size: 14px;
            line-height: 18px;
            padding: 0px 2px;
            font-family: "Arial Narrow", Arial, sans-serif;
            display: block;
            position: absolute;
            background: green;
            color: white;
            top: 50%;
            left: 0;
            transform: translate(0, -50%);
        }

        exit:after {
            content: "EXIT";
            font-size: 14px;
            line-height: 18px;
            padding: 0px 2px;
            font-family: "Arial Narrow", Arial, sans-serif;
            display: block;
            position: absolute;
            background: green;
            color: white;
            top: 50%;
            right: 0;
            transform: translate(0, -50%);
        }

        .fuselage {
            border-right: 5px solid #d8d8d8;
            border-left: 5px solid #d8d8d8;
        }

        ol {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .row {
            margin:20px;
        }

        .seats {
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            justify-content: flex-start;
        }

        .seat {
            display: flex;
            flex: 0 0 14.28571428571429%;
            padding: 5px;
            position: relative;
            &:nth-child(3);

        {
            margin-right: 14.28571428571429%;
        }

        input[type=checkbox] {
            position: absolute;
            opacity: 0;
        }

            input[type=checkbox]:checked {
                + label;

        {
            background: #bada55;
            -webkit-animation-name: rubberBand;
            animation-name: rubberBand;
            animation-duration: 300ms;
            animation-fill-mode: both;
        }

        }

        input[type=checkbox]:disabled {
            + label;

        {
            background: #dddddd;
            text-indent: -9999px;
            overflow: hidden;
            &:after;

        {
            content: "X";
            text-indent: 0;
            position: absolute;
            top: 4px;
            left: 50%;
            transform: translate(-50%, 0%);
        }

        &:hover {
            box-shadow: none;
            cursor: not-allowed;
        }

        }
        }

        label {
            display: block;
            position: relative;
            width: 100%;
            text-align: center;
            font-size: 14px;
            font-weight: bold;
            line-height: 1.5rem;
            padding: 4px 0;
            background: #F42536;
            border-radius: 5px;
            animation-duration: 300ms;
            animation-fill-mode: both;
            &:before;

        {
            content: "";
            position: absolute;
            width: 75%;
            height: 75%;
            top: 1px;
            left: 50%;
            transform: translate(-50%, 0%);
            background: rgba(255,255,255,.4);
            border-radius: 3px;
        }

        &:hover {
            cursor: pointer;
            box-shadow: 0 0 0px 2px #5C6AFF;
        }

        }
        }

        @-webkit-keyframes rubberBand {
            0% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }

            30% {
                -webkit-transform: scale3d(1.25, 0.75, 1);
                transform: scale3d(1.25, 0.75, 1);
            }

            40% {
                -webkit-transform: scale3d(0.75, 1.25, 1);
                transform: scale3d(0.75, 1.25, 1);
            }

            50% {
                -webkit-transform: scale3d(1.15, 0.85, 1);
                transform: scale3d(1.15, 0.85, 1);
            }

            65% {
                -webkit-transform: scale3d(.95, 1.05, 1);
                transform: scale3d(.95, 1.05, 1);
            }

            75% {
                -webkit-transform: scale3d(1.05, .95, 1);
                transform: scale3d(1.05, .95, 1);
            }

            100% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }
        }

        @keyframes rubberBand {
            0% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }

            30% {
                -webkit-transform: scale3d(1.25, 0.75, 1);
                transform: scale3d(1.25, 0.75, 1);
            }

            40% {
                -webkit-transform: scale3d(0.75, 1.25, 1);
                transform: scale3d(0.75, 1.25, 1);
            }

            50% {
                -webkit-transform: scale3d(1.15, 0.85, 1);
                transform: scale3d(1.15, 0.85, 1);
            }

            65% {
                -webkit-transform: scale3d(.95, 1.05, 1);
                transform: scale3d(.95, 1.05, 1);
            }

            75% {
                -webkit-transform: scale3d(1.05, .95, 1);
                transform: scale3d(1.05, .95, 1);
            }

            100% {
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
            }
        }

        .rubberBand {
            -webkit-animation-name: rubberBand;
            animation-name: rubberBand;
        }
    </style>
</head>
<body>
    <div class="plane" style="text-align:center">
        <div class="cockpit">
            <h1>Please select a seat</h1>
        </div>
        <div class="exit exit--front fuselage">
        </div>
        <ol class="cabin fuselage">
            <li class="row row--1">
                <ol class="seats" type="A">
                    <li class="seat">
                        <input type="checkbox" id="1A" value="1A" />
                        <label for="1A">1A</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="1B" value="1B" />
                        <label for="1B">1B</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="1C" value="1C" />
                        <label for="1C">1C</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="1D" value="1D" />
                        <label for="1D">1D</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="1E" value="1E" />
                        <label for="1E">1E</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="1F" value="1F" />
                        <label for="1F">1F</label>
                    </li>
                </ol>
            </li>
            <li class="row row--2">
                <ol class="seats" type="A">
                    <li class="seat">
                        <input type="checkbox" id="2A" value="2A" />
                        <label for="2A">2A</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="2B" value="2B" />
                        <label for="2B">2B</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="2C" value="2C" />
                        <label for="2C">2C</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="2D" value="2D" />
                        <label for="2D">2D</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="2E" value="2E" />
                        <label for="2E">2E</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="2F" value="2F" />
                        <label for="2F">2F</label>
                    </li>
                </ol>
            </li>
            <li class="row row--3">
                <ol class="seats" type="A">
                    <li class="seat">
                        <input type="checkbox" id="3A" value="3A" />
                        <label for="3A">3A</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="3B" value="3B" />
                        <label for="3B">3B</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="3C" value="3C" />
                        <label for="3C">3C</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="3D" value="3D" />
                        <label for="3D">3D</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="3E" value="3E" />
                        <label for="3E">3E</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="3F" value="3F" />
                        <label for="3F">3F</label>
                    </li>
                </ol>
            </li>
            <li class="row row--4">
                <ol class="seats" type="A">
                    <li class="seat">
                        <input type="checkbox" id="4A" value="4A" />
                        <label for="4A">4A</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="4B" value="4B" />
                        <label for="4B">4B</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="4C" value="4C" />
                        <label for="4C">4C</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="4D" value="4D" />
                        <label for="4D">4D</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="4E" value="4E" />
                        <label for="4E">4E</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="4F" value="4F" />
                        <label for="4F">4F</label>
                    </li>
                </ol>
            </li>
            <li class="row row--5">
                <ol class="seats" type="A">
                    <li class="seat">
                        <input type="checkbox" id="5A" value="5A" />
                        <label for="5A">5A</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="5B" value="5B" />
                        <label for="5B">5B</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="5C" value="5C" />
                        <label for="5C">5C</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="5D" value="5D" />
                        <label for="5D">5D</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="5E" value="5E" />
                        <label for="5E">5E</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="5F" value="5F" />
                        <label for="5F">5F</label>
                    </li>
                </ol>
            </li>
            <li class="row row--6">
                <ol class="seats" type="A">
                    <li class="seat">
                        <input type="checkbox" id="6A" value="6A" />
                        <label for="6A">6A</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="6B" value="6B" />
                        <label for="6B">6B</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="6C" value="6C" />
                        <label for="6C">6C</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="6D" value="6D" />
                        <label for="6D">6D</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="6E" value="6E" />
                        <label for="6E">6E</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="6F" value="6F" />
                        <label for="6F">6F</label>
                    </li>
                </ol>
            </li>
            <li class="row row--7">
                <ol class="seats" type="A">
                    <li class="seat">
                        <input type="checkbox" id="7A" value="7A" />
                        <label for="7A">7A</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="7B" value="7B" />
                        <label for="7B">7B</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="7C" value="7C" />
                        <label for="7C">7C</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="7D" value="7D" />
                        <label for="7D">7D</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="7E" value="7E" />
                        <label for="7E">7E</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="7F" value="7F" />
                        <label for="7F">7F</label>
                    </li>
                </ol>
            </li>
            <li class="row row--8">
                <ol class="seats" type="A">
                    <li class="seat">
                        <input type="checkbox" id="8A" value="8A" />
                        <label for="8A">8A</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="8B" value="8B" />
                        <label for="8B">8B</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="8C" value="8C" />
                        <label for="8C">8C</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="8D" value="8D" />
                        <label for="8D">8D</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="8E" value="8E" />
                        <label for="8E">8E</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="8F" value="8F" />
                        <label for="8F">8F</label>
                    </li>
                </ol>
            </li>
            <li class="row row--9">
                <ol class="seats" type="A">
                    <li class="seat">
                        <input type="checkbox" id="9A" value="9A" />
                        <label for="9A">9A</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="9B" value="9B" />
                        <label for="9B">9B</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="9C" value="9C" />
                        <label for="9C">9C</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="9D" value="9D" />
                        <label for="9D">9D</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="9E" value="9E" />
                        <label for="9E">9E</label>
                    </li>
                    <li class="seat">
                        <input type="checkbox" id="9F" value="9F" />
                        <label for="9F">9F</label>
                    </li>
                </ol>
            </li>
        </ol>
        <button id="mainStep" onclick="post_value()" style="display:none">Submit</button>
        <button id="adminPage" class="btn btn-success" onclick="saveSeatValue()" style="display: none">Submit</button>
    </div>
    <script src="../../Scripts/jquery-2.0.0.min.js"></script>
    <script>
        $(document).ready(function () {
            var classType = getGetVariable('ClassType');
            if (classType != "") {
                $("#adminPage").show();
                var className = "";
                switch (classType) {
                    case "business":
                        className = "Business class";
                        break;
                    case "club":
                        className = "Club class";
                        break;
                    case "first":
                        className = "First class";
                        break;
                    case "non_smoking":
                        className = "Non-smoking class";
                        break;
                    case "smoking":
                        className = "Smoking class";
                        break;
                }
                var obj = {
                    'ClassType': className,
                };
                $.ajax({
                    url: '../Admin/GetSeatByClassType',
                    contentType: "application/json; charset=utf-8",
                    dataType: 'json',
                    type: 'POST',
                    data: JSON.stringify(obj),
                    error: function (data) {
                        console.log("Error", data.responseText, "error");
                    },
                    success: function (result) {
                        $.each(result, function (k, item) {
                            $("#" + item["SeatID"]).prop('checked', true);
                        });
                    }
                });
            }

        });

        function saveSeatValue() {
            var checkedValues = $('input:checkbox:checked').map(function () {
                return this.value;
            }).get();

            var classType = getGetVariable('ClassType');
            switch (classType) {
                case "business":
                    className = "Business class";
                    break;
                case "club":
                    className = "Club class";
                    break;
                case "first":
                    className = "First class";
                    break;
                case "non_smoking":
                    className = "Non-smoking class";
                    break;
                case "smoking":
                    className = "Smoking class";
                    break;
            }
            var obj = {
                'SeatID': checkedValues,
                'ClassType': className
            };
            $.ajax({
                url: '../Admin/UpdateSeat',
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                type: 'POST',
                data: JSON.stringify(obj),
                error: function (data) {
                    swal("Error", data.responseText, "error");
                },
                success: function (result) {
                    window.opener.initSeatOfClass();
                    window.close();
                }
            });

            //

        }

        function post_value() {
            var checkedValues = $('input:checkbox:checked').map(function () {
                return this.value;
            }).get();
            window.opener.setValueFromChildPage(getGetVariable("flightID"), checkedValues.join(","));
            window.close();
        }

        function getGetVariable(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split("&");
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split("=");
                if (pair[0] == variable) {
                    return pair[1];
                }
            }
            //alert('Query Variable ' + variable + ' not found');
        }
    </script>
    <script src="../../Bootstrap/js/bootstrap.min.js"></script>
</body>
</html>