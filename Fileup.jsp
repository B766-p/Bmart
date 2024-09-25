<%-- 
    Document   : Fileup
    Created on : 13-Mar-2024, 20:08:47
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<html>
<head>

<title>Insert title here</title>
</head>
<body>
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%
MultipartRequest m = new MultipartRequest(request, "C:\\Users\\DELL\\OneDrive\\Documents\\NetBeansProjects\\BMART\\web\\prouductimg");

Enumeration files = m.getFileNames();
while (files.hasMoreElements()) {
    String name = (String)files.nextElement();
    String filename = m.getFilesystemName(name);
    
    // Add filename to session
    
    session.setAttribute("uploadedFileName", filename);
    out.println("Uploaded file name: " + filename);
}

// Redirect to another page
response.sendRedirect("sucessup.jsp");
%>


</body>
</html>

