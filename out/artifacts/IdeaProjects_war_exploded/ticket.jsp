<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%--Develop only for Chorme--%>
<%--Developed by AlbusDumbledore--%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE>
<html lang="en-US">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="./images/favicon.ico">
    <link rel="Bookmark" href="./images/favicon.ico">
    <link rel="stylesheet" href="images/map.css">
    <link rel="stylesheet" type="text/css" href="images/bar/style.css"/>
    <style type="text/css">
        body {
            color: #000;
            font: 12px Arial, Helvetica, sans-serif;
        }
    </style>
    <script>
        function jump() {
            window.location.href="index.jsp";
        }
    </script>
    <style type="text/css">
        .div-relative {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 1000px;
            height: 1000px;
            width: 500px;
            opacity: 0.8;
        }

        .div-header {
            position: absolute;
            left: 50px;
            top: 10px;
            z-index: 80;
            background-color: white;
            height: 50px;
            width: 1160px;
        }
    </style>
    <title>南昌地铁管理系统首页</title>
</head>
<body style="background-color: white;">
<!-- 整个页面的div开始 -->
<div class="div-relative" style='z-index: 0;'>
    <!-- header -->
    <div class="div-header">
        <img alt="" src="images/logo.jpg"
             style="display: block; height: 100%; position: absolute; left: 0px; top: 0px;">
        <h2 style="position: absolute; top: 5px; left: 80px">南昌地铁自助售票系统</h2>
        <button onclick="jump()" style="position: absolute;top: 10px;left: 1000px;width: 150px;height: 30px;text-align:center;font-size: 15px;">返回主页</button>
    </div>
    <!-- header结束 -->
    <%--主部分开始--%>
    <div id="content" style="position: absolute;top: 130px;left: 50px;">
        <ul id="bar">
            <li id="iphone">
                <div class="top">
                    <h3 style="width: 0px;top: 15px;left: 12px;position: absolute;">一号线</h3>
                </div>
                <div class="bottom">
                    <div class="infobox">
                        <h3 style="width: 200px;">一号线</h3>
                        <p>80,1</p>
                    </div>
                </div>
            </li>
            <li id="macbook">
                <div class="top">
                    <h3 style="width: 0px;top: 15px;left: 12px;position: absolute;">二号线</h3>
                </div>
                <div class="bottom">
                    <div class="infobox">
                        <h3 style="width: 200px;">二号线</h3>
                        <p>102,6</p>
                    </div>
                </div>
            </li>
            <li id="ipod">
                <div class="top">
                    <h3 style="width: 0px;top: 15px;left: 12px;position: absolute;">三号线</h3>
                </div>
                <div class="bottom">
                    <div class="infobox">
                        <h3 style="width: 200px;">三号线</h3>
                        <p>198,4</p>
                    </div>
                </div>
            </li>
            <li id="cinema">
                <div class="top">
                    <h3 style="width: 0px;top: 15px;left: 12px;position: absolute;">四号线</h3>
                </div>
                <div class="bottom">
                    <div class="infobox">
                        <h3 style="width: 200px;">四号线</h3>
                        <p>90,2</p>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <%--主部分结束--%>
</div>
<!-- 整个页面的div结束 -->
<!-- 底部画板开始 -->
<div id="large-header" class="large-header" style="height: 1060px;">
    <canvas id="demo-canvas" width="1263" height="1060"></canvas>
</div>
<script type="text/javascript" src="./images/point_bg/TweenLite.min.js"
        defer="defer"></script>
<script type="text/javascript" src="./images/point_bg/EasePack.min.js"
        defer="defer"></script>
<script type="text/javascript" src="./images/point_bg/templaza_demo.js"
        defer="defer"></script>
<!-- 底部画板结束 -->
</body>
</html>