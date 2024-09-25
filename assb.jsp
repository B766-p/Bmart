<%-- 
    Document   : assb
    Created on : 21-Apr-2024, 17:40:31
    Author     : DELL
--%>

<%@ page import="java.sql.*" %>
<%
// Retrieve form data
String email = request.getParameter("email");
String orderId = request.getParameter("orderid");

// Perform the assignment logic (this is just a basic example)
// You should implement your own logic to assign a delivery boy


// Update the database or perform any other necessary operations
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");
    PreparedStatement ps = connection.prepareStatement("INSERT INTO delivery_assignments (email, order_id) VALUES (?, ?)");
    ps.setString(1, email);
    ps.setString(2, orderId);
    int rowsAffected = ps.executeUpdate();
    if (rowsAffected > 0) {
        out.println("Delivery boy assigned successfully!");
        response.sendRedirect("viewodersS.jsp");
    } else {
        out.println("Failed to assign delivery boy.");
    }
    ps.close();
    connection.close();
} catch (Exception e) {
    out.println("An error occurred: " + e.getMessage());
}
%>
