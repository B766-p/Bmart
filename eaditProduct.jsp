<%-- 
    Document   : eaditProduct
    Created on : 15-Mar-2024, 19:04:13
    Author     : DELL
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Edit Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f1f1f1;
        }

        .edit-form {
            width: 300px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            margin: 0 auto;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 5px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h2>Edit Product</h2>
    <%
        String emailId = request.getParameter("email");
        String productId = request.getParameter("productId");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123"); 

            String sql = "SELECT * FROM Product WHERE emailId = ? AND productId = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, emailId);
            statement.setString(2, productId);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                String productName = resultSet.getString("productName");
                String description = resultSet.getString("description");
                double price = resultSet.getDouble("price");
                String category = resultSet.getString("category");
                String uploadedFileName = resultSet.getString("uploadedFileName");
    %>
                <form class="edit-form" action="updateprouduct.jsp" method="post">
                    <input type="hidden" name="email" value="<%= emailId %>">
                    <input type="hidden" name="productId" value="<%= productId %>">
                    Product Name: <input type="text" name="productName" value="<%= productName %>"><br>
                    Description: <input type="text" name="description" value="<%= description %>"><br>
                    Price: <input type="number" name="price" value="<%= price %>"><br>
                    Category: <input type="text" name="category" value="<%= category %>"><br>
                    <input type="submit" value="Update">
                </form>
    <%
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println(e);
        }
    %>
</body>
</html>

