<%-- 
    Document   : upload_channel_img
    Created on : 13 Jan, 2023, 6:24:19 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" import="java.io.*,java.sql.* " pageEncoding="UTF-8"%>
<%
       String contentType = request.getContentType();
       String imageSave=null;
       byte dataBytes[]=null;
       String saveFile=null;
       String img_code=request.getParameter("code");
       Cookie c[]=request.getCookies();
       String email=null;
        for(int i=0;i<c.length;i++){
           
                    if(c[i].getName().equals("yt_login")){

                   email=c[i].getValue();
                   break;
                }
        
        }
        if(email !=null){
            if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))
            {
                    DataInputStream in = new DataInputStream(request.getInputStream());
                    int formDataLength = request.getContentLength();
                    dataBytes = new byte[formDataLength];
                    int byteRead = 0;
                    int totalBytesRead = 0;
            while (totalBytesRead < formDataLength)
            {
                    byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                    totalBytesRead += byteRead;
            }
           
            
                String file = new String(dataBytes);
              
                 saveFile = img_code+".jpg";
                
                int lastIndex = contentType.lastIndexOf("=");
                String boundary = contentType.substring(lastIndex + 1, contentType.length());
              
                int pos;
                pos = file.indexOf("filename=\"");
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                int boundaryLocation = file.indexOf(boundary, pos) - 4;
                int startPos = ((file.substring(0, pos)).getBytes()).length;
                int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
            try
             { 
                 
                FileOutputStream fileOut = new FileOutputStream(request.getRealPath("/")+"/channel_img/"+saveFile);
                
                // fileOut.write(dataBytes);
                fileOut.write(dataBytes, startPos, (endPos - startPos));
                fileOut.flush();
                fileOut.close();
              response.sendRedirect("dashboard.jsp?Uploaded successfully");
              
             }  
            catch (Exception e)
            {
              out.println(e.getMessage());
           
              imageSave="Failure";
            }
        }
        }
%>