
<%@page import="java.text.ParseException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.io.*,java.sql.*" %>

<%!private String formatDate(String dateStr) {
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
      %><!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Details</title>
<style>
 /* Global styles */
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
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
  width: 100px;
}

/* Page content styles */
#content {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px;
}

/* Navbar styles */
.navbar {
  width: 100%;
  background-color: #333;
  color: #fff;
  padding: 10px 0;
  text-align: center;
}
.navbar a {
  color: #fff;
  text-decoration: none;
  margin: 0 10px;
}
.navbar a:hover {
  text-decoration: underline;
}

/* Container styles */
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
  margin-bottom: 20px;
}

/* Card styles */
.card {
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 10px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  width: 300px;
}
.card img {
  width: 100%;
  height: auto;
  border-radius: 5px;
  margin-bottom: 10px;
}
.card p {
  margin: 5px 0;
}
.card img1 {
  width: 50%;
  height: auto;
  border-radius: 5px;
  margin-bottom: 10px;
}

/* Button styles */
.shop-now-btn {
  background-color: #0b0b0b;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 10px;
}
.shop-now-btn:hover {
  background-color: #0a81ab;
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
      <% 
      try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");
        String uid = (String) session.getAttribute("b");
        String orderId = request.getParameter("oi");

        PreparedStatement ps = connection.prepareStatement("SELECT * FROM orders1 WHERE SEMAIL = ? and ORDERID=?");
        ps.setString(1, uid);
        ps.setString(2, orderId);
        ResultSet resultSet = ps.executeQuery();

        while (resultSet.next()) {
          String productId = resultSet.getString("PRODUCTID");

          PreparedStatement productStatement = connection.prepareStatement("SELECT * FROM PRODUCT WHERE PRODUCTID = ?");
          productStatement.setString(1, productId);
          ResultSet productResultSet = productStatement.executeQuery();

          if (productResultSet.next()) {
            String uploadedFileName = productResultSet.getString("UPLOADEDFILENAME");
            String orderDate = formatDate(resultSet.getString("ORDER_DATE"));
            String expDate = formatDate(resultSet.getString("EXPECTED_DELIVERY_DATE"));
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
            <p><strong>Delivery Date:</strong> <%= expDate %></p>
            <p><strong>Total price:</strong> <%= resultSet.getString(9) %></p>
            <p><strong>Order Status:</strong> <%= resultSet.getString("ORDER_STATUS") %></p>
             <button onclick="goBack()" class="shop-now-btn">Back</button>
          </div>
        </div>
      </div>
        <%
         PreparedStatement otpStatement = connection.prepareStatement("SELECT * FROM delivery_assignments WHERE ORDER_ID = ?");
    otpStatement.setString(1, orderId);
    ResultSet otpResultSet = otpStatement.executeQuery();
    String email = "";
    if (otpResultSet.next()) {
        email = otpResultSet.getString("email");
        // Get user details based on email
        PreparedStatement us = connection.prepareStatement("SELECT * FROM USERS3 WHERE EMAIL = ?");
        us.setString(1, email);
        ResultSet usr = us.executeQuery();
        while (usr.next()) {
            String name = usr.getString("name");
            String mobile = usr.getString("mobile");
            String address = usr.getString("address");
            String vehicle = usr.getString("vehicle");
%>
      
  
  <div class="container">
    <div class="card">
      <h2>Your delivery boy assigned</h2>
      <img src="dels.webp" alt="Image 3">
      <p>name: <%=name  %></p>
      <p>mobile: <%= mobile%></p>
       <p>Address: <%= address%></p>
       <p>Vehicle: <%= vehicle%></p>
      <button onclick="goBack()" class="shop-now-btn">Back</button>
    </div>
  </div>
  

        
        <%
            }
            } else {
              
           PreparedStatement us = connection.prepareStatement("SELECT * FROM users3 WHERE USERS= ?");
                 us.setString(1,"delivery" );
                  ResultSet usr = us.executeQuery();
                while (usr.next()) {
                    String name = usr.getString("name");
                    String em = usr.getString("email");
                    String mobile = usr.getString("mobile");
                    String address = usr.getString("address");
                    String vehicle = usr.getString("vehicle");%>
            
  
  <div class="container">
    <div class="card">
      <h2>Delivery Boy Not Assigned</h2>
        <img class="img1" src="dels.webp" alt="Image 3">
      <p>Name: <%= name %></p>
       
        <p>Mobile: <%= mobile %></p>
        <p>Address: <%= address %></p>
        <p>Vehicle: <%= vehicle %></p>
       
        <form action="assb.jsp" method="post">
            <input type="hidden" name="email" value="<%= em %>">
            <input type="hidden" name="orderid" value="<%=orderId %>">
            <button type="submit"class="shop-now-btn">Assign Delivery Boy</button>
        </form>
      
     
    </div>
  </div>
  
</div>
        
        <%
           }
}
      %>
      
     
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
         out.println(e);
      }
      %>
    </div>
  </div>

  <!-- JavaScript to show content and hide preloader -->
  <script>
    window.onload = function() {
      document.getElementById("content").style.display = "block";
      document.getElementById("preloader").style.opacity = "0";
      setTimeout(function() {
        document.getElementById("preloader").style.display = "none";
      }, 500);
    };
    function goBack() {
  window.history.back();
}
  </script>
</body>
</html>
