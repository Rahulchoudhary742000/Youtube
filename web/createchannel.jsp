<%-- 
    Document   : createchannel
    Created on : 11 Jan, 2023, 2:38:25 PM
    Author     : 91635
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
     Cookie c[]=request.getCookies();
        String email=null;
        for(int i=0;i<c.length;i++){
                    if(c[i].getName().equals("yt_login")){
                    email=c[i].getValue();
                    break;
                 }
         }
    if(request.getParameter("channel_name").trim().length()>0 && request.getParameter("category").trim().length()>0){
            int sn=0;
            String channel_name=request.getParameter("channel_name");
            String category=request.getParameter("category");
            String date=new java.util.Date()+"";
            
             try{
             
                      Class.forName("com.mysql.jdbc.Driver");
                      Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                      Statement st=cn.createStatement();
                      ResultSet rs1=st.executeQuery("select MAX(sn) from channel");   
              
                        if(rs1.next()){
                             sn=rs1.getInt(1);
                        }
                         sn++;

                        LinkedList ls=new LinkedList();
                        for(int i=1;i<9;i++){
                            ls.add(new Integer(i));
                        }
                        for(char cp='A'; cp<='Z'; cp++){
                            ls.add(cp);
                        }
                        for(char cp='a'; cp<='z'; cp++){
                            ls.add(cp);
                        }
                        String code="";
                        Collections.shuffle(ls);
                        for(int i=0;i<8;i++){
                          code=code+ls.get(i);

                        }
                        code=sn+"_"+code;
                       
                      if(st.executeUpdate("insert into channel values("+sn+",'"+code+"','"+channel_name+"','"+category+"','1','"+date+"','"+email+"')")>0){
             
                          response.sendRedirect("dashboard.jsp");
              
                      }
                 
             }
             
             catch(Exception e){
             
                 out.print(e.getMessage());
             }
        }
        
     

%>
