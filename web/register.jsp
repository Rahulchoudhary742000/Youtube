<%-- 
    Document   : register
    Created on : 4 Jan, 2023, 2:26:00 AM
    Author     : 91635
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*"pageEncoding="UTF-8"%>

<%

    if(request.getParameter("fname").length()>0 && request.getParameter("lname").length()>0&& request.getParameter("email").length()>0&&request.getParameter("pass").length()>0){
         int sn=0;
         String fname=request.getParameter("fname").trim();
         String lname=request.getParameter("lname").trim();
         String email=request.getParameter("email").trim();
         String pass=request.getParameter("pass").trim();
        
       try{
       
              Class.forName("com.mysql.jdbc.Driver");
              Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
              PreparedStatement ps=cn.prepareStatement("select email from register where email=?");
              ps.setString(1,email);
              ResultSet rs=ps.executeQuery();
              if(rs.next()){
                  out.print("emailregistered");
              }
              
              else{
               Statement st=cn.createStatement();
               ResultSet rs1=st.executeQuery("select MAX(sn) from register");   
              
                if(rs1.next()){
                     sn=rs1.getInt(1);
                }
                 sn++;
                 
                 LinkedList ls=new LinkedList();
                 for(int i=1;i<9;i++){
                     ls.add(new Integer(i));
                 }
                 for(char c='A'; c<='Z'; c++){
                     ls.add(c);
                 }
                 for(char c='a'; c<='z'; c++){
                     ls.add(c);
                 }
                 String code="";
                 Collections.shuffle(ls);
                 for(int i=0;i<10;i++){
                   code=code+ls.get(i);
                 
                 }
                code=sn+"_"+code;
              
              if(st.executeUpdate("insert into register values('"+code+"','"+sn+"','"+fname+"','"+lname+"','"+email+"','"+pass+"')")>0){
             
                  out.print("success");
              
              }
                
         
            }
    }         
       catch(Exception e){
       
          out.print(e.getMessage());
       }
    }












%>