<%-- 
    Document   : update_channel
    Created on : 11 Jan, 2023, 9:12:03 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" import="java.sql.*"pageEncoding="UTF-8"%>

<%
Cookie c[]=request.getCookies();
        String email=null;
        for(int i=0;i<c.length;i++){
                    if(c[i].getName().equals("yt_login")){
                    email=c[i].getValue();
                    break;
                 }
         }
    if(request.getParameter("channel_name").trim().length()>0 && request.getParameter("category").trim().length()>0){
           
            String channel_name=request.getParameter("channel_name");
            String category=request.getParameter("category");
           
         try{   
             
               Class.forName("com.mysql.jdbc.Driver");
               Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
               Statement st=cn.createStatement();
               
                if(st.executeUpdate("update channel set channel_name='"+channel_name+"',category='"+category+"'where email='"+email+"'")>0){
                    
                        out.print("success");
                 }
             
             }
          
             catch(Exception e){
             
                  out.print(e.getMessage());
             
             }
   }
        
        
  %>      