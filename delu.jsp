<%-- 
    Document   : delu
    Created on : 22-Apr-2024, 15:29:21
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
   
    <title>Delete User</title>
</head>
<body>
<%
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");

    String userId = request.getParameter("userId");

    PreparedStatement ps = con.prepareStatement("DELETE FROM users3 WHERE name = ?");
    ps.setString(1, userId);
    int deleted = ps.executeUpdate();

    if (deleted > 0) {
        out.println("<h1>User deleted successfully.</h1>");
        response.sendRedirect("viewu.jsp");
    } else {
        out.println("<h1>Failed to delete user.</h1>");
    }

    con.close();
} catch (Exception e) {
    out.println(e);
}
%>
</body>
</html>
