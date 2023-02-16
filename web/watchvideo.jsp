<%-- 
    Document   : index
    Created on : 29 Dec, 2022, 6:38:11 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    int sn = 0;
    int subscribe = 1;
    String video_time = "";
    String user_code = "";
    String channel_code = "";
    String channel_img = "";
    String channel_name = "";
    String name = "", lname = "";
    String wcode = request.getParameter("code");
    String wtitle = request.getParameter("title");
    String wdes = request.getParameter("description");
    Cookie c[] = request.getCookies();
    String email = null;
    for (int i = 0; i < c.length; i++) {

        if (c[i].getName().equals("yt_login")) {
            email = c[i].getValue();
            break;
        }
    }
    if (email != null && session.getAttribute(email) != null) {

        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
            Statement st = cn.createStatement();
            Statement st1 = cn.createStatement();
            Statement st2 = cn.createStatement();
            Statement st3 = cn.createStatement();
            Statement st4 = cn.createStatement();
            Statement st5 = cn.createStatement();
            Statement st6 = cn.createStatement();
            Statement st7 = cn.createStatement();
            ResultSet rs = st.executeQuery("select * from register where email='" + email + "'");
            ResultSet rs1 = st1.executeQuery("select * from video where code='" + wcode + "'");

            if (rs.next()) {
                name = rs.getString("first_name");
                lname = rs.getString("last_name");
                user_code = rs.getString("code");
            }

            if (rs1.next()) {

                video_time = rs1.getString("date");
                ResultSet rs2 = st2.executeQuery("select * from channel where code='" + rs1.getString("channel_code") + "'");
                if (rs2.next()) {
                    channel_name = rs2.getString("channel_name");
                    channel_img = rs2.getString("code");
                    channel_code = rs2.getString("code");

                }
            }

            ResultSet rs3 = st3.executeQuery("select * from views where video_code='" + wcode + "' AND user_code='" + user_code + "' ");
            if (rs3.next()) {

                st7.executeUpdate("update views set history=" + 1 + " where  video_code='" + wcode + "' AND user_code='" + user_code + "'  ");

            } else {

                ResultSet rs4 = st4.executeQuery("select MAX(sn) from views");

                if (rs4.next()) {
                    sn = rs4.getInt(1);
                }
                sn++;
                if (st5.executeUpdate("insert into views values(" + sn + ",'" + wcode + "','" + channel_code + "','" + user_code + "'," + 1 + ")") > 0) {
                }
            }

            ResultSet rs5 = st6.executeQuery("select * from subscription where channel_code='" + channel_code + "' AND user_email='" + email + "' AND status=" + 1 + "");
            if (rs5.next()) {

                subscribe = 1;

            } else {
                subscribe = 0;
            }


        } catch (Exception e) {
            out.print(e.getMessage());
        }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>youtube</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"></link>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <style>

            section.example input[type=search] {
                padding: 6px;
                font-size: 17px;
                border: 1px solid grey;
                float: left;
                width: 80%;
            }

            section.example button {
                float: left;
                width: 20%;
                padding: 4px;
                margin-left:-15px;
                color: white;
                font-size: 17px;
                border: 1px solid grey;
                border-left: none;
                cursor: pointer;
                border-top-right-radius:15px;
                border-bottom-right-radius:15px;
            }
            .fa.fa-user-circle.card:hover{
                background-color:#F0F8FF;
                cursor:pointer;
            }
            html,body{
                overflow-x: hidden;
                height: 100%;
            }
            #sidebarmenu{
                height: 100%;
                position: fixed;
                margin-left: -240px;
                overflow-x: hidden; /* Hide horizontal scrollbar */
                overflow-y: scroll; /* Add vertical scrollbar */
                background-color:#fff;
                transition:opacity 1s;
                color:#111;
                transition:margin-left 0.5s;
            }

            /* width */
            ::-webkit-scrollbar {
                width: 10px;
            }

            /* Track */
            ::-webkit-scrollbar-track {
                background: #f1f1f1; 
            }

            /* Handle */
            ::-webkit-scrollbar-thumb {
                background: #888; 
                border-radius:10px;
            }

            /* Handle on hover */
            ::-webkit-scrollbar-thumb:hover {
                background: #555; 
            }
            .menu{
                list-style: none;
                padding: 10px;
                margin:0;
            }

            .menu li a{
                display: block;
                padding:15px;
            }
            .col-sm-12.dropdown-item:hover{
                cursor:pointer;
            }
            #dropdown_user {
                position: relative;
                display: inline-block;
                float:right;
            }

            #dropdown-content_user_profile {
                border-radius: 10px;
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                margin-left:-260px;
                margin-top:44px;
                height:475px;
                width:280px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);

                z-index: 1;
            }
            #dropdown_notification {
                position: relative;
                display: inline-block;
                float:right;
            }

            #dropdown-content_notification {
                display: none;
                position: absolute;
                background-color: #fff;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            } 


            .badge {
                position: absolute;
                top: 0px;
                right:5px;
                padding: 5px 10px;
                border-radius: 90%;
                background-color: red;
                color: white;
            } 
            .fa.fa-bell{
                margin-left:25px;
                font-size:25px;
                padding:10px;
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                border-radius: 8px;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                padding: 12px 16px;
                z-index: 1;
                margin-left: 80px;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

        </style>
        <script>
            $(document).ready(function() {
                var p = 1;
                $(".glyphicon.glyphicon-menu-hamburger.text-dark").on("click", function() {

                    if (p === 1) {
                        $("#sidebarmenu").css('margin-left', '0px');
                        $("#sidebarmenu").css('margin-top', '0px');
                        $("#sidebarmenu").css('top', '0px');
                        $('.row.video').css('z-index', ' -1');

                        p = 0;
                    }
                    else {

                        $("#sidebarmenu").css('margin-left', '-240px');
                        $('.row.video').css('z-index', ' 0');

                        p = 1;
                    }
                });
            });
        </script>

        <!----notification- JQ--->
        <script>
            $(document).ready(function() {
                var flag = true;
                var flag1 = true;
                $(".notification").on("click", function() {
                    if (flag) {
                        $("#dropdown-content_notification").show();
                        $("#dropdown-content_user_profile").hide();
                        flag = false;
                        flag1 = true;
                    }
                    else {
                        $("#dropdown-content_notification").hide();
                        flag = true;
                    }
                });

                $("#user_profile").on("click", function() {
                    if (flag1) {
                        $("#dropdown-content_user_profile").show();
                        $("#dropdown-content_notification").hide();
                        flag1 = false;
                        flag = true;
                    }
                    else {
                        $("#dropdown-content_user_profile").hide();
                        flag1 = true;
                    }
                });


            });


        </script>
        <script>
            $(document).ready(function() {
                var file_content = $("#maincontent").html();
                $("#input").on("change", function(event) {
                    var search_value = event.target.value;
                    if (search_value.length > 0) {
                        $.post(
                                "search_result.jsp", {search_value: search_value}, function(data) {
                            $("#maincontent").html(data.trim());
                        });
                    }
                    else {
                        $("#maincontent").html(file_content);
                    }
                });
            });
        </script>


    </head>
    <body>
        <!--.NAV-BAR..-->
        <nav class=" sticky-top card-body bg-light"  >
            <div class="container-fluid" >
                <div class="row">
                    <div class="col-sm-1"   >
                        <span class="glyphicon glyphicon-menu-hamburger text-dark" style="cursor:pointer; font-size:17px;margin-top:12px;float:left" id="sidebar"></span>    
                    </div>
                    <div class="col-sm-2" style="margin-top:8px">
                        <img src="yt.png"  style="margin-left: -50px; margin-top:-15px;height:55px" id='logo_png'>
                    </div>
                    <!-------search------------>         
                    <div class="col-sm-5"style="margin-top:5px">
                        <section class="example" action="/action_page.php" style="margin:auto">
                            <input type="search" id="input" placeholder="Search.." name="search2"  class="form-control"style="border-radius: 15px;">
                            <button type="submit"><i class="fa fa-search  text-dark" style="border-radius: 15px;"></i></button>
                        </section>
                    </div>
                    <!-------search end------>
                    <!----------notification------------------------>       
                    <div class="col-sm-3">
                        <div class="row">
                            <div class="col-sm-8" >
                                <div class="dropdown">
                                    <i class="fa fa-video-camera " aria-hidden="true" style="font-size:24px; padding: 8px;margin-left: 150px;"></i>
                                    <div class="dropdown-content">
                                        <a href="upload_video.jsp" style="text-decoration:none; color:black;"><i class="fa fa-upload" style="font-size:17px; padding:10px"></i>Upload Video</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <span class="notification" style='cursor: pointer'>
                                    <i class='fa fa-bell' style=""></i>
                                    <span class="badge">3</span>
                                </span>
                                <div class="col-sm-12 dropdown" id="dropdown_notification">
                                    <div class="dropdown-content" id='dropdown-content_notification'style="margin-left:-240px;width:500px;border-radius:10px;height:450px;overflow-x:hidden;overflow-y:scroll">
                                        <div class="container-fluid">
                                            <div class="row sticky-top" style="background-color:#ECF7FB">
                                                <div class="col-sm-12 ">
                                                    <center><h4>notification</h4></center>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <!-- notification start ---->
                                                <div class="col-sm-12">
                                                    <img src="yt.png">
                                                </div>
                                                <div class="col-sm-12">
                                                    <img src="yt.png">
                                                </div>
                                                <!-- notification end ---->

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> 
                    <!-------------notification end----------------->  
                    <!------profile------------------>
                    <div class="col-sm-1" id='user_profile'>
                        <div class="dropdown" id="dropdown_user">
                            <span class="card " style="cursor: pointer;float:right;padding:9px;height:40px;width:40px;border-radius:50%;background-color: #ACDDDE;color:#fff"><%=name.charAt(0) + "" + lname.charAt(0)%></span>
                            <div class="dropdown-content" id="dropdown-content_user_profile">
                                <div class='container-fluid'>
                                    <div class='row'>
                                        <div class="col-sm-12 " style="margin-top:18px;display:flex">
                                            <span class="card"  style="padding:9px;cursor: pointer;background-color: #DDB487;color:#fff;height:40px;width:40px;border-radius:50%;"><%=name.charAt(0) + "" + lname.charAt(0)%></span>
                                            <span style="padding:10px"><b><%=name + " " + lname%></b> </span>
                                        </div>
                                        <div class="col-sm-12" >
                                            <hr>
                                        </div>    
                                    </div>         
                                    <div class="row" >
                                        <div class="col-sm-12 dropdown-item">
                                            <i class="fa fa-user-circle-o" style="font-size:20px;padding:10px"></i>
                                            <a href="check.jsp" style="margin-left:16px;text-decoration: none;color:black">Your Channel</a>
                                        </div>          
                                    </div>
                                    <div class="row" >
                                        <div class="col-sm-12 dropdown-item">
                                            <i class="fa fa-play-circle-o"style="font-size:20px;padding:10px"></i>
                                            <span style="margin-left:20px">Youtube Studio</span>
                                        </div>          
                                    </div>
                                    <div class='row' >
                                        <div class='col-sm-12 dropdown-item'>
                                            <i class='fa fa-sign-out' style="font-size:20px;padding:10px"></i>
                                            <a href="logout.jsp" style='margin-left:20px;color:black;text-decoration:none'>Logout</a>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row" >
                                        <div class="col-sm-12 dropdown-item">
                                            <i class="fa fa-cog" style="font-size:20px;padding:10px"></i>
                                            <span style="margin-left:20px">Settings</span>
                                        </div>          
                                    </div>  
                                    <hr>
                                    <div class="row" >
                                        <div class="col-sm-12 dropdown-item">
                                            <i class="fa fa-question-circle" style="font-size:20px;padding:10px"></i>
                                            <span style="margin-left:20px">Help</span>
                                        </div>          
                                    </div>  
                                    <div class="row" >
                                        <div class="col-sm-12 dropdown-item">
                                            <i class="fa fa-commenting-o" style="font-size:20px;padding:10px"></i>
                                            <span style="margin-left:20px">Send feedback</span>
                                        </div>          
                                    </div>          
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </nav>  

        <!---------profile ----end------------>                                            
        <!--..NAV--BAR-END.--> 

        <!------SIDE-BAR----start-------->
        <style>
            .sidebar{
                position:fixed;
                top:0px;
                width:100px;
                height:100%;
                z-index:1;
            }

        </style>
        <div class="sidebar ">
            <div class="container-fluid bg-light" style=' height:100%;margin-left:-10px;'>
                <div class="row" style="margin-top:85px"> 
                    <!-- Home icon------->                                 
                    <div class="col-sm-12" >
                        <a href="home.jsp"   class="dropdown-item" style='border-radius:10px;' >
                            <center>
                                <i class="fa fa-home" aria-hidden="true" style="font-size:22px;margin-left:-6px"></i> 
                            </center>
                            <small  style="margin-left:0px">Home</small>
                        </a>

                    </div>
                </div>
                <!-- subscription icon------->
                <div class="row" style="margin-top:20px"> 
                    <div class="col-sm-12" >
                        <a href="Subscription.jsp"   class="dropdown-item" style='border-radius:10px;' >
                            <center>
                                <span class="material-icons" style="font-size:22px;">&#xe064;</span> 
                            </center>

                            <small style="margin-left:-12px">Subscription</small>
                        </a>

                    </div>
                </div>
                <!-- Library icon------->
                <div class="row" style="margin-top:20px"> 
                    <div class="col-sm-12" >
                        <a href="#"   class="dropdown-item" style='border-radius:10px;'>
                            <center>
                                <i class="fa fa-film" style="font-size:19px;color:black"></i> 
                            </center>
                            <small style="margin-left:2px">Library</small>
                        </a>

                    </div>
                </div>
                <!-- history icon------->
                <div class="row" style="margin-top:20px"> 
                    <div class="col-sm-12" >
                        <a href="history.jsp"   class="dropdown-item" style='border-radius:10px;' >
                            <center>
                                <span class="fa fa-history" style="font-size:22px"></span> 
                            </center>

                            <small style="margin-left:2px">History</small>
                        </a>

                    </div>
                </div>

            </div>
            <!------SIDE-bar---END-------->   


            <!--SIDE-BAR-MENU--->     
            <div id="sidebarmenu" class="bg-light"   >
                <div class='row' id='sidebarmenu_row'>
                    <div class='col-sm-12' style='margin-top:35%'>
                        <ul class="menu">
                            <li>
                                <a href="home.jsp" class='dropdown-item' style='border-radius:10px;' > <span class="fa fa-home" title="Home" style="font-size:19px;"></span> <span style='margin-left:35px'>Home</span></a>
                            </li>
                            <li>
                                <a href="Subscription.jsp" class='dropdown-item' style='border-radius:10px;' > <span class="material-icons" style="font-size:22px;">&#xe064;</span> <span style='margin-left:30px'>Subscription</span></a>

                            </li>
                            <hr>
                            <li>
                                <a href="history.jsp" class='dropdown-item' style='border-radius:10px;' > <span class="fa fa-history" style="font-size:19px;"></span> <span style='margin-left:35px'>History</span></a>
                            </li>
                            <li>
                                <a href="dashboard.jsp" class='dropdown-item' style='border-radius:10px;' > <span class="fa fa-video-camera" aria-hidden="true" style="font-size:19px;"></span> <span style='margin-left:35px'>Your videos</span></a>
                            </li>
                            <hr>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-fire" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Trending</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-music" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Music</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-play-circle" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Movies</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-gamepad" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Gaming</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-newspaper-o" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>News</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-soccer-ball-o" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Sports</span></a>
                            </li>
                            <hr>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-gear" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Settings</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-question-circle" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Help</span></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--.SIDE-BAR-MENU-END..--> 
        </div>

        <!-- MAIN SCREEN-->

        <section id="maincontent">
            <div class="container " id='video_section' >
                <div class="row">
                    <div class="col-sm-12" >
                        <div class="row video" style='z-index:0;position: relative;margin-top:20px'>
                            <div class='col-sm-12 ' >
                                <div class='row ' >
                                    <div class="col-sm-12 ">   
                                        <div class="row  card-body" style="margin-left:50px">



                                            <div class="col-sm-8 "  >
                                                <div class="row">
                                                    <div class="col-sm-12 ">
                                                        <div class="row">
                                                            <div class="col-sm-12 " style="">
                                                                <!-- for thumbnail use poster="yt.png"--->
                                                                <a> 
                                                                    <video width="650" autoplay height="450" poster="thumbnail/<%=wcode%>.jpg" class="img-fluid" style='border-radius:2px'   controls>
                                                                        <source src="upload_video/<%=wcode%>.mp4" type="video/mp4">
                                                                        <source src="movie.ogg" type="video/ogg">

                                                                    </video>
                                                                </a>
                                                            </div>
                                                            <div class="col-sm-12">
                                                                <h5><b> <%=wtitle%> </b></h5>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <script>
                                                    $(document).ready(function() {
                                                        $("#channel_img").on("click", function() {
                                                             var channel_code=$(this).attr("rel");
                                                             var url = "view_channel.jsp?channel_code="+channel_code;
                                                             window.location.href = url;
                                                        });

                                                    });
                                                </script>
                                                <!-------- subscribe like dislike  ------->
                                                <div class="row mt-3">
                                                    <div class="col-sm-12">
                                                        <div class="row ">
                                                            <div class="col-sm-1" style="margin-top:-10px;"  >
                                                               <img src="channel_img/<%=channel_img%>.jpg" id="channel_img"rel="<%=channel_code%>"style="padding:6px;cursor: pointer;height:60px;width:60px;border-radius:50%;"> 
                                                            </div>
                                                            <div class="col-sm-3" >
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <span><b><%=channel_name%></b> </span>
                                                                    </div>
                                                                    <div class="col-sm-12 ">
                                                                        <span><small>8.25M subscribers</small></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <script>
                                                                $(document).ready(function() {
                                                                    $(".py-2.Subscribe").on("click", function() {
                                                                        var subs_channel_code = $(this).attr("rel");

                                                                        $.post(
                                                                                "subscribe.jsp", {subs_channel_code: subs_channel_code}, function(data) {

                                                                            data = data.trim();

                                                                            if (data === 'success' || data === 'subscribed') {
                                                                                $(".py-2.Subscribe").css("background-color", "#FFFFFF");
                                                                                $(".py-2.Subscribe").css("color", "black");
                                                                                $("#Subscribe").text("Subscribed");
                                                                            }
                                                                            else if (data === 'unsubscribed') {
                                                                                $(".py-2.Subscribe").css("background-color", "black");
                                                                                $(".py-2.Subscribe").css("color", "#FFFFFF");
                                                                                $("#Subscribe").text("Subscribe");

                                                                            }
                                                                            else {
                                                                                alert("You can't subscribe yourself");

                                                                            }
                                                                        });
                                                                    });
                                                                });

                                                            </script>
                                                            <div class="col-sm-2 mt-1" >
                                                                <%
                                                                    if (subscribe == 1) {
                                                                %>
                                                                <button class="py-2 Subscribe" rel="<%=channel_img%>"style="background-color: #FFFFFF; color:black ; border-radius:30px;font-size:13px; width:100px"><b id="Subscribe">Subscribed</b></button>
                                                                <%
                                                                } else {
                                                                %>
                                                                <button class="py-2 Subscribe" rel="<%=channel_img%>"style="background-color: black; color: #FFFFFF ; border-radius:30px;font-size:13px; width:100px"><b  id="Subscribe" >Subscribe</b></button>
                                                                <%
                                                                    }
                                                                %>
                                                            </div> 
                                                            <!----LIKE ---DISLIKE---- STYLE--->                    
                                                            <style>

                                                                .fa.fa-thumbs-up{
                                                                    font-size:22px;  
                                                                    float:left;
                                                                }

                                                                .fa.fa-thumbs-down{
                                                                    font-size:21px;
                                                                }
                                                                .share:hover{
                                                                    background-color: #d3d3d3;
                                                                }
                                                                .py-2.threedot{
                                                                    background-color: #F1F1F1;
                                                                }
                                                                .py-2.threedot:hover{
                                                                    background-color: #d3d3d3;
                                                                }


                                                                .dropdown {
                                                                    position: relative;
                                                                    display: inline-block;
                                                                }

                                                                .dropdown-content.bg-light {
                                                                    display: none;
                                                                    position: absolute;
                                                                    min-width: 160px;
                                                                    padding: 12px 16px;
                                                                    z-index: 1;
                                                                    margin-left: -70px;
                                                                    border-radius:15px;
                                                                    cursor: pointer;
                                                                }

                                                                .dropdown:hover .dropdown-content {
                                                                    display: block;
                                                                }
                                                                .col-sm-12.dropdown.py-3:hover {
                                                                    background-color: #d3d3d3;
                                                                }
                                                                .col-sm-12.dropdown.py-2:hover{
                                                                    background-color: #d3d3d3;
                                                                }
                                                            </style>
                                                            <!------LIKE ---DISLIKE--- STYLE --END--->      
                                                            <!---LIKE---DISLIKE jQuery------->
                                                            <script>
                                                                $(document).ready(function() {
                                                                    var video_id = "";
                                                                    var flag = "";
                                                                    var total_like = "";

                                                                    $(".bg-light.py-2.ml-3.like").on("click", function() {
                                                                        flag = 1;
                                                                        video_id = $(this).attr("rel");
                                                                        $.post(
                                                                                "like.jsp", {video_id: video_id, flag: flag}, function(data) {
                                                                            data = data.trim();
                                                                            var like_number = data.substring(data.indexOf("@") + 1, data.length);
                                                                            data = data.substring(0, data.indexOf("@"));

                                                                            if (data === 'success' || data === 'liked') {

                                                                                $(".fa.fa-thumbs-up.like").css("color", "#332FCC");
                                                                                $(".fa.fa-thumbs-down.dislike").css("color", "#333333");

                                                                                $("#total_like").text(Number.parseInt(like_number));


                                                                            }
                                                                            else if (data === 'unliked') {
                                                                                $(".fa.fa-thumbs-up.like").css("color", "#333333");
                                                                                $("#total_like").text(Number.parseInt(like_number));

                                                                            }
                                                                        }
                                                                        );
                                                                    });
                                                                    //dislike
                                                                    $(".bg-light.py-2.mt-0.dis").on("click", function() {

                                                                        flag = 0;
                                                                        video_id = $(this).attr("rel1");
                                                                        $.post(
                                                                                "like.jsp", {video_id: video_id, flag: flag}, function(data) {
                                                                            data = data.trim();
                                                                            var like_number = data.substring(data.indexOf("@") + 1, data.length);
                                                                            data = data.substring(0, data.indexOf("@"));
                                                                            if (data === 'unlike_success' || data === 'disliked') {
                                                                                $(".fa.fa-thumbs-up.like").css("color", "#333333");
                                                                                $(".fa.fa-thumbs-down.dislike").css("color", "#332FCC");
                                                                                $("#total_like").text(Number.parseInt(like_number));
                                                                            }
                                                                            else if (data === 'undisliked') {
                                                                                $(".fa.fa-thumbs-down.dislike").css("color", "#333333");
                                                                                $("#total_like").text(Number.parseInt(like_number));
                                                                            }

                                                                        }

                                                                        );

                                                                    });

                                                                });


                                                            </script>
                                                            <%
                                                                int views = 0;
                                                                int like = 0;
                                                                int dislike = 0;
                                                                int total_like = 0;
                                                                try {

                                                                    Class.forName("com.mysql.jdbc.Driver");
                                                                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                                                    Statement st = cn.createStatement();
                                                                    Statement st1 = cn.createStatement();
                                                                    Statement st2 = cn.createStatement();
                                                                    ResultSet rs = st.executeQuery("select * from video_like where video_code='" + wcode + "' AND email='" + email + "' ");
                                                                    if (rs.next()) {

                                                                        like = rs.getInt("vlike");
                                                                        dislike = rs.getInt("dislike");

                                                                    }
                                                                    ResultSet rs1 = st1.executeQuery("select count(*) from video_like where video_code='" + wcode + "' AND vlike=" + 1 + " ");

                                                                    if (rs1.next()) {
                                                                        total_like = rs1.getInt(1);
                                                                    }
                                                                    ResultSet rs2 = st2.executeQuery("select count(*) from views where video_code='" + wcode + "'");
                                                                    if (rs2.next()) {
                                                                        views = rs2.getInt(1);
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.print(e.getMessage());
                                                                }

                                                            %>
                                                            <div class="col-sm-3 mt-1" >
                                                                <div class="row">
                                                                    <div class="col-sm-6" id="div1">
                                                                        <button class="bg-light py-2 ml-3 like" rel="<%=wcode%>" style="border-radius:20px; border-top-right-radius: 0px;border-bottom-right-radius:0px;width:80px;border:none">
                                                                            <%
                                                                                if (like == 1) {

                                                                            %>
                                                                            <span><i class="fa fa-thumbs-up like" style="color:#332FCC"></i></span>
                                                                                <%                                                                            } else {
                                                                                %>
                                                                            <span><i class="fa fa-thumbs-up like"></i></span>
                                                                                <%                                                                                    }
                                                                                %>

                                                                            <span style="padding-left: 10px " id="total_like"><%=total_like%></span>
                                                                            <span style="font-size:16px;padding-left: 10px">|</span>
                                                                        </button>

                                                                    </div>
                                                                    <div class="col-sm-6">
                                                                        <button class="bg-light py-2 mt-0 dis" rel1="<%=wcode%>"style="width:40px ;border-radius:20px; border-top-left-radius:0px;border-bottom-left-radius:0px;border:none">
                                                                            <%
                                                                                if (dislike == 1) {
                                                                            %>
                                                                            <i class="fa fa-thumbs-down dislike" style="color:#332FCC"></i>
                                                                            <%                                                                            } else {
                                                                            %>
                                                                            <i class="fa fa-thumbs-down dislike"></i>
                                                                            <%                                                                                }
                                                                            %>
                                                                        </button>
                                                                    </div>
                                                                </div>  
                                                            </div>
                                                            <div class="col-sm-3 mt-1  ">
                                                                <div class="row">
                                                                    <div class="col-sm-6" style="margin-left:-20px">
                                                                        <button  class="share"style="padding:6px;border:none;border-radius: 20px;width:80px">
                                                                            <i class="fa fa-share float-left" style="font-size:18px"></i>
                                                                            <span>Share</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="col-sm-6" style="margin-left:8px">
                                                                        <div class="dropdown">
                                                                            <button class="py-2  threedot" style="border-radius:50px;border:none;width: 40px"> <i class="fa fa-ellipsis-h"></i> </button>
                                                                            <div class="dropdown-content bg-light">
                                                                                <div class="row ">
                                                                                    <div class="col-sm-12 dropdown py-3">
                                                                                        <i class="fa fa-download mt-1"></i><span style="padding:20px">Download</span>
                                                                                    </div>
                                                                                    <div class="col-sm-12 dropdown py-2">
                                                                                        <i class="fa fa-scissors mt-3"></i><span style="padding:20px">Clip</span>
                                                                                    </div>
                                                                                    <div class="col-sm-12 dropdown py-2">
                                                                                        <i class="fa fa-save mt-3"></i><span style="padding:20px">Save</span>
                                                                                    </div>
                                                                                    <div class="col-sm-12 dropdown py-2">
                                                                                        <i class="fa fa-flag mt-3"></i><span style="padding:20px">Report</span>
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
                                                <!----------subscribe like dislike END ------->  
                                                <!-----description work start--------------->
                                                <script>
                                                    $(document).ready(function() {
                                                        var flag = 1;
                                                        $("#myBtn").on("click", function() {
                                                            if (flag === 1) {
                                                                $("#more").css("display", "inline");

                                                                flag = 0;
                                                            }
                                                            else {
                                                                $("#more").css("display", "none");
                                                                flag = 1;
                                                            }
                                                        });
                                                    });
                                                </script>

                                                <style>
                                                    #more {display: none;}

                                                    .row.card{
                                                        background-color:#F1F1F1;
                                                        border-radius:14px;
                                                        width: 630px;

                                                    }

                                                    .row.card:hover{
                                                        background-color: #D3D3D3;
                                                    }
                                                </style>
                                                <div class="row  ml-1 " >
                                                    <div class="col-sm-12  card-body">
                                                        <div class="row card">
                                                            <div class="col-sm-12 mt-3">
                                                                <div class="row">
                                                                    <div class="col-sm-2">
                                                                        <b> <%=views%> Views  </b>
                                                                    </div>
                                                                    <div class="col-sm-6" style="margin-left:-30px">
                                                                        <b><%=video_time%> </b>
                                                                    </div>
                                                                    <div class="col-sm-2"></div>
                                                                </div>
                                                            </div>


                                                            <div class="col-sm-12 mt-2">
                                                                <p><%=wdes%><span id="more"><%=wdes%>
                                                                    </span>
                                                                </p> 
                                                                <button id="myBtn" style="border:none; background: none"><b>Show more</b></button>
                                                            </div>    
                                                        </div>
                                                    </div>
                                                </div> 
                                                <!-----description work END--------------->
                                                <!----comment work start---------------->
                                                <style>
                                                    .comment {
                                                        width: 92%;

                                                        border-left: none;
                                                        border-right: none;
                                                        border-top: none;
                                                        border-bottom-color: black;
                                                        overflow: hidden;
                                                    } 
                                                    .cancel{

                                                        border:none;
                                                        border-radius: 20px; 
                                                        padding:8px ; 
                                                        background: none;
                                                        margin-left: 440px;
                                                        display: none;
                                                    }
                                                    .cancel:hover{

                                                        background-color: #D3D3D3;
                                                    }

                                                    .comment_btn{
                                                        border:none;
                                                        border-radius: 20px; 
                                                        padding:8px ; 
                                                        display: none;

                                                    }
                                                </style>
                                                <style>
                                                    #reply{
                                                        border:none;
                                                        background-color: transparent;font-size:16px;
                                                        padding-left:10px;
                                                        padding-right:10px;
                                                        border-radius: 20px;
                                                    }
                                                    #reply:hover{

                                                        background-color:  #D3D3D3;
                                                    }
                                                    #comment_update_button{
                                                        border:none;
                                                        background-color:#f1f2f4;
                                                        padding:10px;
                                                        border-radius: 10px;
                                                    }
                                                    #comment_update_button:hover{

                                                        background-color:  #D3D3D3;
                                                    }
                                                </style>
                                                <script>
                                                    $(document).ready(function() {

                                                        //comment box click work
                                                        $(".comment").on("click", function() {

                                                            $(".fa.fa-smile-o.ml-3").show();
                                                            $(".cancel").show();
                                                            $(".comment_btn").show();
                                                            $(".comment_btn").css("background-color", "#D3D3D3");
                                                        });
                                                        //cancel button click work
                                                        $(".cancel").on("click", function() {
                                                            $('.comment').val('').empty();
                                                            $(".fa.fa-smile-o.ml-3").hide();
                                                            $(".cancel").hide();
                                                            $(".comment_btn").hide();

                                                        });
                                                        //commment box blue button work   
                                                        $(".comment").keyup(function() {
                                                            var com = $("#com").val();

                                                            if (com.length > 0) {
                                                                $(".comment_btn").removeAttr('disabled');
                                                                $(".comment_btn").css("background-color", "#065fd4");
                                                                $(".comment_btn").css("color", "#fff");
                                                            }
                                                            else {
                                                                $(".comment_btn").attr('disabled', 'disabled');
                                                                $(".comment_btn").css("background-color", "#D3D3D3");
                                                                $(".comment_btn").css("color", "black");
                                                            }
                                                        });


                                                    });




                                                </script>
                                                <!-----comment box style--->

                                                <div class="row mt-4">
                                                    <div class="col-sm-12">
                                                        <textarea id="com" class="comment" rows="2" style="resize : none;"placeholder="Add a comment..."></textarea>

                                                    </div>
                                                    <div class="col-sm-12">
                                                        <i class="fa fa-smile-o ml-3" style="font-size:27px;display:none;"></i>
                                                        <button class="cancel">Cancel</button>
                                                        <button class="comment_btn" rel="<%=wcode%>"disabled>Comment</button>
                                                    </div>

                                                </div>
                                                <!-------------comment work ------------------->   

                                                <script>
                                                    $(document).ready(function() {
                                                        var comment_txt;
                                                        var video_code;
                                                        var cmt_rel;
                                                        $(".comment_btn").on("click", function() {
                                                            comment_txt = $(".comment").val();
                                                            video_code = $(this).attr("rel");

                                                            if (comment_txt.length > 0 && video_code.length > 0) {

                                                                $.post(
                                                                        "comment.jsp", {comment_txt: comment_txt, video_code: video_code}, function(data) {
                                                                    data = data.trim();
                                                                    //success@code
                                                                    cmt_rel = data.substring(data.indexOf("@") + 1);

                                                                    if (data.substring(0, data.indexOf("@")) === 'success') {
                                                                        $("#comment").prepend("<div class='col-sm-12'><div class='row mt-4'><div class='col-sm-1'><span class='card'  style='padding:9px;cursor: pointer;background-color: #DDB487;color:#fff;height:40px;width:40px;border-radius:50%;'><%=name.charAt(0) + "" + lname.charAt(0)%></span></div><div class='col-sm-9'>@<small style='color:black'><%=name%><%=lname%></small></div><div class='col-sm-1'><div class='dropdown' style='margin-top:-10px'><button class='py-2  threedot' style='border-radius:20px;border:none;height: 30px;width: 30px'> <i class='fa fa-ellipsis-v'></i> </button><div class='dropdown-content bg-light'><div class='row '><div class='col-sm-12 dropdown py-3 edit'><i class='fa fa-edit mt-1'></i><span style='padding:20px'>Edit</span></div><div class='col-sm-12 dropdown py-2 delete' rel=" + cmt_rel + "><i class='fa fa-trash mt-3'></i><span style='padding:20px'>Delete</span></div><div class='col-sm-12 dropdown py-2'></div></div></div></div></div></div><div class='row' style='margin-top:-12px'><div class='col-sm-1'></div><div class='col-sm-10' >" + comment_txt + "</div><div class='col-sm-1'></div></div><div class='row mt-4'><div class='col-sm-1'></div><div class='col-sm-2'><i class='fa fa-thumbs-up cmt'    rel5=" + cmt_rel + " ></i><span  rel5=" + cmt_rel + " class='ml-2' style='color:gray;font-size:18px' id='cmt_like'>0</span></div><div class='col-sm-1'><i class='fa fa-thumbs-down cmt ' rel4=" + cmt_rel + "></i></div><div class='col-sm-1'></div><div class='col-sm-1'></div></div><div class='row'><div class='col-sm-11'><hr></div><div class='col-sm-1'></div></div></div></div>");
                                                                        $('.comment').val('').empty();
                                                                        $(".comment_btn").attr('disabled', 'disabled');
                                                                        $(".comment_btn").css("background-color", "#D3D3D3");
                                                                        $(".comment_btn").css("color", "black");
                                                                    }

                                                                }
                                                                );
                                                            }
                                                        });


                                                        // comment like dislike
                                                        var comment_code = "";
                                                        var commnet_flag = "";
                                                        $(".fa.fa-thumbs-up.cmt").on("click", function() {

                                                            commnet_flag = 1;
                                                            comment_code = $(this).attr('rel5');
                                                            $.post(
                                                                    "comment_like.jsp", {comment_code: comment_code, commnet_flag: commnet_flag}, function(data) {

                                                                data = data.trim();
                                                                var like_number = data.substring(data.indexOf("@") + 1, data.length);
                                                                data = data.substring(0, data.indexOf("@"));

                                                                if (data === 'success' || data === 'liked') {
                                                                    // $(this).css("color", "#332FCC");
                                                                    $("[rel5=" + comment_code + "]").css("color", "#332FCC");
                                                                    $("[rel4=" + comment_code + "]").css("color", "#333333");
                                                                    $("span[rel5=" + comment_code + "]").css("color", "#333333");
                                                                    $("span[rel5=" + comment_code + "]").text(Number.parseInt(like_number));
                                                                }
                                                                else if (data === 'unliked') {
                                                                    $("[rel5=" + comment_code + "]").css("color", "#333333");
                                                                    $("span[rel5=" + comment_code + "]").text(Number.parseInt(like_number));
                                                                }
                                                            });
                                                        });
                                                        //dislike comment
                                                        $(".fa.fa-thumbs-down.cmt").on("click", function() {
                                                            commnet_flag = 0;
                                                            comment_code = $(this).attr('rel4');
                                                            $.post(
                                                                    "comment_like.jsp", {comment_code: comment_code, commnet_flag: commnet_flag}, function(data) {

                                                                data = data.trim();
                                                                var like_number = data.substring(data.indexOf("@") + 1, data.length);
                                                                data = data.substring(0, data.indexOf("@"));
                                                                if (data === 'unlike_success' || data === 'disliked') {
                                                                    $("[rel4=" + comment_code + "]").css("color", "#332FCC");
                                                                    $("[rel5=" + comment_code + "]").css("color", "#333333");
                                                                    $("span[rel5=" + comment_code + "]").text(Number.parseInt(like_number));
                                                                }
                                                                else if (data === 'undisliked') {
                                                                    $("[rel4=" + comment_code + "]").css("color", "#333333");
                                                                    $("span[rel5=" + comment_code + "]").text(Number.parseInt(like_number));
                                                                }
                                                            });
                                                        });
                                                    });
                                                </script>

                                                <script>
                                                    $(document).ready(function() {

                                                        $(".col-sm-12.dropdown.py-3.edit").on("click", function() {
                                                            $("#comment_update_" + $(this).attr("rel")).css("display", "block");
                                                            $("#comment_val_to_be_updated_" + $(this).attr("rel")).css("display", "none");


                                                        });
                                                        $(".updateComment").on('click', function() {
                                                            var comm_code = $(this).attr('rel');
                                                            var updatedText = $("[rel=input_" + comm_code + "]").val();

                                                            if (updatedText.length > 0) {
                                                                $.post(
                                                                        "updateComment.jsp", {updatedText: updatedText, comm_code: comm_code}, function(data) {

                                                                    if (data.trim() === "success") {

                                                                        $("#comment_update_" + comm_code).css("display", "none");
                                                                        $("#comment_val_to_be_updated_" + comm_code).text(updatedText);
                                                                        $("#comment_val_to_be_updated_" + comm_code).css("display", "block");

                                                                    }

                                                                });

                                                            }
                                                            else {
                                                                alert("Empty value can't be updated");

                                                            }

                                                        });

                                                        ////commment delete     
                                                        $(".col-sm-12.dropdown.py-2.delete").on("click", function() {

                                                            var delete_cmt_code = $(this).attr('rel');

                                                            if (delete_cmt_code.length > 0) {
                                                                $.post(
                                                                        "comment_delete.jsp", {delete_cmt_code: delete_cmt_code}, function(data) {
                                                                    data = data.trim();

                                                                    if (data === 'comment_deleted') {
                                                                        $("[rel_comment=" + delete_cmt_code + "]").fadeOut();

                                                                    }

                                                                }

                                                                );

                                                            }



                                                        });
                                                    });

                                                </script>
                                                <div class="row" id="comment"></div>
                                                <%
                                                    int dropdown = 0;
                                                    int total_comment_like = 0;
                                                    int cmt_liked = 0;
                                                    int cmt_disliked = 0;
                                                    String video_comment = "";
                                                    String comment_name = "";
                                                    try {

                                                        Class.forName("com.mysql.jdbc.Driver");
                                                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                                        Statement st = cn.createStatement();
                                                        Statement st1 = cn.createStatement();
                                                        Statement st2 = cn.createStatement();
                                                        Statement st3 = cn.createStatement();
                                                        Statement st4 = cn.createStatement();
                                                        Statement st5 = cn.createStatement();
                                                        ResultSet rs = st.executeQuery("select * from comment   where video_code='" + wcode + "' ORDER BY RAND() ");


                                                        while (rs.next()) {

                                                            video_comment = rs.getString("comment");
                                                            ResultSet rs2 = st1.executeQuery("select * from register where email='" + rs.getString("user_email") + "' ");

                                                            while (rs2.next()) {


                                                                ResultSet rs3 = st2.executeQuery("select count(*) from comment_like where comment_code='" + rs.getString("comment_code") + "' AND cmt_like=1 ");

                                                                if (rs3.next()) {

                                                                    total_comment_like = rs3.getInt(1);
                                                                }
                                                                cmt_liked = 0;
                                                                cmt_disliked = 0;
                                                                ResultSet rs4 = st4.executeQuery("select * from comment_like where comment_code='" + rs.getString("comment_code") + "'  AND user_email='" + email + "' ");
                                                                if (rs4.next()) {

                                                                    cmt_liked = rs4.getInt("cmt_like");
                                                                    cmt_disliked = rs4.getInt("cmt_dislike");

                                                                }
                                                                dropdown = 0;
                                                                ResultSet rs5 = st5.executeQuery("select * from comment where comment_code='" + rs.getString("comment_code") + "'  AND user_email='" + email + "' ");

                                                                if (rs5.next()) {

                                                                    dropdown = 1;
                                                                }

                                                %>    

                                                <div class="row" id="comments"   rel_comment="<%=rs.getString("comment_code")%>">
                                                    <div class="col-sm-12">
                                                        <!-----------------comment profile and name show--------------->      
                                                        <div class="row mt-4">
                                                            <div class="col-sm-1 ">
                                                                <span class="card"  style="padding:9px;cursor: pointer;background-color: #DDB487;color:#fff;height:40px;width:40px;border-radius:50%;"><%=rs2.getString("first_name").charAt(0) + "" + rs2.getString("last_name").charAt(0)%></span>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                @<small style="color:black"><%=rs2.getString("first_name")%><%=rs2.getString("last_name")%></small>
                                                            </div>
                                                            <div class="col-sm-6"></div>
                                                            <div class="col-sm-2">
                                                                <%if (dropdown == 1) {%>
                                                                <div class="dropdown" style="margin-top:-10px;">
                                                                    <button class="py-2  threedot" style="border-radius:20px;border:none;height: 30px;width: 30px"> <i class="fa fa-ellipsis-v"></i> </button>
                                                                    <div class="dropdown-content bg-light">
                                                                        <div class="row ">
                                                                            <div class="col-sm-12 dropdown py-3 edit"  rel="<%=rs.getString("comment_code")%>">
                                                                                <i class="fa fa-edit mt-1"></i><span style="padding:20px">Edit</span>
                                                                            </div>
                                                                            <div class="col-sm-12 dropdown py-2 delete" rel="<%=rs.getString("comment_code")%>">
                                                                                <i class="fa fa-trash mt-3"></i><span style="padding:20px">Delete</span>
                                                                            </div>

                                                                        </div>

                                                                    </div>
                                                                </div>
                                                                <%                                                                  } else {
                                                                %>
                                                                <div class="dropdown">
                                                                    <button class="py-2  threedot" style="border-radius:20px;border:none;height: 30px;width: 30px"> <i class="fa fa-ellipsis-v"></i> </button>
                                                                    <div class="dropdown-content bg-light">
                                                                        <div class="row ">

                                                                            <div class="col-sm-12 dropdown py-2">
                                                                                <i class="fa fa-flag mt-3"></i><span style="padding:20px">Report</span>
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                                <%                                                                      }
                                                                %>
                                                            </div>
                                                        </div>
                                                        <!-----------------comment  show--------------->     
                                                        <div class="row" style="margin-top:-12px">
                                                            <div class="col-sm-1"></div>
                                                            <div class="col-sm-10" >

                                                                <!--   <b> this is my comment this is my comment this is my comment this is my comment this is my comment this is my comment</b>-->
                                                                <section id="comment_update_<%=rs.getString("comment_code")%>"  style="display:none">
                                                                    <br>
                                                                    <input type="text" diabled class="form-control"   rel='input_<%=rs.getString("comment_code")%>'value="<%= video_comment%>"/><br>
                                                                    <button id="comment_update_button" rel='<%=rs.getString("comment_code")%>' class="updateComment"  style="float:right">Update</button>
                                                                </section>

                                                                <section id="comment_val_to_be_updated_<%=rs.getString("comment_code")%>"><%= video_comment%></section>

                                                            </div>
                                                            <div class="col-sm-1">

                                                            </div>

                                                        </div>
                                                        <!-----------------comment like dislike show--------------->   
                                                        <div class="row mt-4">
                                                            <div class="col-sm-1 "></div>
                                                            <div class="col-sm-2">
                                                                <%
                                                                    if (cmt_liked == 1) {
                                                                %>
                                                                <i class="fa fa-thumbs-up cmt" style="color:#332FCC"    rel5="<%=rs.getString("comment_code")%>" ></i>
                                                                <%
                                                                } else {
                                                                %> 
                                                                <i class="fa fa-thumbs-up cmt"  rel5="<%=rs.getString("comment_code")%>" ></i>
                                                                <%
                                                                    }
                                                                %>
                                                                <span  rel5="<%=rs.getString("comment_code")%>" class="ml-2" style="color:gray;font-size:18px" id="cmt_like"><%=total_comment_like%></span>


                                                            </div>
                                                            <div class="col-sm-1" style="margin-left:-30px">

                                                                <%
                                                                    if (cmt_disliked == 1) {
                                                                %>
                                                                <i class="fa fa-thumbs-down cmt" style="color:#332FCC" rel4="<%=rs.getString("comment_code")%>"></i>
                                                                <%
                                                                } else {
                                                                %>
                                                                <i class="fa fa-thumbs-down cmt" rel4="<%=rs.getString("comment_code")%>"></i>
                                                                <%
                                                                    }
                                                                %>
                                                            </div>


                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-11">
                                                                <hr>
                                                            </div>
                                                            <div class="col-sm-1"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%      }
                                                        }
                                                    } catch (Exception e) {
                                                        out.print(e.getMessage());
                                                    }
                                                %>
                                            </div>    
                                            <!--- left side video part end------------------------------->
                                            <!--- right side video part start------------------------------->
                                            <div class="col-sm-4 ">

                                                <%

                                                    try {

                                                        Class.forName("com.mysql.jdbc.Driver");
                                                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                                        Statement st = cn.createStatement();
                                                        ResultSet rs = st.executeQuery("select * from video ORDER BY RAND() limit  10");

                                                        while (rs.next()) {


                                                %>
                                                <div class="row">
                                                    <div class="col-sm-6 " >
                                                        <!-- for thumbnail use poster="yt.png"--->
                                                        <a href="watchvideo.jsp?code=<%=rs.getString("code")%>&&title=<%=rs.getString("title")%> &&description=<%=rs.getString("description")%>"> 
                                                            <video width="240"   class="img-fluid" style='border-radius:10px' poster="thumbnail/<%=rs.getString("code")%>.jpg">
                                                                <source src="upload_video/<%=rs.getString("code")%>.mp4" type="video/mp4">
                                                                <source src="movie.ogg" type="video/ogg">

                                                            </video>
                                                        </a>
                                                    </div>  

                                                    <div class="col-sm-6">
                                                        <h6><b><%=rs.getString("title")%></b></h6>
                                                    </div>

                                                </div>
                                                <div class="col-sm-12" style="margin-top:10px"></div>
                                                <%


                                                        }

                                                    } catch (Exception e) {
                                                        out.print(e.getMessage());
                                                    }

                                                %>

                                            </div>
                                        </div>    
                                        <%
                                            // }       
