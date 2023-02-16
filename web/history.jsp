<%-- 
    Document   : Subscription
    Created on : 29 Jan, 2023, 5:15:19 PM
    Author     : 91635
--%>

<%@page contentType="text/html" import="java.sql.*"pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String channel_code = "";
    String channel_img = "";
    String channel_name = "";
    String name = "", lname = "";
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
            ResultSet rs = st.executeQuery("select * from register where email='" + email + "'");

            if (rs.next()) {

                name = rs.getString("first_name");
                lname = rs.getString("last_name");
            }




        } catch (Exception e) {
            out.print(e.getMessage());
        }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>History</title>
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
                $("input").on("change", function(event) {
                    var search_value = event.target.value;
                    if (search_value.length > 0) {
                        $.post(
                                "search_result.jsp", {search_value: search_value}, function(data) {
                                 $("#maincontent").html(data.trim());
                        });
                     }
                    else{
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
                            <input type="search" placeholder="Search.." name="search2"   class="form-control"style="border-radius:15px;">
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
            .row.py-2.px-2{
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                cursor:pointer;
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
                        <a href="Subscription.jsp"  class="dropdown-item" style='border-radius:10px;' >
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
        <!--------------------------------main screen-------------------------->
        <script>
            $(document).ready(function() {
                $(".py-2.Subscribe").on("click", function() {
                    var subs_channel_code = $(this).attr("rel");

                    $.post(
                            "subscribe.jsp", {subs_channel_code: subs_channel_code}, function(data) {
                        data = data.trim();
                        if (data === 'unsubscribed') {

                            $("#channel_" + subs_channel_code).fadeOut();

                        }
                    });
                });
                 
               $(".btn.btn-info.clear.history").on("click", function() {
                    $.post(
                       "clear_history.jsp",{},function(data){
                           data=data.trim();
                           if(data==='clearhistory'){
                               
                               $(".col-sm-11.card-body.mt-2").fadeOut();
                               
                           }
                       }     
            
                   );
                     
                });

            });
            
           
            
           

        </script>
        <section id="maincontent">  
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="row ">
                            <div class="col-sm-1"></div>
                            <div class="col-sm-11 card-header bg-secondary text-light mt-5 py-3 px-3" style="border-radius: 5px;  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);">
                                <center><b class="">History</b></center>
                            </div>
                            <div class="col-sm-12" style="margin-top:-37px;margin-left: 60px">
                                <div class="row" >
                                    <div class="col-sm-10"></div>
                                    <div class="col-sm-2">
                                        <button class="btn btn-info clear history">Clear History</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mt-1 ">
                            <%
                                try {

                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                                    Statement st = cn.createStatement();
                                    Statement st1 = cn.createStatement();
                                    Statement st2 = cn.createStatement();
                                    Statement st3 = cn.createStatement();
                                    ResultSet rs = st.executeQuery("select * from register where email='" + email + "'");

                                    while (rs.next()) {

                                        ResultSet rs1 = st1.executeQuery("select * from views where user_code='" + rs.getString("code") + "' AND history="+1+" ");

                                        while (rs1.next()) {
                                            
                                              ResultSet rs2 = st2.executeQuery("select * from video where code='" + rs1.getString("video_code") + "'");
                                              while(rs2.next()){

                            %>
                            <div class="col-sm-1"></div>
                            <div class="col-sm-11 card-body mt-2" >
                                <div class="row">
                                    <div class="col-sm-4 ">
                                        <div class="row">
                                            <div class="col-sm-12 " style="">
                                                <!-- for thumbnail use poster="yt.png"--->
                                                <a href="watchvideo.jsp?code=<%=rs2.getString("code")%>&&title=<%=rs2.getString("title")%> &&description=<%=rs2.getString("description")%>"> 
                                                    <video width="350"  class="" style='border-radius:10px'  poster="thumbnail/<%=rs2.getString("code")%>.jpg">
                                                        <source src="upload_video/<%=rs2.getString("code")%>.mp4" type="video/mp4">
                                                        <source src="movie.ogg" type="video/ogg">
                                                    </video>
                                                </a>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-1"></div>
                                            <div class="col-sm-8">
                                                <h6><%=rs2.getString("title")%></h6>
                                            </div>
                                            <div class="col-sm-3"></div>
                                            
                                            <div class="col-sm-12">
                                                <%
                                                  ResultSet rs3 = st3.executeQuery("select * from channel where code='" + rs2.getString("channel_code") + "'");
                                                    if (rs3.next()) {


                                                %>
                                                <div class="row mt-3">
                                                      <div class="col-sm-1"></div>
                                                    <div class="col-sm-1">
                                                        <img src="channel_img/<%=rs1.getString("channel_code")%>.jpg" style="height:45px;width:45px;border-radius:50%;">
                                                    </div>

                                                    <div class="col-sm-8" >
                                                        <h6><%=rs3.getString("channel_name")%>&nbsp;<span class="fa fa-check-circle"></span></h6>
                                                    </div>
                                                      <div class="col-sm-2"></div>
                                                </div>
                                                <%
                                                    }
                                                %>
                                            </div>
                                            <div class="col-sm-12 mt-3">
                                                <div class="row">
                                                      <div class="col-sm-1"></div>
                                                    <div class="col-sm-8">
                                                        <p >
                                                            <%=rs2.getString("description").length() > 200 ? rs2.getString("description").substring(0, 200).trim() : rs2.getString("description").trim()%>
                                                        </p>
                                                    </div>
                                                    <div class="col-sm-3"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>        
                                </div>
                            </div>
                            <%   }
                                        }
                                    }
                                } catch (Exception e) {

                                    out.print(e.getMessage());
                                }
                            %>


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