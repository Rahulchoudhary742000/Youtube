<%-- 
    Document   : like
    Created on : 24 Jan, 2023, 11:11:00 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    int total_like = 0;
    int flag = Integer.parseInt(request.getParameter("flag"));
    String channel_code = "";
    String video_code = "";
    Cookie c[] = request.getCookies();
    String email = null;
    for (int i = 0; i < c.length; i++) {

        if (c[i].getName().equals("yt_login")) {
            email = c[i].getValue();
            break;
        }
    }
    if (email != null && session.getAttribute(email) != null) {

        video_code = request.getParameter("video_id");


        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
            Statement st = cn.createStatement();
            Statement st1 = cn.createStatement();
            Statement st2 = cn.createStatement();
            Statement st3 = cn.createStatement();
            Statement st4 = cn.createStatement();
            Statement st5 = cn.createStatement();
            Statement st6 = cn.createStatement();
            Statement st7 = cn.createStatement();
            ResultSet rs = st.executeQuery("select * from video where code='" + video_code + "'");
            //channel code retrieve
            if (rs.next()) {
                channel_code = rs.getString("channel_code");
            }
            ResultSet rs2 = st7.executeQuery("select count(*) from video_like where video_code='" + video_code + "' AND vlike=" + 1 + " ");
            if (rs2.next()) {
                total_like = rs2.getInt(1);
            }
            ResultSet rs1 = st1.executeQuery("select * from video_like where video_code='" + video_code + "' AND channel_code='" + channel_code + "' AND email='" + email + "' ");

            if (rs1.next()) {
                String like = rs1.getString("vlike");
                String dislike = rs1.getString("dislike");
                if (like.equals("1") && flag == 1) {
                    st3.executeUpdate("update video_like set vlike=" + 0 + ", dislike=" + 0 + " where video_code='" + video_code + "' AND email='" + email + "' ");
                    total_like -= 1;
                    out.print("unliked@" + total_like);
                } else if (like.equals("0") && flag == 1) {

                    st4.executeUpdate("update video_like set vlike=" + 1 + ",dislike=" + 0 + " where video_code='" + video_code + "' AND email='" + email + "' ");
                    total_like += 1;
                    out.print("liked@" + total_like);

                } else if (dislike.equals("0") && flag == 0) {
                    if (st5.executeUpdate("update video_like set vlike=" + 0 + ",dislike=" + 1 + " where video_code='" + video_code + "' AND email='" + email + "' ") > 0) {
                        if (like.equals("1")) {
                            total_like -= 1;
                        }
                        out.print("disliked@" + total_like);
                    }



                } else if (dislike.equals("1") && flag == 0) {
                    st5.executeUpdate("update video_like set vlike=" + 0 + ",dislike=" + 0 + " where video_code='" + video_code + "' AND email='" + email + "' ");
                    out.print("undisliked@" + total_like);

                }

            } else {
                if (flag == 1) {
                    //video like record insert
                    if (st2.executeUpdate("insert into video_like values('" + video_code + "','" + channel_code + "','" + email + "'," + 1 + "," + 0 + ")") > 0) {
                        total_like += 1;
                        out.print("success@" + total_like);
                    }
                } else if (flag == 0) {

                    if (st2.executeUpdate("insert into video_like values('" + video_code + "','" + channel_code + "','" + email + "'," + 0 + "," + 1 + ")") > 0) {

                        out.print("unlike_success@" + total_like);
                    }

                }

            }



        } catch (Exception e) {

            out.print(e.getMessage());

        }
    }



%>
