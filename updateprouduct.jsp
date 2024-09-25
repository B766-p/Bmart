<%-- 
    Document   : updateprouduct
    Created on : 15-Mar-2024, 19:08:18
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Update Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f1f1f1;
        }

        .message-card {
            width: 300px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            margin: 0 auto;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }

        .failure {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }

        .message-card h3 {
            margin: 0;
        }
    </style>
</head>
<body>
    <%
        String emailId = request.getParameter("email");
        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String category = request.getParameter("category");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");

            String sql = "UPDATE Product SET productName = ?, description = ?, price = ?, category = ? WHERE emailId = ? AND productId = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, productName);
            statement.setString(2, description);
            statement.setDouble(3, price);
            statement.setString(4, category);
            statement.setString(5, emailId);
            statement.setString(6, productId);

            int rowsUpdated = statement.executeUpdate();
    %>
            <div class="message-card <%= (rowsUpdated > 0) ? "success" : "failure" %>">
                <h3><%= (rowsUpdated > 0) ? "Product updated successfully" : "Failed to update product" %></h3>
            </div>
    <%
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println(e);
        }
    %>
    <script>
        setTimeout(function() {
            window.location.href = "prouductcards.jsp";
        }, 2000); // Redirect to product card page after 5 seconds
    </script>
</body>
</html>
