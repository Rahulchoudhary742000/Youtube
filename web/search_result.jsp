<%-- 
    Document   : search_result
    Created on : 30 Jan, 2023, 1:11:38 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%


    if (request.getParameter("search_value").trim().length() > 0) {

        String s = request.getParameter("search_value");

        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
            Statement st = cn.createStatement();
            Statement st1 = cn.createStatement();
            Statement st2 = cn.createStatement();
            PreparedStatement ps = cn.prepareStatement("select * from video where title LIKE '%" + s + "%' ");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                
                ResultSet rs1 = st1.executeQuery("select * from channel where code='" + rs.getString("channel_code") + "'");

                                  
%>
<div class="col-sm-1"></div>
<div class="col-sm-11 card-body mt-2" >
    <div class="row">
        <div class="col-sm-4 ">
            <div class="row">
                <div class="col-sm-12 " style="">
                    <!-- for thumbnail use poster="yt.png"--->
                    <a href="watchvideo.jsp?code=<%=rs.getString("code")%>&&title=<%=rs.getString("title")%> &&description=<%=rs.getString("description")%>"> 
                        <video width="350"  class="" style='border-radius:10px'  poster="thumbnail/<%=rs.getString("code")%>.jpg">
                            <source src="upload_video/<%=rs.getString("code")%>.mp4" type="video/mp4">
                            <source src="movie.ogg" type="video/ogg">
                        </video>
                    </a>
                </div>

            </div>
        </div>
        <div class="col-sm-8">
            <div class="row">
                <div class="col-sm-8">
                    <h6><b><%=rs.getString("title")%></b></h6>
                </div>
                 <div class="col-sm-4"></div>
                <div class="col-sm-12">
                    <%
                      if (rs1.next()) {
                                    
                                       
                    %>
                    <div class="row mt-3">
                        <div class="col-sm-1">
                                     <img src="channel_img/<%=rs1.getString("code")%>.jpg" style="height:45px;width:45px;border-radius:50%;">
                        </div>
                          
                       <div class="col-sm-11" >
                           <h6><%=rs1.getString("channel_name")%>&nbsp;<span class="fa fa-check-circle"></span></h6>
                         </div>
                    </div>
                         <%
                      }
                         %>
                </div>
                <div class="col-sm-12 mt-3">
                    <div class="row">
                        <div class="col-sm-8">
                            <p >
                                <%=rs.getString("description").length()>200?rs.getString("description").substring(0,200).trim():rs.getString("description").trim()%>
                            </p>
                        </div>
                        <div class="col-sm-4"></div>
                    </div>
                </div>
            </div>
        </div>        
    </div>
</div>
<%
            }
        } catch (Exception e) {

            out.print(e.getMessage());
        }
    }

%>