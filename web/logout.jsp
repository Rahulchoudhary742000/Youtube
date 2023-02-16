<%-- 
    Document   : logout
    Created on : 4 Jan, 2023, 9:02:10 PM
    Author     : 91635
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>logout</title>
    </head>
    <body>
        <% 
      
       Cookie c=new Cookie("yt_login","");
       c.setMaxAge(0);
       response.addCookie(c);
       response.sendRedirect("index.jsp");

      %>
    </body>
</html>