%>
                                    </div>  
                                </div> 
                            </div>
                        </div>
                    </div>
                </div>    
            </div>
        </section>
    </body>
</html>
<%
} else {

    try {

        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
        Statement st = cn.createStatement();
        Statement st1 = cn.createStatement();
        ResultSet rs = st.executeQuery("select * from video where code='" + wcode + "'");
        if (rs.next()) {


            ResultSet rs1 = st1.executeQuery("select * from channel where code='" + rs.getString("channel_code") + "'");
            if (rs1.next()) {

                channel_name = rs1.getString("channel_name");
                channel_img = rs1.getString("code");
            }
        }

    } catch (Exception e) {
        out.print(e.getMessage());
    }


%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>youtube</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"></link>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <style>

            section.example input[type=search] {
                padding: 6px;
                font-size: 17px;
                border: 1px solid grey;
                float: left;
                width: 80%;


            }

            section.example button {
                float: left;
                width: 20%;
                padding: 4px;
                margin-left:-15px;
                color: white;
                font-size: 17px;
                border: 1px solid grey;
                border-left: none;
                cursor: pointer;
                border-top-right-radius:15px;
                border-bottom-right-radius:15px;
            }
            .fa.fa-user-circle.card:hover{
                background-color:#F0F8FF;
                cursor:pointer;
            }


            html,body{

                overflow-x: hidden;
                height: 100%;
            }
            #sidebarmenu{

                height: 100%;
                position: fixed;
                margin-left: -240px;

                overflow-x: hidden; /* Hide horizontal scrollbar */
                overflow-y: scroll; /* Add vertical scrollbar */

                background-color:#fff;

                transition:opacity 1s;
                color:#111;

                transition:margin-left 0.5s;

            }

            /* width */
            ::-webkit-scrollbar {
                width: 10px;

            }

            /* Track */
            ::-webkit-scrollbar-track {
                background: #f1f1f1; 

            }

            /* Handle */
            ::-webkit-scrollbar-thumb {
                background: #888; 
                border-radius:10px;
            }

            /* Handle on hover */
            ::-webkit-scrollbar-thumb:hover {
                background: #555; 
            }
            .menu{
                list-style: none;
                padding: 10px;
                margin:0;

            }

            .menu li a{
                display: block;
                padding:15px;
            }

        </style>
        <script>
                                                    $(document).ready(function() {
                                                        var p = 1;
                                                        $(".glyphicon.glyphicon-menu-hamburger.text-dark").on("click", function() {

                                                            if (p === 1) {
                                                                $("#sidebarmenu").css('margin-left', '0px');
                                                                $("#sidebarmenu").css('margin-top', '0px');
                                                                $("#sidebarmenu").css('top', '0px');
                                                                $('.row.video').css('z-index', ' -1');

                                                                p = 0;
                                                            }
                                                            else {

                                                                $("#sidebarmenu").css('margin-left', '-240px');
                                                                $('.row.video').css('z-index', ' 0');


                                                                p = 1;
                                                            }
                                                        });
                                                    });
        </script>
        <script>
            $(document).ready(function() {
                var file_content = $("#maincontent").html();
                $("#input").on("change", function(event) {
                    var search_value = event.target.value;
                    if (search_value.length > 0) {
                        $.post(
                                "search_result.jsp", {search_value: search_value}, function(data) {
                            $("#maincontent").html(data.trim());
                        });
                    }
                    else {
                        $("#maincontent").html(file_content);
                    }
                });
            });
        </script>
    </head>
    <body>
        <!--.NAV-BAR..-->
        <nav class=" sticky-top card-body bg-light"  >
            <div class="container-fluid" >
                <div class="row">
                    <div class="col-sm-1"   >
                        <span class="glyphicon glyphicon-menu-hamburger text-dark" style="cursor:pointer; font-size:17px;margin-top:12px;float:left" id="sidebar"></span>    
                    </div>
                    <div class="col-sm-2" style="margin-top:8px">
                        <a href="index.jsp"><img src="yt.png"  style="margin-left: -50px; margin-top:-15px;height:55px" id='logo_png'></a>
                    </div>
                    <!---search------>
                    <div class="col-sm-5"style="margin-top:5px">
                        <section class="example" action="/action_page.php" style="margin:auto">
                            <input type="search" id="input" placeholder="Search.." name="search2"  class="form-control"style="border-radius: 15px;">
                            <button type="submit"><i class="fa fa-search  text-dark" style="border-radius: 15px;"></i></button>
                        </section>
                    </div>
                    <!---search-- end---->
                    <div class="col-sm-4">
                        <a href="signin.jsp" class="fa fa-user-circle card" style="text-decoration:none;color:#1E90FF;width:100px;font-size:16px;padding:8px ;border-radius:20px;margin-top:2px;float:right">&nbsp;&nbsp;<span style="font-size:17px;margin-top:-5px">Sign in</span></a>
                    </div>
                </div>
            </div>
        </nav>  
        <!--..NAV-BAR-END.--> 


        <style>
            .sidebar{
                position:fixed;
                top:0px;
                width:100px;
                height:100%;
            }

        </style>
        <!---SIDE BAR ------> 
        <div class="sidebar ">
            <div class="container-fluid bg-light" style=' height:100%;margin-left:-10px;'>
                <div class="row" style="margin-top:85px"> 
                    <!-- Home icon------->                                 
                    <div class="col-sm-12" >
                        <a href="home.jsp"   class="dropdown-item" style='border-radius:10px;' >
                            <center>
                                <i class="fa fa-home" aria-hidden="true" style="font-size:22px;margin-left:-6px"></i> 
                            </center>
                            <small  style="margin-left:0px">Home</small>
                        </a>
                    </div>
                </div>
                <!-- subscription icon------->
                <div class="row" style="margin-top:20px"> 
                    <div class="col-sm-12" >
                        <a href="signin.jsp"   class="dropdown-item" style='border-radius:10px;' >
                            <center>
                                <span class="material-icons" style="font-size:22px;">&#xe064;</span> 
                            </center>

                            <small style="margin-left:-12px">Subscription</small>
                        </a>
                    </div>
                </div>
                <!-- Library icon------->
                <div class="row" style="margin-top:20px"> 
                    <div class="col-sm-12" >
                        <a href="signin.jsp"   class="dropdown-item" style='border-radius:10px;'>
                            <center>
                                <i class="fa fa-film" style="font-size:19px;color:black"></i> 
                            </center>
                            <small style="margin-left:2px">Library</small>
                        </a>
                    </div>
                </div>
                <!-- history icon------->
                <div class="row" style="margin-top:20px"> 
                    <div class="col-sm-12" >
                        <a href="signin.jsp"   class="dropdown-item" style='border-radius:10px;' >
                            <center>
                                <span class="fa fa-history" style="font-size:22px"></span> 
                            </center>

                            <small style="margin-left:2px">History</small>
                        </a>
                    </div>
                </div>
            </div>

            <!--SIDE-BAR-MENU--->     
            <<div id="sidebarmenu" class="bg-light"   >
                <div class='row' id='sidebarmenu_row'>
                    <div class='col-sm-12' style='margin-top:35%'>
                        <ul class="menu">
                            <li>
                                <a href="home.jsp" class='dropdown-item' style='border-radius:10px;' > <span class="fa fa-home" title="Home" style="font-size:19px;"></span> <span style='margin-left:35px'>Home</span></a>
                            </li>
                            <li>
                                <a href="signin.jsp" class='dropdown-item' style='border-radius:10px;' > <span class="material-icons" style="font-size:22px;">&#xe064;</span> <span style='margin-left:30px'>Subscription</span></a>
                            </li>
                            <hr>
                            <li>
                                <a href="signin.jsp" class='dropdown-item' style='border-radius:10px;' > <span class="fa fa-history" style="font-size:19px;"></span> <span style='margin-left:35px'>History</span></a>
                            </li>
                            <li>
                                <a href="signin.jsp" class='dropdown-item' style='border-radius:10px;' > <span class="fa fa-video-camera" aria-hidden="true" style="font-size:19px;"></span> <span style='margin-left:35px'>Your videos</span></a>
                            </li>
                            <hr>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-fire" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Trending</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-music" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Music</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-play-circle" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Movies</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-gamepad" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Gaming</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-newspaper-o" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>News</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-soccer-ball-o" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Sports</span></a>
                            </li>
                            <hr>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-gear" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Settings</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <i class="fa fa-question-circle" aria-hidden="true" style="font-size:19px;"></i> <span style='margin-left:35px'>Help</span></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--.SIDE-BAR-MENU-END..--> 
        </div>  
        <!-- MAIN SCREEN-->
        <section id="maincontent">
            <div class="container " id='video_section' >
                <div class="row">
                    <div class="col-sm-12" >
                        <div class="row video" style='z-index:0;position: relative;margin-top:20px'>
                            <div class='col-sm-12 ' >
                                <div class='row ' >
                                    <div class="col-sm-12 ">   
                                        <div class="row  card-body" style="margin-left:50px">



                                            <div class="col-sm-8 "  >
                                                <div class="row">
                                                    <div class="col-sm-12 ">
                                                        <div class="row">
                                                            <div class="col-sm-12 " style="">
                                                                <!-- for thumbnail use poster="yt.png"--->
                                                                <a> 
                                                                    <video width="650" height="450" autoplay poster="thumbnail/<%=wcode%>.jpg" class="img-fluid" style='border-radius:2px'   controls>
                                                                        <source src="upload_video/<%=wcode%>.mp4" type="video/mp4">
                                                                        <source src="movie.ogg" type="video/ogg">

                                                                    </video>
                                                                </a>
                                                            </div>
                                                            <div class="col-sm-12">
                                                                <h5><b> <%=wtitle%> </b></h5>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-------- subscribe like dislike  ------->
                                                <div class="row mt-3">
                                                    <div class="col-sm-12">
                                                        <div class="row ">
                                                            <div class="col-sm-1" style="margin-top:-10px;" >
                                                                <img src="channel_img/<%=channel_img%>.jpg" style="padding:6px;cursor: pointer;height:60px;width:60px;border-radius:50%;">
                                                            </div>
                                                            <div class="col-sm-3" >
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <span><b><%=channel_name%></b> </span>
                                                                    </div>
                                                                    <div class="col-sm-12 ">
                                                                        <span><small>8.25M subscribers</small></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-2 mt-1" >
                                                                <a href="signin.jsp" style="text-decoration:none;color:black"><button class="py-2"style="background-color: black; color:#FFFFFF ; border-radius:30px;font-size:13px; width:100px"><b>Subscribe</b></button></a>
                                                            </div> 
                                                            <!----LIKE ---DISLIKE---- STYLE--->                    
                                                            <style>

                                                                .fa.fa-thumbs-up{
                                                                    font-size:22px;  
                                                                    float:left;
                                                                }

                                                                .fa.fa-thumbs-down{
                                                                    font-size:21px;
                                                                }
                                                                .share:hover{
                                                                    background-color: #d3d3d3;
                                                                }
                                                                .py-2.threedot{
                                                                    background-color: #F1F1F1;
                                                                }
                                                                .py-2.threedot:hover{
                                                                    background-color: #d3d3d3;
                                                                }


                                                                .dropdown {
                                                                    position: relative;
                                                                    display: inline-block;
                                                                }

                                                                .dropdown-content.bg-light {
                                                                    display: none;
                                                                    position: absolute;
                                                                    min-width: 160px;
                                                                    padding: 12px 16px;
                                                                    z-index: 1;
                                                                    margin-left: -70px;
                                                                    border-radius:15px;
                                                                    cursor: pointer;
                                                                }

                                                                .dropdown:hover .dropdown-content {
                                                                    display: block;
                                                                }
                                                                .col-sm-12.dropdown.py-3:hover {
                                                                    background-color: #d3d3d3;
                                                                }
                                                                .col-sm-12.dropdown.py-2:hover{
                                                                    background-color: #d3d3d3;
                                                                }
                                                            </style>
                                                            <!------LIKE ---DISLIKE--- STYLE --END--->      
                                                            <!---LIKE---DISLIKE jQuery------->

                                                            <%

                                                                int total_like = 0;
                                                                int views = 0;
                                                                try {

                                                                    Class.forName("com.mysql.jdbc.Driver");
                                                                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                                                    Statement st = cn.createStatement();
                                                                    Statement st1 = cn.createStatement();

                                                                    ResultSet rs = st.executeQuery("select count(*) from video_like where video_code='" + wcode + "' AND vlike=" + 1 + " ");

                                                                    if (rs.next()) {
                                                                        total_like = rs.getInt(1);
                                                                    }
                                                                    ResultSet rs1 = st1.executeQuery("select count(*) from views where video_code='" + wcode + "' ");
                                                                    if (rs1.next()) {
                                                                        views = rs1.getInt(1);

                                                                    }

                                                                } catch (Exception e) {
                                                                    out.print(e.getMessage());
                                                                }

                                                            %>
                                                            <div class="col-sm-3 mt-1" >
                                                                <div class="row">
                                                                    <div class="col-sm-6">
                                                                        <a href="signin.jsp" style="text-decoration:none;color:black"><button class="bg-light py-2 ml-3" style="border-radius:20px; border-top-right-radius: 0px;border-bottom-right-radius:0px;width:80px;border:none">
                                                                                <span><i class="fa fa-thumbs-up"></i></span>
                                                                                <span style="padding-left: 10px " id="total_like"><%=total_like%></span>
                                                                                <span style="font-size:16px;padding-left: 10px">|</span>
                                                                            </button></a>

                                                                    </div>
                                                                    <div class="col-sm-6">
                                                                        <a href="signin.jsp" style="text-decoration:none;color:black"><button class="bg-light py-2 mt-0 dis" style="width:40px ;border-radius:20px; border-top-left-radius:0px;border-bottom-left-radius:0px;border:none"><i class="fa fa-thumbs-down"></i></button></a>
                                                                    </div>
                                                                </div>  
                                                            </div>
                                                            <div class="col-sm-3 mt-1  ">
                                                                <div class="row">
                                                                    <div class="col-sm-6" style="margin-left:-20px">
                                                                        <button  class="share"style="padding:6px;border:none;border-radius: 20px;width:80px">
                                                                            <i class="fa fa-share float-left" style="font-size:18px"></i>
                                                                            <span>Share</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="col-sm-6" style="margin-left:8px">
                                                                        <div class="dropdown">
                                                                            <button class="py-2  threedot" style="border-radius:50px;border:none;width: 40px"> <i class="fa fa-ellipsis-h"></i> </button>
                                                                            <div class="dropdown-content bg-light">
                                                                                <div class="row ">
                                                                                    <div class="col-sm-12 dropdown py-3">
                                                                                        <i class="fa fa-download mt-1"></i><span style="padding:20px">Download</span>
                                                                                    </div>
                                                                                    <div class="col-sm-12 dropdown py-2">
                                                                                        <i class="fa fa-scissors mt-3"></i><span style="padding:20px">Clip</span>
                                                                                    </div>
                                                                                    <div class="col-sm-12 dropdown py-2">
                                                                                        <i class="fa fa-save mt-3"></i><span style="padding:20px">Save</span>
                                                                                    </div>
                                                                                    <div class="col-sm-12 dropdown py-2">
                                                                                        <i class="fa fa-flag mt-3"></i><span style="padding:20px">Report</span>
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
                                                <!----------subscribe like dislike END ------->  
                                                <!-----description work start--------------->
                                                <script>
                                                    $(document).ready(function() {
                                                        var flag = 1;
                                                        $("#myBtn").on("click", function() {
                                                            if (flag === 1) {
                                                                $("#more").css("display", "inline");
                                                                flag = 0;
                                                            }
                                                            else {
                                                                $("#more").css("display", "none");
                                                                flag = 1;
                                                            }
                                                        });
                                                    });
                                                </script>

                                                <style>
                                                    #more {display: none;}

                                                    .row.card{
                                                        background-color:#F1F1F1;
                                                        border-radius:14px;
                                                        width: 630px;

                                                    }

                                                    .row.card:hover{
                                                        background-color: #D3D3D3;
                                                    }
                                                </style>
                                                <div class="row  ml-1 " >
                                                    <div class="col-sm-12  card-body">
                                                        <div class="row card">
                                                            <div class="col-sm-12 mt-3">
                                                                <div class="row">
                                                                    <div class="col-sm-2">
                                                                        <b> <%=views%> Views  </b>
                                                                    </div>
                                                                    <div class="col-sm-6" style="margin-left:-30px">
                                                                        <b><%=video_time%> </b>
                                                                    </div>
                                                                    <div class="col-sm-2"></div>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-12 ">
                                                                <p><%=wdes%>
                                                                    <span id="more"> 
                                                                        <%=wdes%>
                                                                    </span>
                                                                </p> 
                                                                <button id="myBtn" style="border:none; background: none"><b>Show more</b></button>
                                                            </div>    
                                                        </div>
                                                    </div>
                                                </div> 
                                                <!-----description work END--------------->
                                                <!----comment work start---------------->
                                                <script>
                                                    $(document).ready(function() {

                                                        //comment box click work
                                                        $(".comment").on("click", function() {

                                                            $(".fa.fa-smile-o.ml-3").show();
                                                            $(".cancel").show();
                                                            $(".comment_btn").show();
                                                            $(".comment_btn").css("background-color", "#D3D3D3");

                                                        });
                                                        $(".comment_btn").on("click", function() {
                                                            $(location).attr('href', 'signin.jsp');

                                                        });
                                                        //cancel button click work
                                                        $(".cancel").on("click", function() {
                                                            $('.comment').val('').empty();
                                                            $(".fa.fa-smile-o.ml-3").hide();
                                                            $(".cancel").hide();
                                                            $(".comment_btn").hide();
                                                            $(".comment_btn").prop('disabled', true);
                                                            $(".comment_btn").css("color", "black");

                                                        });
                                                        //commment box blue button work   
                                                        $(".comment").keyup(function() {
                                                            var com = $("#com").val();

                                                            if (com.length > 0) {

                                                                $(".comment_btn").css("background-color", "#065fd4");
                                                                $(".comment_btn").prop('disabled', false);
                                                                $(".comment_btn").css("color", "#fff");
                                                            }
                                                            else {

                                                                $(".comment_btn").css("background-color", "#D3D3D3");
                                                                $(".comment_btn").css("color", "black");
                                                                $(".comment_btn").prop('disabled', true);
                                                            }
                                                        });


                                                    });




                                                </script>
                                                <!-----comment box style--->
                                                <style>
                                                    .comment {
                                                        width: 92%;

                                                        border-left: none;
                                                        border-right: none;
                                                        border-top: none;
                                                        border-bottom-color: black;
                                                        overflow: hidden;
                                                    } 
                                                    .cancel{

                                                        border:none;
                                                        border-radius: 20px; 
                                                        padding:8px ; 
                                                        background: none;
                                                        margin-left: 440px;
                                                        display: none;
                                                    }
                                                    .cancel:hover{

                                                        background-color: #D3D3D3;
                                                    }

                                                    .comment_btn{
                                                        border:none;
                                                        border-radius: 20px; 
                                                        padding:8px ; 
                                                        display: none;

                                                    }
                                                </style>
                                                <div class="row mt-4">
                                                    <div class="col-sm-12">
                                                        <textarea id="com" class="comment" rows="2" style="resize : none;"placeholder="Add a comment..."></textarea>

                                                    </div>
                                                    <div class="col-sm-12">
                                                        <i class="fa fa-smile-o ml-3" style="font-size:27px;display:none;"></i>
                                                        <button class="cancel">Cancel</button>
                                                        <button class="comment_btn" disabled >Comment</button>
                                                    </div>
                                                    <div class="col-sm-12">

                                                        <%
                                                            int dropdown = 0;
                                                            int total_comment_like = 0;
                                                            int cmt_liked = 0;
                                                            int cmt_disliked = 0;
                                                            String video_comment = "";
                                                            String comment_name = "";
                                                            try {

                                                                Class.forName("com.mysql.jdbc.Driver");
                                                                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                                                Statement st = cn.createStatement();
                                                                Statement st1 = cn.createStatement();
                                                                Statement st2 = cn.createStatement();
                                                                Statement st3 = cn.createStatement();
                                                                Statement st4 = cn.createStatement();
                                                                Statement st5 = cn.createStatement();
                                                                Statement st6 = cn.createStatement();
                                                                ResultSet rs = st.executeQuery("select * from comment   where video_code='" + wcode + "' ORDER BY RAND() ");


                                                                while (rs.next()) {

                                                                    video_comment = rs.getString("comment");
                                                                    ResultSet rs2 = st1.executeQuery("select * from register where email='" + rs.getString("user_email") + "' ");

                                                                    while (rs2.next()) {


                                                                        ResultSet rs3 = st2.executeQuery("select count(*) from comment_like where comment_code='" + rs.getString("comment_code") + "' AND cmt_like=1 ");

                                                                        if (rs3.next()) {

                                                                            total_comment_like = rs3.getInt(1);
                                                                        }
                                                                        cmt_liked = 0;
                                                                        cmt_disliked = 0;
                                                                        ResultSet rs4 = st4.executeQuery("select * from comment_like where comment_code='" + rs.getString("comment_code") + "'  AND user_email='" + email + "' ");
                                                                        if (rs4.next()) {

                                                                            cmt_liked = rs4.getInt("cmt_like");
                                                                            cmt_disliked = rs4.getInt("cmt_dislike");

                                                                        }
                                                                        dropdown = 0;
                                                                        ResultSet rs5 = st5.executeQuery("select * from comment where comment_code='" + rs.getString("comment_code") + "'  AND user_email='" + email + "' ");

                                                                        if (rs5.next()) {

                                                                            dropdown = 1;
                                                                        }

                                                        %>    

                                                        <div class="row" id="comments"   rel_comment="<%=rs.getString("comment_code")%>">
                                                            <div class="col-sm-12">
                                                                <!-----------------comment profile and name show--------------->      
                                                                <div class="row mt-4">
                                                                    <div class="col-sm-1 ">
                                                                        <span class="card"  style="padding:9px;cursor: pointer;background-color: #DDB487;color:#fff;height:40px;width:40px;border-radius:50%;"><%=rs2.getString("first_name").charAt(0) + "" + rs2.getString("last_name").charAt(0)%></span>
                                                                    </div>
                                                                    <div class="col-sm-3">
                                                                        @<small style="color:black"><%=rs2.getString("first_name")%><%=rs2.getString("last_name")%></small>
                                                                    </div>
                                                                    <div class="col-sm-6"></div>
                                                                    <div class="col-sm-2">
                                                                        <%if (dropdown == 1) {%>
                                                                        <div class="dropdown" style="margin-top:-10px;">
                                                                            <button class="py-2  threedot" style="border-radius:20px;border:none;height: 30px;width: 30px"> <i class="fa fa-ellipsis-v"></i> </button>
                                                                            <div class="dropdown-content bg-light">
                                                                                <div class="row ">
                                                                                    <div class="col-sm-12 dropdown py-3 edit"  rel="<%=rs.getString("comment_code")%>">
                                                                                        <i class="fa fa-edit mt-1"></i><span style="padding:20px">Edit</span>
                                                                                    </div>
                                                                                    <div class="col-sm-12 dropdown py-2 delete" rel="<%=rs.getString("comment_code")%>">
                                                                                        <i class="fa fa-trash mt-3"></i><span style="padding:20px">Delete</span>
                                                                                    </div>

                                                                                </div>

                                                                            </div>
                                                                        </div>
                                                                        <%                                                                  } else {
                                                                        %>
                                                                        <div class="dropdown">
                                                                            <button class="py-2  threedot" style="border-radius:20px;border:none;height: 30px;width: 30px"> <i class="fa fa-ellipsis-v"></i> </button>
                                                                            <div class="dropdown-content bg-light">
                                                                                <div class="row ">

                                                                                    <div class="col-sm-12 dropdown py-2">
                                                                                        <i class="fa fa-flag mt-3"></i><span style="padding:20px">Report</span>
                                                                                    </div>
                                                                                </div>

                                                                            </div>
                                                                        </div>
                                                                        <%                                                                      }
                                                                        %>
                                                                    </div>
                                                                </div>
                                                                <!-----------------comment  show--------------->     
                                                                <div class="row" style="margin-top:-12px">
                                                                    <div class="col-sm-1"></div>
                                                                    <div class="col-sm-10" >

                                                                        <!--   <b> this is my comment this is my comment this is my comment this is my comment this is my comment this is my comment</b>-->
                                                                        <section id="comment_update_<%=rs.getString("comment_code")%>"  style="display:none">
                                                                            <br>
                                                                            <input type="text" diabled class="form-control"   rel='input_<%=rs.getString("comment_code")%>'value="<%= video_comment%>"/><br>
                                                                            <button id="comment_update_button" rel='<%=rs.getString("comment_code")%>' class="updateComment"  style="float:right">Update</button>
                                                                        </section>

                                                                        <section id="comment_val_to_be_updated_<%=rs.getString("comment_code")%>"><%= video_comment%></section>

                                                                    </div>
                                                                    <div class="col-sm-1">

                                                                    </div>

                                                                </div>
                                                                <!-----------------comment like dislike show--------------->   
                                                                <div class="row mt-4">
                                                                    <div class="col-sm-1 "></div>
                                                                    <div class="col-sm-2">
                                                                        <%
                                                                            if (cmt_liked == 1) {
                                                                        %>
                                                                        <i class="fa fa-thumbs-up cmt" style="color:#332FCC"    rel5="<%=rs.getString("comment_code")%>" ></i>
                                                                        <%
                                                                        } else {
                                                                        %> 
                                                                        <i class="fa fa-thumbs-up cmt"  rel5="<%=rs.getString("comment_code")%>" ></i>
                                                                        <%
                                                                            }
                                                                        %>
                                                                        <span  rel5="<%=rs.getString("comment_code")%>" class="ml-2" style="color:gray;font-size:18px" id="cmt_like"><%=total_comment_like%></span>


                                                                    </div>
                                                                    <div class="col-sm-1" style="margin-left:-30px">

                                                                        <%
                                                                            if (cmt_disliked == 1) {
                                                                        %>
                                                                        <i class="fa fa-thumbs-down cmt" style="color:#332FCC" rel4="<%=rs.getString("comment_code")%>"></i>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <i class="fa fa-thumbs-down cmt" rel4="<%=rs.getString("comment_code")%>"></i>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </div>


                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-sm-11">
                                                                        <hr>
                                                                    </div>
                                                                    <div class="col-sm-1"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%      }
                                                                }
                                                            } catch (Exception e) {
                                                                out.print(e.getMessage());
                                                            }
                                                        %>
                                                    </div>
                                                </div>
                                            </div>    
                                            <!--- left side video part end------------------------------->
                                            <!--- right side video part start------------------------------->
                                            <div class="col-sm-4 ">

                                                <%

                                                    try {

                                                        Class.forName("com.mysql.jdbc.Driver");
                                                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                                        Statement st = cn.createStatement();
                                                        ResultSet rs = st.executeQuery("select * from video ORDER BY RAND() limit  10");

                                                        while (rs.next()) {


                                                %>
                                                <div class="row">
                                                    <div class="col-sm-6 " >
                                                        <!-- for thumbnail use poster="yt.png"--->
                                                        <a href="watchvideo.jsp?code=<%=rs.getString("code")%>&&title=<%=rs.getString("title")%> &&description=<%=rs.getString("description")%>"> 
                                                            <video width="240"  class="img-fluid" style='border-radius:10px' poster="thumbnail/<%=rs.getString("code")%>.jpg">
                                                                <source src="upload_video/<%=rs.getString("code")%>.mp4" type="video/mp4">
                                                                <source src="movie.ogg" type="video/ogg">

                                                            </video>
                                                        </a>
                                                    </div>  

                                                    <div class="col-sm-6">
                                                        <h6><b><%=rs.getString("title")%></b></h6>
                                                    </div>

                                                </div>
                                                <div class="col-sm-12" style="margin-top:10px"></div>
                                                <%


                                                        }

                                                    } catch (Exception e) {
                                                        out.print(e.getMessage());
                                                    }

                                                %>

                                            </div>
                                        </div>    
                                        <%
                                            // }       
%>
                                    </div>  
                                </div> 
                            </div>
                        </div>
                    </div>
                </div>    
            </div>
        </section>

    </body>
</html>
<%
    }
%>
