<%-- 
    Document   : upimage.jsp
    Created on : 13-Mar-2024, 19:56:15
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Get form data
    String productName = request.getParameter("productName");
    String description = request.getParameter("description");
    double price = Double.parseDouble(request.getParameter("price"));
    String category = request.getParameter("category");

  
    // Set session attributes
    session.setAttribute("productName", productName);
    session.setAttribute("description", description);
    session.setAttribute("price", price);
    session.setAttribute("category", category);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <title>Input Image With Preview Image</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f1f1f1;
        }

        h3 {
            color: #333;
        }

        form {
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: #fff;
            border-radius: 5px;
        }

        input[type="file"] {
            margin-bottom: 10px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h3>File Upload:</h3>
    <form action="Fileup.jsp" method="post" enctype="multipart/form-data">
        <input type="file" name="file" size="50" />
        <br />
        <input type="submit" value="Upload File" />
    </form>
</body>
</html>

