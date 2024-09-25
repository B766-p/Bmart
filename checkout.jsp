<%-- 
    Document   : checkout
    Created on : 23-Mar-2024, 19:13:00
    Author     : DELL
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: whitesmoke;
        }
       /* Preloader styles */
.preloader {
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  z-index: 9999;
  background-color: #fff;
  display: flex;
  justify-content: center;
  align-items: center;
  opacity: 1;
  transition: opacity 0.5s ease-in-out;
}
.preloader img {
  width: 350px; /* Adjust size as needed */
  height: 300px; /* Adjust size as needed */
}

/* Navbar styles */
.navbar {
  overflow: hidden;
  background-color: #f8f4f4;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 20px;
}
.navbar a {
  color: rgb(11, 11, 11);
  text-decoration: none;
  padding: 10px;
  border-radius: 50%;
}
.navbar a:hover {
  background-color: #0b0b0b;
  color: rgb(238, 231, 231);
  border-radius: 10%;
}
.navbar img {
  height: 50px;
}
.navbar .logo {
  display: flex;
  align-items: center;
}
.navbar .logo span {
  font-size: 24px; /* Adjust font size as needed */
  margin-left: 10px;
}
.sub-navbar {
  display: flex;
  justify-content: center;
  margin-top: 20px;
  padding-inline: 20px;
}
.sub-navbar a {
  margin: 0 50px; /* Adjust spacing between links as needed */
  text-align: center;
  text-decoration: none;
  color: black;
  display: block;
}
.sub-navbar img {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  margin: 0 50px; /* Adjust spacing between images as needed */
}
.sub-navbar span {
  display: block;
  margin-top: 5px;
  font-size: 14px; /* Adjust font size as needed */
}

/* Footer styles */
footer {
  background-color: #333;
  color: #fff;
  padding: 20px 0;
}
.footer-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}
.footer-left,
.footer-right {
  flex: 1;
}
.footer-left h3,
.footer-right h3 {
  margin-bottom: 10px;
  color: #fff;
}
.footer-left p {
  margin-bottom: 10px;
}
.footer-right form input,
.footer-right form textarea,
.footer-right form button {
  width: 100%;
  margin-bottom: 10px;
  padding: 10px;
  border-radius: 5px;
  border: none;
}
.footer-right form button {
  background-color: #0b0b0b;
  color: #fff;
  cursor: pointer;
}
.footer-right form button:hover {
  background-color: #0a81ab;
}
.footer-bottom {
  text-align: center;
  margin-top: 20px;
}

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .card {
            flex: 1;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            background-color: #fff;
        }

        .card img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        .card p {
            margin: 5px 0;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        input[type="submit"],
        textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #0b0b0b;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0a81ab;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Checkout</h2>

        <%-- Retrieve the product ID and quantity from the request --%>
        <%
        String productId = request.getParameter("productid");
        String quantityParam = request.getParameter("quantity");

        // Check if quantity parameter is not null and not empty
        int quantity = 0; // Default value if quantity is not provided
        if (quantityParam != null && !quantityParam.isEmpty()) {
            try {
                quantity = Integer.parseInt(quantityParam);
            } catch (NumberFormatException e) {
                // Handle the case where quantityParam is not a valid integer
                // You can set a default value, show an error message, etc.
                // For example:
                quantity = 1; // Default to 1
            }
        } else {
            // Handle the case where quantityParam is null or empty
            // You can set a default value, show an error message, etc.
            // For example:
            quantity = 1; // Default to 1
        }

        String uemail = (String) session.getAttribute("b");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");

            PreparedStatement productPS = connection.prepareStatement("SELECT * FROM Product WHERE productid = ?");
            productPS.setString(1, productId);
            ResultSet productRS = productPS.executeQuery();

            if (productRS.next()) {
                String semail = productRS.getString(7);
                String productName = productRS.getString("productName");
                String description = productRS.getString("description");
                double price = productRS.getDouble("price");
                String uploadedFileName = productRS.getString("uploadedFileName");
        %>
        <div class="card-container">
            <!-- Product Details Card -->
            <div class="card">
                <h3>Product Details:</h3>
                <img src="prouductimg/<%= uploadedFileName %>" alt="<%= productName %>">
                <p><strong>Name:</strong> <%= productName %></p>
                <p><strong>Description:</strong> <%= description %></p>
                <p><strong>Price:</strong> <%= price %></p>
                <p><strong>Quantity:</strong> <%= quantity %></p>
                <p><strong>Total Price:</strong> <%= price * quantity %></p>
            </div>

            <!-- Checkout Form Card -->
            <div class="card">
                <h3>Enter Delivery Details:</h3>
                <form action="order.jsp" method="POST">
                    <label for="city">City:</label><br>
                    <input type="text" id="city" name="city" required><br>
                    <label for="area">Area:</label><br>
                    <input type="text" id="area" name="area" required><br>
                    <label for="address">Address:</label><br>
                    <textarea id="address" name="address" required></textarea><br>
                    <input type="hidden" id="product-id" name="productid" value="<%= productId %>">
                    <input type="hidden" id="product-id" name="uemail" value="<%= uemail %>">
                    <input type="hidden" id="product-id" name="semail" value="<%= semail %>">
                         <input type="hidden" id="product-id" name="qantity" value="<%= quantity %>">
                       <input type="hidden" id="product-id" name="totalprice" value="<%=price * quantity  %>">
                    <input type="submit" value="Place Order">
                </form>
            </div>
        </div>
        <%
                } else {
        %>
        <p>Product not found.</p>
        <%
                }
        %>

        <%      
            productRS.close();
            productPS.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>An error occurred: " + e.getMessage() + "</p>");
        }
        %>
    </div>
    
</body>
</html>

