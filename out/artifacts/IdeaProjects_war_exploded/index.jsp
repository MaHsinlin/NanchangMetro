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
    <style type="text/css">
        #alertMsg {
            display: none;
            width: 400px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 1px 1px 10px black;
            padding: 10px;
            font-size: 12px;
            position: absolute;
            text-align: center;
            background: #fff;
            z-index: 100000;
        }

        #alertMsg_info {
            padding: 2px 15px;
            line-height: 1.6em;
            text-align: left;
        }

        #alertMsg_btn1, #alertMsg_btn2 {
            display: inline-block;
            background: no-repeat left top;
            padding-left: 3px;
            color: #000000;
            font-size: 12px;
            text-decoration: none;
            margin-right: 10px;
            cursor: pointer;
        }

        #alertMsg_btn1 cite, #alertMsg_btn2 cite {
            line-height: 24px;
            display: inline-block;
            padding: 0 13px 0 10px;
            background: no-repeat right top;
            font-style: normal;
        }
    </style>
    <script>
        function alertMsg(msg, mode) { //mode为空，即只有一个确认按钮，mode为1时有确认和取消两个按钮
            msg = msg || '';
            mode = mode || 0;
            var top = document.body.scrollTop || document.documentElement.scrollTop;
            var isIe = (document.all) ? true : false;
            var isIE6 = isIe && !window.XMLHttpRequest;
            var sTop = document.documentElement.scrollTop || document.body.scrollTop;
            var sLeft = document.documentElement.scrollLeft || document.body.scrollLeft;
            var winSize = function () {
                var xScroll, yScroll, windowWidth, windowHeight, pageWidth, pageHeight;
                // innerHeight获取的是可视窗口的高度，IE不支持此属性
                if (window.innerHeight && window.scrollMaxY) {
                    xScroll = document.body.scrollWidth;
                    yScroll = window.innerHeight + window.scrollMaxY;
                } else if (document.body.scrollHeight > document.body.offsetHeight) { // all but Explorer Mac
                    xScroll = document.body.scrollWidth;
                    yScroll = document.body.scrollHeight;
                } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
                    xScroll = document.body.offsetWidth;
                    yScroll = document.body.offsetHeight;
                }
                if (self.innerHeight) {    // all except Explorer
                    windowWidth = self.innerWidth;
                    windowHeight = self.innerHeight;
                } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
                    windowWidth = document.documentElement.clientWidth;
                    windowHeight = document.documentElement.clientHeight;
                } else if (document.body) { // other Explorers
                    windowWidth = document.body.clientWidth;
                    windowHeight = document.body.clientHeight;
                }
                // for small pages with total height less then height of the viewport
                if (yScroll < windowHeight) {
                    pageHeight = windowHeight;
                } else {
                    pageHeight = yScroll;
                }
                // for small pages with total width less then width of the viewport
                if (xScroll < windowWidth) {
                    pageWidth = windowWidth;
                } else {
                    pageWidth = xScroll;
                }
                return {
                    'pageWidth': pageWidth,
                    'pageHeight': pageHeight,
                    'windowWidth': windowWidth,
                    'windowHeight': windowHeight
                }
            }();
            //遮罩层
            var styleStr = 'top:0;left:0;position:absolute;z-index:10000;background:#666;width:' + winSize.pageWidth + 'px;height:' + (winSize.pageHeight + 30) + 'px;';
            styleStr += (isIe) ? "filter:alpha(opacity=80);" : "opacity:0.8;"; //遮罩层DIV
            var shadowDiv = document.createElement('div'); //添加阴影DIV
            shadowDiv.style.cssText = styleStr; //添加样式
            shadowDiv.id = "shadowDiv";
            //如果是IE6则创建IFRAME遮罩SELECT
            if (isIE6) {
                var maskIframe = document.createElement('iframe');
                maskIframe.style.cssText = 'width:' + winSize.pageWidth + 'px;height:' + (winSize.pageHeight + 30) + 'px;position:absolute;visibility:inherit;z-index:-1;filter:alpha(opacity=0);';
                maskIframe.frameborder = 0;
                maskIframe.src = "about:blank";
                shadowDiv.appendChild(maskIframe);
            }
            document.body.insertBefore(shadowDiv, document.body.firstChild); //遮罩层加入文档
            //弹出框
            var styleStr1 = 'display:block;position:fixed;_position:absolute;left:' + (winSize.windowWidth / 2 - 200) + 'px;top:' + (winSize.windowHeight / 2 - 150) + 'px;_top:' + (winSize.windowHeight / 2 + top - 150) + 'px;'; //弹出框的位置
            var alertBox = document.createElement('div');
            alertBox.id = 'alertMsg';
            alertBox.style.cssText = styleStr1;
            alertBox.style.height = '130px';
            //创建弹出框里面的内容P标签
            var alertMsg_info = document.createElement('P');
            alertMsg_info.id = 'alertMsg_info';
            alertMsg_info.innerHTML = msg;
            alertMsg_info.style.position = 'absolute';
            alertMsg_info.style.top = '20px';
            alertMsg_info.style.width = '300px';
            alertMsg_info.style.left = '50px';
            alertMsg_info.style.textAlign = 'center';
            alertBox.appendChild(alertMsg_info);
