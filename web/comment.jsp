<%-- 
    Document   : comment
    Created on : 26 Jan, 2023, 10:14:22 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%
    String comment_txt = "";
    String video_code = "";
    String channel_code = "";
    Cookie c[] = request.getCookies();
    String email = null;
    for (int i = 0; i < c.length; i++) {

        if (c[i].getName().equals("yt_login")) {
            email = c[i].getValue();
            break;
        }
    }
    if (email != null && session.getAttribute(email) != null) {

        comment_txt = request.getParameter("comment_txt");
        video_code = request.getParameter("video_code");
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
            Statement st = cn.createStatement();
            Statement st1 = cn.createStatement();
            ResultSet rs = st.executeQuery("select * from video where code='" + video_code + "'");

            if (rs.next()) {
                channel_code = rs.getString("channel_code");
            }

            LinkedList ls = new LinkedList();
            for (int i = 1; i < 9; i++) {
                ls.add(new Integer(i));
            }
            for (char cd = 'A'; cd <= 'Z'; cd++) {
                ls.add(cd);
            }
            for (char cd = 'a'; cd <= 'z'; cd++) {
                ls.add(cd);
            }
            String code = "";
            Collections.shuffle(ls);
            for (int i = 0; i < 9; i++) {
                code = code + ls.get(i);

            }


            if (st1.executeUpdate("insert into comment values('" + video_code + "','" + channel_code + "','" + code + "','" + email + "','" + comment_txt + "')") > 0) {
                out.print("success@" + code);
            }
        } catch (Exception e) {

            out.print(e.getMessage());
        }



    }




%>
