<%-- 
    Document   : Edit_title
    Created on : 30 Jan, 2023, 4:15:32 PM
    Author     : 91635
--%>

<%@page contentType="text/html" import="java.sql.*"pageEncoding="UTF-8"%>
<%
String video_code=request.getParameter("video_code");
String title=request.getParameter("title");
String description=request.getParameter("description");

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
            Statement st1= cn.createStatement();
           
            
            if(st1.executeUpdate("update video set title='"+title+"' ,description='"+description+"' where code='"+video_code+"' ")>0){
                 out.print("success");
           }
                
          
           }
           catch(Exception e){
              out.print(e.getMessage());
           }
      }

%>