//            创建按钮
            var btn1 = document.createElement('a');
            btn1.id = 'alertMsg_btn1';
            btn1.href = 'javas' + 'cript:void(0)';
            btn1.innerHTML = '<cite>确定</cite>';
            btn1.style.position = 'absolute';
            btn1.style.bottom = '10px';
            btn1.style.width = '80px';
            btn1.style.height = '25px';
            btn1.style.left = '160px';
            btn1.style.textAlign = 'center';
            btn1.style.border = '1px solid #000';
            btn1.onclick = function () {
                document.body.removeChild(alertBox);
                document.body.removeChild(shadowDiv);
                if (document.getElementById("jumpflag").value == "1") {
                    window.location.href = "http://localhost:8080";
                }
                return true;
            };
            alertBox.appendChild(btn1);
            if (document.getElementById("jumpflag").value == "1") {
                alertBox.style.height = '270px';
                alertMsg_info.style.position = 'absolute';
                alertMsg_info.style.bottom = '30px';
                alertMsg_info.style.width = '300px';
                alertMsg_info.style.left = '50px';
                alertMsg_info.style.textAlign = 'center';
                //添加div
                var alert_div = document.createElement('div');
                alert_div.id = 'alert_div';
                alert_div.style.backgroundColor = '#ffb3ac';
                alert_div.style.border = '2px solid #ff565e';
                alert_div.style.borderRadius = '5px';
                alert_div.style.width = '300px';
                alert_div.style.height = '170px';
                alert_div.style.position = 'absolute';
                alert_div.style.top = '20px';
                alert_div.style.left = '50px';
                alertBox.appendChild(alert_div);
                //添加具体车票信息
                var sinfo = document.getElementById("startinput").value;
                var einfo = document.getElementById("endinput").value;
                var alert_start = document.createElement('P');
                alert_start.id = 'alert_start';
                alert_start.style.position = 'absolute';
                alert_start.style.width = '120px';
                alert_start.style.left = '50px';
                alert_start.style.top = '15px';
                alert_start.style.fontSize = '20px';
                alert_start.innerHTML = '起点站';
                alert_start.style.textAlign = 'center';
                alertBox.appendChild(alert_start);
                var alert_sinfo = document.createElement('P');
                alert_sinfo.id = 'alert_sinfo';
                alert_sinfo.style.position = 'absolute';
                alert_sinfo.style.width = '120px';
                alert_sinfo.style.left = '50px';
                alert_sinfo.style.top = '55px';
                alert_sinfo.style.fontSize = '15px';
                alert_sinfo.innerHTML = sinfo;
                alert_sinfo.style.textAlign = 'center';
                alertBox.appendChild(alert_sinfo);
                var alert_end = document.createElement('P');
                alert_end.id = 'alert_end';
                alert_end.style.position = 'absolute';
                alert_end.style.width = '120px';
                alert_end.style.right = '50px';
                alert_end.style.top = '15px';
                alert_end.style.fontSize = '20px';
                alert_end.innerHTML = '终点站';
                alert_end.style.textAlign = 'center';
                alertBox.appendChild(alert_end);
                var alert_einfo = document.createElement('P');
                alert_einfo.id = 'alert_einfo';
                alert_einfo.style.position = 'absolute';
                alert_einfo.style.width = '120px';
                alert_einfo.style.right = '50px';
                alert_einfo.style.top = '55px';
                alert_einfo.style.fontSize = '15px';
                alert_einfo.innerHTML = einfo;
                alert_einfo.style.textAlign = 'center';
                alertBox.appendChild(alert_einfo);
                var alert_arrow = document.createElement('img');
                alert_arrow.style.position = 'absolute';
                alert_arrow.style.width = '60px';
                alert_arrow.style.height = '25px';
                alert_arrow.style.right = '170px';
                alert_arrow.style.top = '40px';
                alert_arrow.src = 'images/arrow.png';
                alertBox.appendChild(alert_arrow);
                var pinfo = document.getElementById("mmp").value;
                var tinfo = document.getElementById("ticketnum").value;
                var payinfo = document.getElementById("thisaddmoney").value;
                var alert_price = document.createElement('P');
                var wantinfo = parseInt(payinfo) - parseInt(pinfo);
                alert_price.id = 'alert_price';
                alert_price.style.position = 'absolute';
                alert_price.style.width = '300px';
                alert_price.style.left = '50px';
                alert_price.style.top = '120px';
                alert_price.style.fontSize = '15px';
                alert_price.innerHTML = '购买' + tinfo + '张，票价共计' + pinfo + '元，找零' + wantinfo + '元';
                alert_price.style.textAlign = 'center';
                alertBox.appendChild(alert_price);
            }
            if (mode === 1) {
                var btn2 = document.createElement('a');
                btn2.id = 'alertMsg_btn2';
                btn2.href = 'javas' + 'cript:void(0)';
                btn2.innerHTML = '<cite>取消</cite>';
                btn2.onclick = function () {
                    document.body.removeChild(alertBox);
                    document.body.removeChild(shadowDiv);
                    return false;
                };
                alertBox.appendChild(btn2);
            }
            document.body.appendChild(alertBox);

        }
    </script>
    <script type="text/javascript">
        function appear(id) {
            document.getElementById(id + "disappear").hidden = "";
        }
        function disappear(id) {
            document.getElementById(id + "disappear").hidden = "hidden";
        }
        function divblur(id) {
            document.getElementById(id + "disappear").hidden = "hidden";
        }
    </script>
    <script>
        function start(btn) {
            document.getElementById("startinput").value = btn.value;
            document.getElementById("startsign").value = btn.value;
            myForm.submit();
        }
        function end(btn) {
            document.getElementById("endinput").value = btn.value;
            document.getElementById("endsign").value = btn.value;
            myForm.submit();
        }
        function share() {
            if (!document.getElementById("getstartsign").value == "") {
                document.getElementById("startsign").value = document.getElementById("getstartsign").value;
            }
            if (!document.getElementById("getendsign").value == "") {
                document.getElementById("endsign").value = document.getElementById("getendsign").value;
            }
        }
        function check() {
            var start = document.getElementById("startinput").value;
            var end = document.getElementById("endinput").value;
            if ((start == end) && (start != "请选择")) {
                alertMsg('请选择两个不同的站点。', null);
                return false;
            }
            if (start == "请选择") {
                alertMsg('请选择起点站。', null);
                return false;
            }
            if (end == "请选择") {
                alertMsg('请选择终点站。', null);
                return false;
            }
            return true;
        }
        function switchmove() {
            document.getElementById("flag").value = parseInt(document.getElementById("flag").value) + parseInt("1");
            var flag = parseInt(document.getElementById("flag").value);
            if (flag % 2 == 0) {
                document.getElementById("threepay").hidden = "hidden";
                document.getElementById("cash").hidden = "";
            } else {
                document.getElementById("cash").hidden = "hidden";
                document.getElementById("threepay").hidden = "";
            }
        }
        function btncheck() {
            document.getElementById("btn1").style.backgroundColor = "#437b7d";
            document.getElementById("btn2").style.backgroundColor = "#437b7d";
            document.getElementById("btn3").style.backgroundColor = "#437b7d";
            document.getElementById("btn4").style.backgroundColor = "#437b7d";
            document.getElementById("btn5").style.backgroundColor = "#437b7d";
            document.getElementById("btn6").style.backgroundColor = "#437b7d";
            document.getElementById("btn7").style.backgroundColor = "#437b7d";
            document.getElementById("btn8").style.backgroundColor = "#437b7d";
            document.getElementById("btn9").style.backgroundColor = "#437b7d";
        }
        function btnchange(btn) {
            btncheck();
            document.getElementById("ticketnum").value = btn.value;
            var ticketnum = document.getElementById("ticketnum").value;
            document.getElementById("btn" + ticketnum).style.backgroundColor = "7ce7ea";
            if ((document.getElementById("startinput").value != "请选择") && (document.getElementById("endinput").value != "请选择")) {
                myForm.submit();
            }
        }
        function moneyin() {
            if (parseInt(document.getElementById("thismoney").value) > 100) {
                document.getElementById("thismoney").value = "";
                alertMsg('您放入的面额过大，已退回。', null);
                return;
            }
            if(parseInt(document.getElementById("thismoney").value)<0){
                document.getElementById("thismoney").value="";
                return;
            }
            if ((document.getElementById("thismoney").value == "") || (document.getElementById("thismoney").value == "0")) {
                document.getElementById("thismoney").value = "";
                return;
            }
            document.getElementById("money").value = document.getElementById("thismoney").value;
            document.getElementById("addmoney").value = document.getElementById("thisaddmoney").value;
            myForm.submit();
        }
        function ticket() {
            var need = document.getElementById("mmp").value;
            var pay = document.getElementById("thisaddmoney").value;
            if ((document.getElementsByName("startinput").value == "请选择") || (document.getElementsByName("endinput").value == "请选择")) {
                alertMsg('请选择起点站和终点站。', null);
            } else if (need == "0") {
                alertMsg('请选择起点站和终点站。', null);
            } else if (parseInt(need) <= parseInt(pay)) {
                document.getElementById("jumpflag").value = "1";
                alertMsg('出票成功，请拿走您的找零和车票。', null);
            } else {
                alertMsg('您尚未完成支付。', null);
            }
        }
        function jump() {
            window.location.href = "ticket.jsp";
        }
        window.onload = function () {
            share();
            document.getElementById(document.getElementById("getstartsign").value + "ss").style.display = "block";
            document.getElementById(document.getElementById("getendsign").value + "es").style.display = "block";
        }
        function checkinput(){
            if(!/^[-]?[0-9]*\.?[0-9]+(eE?[0-9]+)?$/.test(document.getElementById('thismoney').value)){
                document.getElementById("thismoney").value="";
                return;
            }
        }
    </script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="./images/favicon.ico">
    <link rel="Bookmark" href="./images/favicon.ico">
    <link rel="stylesheet" href="images/map.css">
    <style>
        *, *:before,
        *:after {
            box-sizing: border-box;
        }

        .toggle {
            position: relative;
            display: block;
            margin: 0 auto;
            width: 240px;
            height: 60px;
            color: white;
            outline: 0;
            text-decoration: none;
            border-radius: 100px;
            border: 2px solid #546E7A;
            background-color: #263238;
            transition: all 500ms;
        }

        .toggle:active {
            background-color: #1c2429;
        }

        .toggle:hover:not(.toggle--moving):after {
            background-color: #455A64;
        }

        .toggle:after {
            display: block;
            position: absolute;
            top: 4px;
            bottom: 4px;
            left: 4px;
            width: calc(50% - 4px);
            line-height: 45px;
            text-align: center;
            text-transform: uppercase;
            font-size: 20px;
            color: white;
            background-color: #37474F;
            border: 2px solid;
            transition: all 500ms;
        }

        .toggle--on:after {
            content: '现金支付';
            border-radius: 50px 5px 5px 50px;
            color: #66BB6A;
        }

        .toggle--off:after {
            content: '三方支付';
            border-radius: 5px 50px 50px 5px;
            transform: translate(100%, 0);
            color: #f44336;
        }

        .toggle--moving {
            background-color: #1c2429;
        }

        .toggle--moving:after {
            color: transparent;
            border-color: #435862;
            background-color: #222c31;
            transition: color 0s, transform 500ms, border-radius 500ms, background-color 500ms;
        }
    </style>
    <style type="text/css">
        body {
            color: #000;
            font: 12px Arial, Helvetica, sans-serif;
        }
    </style>
    <style type="text/css">
        .div-relative {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 900px;
            height: 820px;
            opacity: 0.8;
            /*background-color: black;*/
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

        .div-right {
            position: absolute;
            left: 970px;
            top: 80px;
            z-index: 3;
            background-color: white;
            width: 240px;
            height: 821px
        }

        .div-map {
            position: absolute;
            left: 50px;
            top: 80px;
            z-index: 80;
            width: 900px;
            height: 820px;
        }

        .div-station {
            position: absolute;
            z-index: 4;
            height: 12px;
            width: 12px;
            border: 0px solid #000;
            border-radius: 7.5px;
            color: #000;
            text-decoration: none;
        }

        .div-alphabox {
            position: absolute;
            z-index: 8;
            top: -13px;
            left: 0px;
            min-height: 20px;
            opacity: 1;
            background: #eee;
            width: 230px;
            height: 50px;
        }

        .div-empty {
            height: 170px;
            width: 100px;
        }

        .button-startbtn {
            position: absolute;
            z-index: 6;
            top: 25px;
            left: 10px;
            width: 100px;
            height: 20px;
        }

        .button-endbtn {
            position: absolute;
            z-index: 6;
            top: 25px;
            left: 120px;
            width: 100px;
            height: 20px;
        }

        .img-scenary {
            position: absolute;
            z-index: 9;
            top: 50px;
            left: 10px;
            width: 210px;
            opacity: 1;
        }

        .img-sign {
            position: absolute;
            z-index: 40;
            top: -24px;
            left: -3px;
            width: 20px;
            display: none;
        }

        .h3-title {
            z-index: 11;
            text-align: center;
            margin: 0 auto;
            top: 10px;
        }

        .p-content {
            z-index: 11;
            top: 40px;
            width: 210px;
            text-align: center;
            margin: 0 auto;
        }
    </style>
    <%--zoom--%>
    <style>
        .zoom {
            display: inline-block;
        }

        .zoom:after {
            content: '';
            display: block;
            width: 33px;
            height: 33px;
            position: absolute;
            top: 0;
            right: 0;;
        }
    </style>
    <script src='images/zoom/jquery-3.2.1.js'></script>
    <script src='images/zoom/zoombie.js'></script>
    <script>
        $(document).ready(function () {
            $('#mxl').zoombieidk({on:'click'});
        });
    </script>
    <title>南昌地铁管理系统首页</title>
</head>
<body style="background-color: white;">
<!-- 整个页面的div开始 -->
<div class="div-relative" onclick="verygood()">
    <!-- header -->
    <div class="div-header">
        <img alt="" src="images/logo.jpg"
             style="display: block; height: 100%; position: absolute; left: 0px; top: 0px;">
        <h2 style="position: absolute; top: -6px; left: 80px">南昌地铁自助售票系统</h2>
        <button onclick="jump()"
                style="position: absolute;top: 10px;left: 1000px;width: 150px;height: 30px;text-align:center;font-size: 15px;">
            后台统计
        </button>
    </div>
    <!-- header结束 -->
    <!-- 地图开始 -->
    <div class="div-map">
        <!-- 地图背景开始 -->
        <span id='mxl' class='zoom'>
            <img src="images/line_img.jpg" id='img2'
                 style="width: 900px;height: 820px;">
        </span>
        <!-- 地图背景结束 -->
        <!-- 站点开始 -->
        <!-- 1号线开始 -->
        <!-- 双港站 -->
        <div id="shuanggang" class="div-station" onclick="appear(this.id)" tabindex="0"
        <%--onmouseout="disappear(this.id)--%>
             style="top: 50px; left: 25px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="shuanggangzhanss">
            <img src="images/end.png" class="img-sign" id="shuanggangzhanes">
            <div hidden class="div-alphabox" id="shuanggangdisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">双港站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="双港站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="双港站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 孔目湖 -->
        <div id="kongmuhu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 88px; left: 25px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="kongmuhuss">
            <img src="images/end.png" class="img-sign" id="kongmuhues">
            <div hidden class="div-alphabox" id="kongmuhudisappear" style="height: 278px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">孔目湖</h3>
                    <button class="button-startbtn" onclick="start(this)" value="孔目湖">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="孔目湖">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/kongmuhu.jpg">
                    <div class="div-empty" style="height: 175px;"></div>
                    <p class="p-content">
                        孔目湖，华东交通大学的一座校内湖，水面面积四百亩，原生态，风光秀美，每年有数千只白鹭迁徙来此过冬，上百种鸟活跃在公园，一到春天更是鸟语花香，吸引了不少市民前来踏足游玩。</p>
                </div>
            </div>
        </div>
        <!-- 长江路 -->
        <div id="changjianglu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 125px; left: 25px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="changjiangluss">
            <img src="images/end.png" class="img-sign" id="changjianglues">
            <div hidden class="div-alphabox" id="changjiangludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">长江路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="长江路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="长江路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 珠江路 -->
        <div id="zhujianglu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 25px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="zhujiangluss">
            <img src="images/end.png" class="img-sign" id="zhujianglues">
            <div hidden class="div-alphabox" id="zhujiangludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">珠江路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="珠江路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="珠江路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 庐山南大道 -->
        <div id="lushannandadao" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 62px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="lushannandadaoss">
            <img src="images/end.png" class="img-sign" id="lushannandadaoes">
            <div hidden class="div-alphabox" id="lushannandadaodisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">庐山南大道</h3>
                    <button class="button-startbtn" onclick="start(this)" value="庐山南大道">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="庐山南大道">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 绿茵路 -->
        <div id="lvyinlu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 99px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="lvyinluss">
            <img src="images/end.png" class="img-sign" id="lvyinlues">
            <div hidden class="div-alphabox" id="lvyinludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">绿茵路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="绿茵路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="绿茵路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 卫东站 -->
        <div id="weidongzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 136px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="weidongzhanss">
            <img src="images/end.png" class="img-sign" id="weidongzhanes">
            <div hidden class="div-alphabox" id="weidongzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">卫东站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="卫东站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="卫东站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 地铁大厦 -->
        <div id="ditiedasha" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="ditiedashass">
            <img src="images/end.png" class="img-sign" id="ditiedashaes">
            <div hidden class="div-alphabox" id="ditiedashadisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">地铁大厦</h3>
                    <button class="button-startbtn" onclick="start(this)" value="地铁大厦">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="地铁大厦">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 秋水广场 -->
        <div id="qiushuiguangchang" class="div-station" onclick="appear(this.id)" tabindex="0"
              
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 210px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="qiushuiguangchangss">
            <img src="images/end.png" class="img-sign" id="qiushuiguangchanges">
            <div hidden class="div-alphabox" id="qiushuiguangchangdisappear" style="height: 380px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">秋水广场</h3>
                    <button class="button-startbtn" onclick="start(this)" value="秋水广场">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="秋水广场">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/qiushuiguangchang.jpg">
                    <div class="div-empty" style="height: 160px;"></div>
                    <p class="p-content">秋水广场
                        ，位于江西省南昌市红谷滩新区的赣江之滨，紧邻行政中心广场，于2004年1月28日落成，是利用荒滩兴建，既防洪，又观景，与滕王阁隔江相望，再现了千古名篇《滕王阁序》中的“落霞与孤鹜齐飞，秋水共长天一色”的意境——秋水广场正是由此而得名。红谷滩秋水广场上音乐灯光喷泉引人注目，是亚洲最大的音乐喷泉群，喷水池面积1.2万平方米，主喷高度达128米，是南昌市一靓丽景观。人们可一边欣赏音乐一边观看滕王阁美景。</p>
                </div>
            </div>
        </div>
        <!-- 滕王阁 -->
        <div id="tengwangge" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 247px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="tengwanggess">
            <img src="images/end.png" class="img-sign" id="tengwanggees">
            <div hidden class="div-alphabox" id="tengwanggedisappear" style="height: 235px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">滕王阁</h3>
                    <button class="button-startbtn" onclick="start(this)" value="滕王阁">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="滕王阁">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/tengwangge.jpg">
                    <div class="div-empty" style="height: 115px;"></div>
                    <p class="p-content">滕王阁，江南三大名楼之首
                        ，位于江西省南昌市西北部沿江路赣江东岸，始建于唐朝永徽四年，因唐太宗李世民之弟——李元婴始建而得名，因初唐诗人王勃诗句“落霞与孤鹜齐飞，秋水共长天一色”而流芳后世。</p>
                </div>
            </div>
        </div>
        <!-- 万寿宫 -->
        <div id="wanshougong" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 283.7px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="wanshougongss">
            <img src="images/end.png" class="img-sign" id="wanshougonges">
            <div hidden class="div-alphabox" id="wanshougongdisappear" style="height: 282px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">万寿宫</h3>
                    <button class="button-startbtn" onclick="start(this)" value="万寿宫">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="万寿宫">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/wanshougong.jpg">
                    <div class="div-empty" style="height: 195px;"></div>
                    <p class="p-content">万寿宫，为纪念江西的地方保护神——俗称“福主”的许真君而建。许真君，原名许逊，字敬元。东汉末，其父许萧从中原避乱来南昌。</p>
                </div>
            </div>
        </div>
        <!-- 八一馆 -->
        <div id="bayiguan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 321px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="bayiguanss">
            <img src="images/end.png" class="img-sign" id="bayiguanes">
            <div hidden class="div-alphabox" id="bayiguandisappear" style="height: 315px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">八一馆</h3>
                    <button class="button-startbtn" onclick="start(this)" value="八一馆">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="八一馆">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/bayiguan.jpg">
                    <div class="div-empty" style="height: 175px;"></div>
                    <p class="p-content">
                        南昌八一起义纪念馆成立于1956年，1959年10月1日正式对外开放，1961年被国务院公布为全国首批重点文物保护单位（所辖五处革命旧址-总指挥部旧址、贺龙指挥部旧址、叶挺指挥部旧址、朱德军官教育团旧址和朱德旧居）。</p>
                </div>
            </div>
        </div>
        <!-- 八一广场 -->
        <div id="bayiguangchang" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 358px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="bayiguangchangss">
            <img src="images/end.png" class="img-sign" id="bayiguangchanges">
            <div hidden class="div-alphabox" id="bayiguangchangdisappear" style="height: 270px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">八一广场</h3>
                    <button class="button-startbtn" onclick="start(this)" value="八一广场">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="八一广场">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/bayiguangchang.jpg">
                    <div class="div-empty" style="height: 175px;"></div>
                    <p class="p-content">八一广场位于江西省南昌市东湖区，为南昌市的心脏地带，江西省最大的城市中心广场，伫立着由叶剑英元帅题写的“八一南昌起义纪念塔”。</p>
                </div>
            </div>
        </div>
        <!-- 丁公路北 -->
        <div id="dinggonglubei" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="dinggonglubeiss">
            <img src="images/end.png" class="img-sign" id="dinggonglubeies">
            <div hidden class="div-alphabox" id="dinggonglubeidisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">丁公路北</h3>
                    <button class="button-startbtn" onclick="start(this)" value="丁公路北">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="丁公路北">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 师大南路 -->
        <div id="shidananlu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 432.5px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="shidananluss">
            <img src="images/end.png" class="img-sign" id="shidananlues">
            <div hidden class="div-alphabox" id="shidananludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">师大南路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="师大南路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="师大南路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 彭家桥 -->
        <div id="pengjiaqiao" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 469.3px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="pengjiaqiaoss">
            <img src="images/end.png" class="img-sign" id="pengjiaqiaoes">
            <div hidden class="div-alphabox" id="pengjiaqiaodisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">彭家桥</h3>
                    <button class="button-startbtn" onclick="start(this)" value="彭家桥">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="彭家桥">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 谢家村 -->
        <div id="xiejiacun" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 506px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="xiejiacunss">
            <img src="images/end.png" class="img-sign" id="xiejiacunes">
            <div hidden class="div-alphabox" id="xiejiacundisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">谢家村</h3>
                    <button class="button-startbtn" onclick="start(this)" value="谢家村">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="谢家村">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 青山湖大道 -->
        <div id="qingshanhudadao" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 543px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="qingshanhudadaoss">
            <img src="images/end.png" class="img-sign" id="qingshanhudadaoes">
            <div hidden class="div-alphabox" id="qingshanhudadaodisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">青山湖大道</h3>
                    <button class="button-startbtn" onclick="start(this)" value="青山湖大道">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="青山湖大道">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 高新大道 -->
        <div id="gaoxindadao" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 580.2px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="gaoxindadaoss">
            <img src="images/end.png" class="img-sign" id="gaoxindadaoes">
            <div hidden class="div-alphabox" id="gaoxindadaodisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">高新大道</h3>
                    <button class="button-startbtn" onclick="start(this)" value="高新大道">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="高新大道">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 艾溪湖西 -->
        <div id="aixihuxi" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 617.3px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="aixihuxiss">
            <img src="images/end.png" class="img-sign" id="aixihuxies">
            <div hidden class="div-alphabox" id="aixihuxidisappear" style="height: 380px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">艾溪湖西</h3>
                    <button class="button-startbtn" onclick="start(this)" value="艾溪湖西">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="艾溪湖西">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/aixihu.jpg">
                    <div class="div-empty" style="height: 175px;"></div>
                    <p class="p-content">
                        艾溪湖湿地公园是江西省南昌市唯一的一块典型城市天然湿地，位于高新开发区艾溪湖东岸。艾溪湖古来有之，然不得其源，甲午年冬月廿一日，余与某君偕游艾溪湖，欲觅湖之渊源，不得，余听闻，但凡大美弥深之人必有数不尽道不完的历史，一个人思想的程度，恰等于她经历岁月的深度，物与人共处，此造物者无尽臧也，人的经历难追寻，物亦如此，大美艾溪湖，探之不得，余遗憾万分。</p>
                </div>
            </div>
        </div>
        <!-- 艾溪湖东 -->
        <div id="aixihudong" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 656px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="aixihudongss">
            <img src="images/end.png" class="img-sign" id="aixihudonges">
            <div hidden class="div-alphabox" id="aixihudongdisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">艾溪湖东</h3>
                    <button class="button-startbtn" onclick="start(this)" value="艾溪湖东">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="艾溪湖东">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 太子殿 -->
        <div id="taizidian" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 693px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="taizidianss">
            <img src="images/end.png" class="img-sign" id="taizidianes">
            <div hidden class="div-alphabox" id="taizidiandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">太子殿</h3>
                    <button class="button-startbtn" onclick="start(this)" value="太子殿">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="太子殿">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 奥体中心 -->
        <div id="aotizhongxin" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 730px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="aotizhongxinss">
            <img src="images/end.png" class="img-sign" id="aotizhongxines">
            <div hidden class="div-alphabox" id="aotizhongxindisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">奥体中心</h3>
                    <button class="button-startbtn" onclick="start(this)" value="奥体中心">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="奥体中心">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 瑶湖西 -->
        <div id="yaohuxi" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 162px; left: 768px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="yaohuxiss">
            <img src="images/end.png" class="img-sign" id="yaohuxies">
            <div hidden class="div-alphabox" id="yaohuxidisappear" style="height: 285px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">瑶湖西</h3>
                    <button class="button-startbtn" onclick="start(this)" value="瑶湖西">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="瑶湖西">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/yaohu.jpg">
                    <div class="div-empty" style="height: 175px;"></div>
                    <p class="p-content">瑶湖是南昌地区最大的内陆天然湖泊，现有水面二万三千余亩(15.25平方公里），是南昌地区最大的天然湖泊。坐落于南昌市东郊，与江西师范大学相邻。</p>
                </div>
            </div>
        </div>
        <!-- 1号线结束 -->
        <!-- 2号线开始 -->
        <!-- 南路站 -->
        <div id="nanluzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 754px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="nanluzhanss">
            <img src="images/end.png" class="img-sign" id="nanluzhanes">
            <div hidden class="div-alphabox" id="nanluzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">南路站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="南路站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="南路站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 大岗站 -->
        <div id="dagangzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 717px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="dagangzhanss">
            <img src="images/end.png" class="img-sign" id="dagangzhanes">
            <div hidden class="div-alphabox" id="dagangzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">大岗站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="大岗站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="大岗站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 生米站 -->
        <div id="shengmizhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 680px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="shengmizhanss">
            <img src="images/end.png" class="img-sign" id="shengmizhanes">
            <div hidden class="div-alphabox" id="shengmizhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">生米站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="生米站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="生米站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 九龙湖南 -->
        <div id="jiulonghunan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 643px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="jiulonghunanss">
            <img src="images/end.png" class="img-sign" id="jiulonghunanes">
            <div hidden class="div-alphabox" id="jiulonghunandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">九龙湖南</h3>
                    <button class="button-startbtn" onclick="start(this)" value="九龙湖南">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="九龙湖南">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 市民中心 -->
        <div id="shiminzhongxin" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 606px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="shiminzhongxinss">
            <img src="images/end.png" class="img-sign" id="shiminzhongxines">
            <div hidden class="div-alphabox" id="shiminzhongxindisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">市民中心</h3>
                    <button class="button-startbtn" onclick="start(this)" value="市民中心">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="市民中心">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 鹰潭街 -->
        <div id="yingtanjie" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 569px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="yingtanjiess">
            <img src="images/end.png" class="img-sign" id="yingtanjiees">
            <div hidden class="div-alphabox" id="yingtanjiedisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">鹰潭街</h3>
                    <button class="button-startbtn" onclick="start(this)" value="鹰潭街">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="鹰潭街">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 集嘉坊 -->
        <div id="jijiafang" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 532px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="jijiafangss">
            <img src="images/end.png" class="img-sign" id="jijiafanges">
            <div hidden class="div-alphabox" id="jijiafangdisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">集嘉坊</h3>
                    <button class="button-startbtn" onclick="start(this)" value="集嘉坊">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="集嘉坊">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 西站南广场 -->
        <div id="xizhannanguangchang" class="div-station" onclick="appear(this.id)" tabindex="0"
              
        <%--onmouseout="disappear(this.id)--%>
             style="top: 495px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="xizhannanguangchangss">
            <img src="images/end.png" class="img-sign" id="xizhannanguangchanges">
            <div hidden class="div-alphabox" id="xizhannanguangchangdisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">西站南广场</h3>
                    <button class="button-startbtn" onclick="start(this)" value="西站南广场">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="西站南广场">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 南昌西 -->
        <div id="nanchangxi" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 458px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="nanchangxiss">
            <img src="images/end.png" class="img-sign" id="nanchangxies">
            <div hidden class="div-alphabox" id="nanchangxidisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">南昌西</h3>
                    <button class="button-startbtn" onclick="start(this)" value="南昌西">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="南昌西">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 龙岗站 -->
        <div id="longgangzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 421px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="longgangzhanss">
            <img src="images/end.png" class="img-sign" id="longgangzhanes">
            <div hidden class="div-alphabox" id="longgangzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">龙岗站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="龙岗站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="龙岗站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 国体中心 -->
        <div id="guotizhongxin" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 384px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="guotizhongxinss">
            <img src="images/end.png" class="img-sign" id="guotizhongxines">
            <div hidden class="div-alphabox" id="guotizhongxindisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">国体中心</h3>
                    <button class="button-startbtn" onclick="start(this)" value="国体中心">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="国体中心">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 卧龙山 -->
        <div id="wolongshan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 347px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="wolongshanss">
            <img src="images/end.png" class="img-sign" id="wolongshanes">
            <div hidden class="div-alphabox" id="wolongshandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">卧龙山</h3>
                    <button class="button-startbtn" onclick="start(this)" value="卧龙山">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="卧龙山">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 岭北站 -->
        <div id="lingbeizhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 310px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="lingbeizhanss">
            <img src="images/end.png" class="img-sign" id="lingbeizhanes">
            <div hidden class="div-alphabox" id="lingbeizhandisappear" style="height: 280px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">岭北站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="岭北站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="岭北站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/lingbeizhan.jpg">
                    <div class="div-empty" style="height: 175px;"></div>
                    <p class="p-content">
                        红谷滩湿地公园坐落于赣江80米绿化带内，面积并不大，但这里春可赏花、夏可听荷、秋可观月、冬可觅绿，毗邻赣江，四季皆宜，而且游人不多，可以静静地在里面逡巡，不必担心喧哗。</p>
                </div>
            </div>
        </div>
        <!-- 前湖大道 -->
        <div id="qianhudadao" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 273px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="qianhudadaoss">
            <img src="images/end.png" class="img-sign" id="qianhudadaoes">
            <div hidden class="div-alphabox" id="qianhudadaodisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">前湖大道</h3>
                    <button class="button-startbtn" onclick="start(this)" value="前湖大道">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="前湖大道">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 学府大道东 -->
        <div id="xuefudadaodong" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 236px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="xuefudadaodongss">
            <img src="images/end.png" class="img-sign" id="xuefudadaodonges">
            <div hidden class="div-alphabox" id="xuefudadaodongdisappear" style="height: 305px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">学府大道东</h3>
                    <button class="button-startbtn" onclick="start(this)" value="学府大道东">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="学府大道东">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/xuefudadaodong.jpg">
                    <div class="div-empty" style="height: 210px;"></div>
                    <p class="p-content">南昌之星摩天轮位于江西省南昌市红谷滩新区红角洲赣江市民公园，高度为160米，2006建成时是当时世界最高摩天轮，现为目前世界上第五高摩天轮。</p>
                </div>
            </div>
        </div>
        <!-- 翠苑路 -->
        <div id="cuiyuanlu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 199px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="cuiyuanluss">
            <img src="images/end.png" class="img-sign" id="cuiyuanlues">
            <div hidden class="div-alphabox" id="cuiyuanludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">翠苑路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="翠苑路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="翠苑路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 雅苑路 -->
        <div id="yayuanlu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 125px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="yayuanluss">
            <img src="images/end.png" class="img-sign" id="yayuanlues">
            <div hidden class="div-alphabox" id="yayuanludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">雅苑路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="雅苑路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="雅苑路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 红谷中大道 -->
        <div id="hongguzhongdadao" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 51px; left: 173px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="hongguzhongdadaoss">
            <img src="images/end.png" class="img-sign" id="hongguzhongdadaoes">
            <div hidden class="div-alphabox" id="hongguzhongdadaodisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">红谷中大道</h3>
                    <button class="button-startbtn" onclick="start(this)" value="红谷中大道">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="红谷中大道">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 阳明公园 -->
        <div id="yangminggongyuan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 51px; left: 358px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="yangminggongyuanss">
            <img src="images/end.png" class="img-sign" id="yangminggongyuanes">
            <div hidden class="div-alphabox" id="yangminggongyuandisappear" style="height: 235px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">阳明公园</h3>
                    <button class="button-startbtn" onclick="start(this)" value="阳明公园">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="阳明公园">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/yangminggongyuan.jpg">
                    <div class="div-empty" style="height: 155px;"></div>
                    <p class="p-content">以明代哲学家王阳明的名字命名，公园内风景秀美，环境宜人，是一个很适合市民散步晨练的好地方。</p>
                </div>
            </div>
        </div>
        <!-- 青山路口 -->
        <div id="qingshanlukou" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 88px; left: 358px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="qingshanlukouss">
            <img src="images/end.png" class="img-sign" id="qingshanlukoues">
            <div hidden class="div-alphabox" id="qingshanlukoudisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">青山路口</h3>
                    <button class="button-startbtn" onclick="start(this)" value="青山路口">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="青山路口">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 福州路 -->
        <div id="fuzhoulu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 125px; left: 358px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="fuzhouluss">
            <img src="images/end.png" class="img-sign" id="fuzhoulues">
            <div hidden class="div-alphabox" id="fuzhouludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">福州路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="福州路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="福州路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 永叔路 -->
        <div id="yongshulu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 199px; left: 358px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="yongshuluss">
            <img src="images/end.png" class="img-sign" id="yongshulues">
            <div hidden class="div-alphabox" id="yongshuludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">永叔路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="永叔路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="永叔路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 丁公路南 -->
        <div id="dinggonglunan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 199px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="dinggonglunanss">
            <img src="images/end.png" class="img-sign" id="dinggonglunanes">
            <div hidden class="div-alphabox" id="dinggonglunandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">丁公路南</h3>
                    <button class="button-startbtn" onclick="start(this)" value="丁公路南">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="丁公路南">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 南昌站 -->
        <div id="nanchangzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 199px; left: 432px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="nanchangzhanss">
            <img src="images/end.png" class="img-sign" id="nanchangzhanes">
            <div hidden class="div-alphabox" id="nanchangzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">南昌站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="南昌站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="南昌站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 顺外站 -->
        <div id="shunwaizhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 199px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="shunwaizhanss">
            <img src="images/end.png" class="img-sign" id="shunwaizhanes">
            <div hidden class="div-alphabox" id="shunwaizhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">顺外站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="顺外站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="顺外站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 辛家庵 -->
        <div id="xinjiaan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 199px; left: 506px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="xinjiaanss">
            <img src="images/end.png" class="img-sign" id="xinjiaanes">
            <div hidden class="div-alphabox" id="xinjiaandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">辛家庵</h3>
                    <button class="button-startbtn" onclick="start(this)" value="辛家庵">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="辛家庵">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 上海南路 -->
        <div id="shanghainanlu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 236px; left: 506px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="shanghainanluss">
            <img src="images/end.png" class="img-sign" id="shanghainanlues">
            <div hidden class="div-alphabox" id="shanghainanludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">上海南路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="上海南路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="上海南路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 新溪桥 -->
        <div id="xinxiqiao" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 273px; left: 506px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="xinxiqiaoss">
            <img src="images/end.png" class="img-sign" id="xinxiqiaoes">
            <div hidden class="div-alphabox" id="xinxiqiaodisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">新溪桥</h3>
                    <button class="button-startbtn" onclick="start(this)" value="新溪桥">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="新溪桥">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 昌南大市场 -->
        <div id="changnandashichang" class="div-station" onclick="appear(this.id)" tabindex="0"
              
        <%--onmouseout="disappear(this.id)--%>
             style="top: 310px; left: 506px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="changnandashichangss">
            <img src="images/end.png" class="img-sign" id="changnandashichanges">
            <div hidden class="div-alphabox" id="changnandashichangdisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">昌南大市场</h3>
                    <button class="button-startbtn" onclick="start(this)" value="昌南大市场">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="昌南大市场">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 2号线结束 -->
        <!-- 3号线开始 -->
        <!-- 京东大道 -->
        <div id="jingdongdadao" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 88px; left: 580px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="jingdongdadaoss">
            <img src="images/end.png" class="img-sign" id="jingdongdadaoes">
            <div hidden class="div-alphabox" id="jingdongdadaodisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">京东大道</h3>
                    <button class="button-startbtn" onclick="start(this)" value="京东大道">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="京东大道">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 梁万站 -->
        <div id="liangwanzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 88px; left: 543px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="liangwanzhanss">
            <img src="images/end.png" class="img-sign" id="liangwanzhanes">
            <div hidden class="div-alphabox" id="liangwanzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">梁万站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="梁万站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="梁万站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 火炬广场 -->
        <div id="huojuguangchang" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 88px; left: 506px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="huojuguangchangss">
            <img src="images/end.png" class="img-sign" id="huojuguangchanges">
            <div hidden class="div-alphabox" id="huojuguangchangdisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">火炬广场</h3>
                    <button class="button-startbtn" onclick="start(this)" value="火炬广场">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="火炬广场">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 国威路 -->
        <div id="guoweilu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 88px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="guoweiluss">
            <img src="images/end.png" class="img-sign" id="guoweilues">
            <div hidden class="div-alphabox" id="guoweiludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">国威路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="国威路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="国威路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 青山湖西 -->
        <div id="qingshanhuxi" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 88px; left: 432px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="qingshanhuxiss">
            <img src="images/end.png" class="img-sign" id="qingshanhuxies">
            <div hidden class="div-alphabox" id="qingshanhuxidisappear" style="height: 320px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">青山湖西</h3>
                    <button class="button-startbtn" onclick="start(this)" value="青山湖西">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="青山湖西">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/qingshanhuxi.jpg">
                    <div class="div-empty" style="height: 120px;"></div>
                    <p class="p-content">
                        青山湖位于南昌市区东郊，面积约400公顷，湖岸曲折迂回，湖面碧波浩淼，景色秀丽，是南昌市著名的风景游览区。建设中的青山湖游览区分西南、东北两部分。西南部建有游乐园、技艺场、游泳场、竟舟区、江西少年活动中心等五个游乐点。东北部将辟有青山园、鱼趣园、盆景园、观鸟园、江西名人园等五个风景点，建成后的青山湖风景游览区，日接待游客量可达6．5万人。</p>
                </div>
            </div>
        </div>
        <!-- 墩子塘 -->
        <div id="dunzitang" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 88px; left: 321px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="dunzitangss">
            <img src="images/end.png" class="img-sign" id="dunzitanges">
            <div hidden class="div-alphabox" id="dunzitangdisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">墩子塘</h3>
                    <button class="button-startbtn" onclick="start(this)" value="墩子塘">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="墩子塘">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 六眼井 -->
        <div id="liuyanjing" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 273px; left: 321px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="liuyanjingss">
            <img src="images/end.png" class="img-sign" id="liuyanjinges">
            <div hidden class="div-alphabox" id="liuyanjingdisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">六眼井</h3>
                    <button class="button-startbtn" onclick="start(this)" value="六眼井">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="六眼井">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 十字街 -->
        <div id="shizijie" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 273px; left: 432px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="shizijiess">
            <img src="images/end.png" class="img-sign" id="shizijiees">
            <div hidden class="div-alphabox" id="shizijiedisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">十字街</h3>
                    <button class="button-startbtn" onclick="start(this)" value="十字街">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="十字街">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 京家山 -->
        <div id="jingjiashan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 273px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="jingjiashanss">
            <img src="images/end.png" class="img-sign" id="jingjiashanes">
            <div hidden class="div-alphabox" id="jingjiashandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">京家山</h3>
                    <button class="button-startbtn" onclick="start(this)" value="京家山">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="京家山">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 江铃站 -->
        <div id="jianglingzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 310px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="jianglingzhanss">
            <img src="images/end.png" class="img-sign" id="jianglingzhanes">
            <div hidden class="div-alphabox" id="jianglingzhandisappear" style="height: 215px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">江铃站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="江铃站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="江铃站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/jianglingzhan.jpg">
                    <div class="div-empty" style="height: 102px;"></div>
                    <p class="p-content">
                        象湖位于江西省南昌市西郊，是一个风景如画的旅游景区。象湖由南江、北江、东江、西江，以及青山湖的水流汇聚而成，其象湖的平面图颇似一头大象，故得名象湖。</p>
                </div>
            </div>
        </div>
        <!-- 施尧站 -->
        <div id="shiyaozhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 347px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="shiyaozhanss">
            <img src="images/end.png" class="img-sign" id="shiyaozhanes">
            <div hidden class="div-alphabox" id="shiyaozhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">施尧站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="施尧站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="施尧站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 八大山人 -->
        <div id="badashanren" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 384px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="badashanrenss">
            <img src="images/end.png" class="img-sign" id="badashanrenes">
            <div hidden class="div-alphabox" id="badashanrendisappear" style="height: 340px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">八大山人</h3>
                    <button class="button-startbtn" onclick="start(this)" value="八大山人">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="八大山人">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/badashanren.jpg">
                    <div class="div-empty" style="height: 190px;"></div>
                    <p class="p-content">
                        八大山人纪念馆成立于1959年，是我国第一座古代画家纪念馆，位于南昌南郊十五华里处的梅湖定山桥畔青云谱。全国重点文物保护单位，占地约39亩，四面环水，形似“八大”笔下游鱼，与西南面梅湖浑然一体，水陆相生，宛若“太极”天成，馆内布局一院一楼一中心，品形而立，风格迥异。</p>
                </div>
            </div>
        </div>
        <!-- 邓埠站 -->
        <div id="dengbuzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 421px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="dengbuzhanss">
            <img src="images/end.png" class="img-sign" id="dengbuzhanes">
            <div hidden class="div-alphabox" id="dengbuzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">邓埠站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="邓埠站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="邓埠站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 振兴大道 -->
        <div id="zhenxingdadao" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 458px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="zhenxingdadaoss">
            <img src="images/end.png" class="img-sign" id="zhenxingdadaoes">
            <div hidden class="div-alphabox" id="zhenxingdadaodisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">振兴大道</h3>
                    <button class="button-startbtn" onclick="start(this)" value="振兴大道">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="振兴大道">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 沥山站 -->
        <div id="lishanzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 495px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="lishanzhanss">
            <img src="images/end.png" class="img-sign" id="lishanzhanes">
            <div hidden class="div-alphabox" id="lishanzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">沥山站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="沥山站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="沥山站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 柏岗站 -->
        <div id="baigangzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 532px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="baigangzhanss">
            <img src="images/end.png" class="img-sign" id="baigangzhanes">
            <div hidden class="div-alphabox" id="baigangzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">柏岗站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="柏岗站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="柏岗站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 斗门站 -->
        <div id="doumenzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 569px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="doumenzhanss">
            <img src="images/end.png" class="img-sign" id="doumenzhanes">
            <div hidden class="div-alphabox" id="doumenzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">斗门站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="斗门站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="斗门站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 银三角北 -->
        <div id="yinsanjiaobei" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 606px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="yinsanjiaobeiss">
            <img src="images/end.png" class="img-sign" id="yinsanjiaobeies">
            <div hidden class="div-alphabox" id="yinsanjiaobeidisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">银三角北</h3>
                    <button class="button-startbtn" onclick="start(this)" value="银三角北">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="银三角北">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 3号线结束 -->
        <!-- 4号线开始 -->
        <!-- 北沥站 -->
        <div id="beilizhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 51px; left: 543px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="beilizhanss">
            <img src="images/end.png" class="img-sign" id="beilizhanes">
            <div hidden class="div-alphabox" id="beilizhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">北沥站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="北沥站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="北沥站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 民园路东 -->
        <div id="minyuanludong" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 51px; left: 506px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="minyuanludongss">
            <img src="images/end.png" class="img-sign" id="minyuanludonges">
            <div hidden class="div-alphabox" id="minyuanludongdisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">民园路东</h3>
                    <button class="button-startbtn" onclick="start(this)" value="民园路东">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="民园路东">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 民园路西 -->
        <div id="minyuanluxi" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 51px; left: 469px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="minyuanluxiss">
            <img src="images/end.png" class="img-sign" id="minyuanluxies">
            <div hidden class="div-alphabox" id="minyuanluxidisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">民园路西</h3>
                    <button class="button-startbtn" onclick="start(this)" value="民园路西">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="民园路西">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 七里站 -->
        <div id="qilizhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 51px; left: 432px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="qilizhanss">
            <img src="images/end.png" class="img-sign" id="qilizhanes">
            <div hidden class="div-alphabox" id="qilizhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">七里站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="七里站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="七里站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 起凤路 -->
        <div id="qifenglu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 51px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="qifengluss">
            <img src="images/end.png" class="img-sign" id="qifenglues">
            <div hidden class="div-alphabox" id="qifengludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">起凤路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="起凤路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="起凤路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 上沙沟 -->
        <div id="shangshagou" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 88px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="shangshagouss">
            <img src="images/end.png" class="img-sign" id="shangshagoues">
            <div hidden class="div-alphabox" id="shangshagoudisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">上沙沟</h3>
                    <button class="button-startbtn" onclick="start(this)" value="上沙沟">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="上沙沟">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 人民公园 -->
        <div id="renmingongyuan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 125px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="renmingongyuanss">
            <img src="images/end.png" class="img-sign" id="renmingongyuanes">
            <div hidden class="div-alphabox" id="renmingongyuandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">人民公园</h3>
                    <button class="button-startbtn" onclick="start(this)" value="人民公园">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="人民公园">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 坛子口 -->
        <div id="tanzikou" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 236px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="tanzikouss">
            <img src="images/end.png" class="img-sign" id="tanzikoues">
            <div hidden class="div-alphabox" id="tanzikoudisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">坛子口</h3>
                    <button class="button-startbtn" onclick="start(this)" value="坛子口">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="坛子口">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 绳金塔 -->
        <div id="shengjinta" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 273px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="shengjintass">
            <img src="images/end.png" class="img-sign" id="shengjintaes">
            <div hidden class="div-alphabox" id="shengjintadisappear" style="height: 305px;">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">绳金塔</h3>
                    <button class="button-startbtn" onclick="start(this)" value="绳金塔">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="绳金塔">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div>
                    <img class="img-scenary" alt="" src="images/scenary/shengjinta.jpg">
                    <div class="div-empty" style="height: 155px;"></div>
                    <p class="p-content">
                        绳金塔，位于江西省南昌市西湖区绳金塔街东侧，原南昌城进贤门外，始建于唐天祐年间（公元904～907年），相传建塔前异僧惟一掘地得铁函一只，内有金绳四匝，古剑三把（分别刻有“驱风”、“镇火”、“降蛟”字样），还有金瓶一个，盛有舍利子三百粒，绳金塔因此而得名。</p>
                </div>
            </div>
        </div>
        <!-- 桃苑站 -->
        <div id="taoyuanzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 310px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="taoyuanzhanss">
            <img src="images/end.png" class="img-sign" id="taoyuanzhanes">
            <div hidden class="div-alphabox" id="taoyuanzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">桃苑站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="桃苑站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="桃苑站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 南昌大桥东 -->
        <div id="nanchangdaqiaodong" class="div-station" onclick="appear(this.id)" tabindex="0"
              
        <%--onmouseout="disappear(this.id)--%>
             style="top: 347px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="nanchangdaqiaodongss">
            <img src="images/end.png" class="img-sign" id="nanchangdaqiaodonges">
            <div hidden class="div-alphabox" id="nanchangdaqiaodongdisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">南昌大桥东</h3>
                    <button class="button-startbtn" onclick="start(this)" value="南昌大桥东">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="南昌大桥东">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 灌婴路 -->
        <div id="guanyinglu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 384px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="guanyingluss">
            <img src="images/end.png" class="img-sign" id="guanyinglues">
            <div hidden class="div-alphabox" id="guanyingludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">灌婴路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="灌婴路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="灌婴路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 云天路 -->
        <div id="yuntianlu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 421px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="yuntianluss">
            <img src="images/end.png" class="img-sign" id="yuntianlues">
            <div hidden class="div-alphabox" id="yuntianludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">云天路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="云天路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="云天路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 观洲站 -->
        <div id="guanzhouzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 458px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="guanzhouzhanss">
            <img src="images/end.png" class="img-sign" id="guanzhouzhanes">
            <div hidden class="div-alphabox" id="guanzhouzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">观洲站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="观洲站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="观洲站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 丁家洲 -->
        <div id="dingjiazhou" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 495px; left: 395px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="dingjiazhouss">
            <img src="images/end.png" class="img-sign" id="dingjiazhoues">
            <div hidden class="div-alphabox" id="dingjiazhoudisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">丁家洲</h3>
                    <button class="button-startbtn" onclick="start(this)" value="丁家洲">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="丁家洲">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 八月湖路 -->
        <div id="bayuehulu" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 495px; left: 321px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="bayuehuluss">
            <img src="images/end.png" class="img-sign" id="bayuehulues">
            <div hidden class="div-alphabox" id="bayuehuludisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">八月湖路</h3>
                    <button class="button-startbtn" onclick="start(this)" value="八月湖路">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="八月湖路">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 东新站 -->
        <div id="dongxinzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 495px; left: 284px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="dongxinzhanss">
            <img src="images/end.png" class="img-sign" id="dongxinzhanes">
            <div hidden class="div-alphabox" id="dongxinzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">东新站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="东新站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="东新站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 安丰站 -->
        <div id="anfengzhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 495px; left: 247px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="anfengzhanss">
            <img src="images/end.png" class="img-sign" id="anfengzhanes">
            <div hidden class="div-alphabox" id="anfengzhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">安丰站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="安丰站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="安丰站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 怀玉山大道 -->
        <div id="huaiyushandadao" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 495px; left: 210px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="huaiyushandadaoss">
            <img src="images/end.png" class="img-sign" id="huaiyushandadaoes">
            <div hidden class="div-alphabox" id="huaiyushandadaodisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">怀玉山大道</h3>
                    <button class="button-startbtn" onclick="start(this)" value="怀玉山大道">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="怀玉山大道">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 礼庄山 -->
        <div id="lizhuangshan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 495px; left: 136px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="lizhuangshanss">
            <img src="images/end.png" class="img-sign" id="lizhuangshanes">
            <div hidden class="div-alphabox" id="lizhuangshandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">礼庄山</h3>
                    <button class="button-startbtn" onclick="start(this)" value="礼庄山">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="礼庄山">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 中堡站 -->
        <div id="zhongbaozhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 532px; left: 136px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="zhongbaozhanss">
            <img src="images/end.png" class="img-sign" id="zhongbaozhanes">
            <div hidden class="div-alphabox" id="zhongbaozhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">中堡站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="中堡站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="中堡站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 璜溪站 -->
        <div id="huangxizhan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 532px; left: 99px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="huangxizhanss">
            <img src="images/end.png" class="img-sign" id="huangxizhanes">
            <div hidden class="div-alphabox" id="huangxizhandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">璜溪站</h3>
                    <button class="button-startbtn" onclick="start(this)" value="璜溪站">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="璜溪站">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 裕丰街 -->
        <div id="yufengjie" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 532px; left: 62px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="yufengjiess">
            <img src="images/end.png" class="img-sign" id="yufengjiees">
            <div hidden class="div-alphabox" id="yufengjiedisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">裕丰街</h3>
                    <button class="button-startbtn" onclick="start(this)" value="裕丰街">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="裕丰街">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 白马山 -->
        <div id="baimashan" class="div-station" onclick="appear(this.id)" tabindex="0"  
        <%--onmouseout="disappear(this.id)--%>
             style="top: 532px; left: 25px;">
            <!-- 隐藏菜单栏 -->
            <img src="images/start.png" class="img-sign" id="baimashanss">
            <img src="images/end.png" class="img-sign" id="baimashanes">
            <div hidden class="div-alphabox" id="baimashandisappear">
                <!-- 起终点按钮 -->
                <div>
                    <h3 class="h3-title">白马山</h3>
                    <button class="button-startbtn" onclick="start(this)" value="白马山">设为起点</button>
                    <button class="button-endbtn" onclick="end(this)" value="白马山">设为终点</button>
                </div>
                <!-- 景点选填 -->
                <div></div>
            </div>
        </div>
        <!-- 4号线结束 -->
        <!-- 站点结束 -->
    </div>
    <!-- 地图结束 -->
    <!-- 右部选框开始 -->
    <div class="div-right">
        <!-- 上部选框开始 -->
        <div>
            <!-- 起点框开始 -->
            <form action="<%=path %>/test" method="post" onsubmit="return check()" name="myForm">
                <div
                        style="position: absolute; left: 10px; top: 10px; width: 220px; height: 40px;">
                    <img alt="" src="images/start.png"
                         style="display: block; height: 100%; position: absolute; left: 0px;">
                    <input id="startinput"
                           style="position: absolute; left: 45px; top: 6px; height: 30px;"
                           onfocus=this.blur()
                           value="<%=request.getAttribute("start")==null?"请选择":request.getAttribute("start")%>"
                           name="start">
                </div>
                <!-- 起点框结束 -->
                <!-- 终点框开始 -->
                <div
                        style="position: absolute; left: 10px; top: 60px; width: 220px; height: 40px;">
                    <img alt="" src="images/end.png"
                         style="display: block; height: 100%; position: absolute; left: 0px;">
                    <input id="endinput"
                           style="position: absolute; left: 45px; top: 6px; height: 30px;"
                           onfocus=this.blur()
                           value="<%=request.getAttribute("end")==null?"请选择":request.getAttribute("end")%>" name="end">
                </div>
                <iframe name="frameFile" style="display: none"></iframe>
                <input hidden name="ticketnum" id="ticketnum"
                       value="<%=request.getAttribute("ticketnum")==null?1:request.getAttribute("ticketnum")%>">
                <input hidden name="money" id="money"
                       value="<%=request.getAttribute("money")==null?"":request.getAttribute("money")%>">
                <input hidden name="addmoney" id="addmoney">
                <input hidden name="startsign" id="startsign" value="">
                <input hidden name="endsign" id="endsign" value="">
                <%--<input type="submit" value="提交">--%>
            </form>
            <!-- 终点框结束 -->
            <!-- 车票数量选择开始 -->
            <div
                    style="position: absolute; left: 10px; top: 110px; width: 220px; height: 40px;">
                <h4
                        style="position: absolute; left: 0px; top: -18px; height: 30px;">车票数量</h4>
                <button id="btn1" onclick="btnchange(this)" value="1"
                        style="position: absolute; left: 75px; top: 2px; height: 35px; width: 35px;background-color: #7ce7ea;">
                    1
                </button>
                <button id="btn2" onclick="btnchange(this)" value="2"
                        style="position: absolute; left: 125px; top: 2px; height: 35px; width: 35px;background-color: #437b7d;">
                    2
                </button>
                <button id="btn3" onclick="btnchange(this)" value="3"
                        style="position: absolute; left: 175px; top: 2px; height: 35px; width: 35px;background-color: #437b7d;">
                    3
                </button>
                <button id="btn4" onclick="btnchange(this)" value="4"
                        style="position: absolute; left: 75px; top: 52px; height: 35px; width: 35px;background-color: #437b7d;">
                    4
                </button>
                <button id="btn5" onclick="btnchange(this)" value="5"
                        style="position: absolute; left: 125px; top: 52px; height: 35px; width: 35px;background-color: #437b7d;">
                    5
                </button>
                <button id="btn6" onclick="btnchange(this)" value="6"
                        style="position: absolute; left: 175px; top: 52px; height: 35px; width: 35px;background-color: #437b7d;">
                    6
                </button>
                <button id="btn7" onclick="btnchange(this)" value="7"
                        style="position: absolute; left: 75px; top: 102px; height: 35px; width: 35px;background-color: #437b7d;">
                    7
                </button>
                <button id="btn8" onclick="btnchange(this)" value="8"
                        style="position: absolute; left: 125px; top: 102px; height: 35px; width: 35px;background-color: #437b7d;">
                    8
                </button>
                <button id="btn9" onclick="btnchange(this)" value="9"
                        style="position: absolute; left: 175px; top: 102px; height: 35px; width: 35px;background-color: #437b7d;">
                    9
                </button>
                <script>
                    var ticketnum = "btn" + document.getElementById("ticketnum").value;
                    btncheck();
                    document.getElementById(ticketnum).style.backgroundColor = "7ce7ea";
                </script>
            </div>
            <!-- 车票数量选择结束 -->
        </div>
        <!-- 上部选框结束 -->
        <!-- 下部支付方式开始 -->
        <div style="position: absolute;top: 255px;width: 240px;">
            <h1 style="text-align: center">支付方式</h1>
            <%--switch开关开始--%>
            <button class="toggle toggle--on" onclick="switchmove()"></button>
            <script src="images/switch/index.js"></script>
            <%--switch开关结束--%>
            <%--隐藏的switch按钮判断--%>
            <input id="flag" value="0" hidden>
            <%--现金支付开始--%>
            <div id="cash" style="height: 200px;width: 240px;background-color: #fff">
                <input id="thismoney" type="number" min="1"
                       style="position: absolute;top: 140px;height: 25px;width: 120px;left: 60px;">
                <button onclick="moneyin()"
                        style="position: absolute;top: 180px;text-align: center;width: 120px;left: 60px;">放入钱币
                </button>
                <div style="position: absolute;top: 220px;width: 50px;left: 40px;text-align: center">
                    <h2>应付</h2>
                    <h2>
                        <input id="mmp" value="<%=request.getAttribute("price")==null?0:request.getAttribute("price")%>"
                               style="font-size: 20px;height: 40px;width: 40px;text-align: center;" onfocus=this.blur()>
                    </h2>
                    <h2>元</h2>
                </div>
                <div style="position: absolute;top: 220px;width: 270px;left: 40px;text-align: center">
                    <h2>已付</h2>
                    <h2>
                        <input id="thisaddmoney"
                               value="<%=request.getAttribute("addmoney")==null?0:request.getAttribute("addmoney")%>"
                               style="height: 40px;width: 40px;text-align: center;font-size: 20px;" onfocus=this.blur()>
                    </h2>
                    <h2>元</h2>
                </div>
                <button onclick="ticket()"
                        style="position: absolute;top: 370px;width: 140px;left: 50px;text-align: center;font-size: 25px;">
                    出 票
                </button>
            </div>
            <%--现金支付结束--%>
            <%--三方支付开始--%>
            <div id="threepay" style="height: 200px;width: 240px;background-color: #fff" hidden="hidden">
                <%--支付宝支付   未开发--%>
                <div style="height:100px;width: 100px;position: absolute;top: 135px;left: 10px;">
                    <img src="images/zhifubao.png" style="height:100px;width: 100px;">
                    <img src="images/zhifubaologo.jpg"
                         style="display: block;width: 80px;left: 10px;position: absolute;top: 120px;">
                </div>
                <%--微信支付   未开发--%>
                <div style="height:100px;width: 100px;position: absolute;top: 135px;right: 10px;">
                    <img src="images/weixin.png" style="height:100px;width: 100px;">
                    <img src="images/weixinlogo.jpg"
                         style="display: block;width: 40px;left: 30px;position:absolute;top: 115px;">
                </div>
                <div style="position: absolute;top: 300px;width: 170px;left: 40px;text-align: center">
                    <h2>应付</h2>
                    <h2>
                        <input value="<%=request.getAttribute("price")==null?0:request.getAttribute("price")%>"
                               style="font-size: 20px;height: 40px;width: 40px;text-align: center;" onfocus=this.blur()>
                    </h2>
                    <h2>元</h2>
                </div>
            </div>
            <%--三方支付结束--%>
        </div>
        <!-- 下部支付方式结束 -->
    </div>
    <!-- 右部选框结束 -->
</div>
<input hidden name="" id="jumpflag" value="0">
<input hidden name="" id="getstartsign" value="<%=request.getAttribute("getstartsign")%>">
<input hidden name="" id="getendsign" value="<%=request.getAttribute("getendsign")%>">
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