<%-- 
    Document   : comment_delete
    Created on : 28 Jan, 2023, 11:15:15 PM
    Author     : 91635
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    String delete_cmt_code=request.getParameter("delete_cmt_code");
   
    Cookie c[]=request.getCookies();
        String email=null;
        for(int i=0;i<c.length;i++){
                    if(c[i].getName().equals("yt_login")){
                    email=c[i].getValue();
                    break;
                 }
        }
      if(email !=null && session.getAttribute(email) !=null){
                if(request.getParameter("delete_cmt_code").length()>0){
                      try {

                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                        Statement st = cn.createStatement();
                       
                      if(st.executeUpdate("delete from comment where user_email='"+email+"' AND comment_code='"+delete_cmt_code+"' ")>0){
				
                           out.print("comment_deleted");
                        }
                    
                      }
                      catch(Exception e){
                          out.print(e.getMessage());
                      }
                }
      }
      


%>