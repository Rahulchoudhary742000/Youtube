<%-- 
    Document   : signup
    Created on : 3 Jan, 2023, 11:12:56 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>sign in</title>
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
              .invalid_pss{
                 
              }
              
              
           </style>
          
          
          <script>
             $(document).ready(function(){
                  var flag;
                  var fname;
                  var lname;
                  var email;
                  var pass;
                  var confirm;
                  
                 $(".btn.btn-secondary").on("click",function(){
                      $('#sign_in_form_data_load').slideUp();
                      $('#register_form_data_load').slideDown();
                      
              /*   $("#sign").slideUp();
                   $("#register").load('register.jsp');
                     $.post(
                         "register.jsp",{},function(data){
                              $("#sign").slideUp();
                              $("#register").html(data);
                          }
                      );*/
                 });
                 $(".btn.btn-default").on("click",function(){
                   
                      $('#sign_in_form_data_load').slideDown();
                      $('#register_form_data_load').slideUp();
                      
                 });
                //--------form register--------------
                $(".form-control").keyup(function(){
                       fname=$("#fname").val();
                       lname=$("#lname").val();
                       email=$("#rg_email").val();
                       pass=$("#rg_pass").val();
                       confirm=$("#rg_confirm").val();
                       if(fname.length> 0 && lname.length >0 && email.length >0 && pass.length >0 && confirm.length >0){
                            $('.btn.btn-info.btn-block').prop('disabled',false);
                                if(pass===confirm){
                                    $("#rg_confirm").css("border-color","");
                                    $("#missmatch").hide();
                                   $(document).on("click",".btn.btn-info.btn-block",function(){
                                        $.post(                      
                                             "register.jsp",{fname:fname,lname:lname,email:email,pass:pass},function(data){
                                               data=data.trim();
                                              
                                               if(data==='success'){
                                                        $('#sign_in_form_data_load').slideDown();
                                                        $('#register_form_data_load').slideUp();
                                               }
                                               else if(data==="emailregistered"){
                                                  $("#emailregistered").show();
                                                  $("#rg_email").css("border-color","red");
                                               }
                                        });
                                   });
                                }
                               else{
                                   $("#missmatch").show();
                                   $("#emailregistered").hide();
                                   $("#rg_email").css("border-color","");
                                    $("#rg_confirm").css("border-color","red");
                               }
                       }
                       
                  });
                 $(".form-control").keydown(function(){
                      fname=$("#fname").val();
                      lname=$("#lname").val();
                      email=$("#rg_email").val();
                      pass=$("#rg_pass").val();
                      confirm=$("#rg_confirm").val();
                      if(fname.length ===0 || lname.length ===0 || email.length ===0 || pass.length ===0 || confirm.length===0){
                             $('.btn.btn-info.btn-block').prop('disabled',true);
                      }
                 });  
                 
                 //----login--------
                 
                 $(document).on("click",".btn.btn-primary.btn-block",function(){
                     
                       email=$("#login_email").val();
                       pass=$("#login_pass").val();
                      if(email.length >0 && pass.length >0){
                          
                           $.post(                      
                                       "login.jsp",{email:email,pass:pass},function(data){
                                          
                                           data=data.trim();
                                           if(data==='success'){
                                               window.location.replace("home.jsp");
                                           }
                                         else if(data==='invalid_pss'){
                                               $("#invalid_pass").show();
                                               $("#login_pass").css("border-color","red");
                                               $("#login_email").css("border-color","");
                                               $("#enter_pass").hide();
                                               $("#invalid_email").hide();
                                               $("#enter_email").hide();
                                                 
                                           }
                                           else if('invalid_email'){
                                               $("#login_email").css("border-color","red");
                                               $("#login_pass").css("border-color","");
                                               $("#invalid_email").show();
                                               $("#invalid_pass").hide();
                                           
                                               
                                           }
                            });
                        }
                        else if(email.length >0 && pass.length===0){
                            $("#enter_pass").show();
                            $("#invalid_pass").hide();
                            $("#invalid_email").hide();
                            $("#enter_email").hide();
                            $("#login_pass").css("border-color","red");
                            $("#login_email").css("border-color","");
                        }
                      else{
                          $("#enter_email").show();
                          $("#enter_pass").hide();
                           $("#invalid_pass").hide();
                          $("#login_email").css("border-color","red");
                          $("#login_pass").css("border-color","");
                      }
                  });
         });
              // $(' .alert.alert-danger').css('margin-left','10px');
              
          </script>    
    </head>
  <body>
         <div class="container-fluid">
              <div class="row" style="margin-top: 50px"  id="sign_in_form_data_load">
                  <div class="col-sm-3"></div>        
                       <div class="col-sm-6 card  "style="height:470px">
                           <div class="row ">
                               <div class="col-sm-12"></div>
                               <div class="col-sm-12 card-header">
                                     <center><b><h4>SIGN IN</h4></b></center>
                               </div>
                               <div class="col-sm-12">
                                   <div class="row">
                                       <div class="col-sm-12">
                                           <center><img src="yt.png" class="img-fluid"style="height:75px"></center>
                                      </div>
                                  </div>   
                              </div>
                           </div>
                           <div class="row" style="margin-top: 15px">
                               <!---- alert---->
                              
                                <div class="col-sm-12">
                                     <small>Email</small><input type="email" id="login_email" name="email"  Placeholder="Enter Email" class="form-control"  required><br>
                                     <small>Password</small><input type="password" id="login_pass" name="pass" Placeholder="Enter Password"  class="form-control"  required><br>
                                       <div class=" col-sm-12 alert alert-warning"  id='enter_pass'style="display:none;"><b>please enter password</b></div>
                                        <div class=" col-sm-12 alert alert-danger"  id='invalid_pass'style="display:none;"><b>invalid password</b></div>
                                        <div class=" col-sm-12 alert alert-danger"  id='invalid_email' style="display:none;"><b>invalid email</b></div>
                                         <div class=" col-sm-12 alert alert-danger"  id='enter_email' style="display:none;"><b>Please enter valid email</b></div>
                                       <div class="row" style=" margin-top:40px">
                                             <div class="col-sm-6">
                                                  <button class="btn btn-secondary btn-block" style="float:left">Create account</button>
                                             </div>
                                             <div class="col-sm-6">
                                                  <button class="btn btn-primary btn-block"style="float:right">Login</button>
                                             </div>
                                         </div>
                                    </div>
                             </div>    
                          </div>
                   <div class="col-sm-3"></div>
              </div> 
 <!-- sign in form end---------------------------------------------------------------------------->
 <!--  register form----------------------------------------------------------------------->
   <div class="row" style="margin-top: 40px;display:none" id="register_form_data_load">
       <div class="col-sm-3"></div>        
             <div class="col-sm-6 card " style="height:520px" >
                  <div class="row">
                      <div class="col-sm-12 card-header" >
                           <center><b><h4>REGISTER</h4></b></center>
                      </div>
                      <div class="col-sm-12">
                           <div class="row">
                               <div class="col-sm-12">
                                   <center><img src="yt.png" class="img-fluid"style="height:75px"></center>      
                               </div>
                               <div class="col-sm-6" style="top:8px">
                                    <small>First Name</small><input type="text" id="fname" name="fname" Placeholder="First Name" class="form-control"  required >
                               </div>
                               <div class="col-sm-6" style="top:8px;">
                                   <small>Last Name</small><input type="text" id="lname"name="lname" Placeholder="Last Name" class="form-control"  required >
                               </div>
                            </div>   
                       </div>
                    </div>
                    <div class="row" style="margin-top: 30px">
                    
                           <div class="col-sm-12">
                                <small>Email</small> <input type="email" id="rg_email" name="email"  Placeholder="Your email address" class="form-control"  required><br>
                               <!-----alert---->
                                
                                <div class="row" style=" margin-top:5px">
                                      <div class="col-sm-6">
                                           <small>Password</small><input type="password" id="rg_pass" name="pass" Placeholder="Password"  class="form-control"  required>
                                     </div>  
                                     <div class="col-sm-6">
                                          <small>Confirm</small><input type="password" id="rg_confirm" name="pass" Placeholder="Confirm"  class="form-control"  required>
                                    </div>  
                                 </div> 
                                <div class='col-sm-12 alert alert-danger card card-body'  id="missmatch"style="display: none; margin-top: 10px">
                                                 <b> Password Mismatch</b>
                                 </div>
                                <div class='col-sm-12 alert alert-danger card card-body'  id="emailregistered"style="display: none; margin-top: 10px">
                                                 <b> Email Already Registered</b>
                                 </div>
                                 <div class="row" style="margin-top:50px">
                                       <div class="col-sm-6" >
                                            <button class="btn btn-default btn-block" id="Sign_ in_instead"  style="float:left;text-decoration:none">Sign in instead</button>
                                       </div><!-- $('.btn.btn-info.btn-block').prop('disbaled',false) ----->
                                        <div class="col-sm-6">
                                             <button class="btn btn-info btn-block " disabled style="float:right">Register</button>
                                        </div>
                                 </div>
                             </div>
                     </div>
               </div>
            <div class="col-sm-3"></div>
         </div>
      </div>
 </body>
</html>
