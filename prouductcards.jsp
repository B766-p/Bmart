<%-- 
    Document   : prouductcards
    Created on : 15-Mar-2024, 18:52:04
    Author     : DELL
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Product Card</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f1f1f1;
        }

        .product-card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .product-card {
            width: 300px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            margin: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .product-card img {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        .product-card h3 {
            margin: 0;
            color: #333;
        }

        .product-card p {
            margin: 5px 0;
            color: #666;
        }

        .edit-button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }

        .edit-button:hover {
            background-color: #0056b3;
        }
        .delete-button {
    background-color: #dc3545;
    color: #fff;
    border: none;
    padding: 5px 10px;
    border-radius: 3px;
    cursor: pointer;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    margin-top: 10px;
}

.delete-button:hover {
    background-color: #c82333;
}

    </style>
     <script>
        function showAlert(message) {
            alert(message);
        }
    </script>
</head>
<body>
    <h2>Product Card</h2>
    <div class="product-card-container">
     <%
    String emailId  = (String) session.getAttribute("b");

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");

        if (request.getParameter("deleteProductId") != null) {
            String deleteProductId = request.getParameter("deleteProductId");
            String deleteSql = "DELETE FROM Product WHERE productid = ?";
            PreparedStatement deleteStatement = connection.prepareStatement(deleteSql);
            deleteStatement.setString(1, deleteProductId);
            int deleteResult = deleteStatement.executeUpdate();
            if (deleteResult > 0) {
                 String deleteMessage = "Product with ID " + deleteProductId + " has been deleted.";
                 %> <script>
                    showAlert("<%= deleteMessage %>");
                                </script><%
            } else {
                String deleteMessage = "Product with ID " + deleteProductId + " has been deleted.";

               %> <script>
                    showAlert("<%= deleteMessage %>");
                                </script><%
            }
            deleteStatement.close();
        }

        String sql = "SELECT * FROM Product WHERE emailId = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, emailId);

        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
            String productid = resultSet.getString("productid");
            String productName = resultSet.getString("productName");
            String description = resultSet.getString("description");
            double price = resultSet.getDouble("price");
            String category = resultSet.getString("category");
            String uploadedFileName = resultSet.getString("uploadedFileName");
%>
            <div class="product-card">
                <img src="prouductimg/<%= uploadedFileName %>" alt="<%= productName %>">
                <h3><%= productName %></h3>
                <p>Description: <%= description %></p>
                <p>Price: <%= price %></p>
                <p>Category: <%= category %></p>
                  <a href="eaditProduct.jsp?email=<%= emailId %>&productId=<%= productid %>" class="edit-button">Edit</a>
                <form method="post">
                    <input type="hidden" name="deleteProductId" value="<%= productid %>">
                    <input type="submit" value="Delete" class="delete-button">
                </form>
            </div>
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
    </div>
</body>
</html>


