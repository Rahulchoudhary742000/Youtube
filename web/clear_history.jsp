<%-- 
    Document   : clear_history
    Created on : 30 Jan, 2023, 11:27:53 AM
    Author     : 91635
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>

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



        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
            Statement st = cn.createStatement();
            Statement st1= cn.createStatement();
            Statement st2= cn.createStatement();
            ResultSet rs=st.executeQuery("select code from register where email='"+email+"' ");
            if(rs.next()){
                     ResultSet rs1=st1.executeQuery("select * from views where user_code='"+rs.getString("code")+"' ");
                     while(rs1.next()){
                     
                               if(st2.executeUpdate("update views set history="+0+" where user_code='"+rs.getString("code")+"' ")>0){}
                     }
                     
                     out.print("clearhistory");
            }
        }
        catch(Exception e){
            
            out.print(e.getMessage());
        }
     }
%>
