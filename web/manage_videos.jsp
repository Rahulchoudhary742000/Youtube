<%-- 
    Document   : index
    Created on : 29 Dec, 2022, 6:38:11 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String channel_code = "";
    String video_code = "";
    String title = "";
    String description = "";
    String category = "";
    String channel_name = "";
    String name = "";
    String lname = "";
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
            ResultSet rs1 = st1.executeQuery("select * from channel where email='" + email + "'");
            ResultSet rs2 = st2.executeQuery("select * from video where email='" + email + "'");
            if (rs.next()) {
                name = rs.getString("first_name");
                lname = rs.getString("last_name");
            }

            if (rs1.next()) {
                channel_name = rs1.getString("channel_name");
                category = rs1.getString("category");
            }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Manage video</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
         <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"></link>
<!--        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>-->
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
                margin-left:250px;
                font-size:25px;
                padding:10px;
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

        <!----notification---->
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
   $(document).ready(function(){
       $("#input").on("change",function(event){
           var search_value=event.target.value;
           
           
           if(search_value.length>0){
                 $.post(
                   "search_result.jsp",{search_value:search_value},function(data){
                   
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

                    <div class="col-sm-5"style="margin-top:5px">
                         <section class="example" action="/action_page.php" style="margin:auto">
                            <input type="search" id="input" placeholder="Search.." name="search2"  class="form-control"style="border-radius: 15px;">
                            <button type="submit"><i class="fa fa-search  text-dark" style="border-radius: 15px;"></i></button>
                        </section>
                    </div>
                    <div class="col-sm-3" style="float:right">
                        <div class="row">

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
                                            <span style="margin-left:20px;">Your Channel</span>
                                        </div>          
                                    </div>
                                    <div class="row" >
                                        <div class="col-sm-12 dropdown-item">
                                            <i class="fa fa-play-circle-o"style="font-size:20px;padding:10px"></i>
                                            <a href="check.jsp" style="margin-left:16px;text-decoration: none;color:black">Your Channel</a>
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
        <!--..NAV-BAR-END.--> 


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
        
        <!-------------------------------------manage videos ------------------------------->
        <section id="maincontent">
        <div class="container-fluid">
            <div class="row ">
                <div class="col-sm12  " style="padding:20px; width:1170px; margin-left:100px">
                    <h2>Channel content</h2>
                    <h1><%=channel_code%></h1>
                    <h1><%=video_code%></h1>
                    <hr>    
                </div>
            </div>
            <div class="row"  style="margin-left:90px">
                <div class="col-sm-12">
                    <table class="table table-bordered" >

                        <tr>
                            <td><b>Videos</b></td>
                            <td><b>Title</b></td>
                            <td><b>Description</b></td>
                            <td><b>Views</b></td>
                            <td><b>Comment</b></td>
                            <td><b>LIke</b></td>
                            <td><b>Edit/Delete</b></td>
                        </tr>
                        <%
                            while (rs2.next()) {
                                video_code = rs2.getString("code");
                                title = rs2.getString("title");
                                description = rs2.getString("description");


                        %>
                        <tr>
                            <td width="200">
                                <a href="watchvideo.jsp?code=<%=video_code%>&&title=<%=title%> &&description=<%=description%>"> 
                                    <video width="230"  class="img-fluid"  poster="thumbnail/<%= video_code%>.jpg"style='border-radius:10px'>
                                        <source src="upload_video/<%= video_code%>.mp4" type="video/mp4">
                                        <source src="movie.ogg" type="video/ogg">
                                    </video>
                                </a>
                            </td>
                            <!------title--->

                            <td>
                                <h6>
                                 <b  id="title_val_to_be_updated_<%=video_code%>"> <%=title%></b>
                                    
                                      
                                </h6>
                            </td>
                            <!------Description--->
                            <td>
                                <small>
                                    <p id="description_val_to_be_updated_<%=video_code%>"><%=description%>
                                    </p>     
                                </small>
                            </td>
                            <!-----Views---->
                            <td>
                                <h5>100</h5>
                            </td> 
                            <!-----comment---->
                            <td>
                                <h5>60</h5>
                            </td> 
                            <!-----like---->
                            <td>
                                <h5>20</h5>
                            </td> 
                            <!-----edit/delete---->
                            <td>
                                <i class="fa fa-edit" rel="<%=title%>" rel1='<%=description%>'rel2=<%=video_code%> data-toggle="modal" data-target="#myModal" aria-hidden="true" style="font-size:18px; padding: 6px; cursor: pointer;color:red"></i>
                                <i class="fa fa-trash" aria-hidden="true" style="font-size:18px;padding: 6px; cursor: pointer"></i>
                            </td>
                        </tr>
                        <%
                                }

                            } catch (Exception e) {
                                out.print(e.getMessage());
                            }
                        %>
                    </table>
                </div>
            </div>  
        </div>
</section>






        <%

            } else {

                response.sendRedirect("index.jsp");


            }

        %>
        <script>
            $(document).ready(function() {
                 var title;
                 var description;
                 var video_code;
                $(".fa.fa-edit").on("click", function() {
                    
                     title= $(this).attr("rel");
                     description=$(this).attr("rel1");
                     video_code=$(this).attr("rel2");
                      $("#title_text").val(title);
                      $("#description_text").val(description);
                     

                });
                $(".btn.btn-success").on("click",function(){
                      title= $("#title_text").val();
                      description=$("#description_text").val();
                   
                   if(title.length>0&&description.length>0){
                       
                       $.post(
                         "Edit_title.jsp",{video_code:video_code,title:title,description:description},function(data){
                             data=data.trim();
                            
                             if(data==='success'){
                                 $("#title_val_to_be_updated_"+video_code).text(title);
                                 $("#description_val_to_be_updated_"+video_code).text(description);
                                 $("[rel2="+video_code+"]").attr("rel",title);
                                  $("[rel2="+video_code+"]").attr("rel1",description);
                             }
                            
                         }   
                     );
                   }
                });
            });
        </script>
        <!-- Modal -->
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
<!--                        <button type="button" class="close" data-dismiss="modal">&times;</button>-->
                        <h4 class="modal-title text-center">Title & Description</h4>
                    </div>
                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class='row'>
                                <div class='col-sm-12 mt-3'>
                                    <label>Title</label>
                                     <input type="text" id='title_text'  class="form-control">
                                </div>
                                 <div class='col-sm-12 mt-5'>
                                     <label>Description</label>
                                     <textarea class='form-control' id='description_text'  rows='8' style='resize:none'></textarea>
                                </div>
                            </div>
                        </div>
                       
                    </div>
                    <div class="modal-footer">
                        <button class='btn btn-success'  data-dismiss="modal">Save</button>
                        <button type="button" class="btn btn-default " data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>
    </body>
</html>
