<%-- 
    Document   : comment_like
    Created on : 27 Jan, 2023, 9:54:02 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" import="java.sql.*"pageEncoding="UTF-8"%>
<%
    String comment_code = request.getParameter("comment_code");
    int comment_flag = Integer.parseInt(request.getParameter("commnet_flag"));
    int total_like = 0;
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
            ResultSet rs = st.executeQuery("select * from comment where comment_code='" + comment_code + "'");

            ResultSet rs2 = st6.executeQuery("select count(*) from comment_like where comment_code='" + comment_code + "' AND cmt_like=" + 1 + " ");
            if (rs2.next()) {
                total_like = rs2.getInt(1);
            }
            if (rs.next()) {

                video_code = rs.getString("video_code");

            }
            ResultSet rs1 = st1.executeQuery("select * from comment_like where comment_code='" + comment_code + "' AND user_email='" + email + "' ");

            if (rs1.next()) {
                String like = rs1.getString("cmt_like");
                String dislike = rs1.getString("cmt_dislike");
                if (like.equals("1") && comment_flag == 1) {
                    st3.executeUpdate("update comment_like set cmt_like=" + 0 + ", cmt_dislike=" + 0 + " where comment_code='" + comment_code + "' AND user_email='" + email + "' ");
                    total_like -= 1;
                    out.print("unliked@" + total_like);
                } else if (like.equals("0") && comment_flag == 1) {

                    st4.executeUpdate("update comment_like set cmt_like=" + 1 + ",cmt_dislike=" + 0 + " where comment_code='" + comment_code + "' AND user_email='" + email + "' ");
                    total_like += 1;
                    out.print("liked@" + total_like);

                } else if (dislike.equals("0") && comment_flag == 0) {
                    if (st5.executeUpdate("update comment_like set cmt_like=" + 0 + ",cmt_dislike=" + 1 + " where comment_code='" + comment_code + "' AND user_email='" + email + "' ") > 0) {
                        if (like.equals("1")) {
                            total_like -= 1;
                        }
                        out.print("disliked@" + total_like);
                    }
                } else if (dislike.equals("1") && comment_flag == 0) {
                    st5.executeUpdate("update comment_like set cmt_like=" + 0 + ",cmt_dislike=" + 0 + " where comment_code='" + comment_code + "' AND user_email='" + email + "' ");
                    out.print("undisliked@" + total_like);

                }

            } //insert like dislike
            else {

                if (comment_flag == 1) {
                    if (st2.executeUpdate("insert into comment_like values('" + video_code + "','" + comment_code + "','" + email + "'," + 1 + "," + 0 + ")") > 0) {
                        total_like += 1;
                        out.print("success@" + total_like);
                    }
                } else if (comment_flag == 0) {

                    if (st2.executeUpdate("insert into comment_like values('" + video_code + "','" + comment_code + "','" + email + "'," + 0 + "," + 1 + ")") > 0) {

                        out.print("unlike_success@" + total_like);
                    }

                }

            }



        } catch (Exception e) {

            out.print(e.getMessage());

        }
    }
%>