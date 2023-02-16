<%-- 
    Document   : updateComment
    Created on : 29 Jan, 2023, 4:12:12 PM
    Author     : 91635
--%>

<%@page contentType="text/html"  import='java.sql.*'pageEncoding="UTF-8"%>
<%
    
      String comment_code=request.getParameter("comm_code");
      String inputValue=request.getParameter("updatedText");
    
    Cookie c[]=request.getCookies();
        String email=null;
        for(int i=0;i<c.length;i++){
                    if(c[i].getName().equals("yt_login")){
                    email=c[i].getValue();
                    break;
                 }
        }
      if(email !=null && session.getAttribute(email) !=null){
               
                      try {

                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                        Statement st = cn.createStatement();
                        if(st.executeUpdate("update comment set  comment='"+inputValue+"' where comment_code='"+comment_code+"' AND user_email='"+email+"'")>0){
                            out.println("success");
                        }
    
                      }
                      catch(Exception e){}
    
      }
    
    
    
    
    
    
    
    
    
    
    %>
