<%-- 
    Document   : pupdate
    Created on : 23-Mar-2024, 13:30:05
    Author     : DELL
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
            String uid = (String) session.getAttribute("b");
            if (uid != null) {
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bmart","bmart123"); 
                    PreparedStatement ps = con.prepareStatement("UPDATE users3 SET name=?, email=?, mobile=?, upass=? WHERE email=?");
                    ps.setString(1, request.getParameter("first_name"));
                    ps.setString(2, request.getParameter("email_address"));
                    ps.setString(3, request.getParameter("m"));
                    ps.setString(4, request.getParameter("new_password"));
                    ps.setString(5, uid);
                    int rowsUpdated = ps.executeUpdate();
                    if (rowsUpdated > 0) {
                        response.sendRedirect("profile.jsp");
                    } else {
                        out.println("<p class='error'>Failed to update profile. Please try again.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p class='error'>An error occurred: " + e.getMessage() + "</p>");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        %>