<%-- 
    Document   : cart
    Created on : 23-Mar-2024, 14:40:33
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%
    // Retrieve the productid parameter from the request
    String productid = request.getParameter("productid");

    // Assuming the user's email is stored in the session
    String email = (String) session.getAttribute("b");

    // Example database connection
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");

        // Check if the product is already in the cart
        PreparedStatement checkPs = connection.prepareStatement("SELECT * FROM Cart WHERE product_id = ? AND email = ?");
        checkPs.setString(1, productid);
        checkPs.setString(2, email);
        ResultSet checkRs = checkPs.executeQuery();

        if (checkRs.next()) {
            // Product already in cart
            out.println("Product already in cart");
        } else {
            // Insert the product into the cart table
            PreparedStatement ps = connection.prepareStatement("INSERT INTO Cart (product_id, email) VALUES (?, ?)");
            ps.setString(1, productid);
            ps.setString(2, email);
            int r = ps.executeUpdate();
            if (r >= 1) {
                out.println("Add to cart successful");
            } else {
                out.println("Add to cart unsuccessful");
            }
            ps.close();
        }

        // Close resources
        checkRs.close();
        checkPs.close();
        connection.close();

        // Redirect to a confirmation page or back to the product page
        response.sendRedirect("cart1.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred: " + e.getMessage());
    }
%>
