<%-- 
    Document   : yourchanneldetails
    Created on : 11 Jan, 2023, 11:45:19 AM
    Author     : 91635
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
        Cookie c[]=request.getCookies();
        String email=null;
        for(int i=0;i<c.length;i++){
                    if(c[i].getName().equals("yt_login")){
                    email=c[i].getValue();
                    break;
                 }
         }
        
        try{
             
                      Class.forName("com.mysql.jdbc.Driver");
                      Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                      Statement st=cn.createStatement();
                      ResultSet rs=st.executeQuery("select status from channel where email='"+email+"'");   
                      
                      if(rs.next()){
                          
                          
                          if(rs.getInt(1)==1){
                               response.sendRedirect("dashboard.jsp");
                          }
                         
                          else{
                              out.print("channel deleted");
                          }
                         
                      }
                     
                     else{
                         response.sendRedirect("yourchannel.jsp");
                      }  
                      
        }
        catch(Exception e){
        
            out.print(e.getMessage());
        
        }
  
%>
