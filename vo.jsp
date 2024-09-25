<%-- 
    Document   : vo
    Created on : 22-Apr-2024, 15:48:54
    Author     : DELL
--%>
<%@page import="java.text.ParseException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.io.*,java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Details</title>
<style>
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
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* Three columns */
            gap: 20px; /* Gap between cards */
            margin-bottom: 20px
        }
        .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex; /* Use flexbox for layout */
            flex-direction: column; /* Arrange items in a column */
            align-items: center; /* Center items horizontally */
        }
        .card img {
            max-width: 50%;
            height: auto;
            margin-bottom: 10px;
            align-self: center; /* Center the image */
        }
        .card-details {
            display: grid;
            grid-template-columns: 1fr 1fr; /* Two columns */
            gap: 10px; /* Gap between columns */
        }
        .card-details div {
            padding: 5px;
        }
.shop-now-btn {
    background-color: #0b0b0b; /* Button background color */
    color: white; /* Button text color */
    padding: 10px 20px; /* Button padding */
    border-radius: 20px; /* Button border radius for curved shape */
    border: none; /* Remove button border */
    cursor: pointer; /* Add pointer cursor on hover */
    margin-top: 20px; /* Adjust margin-top as needed */
    font-size: 18px; /* Button text size */
    transition: background-color 0.3s, color 0.3s; /* Smooth transition effect for hover */
  }
  .shop-now-btn:hover {
    background-color: #0a81ab; /* Change background color on hover */
    color: #fff; /* Change text color on hover */
  }
.shop-now-btn1{
    background-color: #0b0b0b; /* Button background color */
    color: white; /* Button text color */
    padding: 10px 20px; /* Button padding */
    border-radius: 20px; /* Button border radius for curved shape */
    border: none; /* Remove button border */
    cursor: pointer; /* Add pointer cursor on hover */
    margin-top: 20px; /* Adjust margin-top as needed */
    font-size: 18px; /* Button text size */
    transition: background-color 0.3s, color 0.3s; /* Smooth transition effect for hover */
  }
  .shop-now-btn1:hover {
    background-color: #0a81ab; /* Change background color on hover */
    color: #fff; /* Change text color on hover */
  }
   .popup {
  display: none;
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
  z-index: 1000; /* Higher z-index to appear above other elements */
  justify-content: center;
  align-items: center;
}

.popup-content {
  background-color: #fff;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
  width: 500px;
  height: 400px; /* Increased maximum height */
  overflow: auto;
  text-align: center;
  /* Additional styling */
  border: 2px solid #ccc;
  color: #333;
}
.popup-content h2 {
  color: #0b0b0b; /* Heading color */
  margin-bottom: 10px;
}

.popup-content p {
  margin-bottom: 10px;
}

.popup-content button {
  background-color: #0b0b0b; /* Button background color */
  color: white; /* Button text color */
  padding: 10px 20px; /* Button padding */
  border-radius: 5px; /* Button border radius */
  border: none; /* Remove button border */
  cursor: pointer; /* Add pointer cursor on hover */
  margin-top: 20px; /* Adjust margin-top as needed */
  font-size: 16px; /* Button text size */
  transition: background-color 0.3s, color 0.3s; /* Smooth transition effect for hover */
}

.popup-content button:hover {
  background-color: #0a81ab; /* Change background color on hover */
}

</style>
</head>
<body>
  <!-- Preloader -->
  <div class="preloader" id="preloader">
    <img src="k.gif" alt="Loading..."><br><br>
  </div>

  <!-- Page content -->
  <div id="content" style="display: none;">
    <!-- Navbar -->
   
    <!-- Order Details Section -->
    <h2>Order Details</h2>
    <div class="container">
      <% try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");
        

        PreparedStatement ps = connection.prepareStatement("SELECT * FROM orders1");
        ResultSet resultSet = ps.executeQuery();

        while (resultSet.next()) {
          String productId = resultSet.getString("PRODUCTID");

          PreparedStatement productStatement = connection.prepareStatement("SELECT * FROM PRODUCT WHERE PRODUCTID = ?");
          productStatement.setString(1, productId);
          ResultSet productResultSet = productStatement.executeQuery();

          if (productResultSet.next()) {
            String uploadedFileName = productResultSet.getString("UPLOADEDFILENAME");
            String orderDate = formatDate(resultSet.getString("ORDER_DATE"));
            String expDate = formatDate(resultSet.getString("EXPECTED_DELIVERY_DATE"));// Format the date
      %>
      <div class="card">
        <img src="prouductimg/<%= uploadedFileName %>" alt="<%= productResultSet.getString("PRODUCTNAME") %>">
        <div class="card-details">
          <div>
            <p><strong>Product Name:</strong> <%= productResultSet.getString("PRODUCTNAME") %></p>
            <p><strong>Description:</strong> <%= productResultSet.getString("DESCRIPTION") %></p>
            <p><strong>Price:</strong> <%= productResultSet.getString("PRICE") %></p>
          </div>
          <div>
            <p><strong>Order ID:</strong> <%= resultSet.getString("ORDERID") %></p>
              <p><strong>Quantity:</strong> <%= resultSet.getString(8) %></p>
            <p><strong>Order Date:</strong> <%= orderDate %></p>
             <p><strong>Delivery Date:</strong> <%= expDate %></p><!-- Use formatted date -->
              <p><strong>Total price:</strong> <%= resultSet.getString(9) %></p>
            <p><strong>Order Status:</strong> <%= resultSet.getString("ORDER_STATUS") %></p>
          </div>
          <% if(resultSet.getString("ORDER_STATUS").equals("Delivered")) { %>
            <button class="shop-now-btn" onclick="showPopup('deliveredPopup', '<%= resultSet.getString("ORDERID") %>')">Delivered</button>
          <% } else { %>
          <a href="assingd.jsp?oi=<%=  resultSet.getString("ORDERID")  %>"><button class="shop-now-btn">Assing delivery boy</button></a>
           
            
          <% } %>
        </div>
      </div>
      <%
            }

            productResultSet.close();
            productStatement.close();
          }

          resultSet.close();
          ps.close();
          connection.close();
        } catch (Exception e) {
          e.printStackTrace();
        }
      %>
      <%!   private String formatDate(String dateStr) {
        try {
          SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
          Date date = inputFormat.parse(dateStr);
          SimpleDateFormat outputFormat = new SimpleDateFormat("dd MMMM yyyy");
          return outputFormat.format(date);
        } catch (ParseException e) {
          e.printStackTrace();
          return dateStr; // Return original date string if parsing fails
        }
      }
      %>
    </div>
  </div>

  <!-- Footer -->
 


  <!-- JavaScript to show content and hide preloader -->
  <script>
    window.onload = function() {
      document.getElementById("content").style.display = "block";
      document.getElementById("preloader").style.opacity = "0";
      setTimeout(function() {
        document.getElementById("preloader").style.display = "none";
      }, 500);
    };
    
    function showPopup(popupId, orderId) {
      document.getElementById(popupId).style.display = "flex";
      document.getElementById(popupId.replace('Popup', 'OrderId')).innerText = orderId; // Display order ID in the popup
    }

    function closePopup(popupId) {
      document.getElementById(popupId).style.display = "none";
    }
  </script>
</body>
</html>
