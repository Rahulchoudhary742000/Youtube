 <%-- 
    Document   : video_details
    Created on : 13 Jan, 2023, 7:12:56 PM
    Author     : 91635
--%>

<%@page contentType="text/html"  import='java.sql.*'pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
         int sn=0;
         String channel_code="";
         String code="";
         String vcode=request.getParameter("code");
         String date=new java.util.Date()+"";
         String title=request.getParameter("title");
         String description=request.getParameter("description");     
         Cookie c[]=request.getCookies();
         String email=null;
        for(int i=0;i<c.length;i++){
           
                    if(c[i].getName().equals("yt_login")){

                   email=c[i].getValue();
                   break;
                }
        
        }
        if(email !=null){
            
      
      try{
			
		 Class.forName("com.mysql.jdbc.Driver");
		 Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
		 Statement st1=cn.createStatement();
                                   Statement st=cn.createStatement();
                                   ResultSet rs=st1.executeQuery("select code from channel where email='"+email+"'");   
                                   if(rs.next()){
                                   
                                      channel_code=rs.getString("code");
                                   }
                 
                                   ResultSet rs1=st1.executeQuery("select MAX(sn) from video");   
                                    if(rs1.next()){
                                     sn=rs1.getInt(1);
                                    }
                                    sn++;
                                  
                                 if(st.executeUpdate("insert into video values("+sn+",'"+vcode+"','"+title+"','"+description+"','"+email+"','"+channel_code+"','"+date+"','1')")>0){
                                          response.sendRedirect("upload_thumbnail.jsp?code="+vcode);
                                   

                                }
                                   
          }
      
          catch(Exception e){
              out.println(e.getMessage());
          }
        }
%>
