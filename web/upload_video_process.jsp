<%-- 
    Document   : upload_video_process
    Created on : 13 Jan, 2023, 12:13:04 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" import="java.sql.*,java.io.*,java.util.*"pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
       
        String vcode=""; 
       String contentType = request.getContentType();
       String videoSave=null;
       byte dataBytes[]=null;
       String saveFile=null;
      
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
           
                LinkedList ls=new LinkedList();
                for(int i=1;i<9;i++){
                    ls.add(new Integer(i));
                }
                for(char ch='A'; ch<='Z'; ch++){
                    ls.add(ch);
                }
                for(char ch='a'; ch<='z'; ch++){
                    ls.add(ch);
                }
                String code="";
                Collections.shuffle(ls);
                for(int i=0;i<10;i++){
                  code=code+ls.get(i);

                }
                vcode=code;
                String file = new String(dataBytes);
              
                 saveFile = vcode+".mp4";
                
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
                 
                FileOutputStream fileOut = new FileOutputStream(request.getRealPath("/")+"/upload_video/"+saveFile);
                
                // fileOut.write(dataBytes);
                fileOut.write(dataBytes, startPos, (endPos - startPos));
                fileOut.flush();
                fileOut.close();
               response.sendRedirect("video_details_form.jsp?code="+vcode);
           
             }  
            catch (Exception e)
            {
              out.println(e.getMessage());
           
              videoSave="Failure";
            }
        }
        
%>