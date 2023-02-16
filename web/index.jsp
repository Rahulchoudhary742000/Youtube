<%-- 
    Document   : index
    Created on : 29 Dec, 2022, 6:38:11 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" import="java.sql.*"pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Cookie c[] = request.getCookies();
    String email = null;
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("yt_login")) {
            email = c[i].getValue();
            break;
        }
    }
    if (email != null && session.getAttribute(email) != null) {
        response.sendRedirect("home.jsp");

    } else {

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
                $("input").on("change", function(event) {
                    var search_value = event.target.value;


                    if (search_value.length > 0) {
                        $.post(
                                "search_result.jsp", {search_value: search_value}, function(data) {

                            $("#maincontent").html(data.trim());
                        });

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
                    <!---search------>
                    <div class="col-sm-5"style="margin-top:5px">
                        <section class="example" action="/action_page.php" style="margin:auto">
                            <input type="search" placeholder="Search.." name="search2"  class="form-control"style="border-radius: 15px;">
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
                        <a href="#"   class="dropdown-item" style='border-radius:10px;' >
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
                        <a href="#"   class="dropdown-item" style='border-radius:10px;' >
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
                        <a href="#"   class="dropdown-item" style='border-radius:10px;' >
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
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <span class="fa fa-home" title="Home" style="font-size:19px;"></span> <span style='margin-left:35px'>Home</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <span class="material-icons" style="font-size:22px;">&#xe064;</span> <span style='margin-left:30px'>Subscription</span></a>
                            </li>
                            <hr>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <span class="fa fa-history" style="font-size:19px;"></span> <span style='margin-left:35px'>History</span></a>
                            </li>
                            <li>
                                <a href="#" class='dropdown-item' style='border-radius:10px;' > <span class="fa fa-video-camera" aria-hidden="true" style="font-size:19px;"></span> <span style='margin-left:35px'>Your videos</span></a>
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
                                        <div class="row " style="display:flex;margin-left:50px">
                                            <%

                                                try {

                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                                    Statement st = cn.createStatement();
                                                    Statement st1 = cn.createStatement();
                                                    ResultSet rs = st.executeQuery("select * from video ORDER BY RAND() limit  15");

                                                    while (rs.next()) {
                                                     ResultSet rs1 = st1.executeQuery("select * from channel where code='"+rs.getString("channel_code")+"' ");
                            

                                            %>

                                            <div class="col-sm-4 card-body" style="width:33%" >
                                                <div class="row">
                                                    <div class="col-sm-12 ">
                                                        <div class="row">
                                                            <div class="col-sm-12 " style="">
                                                                <!-- for thumbnail use poster="yt.png"--->
                                                                <a href="watchvideo.jsp?code=<%=rs.getString("code")%>&&title=<%=rs.getString("title")%> &&description=<%=rs.getString("description")%>"> 
                                                                    <video width="350"  class="" style='border-radius:10px'  poster="thumbnail/<%=rs.getString("code")%>.jpg">
                                                                        <source src="upload_video/<%=rs.getString("code")%>.mp4" type="video/mp4">
                                                                        <source src="movie.ogg" type="video/ogg">
                                                                    </video>
                                                                </a>
                                                            </div>
                                                            <div class="col-sm-12">
                                                                <h6><%=rs.getString("title")%></h6>
                                                            </div>
                                                            <div class="col-sm-12 d-flex">
                                                                <img src="channel_img/<%=rs.getString("channel_code")%>.jpg" style="height:35px;width:35px;border-radius:50%;">
                                                             <%if(rs1.next()){
                                                                 %>
                                                                &nbsp;<h6><%=rs1.getString("channel_name")%>&nbsp;<span class="fa fa-check-circle"></span></h6>
                                                            <%
                                                                        }
                                                             %>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%


                                                    }

                                                } catch (Exception e) {
                                                    out.print(e.getMessage());
                                                }

                                            %>
                                        </div>  
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