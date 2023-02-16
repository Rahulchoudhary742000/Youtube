<%-- 
    Document   : login
    Created on : 4 Jan, 2023, 9:54:25 AM
    Author     : 91635
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>

<%
 
   if(request.getParameter("email").trim().length()>0 && request.getParameter("pass").trim().length()>0){
       
          String email=request.getParameter("email");
          String pass=request.getParameter("pass");
          
       
        try{
			
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                    Statement st=cn.createStatement();
                    ResultSet rs=st.executeQuery("select * from register where email='"+email+"'");

                 
                    if(rs.next()){
                     
                          if(rs.getString("password").equals(pass)){
                              
                           Cookie cr=new Cookie("yt_login",email);
                           cr.setMaxAge(36000);
                           response.addCookie(cr);
                           session.setAttribute(email,pass);
                           session.setMaxInactiveInterval(10000);
                           out.println("success");
                        }
                        else{
                         
                           out.println("invalid_pss");
                        }
                 }
                 else{
                 
                          out.println("invalid_email");
                 
                 }
        }
       catch(Exception e){
       
                 out.print(e.getMessage());
       } 
    }
    


       %>
