<%-- 
    Document   : subscribe
    Created on : 29 Jan, 2023, 6:25:57 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" import="java.sql.*"pageEncoding="UTF-8"%>
<%
    String subs_channel_code = request.getParameter("subs_channel_code");
    int sn = 0;
    int flag=1;
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
            ResultSet rs = st1.executeQuery("select * from channel where code='"+subs_channel_code+"' AND email='"+email+"'");
            if(rs.next()){
                  flag=0;
            }
            if(flag==1){
            ResultSet rs1= st1.executeQuery("select MAX(sn) from subscription");
            if (rs1.next()) {
                sn = rs1.getInt(1);
            }
            sn++;
            ResultSet rs2 = st2.executeQuery("select * from subscription where user_email='" + email + "' AND channel_code='" + subs_channel_code + "'");
            if (rs2.next()) {

                if (rs2.getString("status").equals("1")) {
                    if (st3.executeUpdate("update subscription set status=" + 0 + " where channel_code='" + subs_channel_code + "' AND user_email='" + email + "' ") > 0) {

                        out.print("unsubscribed");
                    }
                } else {
                    if (st3.executeUpdate("update subscription set status=" + 1 + " where channel_code='" + subs_channel_code + "' AND user_email='" + email + "' ") > 0) {

                        out.print("subscribed");
                    }

                }


            } else {

                if (st4.executeUpdate("insert into subscription values('" + sn + "','" + subs_channel_code + "','" + email + "'," + 1 + ")") > 0) {

                    out.print("success");

                }

            }
            }
            
            else{
                      out.print("can't subscribe");
            }
        } catch (Exception e) {
            out.print(e.getMessage());
        }
    }



%>