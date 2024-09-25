<%-- 
    Document   : ADD_NEW PR
    Created on : 13-Mar-2024, 19:49:37
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Form</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #fff;
        color: #000;
        margin: 0;
        padding: 0;
    }
    .container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .form-container {
        max-width: 400px;
        padding: 20px;
        background-color: blueviolet;
        color: #fff;
        border-radius: 8px;
        margin-left: 200px;
    }
    h1 {
        color: #000;
        text-align: center;
        margin-top: 20px;
    }
    form {
        margin-top: 20px;
    }
    label {
        display: block;
        margin-bottom: 5px;
    }
    input[type="text"],
    input[type="number"],
    select,
    textarea {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        box-sizing: border-box;
    }
    input[type="submit"] {
        background-color: #fff;
        color: #000;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
    }
    input[type="submit"]:hover {
        background-color: #000;
        color: #fff;
    }
    .side-image {
        max-width: 700px;
        height: auto;
        margin-left: auto;
        margin-right: auto;
        display: block;
        margin-top: 20px;
    }
</style>
</head>
<body>
<div class="container">
    <div class="form-container">
        <h1>Add a New Product</h1>
        <form action="upimage.jsp" method="post">
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" required>
            
            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="4" cols="50" required></textarea>
            
            <label for="price">Price:</label>
            <input type="text" id="price" name="price"  required>
            
            <label for="category">Category:</label>
            <select id="category" name="category" required>
                <option value="" disabled selected>Select a category</option>
                <option value="Electronics">Electronics</option>
                <option value="Clothing">Clothing</option>
                <option value="laptop">Laptop</option>
                <option value="mobile">Mobile</option>
                <option value="Others">Others</option>
            </select>
            
            <input type="submit" value="Submit">
        </form>
    </div>
    <img src="ad.gif" alt="Side Image" class="side-image">
</div>
</body>
</html>

