<%-- 
    Document   : orderstatus
    Created on : 19-Apr-2024, 16:06:32
    Author     : DELL
--%>

<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
        }

        form {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }

        label {
            display: none;
        }

        input[type="text"] {
            padding: 8px;
            border-radius: 5px 0 0 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            width: 200px;
        }

        input[type="submit"] {
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
.card {
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    margin: 10px auto; /* Center the card horizontally */
    width: 500px;
    text-align: center;
}

  .img1 {
    max-width: 200px;
    height: auto;
    margin-bottom: 10px;
}

.img2 {
    max-width: 200px; /* Adjust the width as needed */
    height: auto;
    margin-bottom: 10px;
}


    p {
        font-size: 16px;
        font-weight: bold;
        color: #333;
    }
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
    </style>

</head>
<body>
     <div class="navbar">
      <div class="logo">
        <img src="k.gif" alt="Logo">
        <span><b>Bmart</b></span>
      </div>
      <div>
        <a href="index.jsp">Home</a>
        <a href="about.jsp">About Us</a>
        <a href="car.jsp">career</a>
        <a href="cart1.jsp">cart</a>
        <a href="profile.jsp" style="background-color: black; color: white; border-radius: 0;">MY account</a>
      </div>
    </div>
    <h1>Search Orders</h1>
     <form method="get" action="">
        <label for="searchOrderId">Search by ORDERID:</label>
        <div style="position: relative;">
            <input type="text" id="searchOrderId" name="searchOrderId" placeholder="Search...">
            <button type="submit" class="search-button" style="position: absolute; right: 0; top: 0; bottom: 0; background-color: transparent; border: none; cursor: pointer;">
                <i class="fas fa-search" style="padding: 8px;"></i>
            </button>
        </div>
    </form>
    <hr>
    <% 
        String searchOrderId = request.getParameter("searchOrderId");
        String searchUemail = (String) session.getAttribute("b");
        if (searchOrderId != null || searchUemail != null) {
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bmart","bmart123"); 
                Statement st = con.createStatement();
                ResultSet rs = null;
                if (searchOrderId != null && !searchOrderId.isEmpty()) {
                    rs = st.executeQuery("SELECT * FROM ORDERS1 WHERE ORDERID = '" + searchOrderId + "' AND UEMAIL = '" + searchUemail + "'");

                } 
    %>
   <% while (rs.next()) { %>
    <div class="card">
        <%
            String orderStatus = rs.getString("ORDER_STATUS");
            String productId = rs.getString("PRODUCTID");
            String imageSrc = "";
            switch (orderStatus) {
                case "Pending":
                    imageSrc = "pending.gif";
                    break;
                case "Shipped":
                    imageSrc = "shipped.gif";
                    break;
                case "Arrived":
                    imageSrc = "delivered.gif";
                    break;
                case "Delivered":
                    imageSrc = "arrived.gif";
                    break;
                default:
                    imageSrc = "default.png";
                    break;
            }
            PreparedStatement productStatement = con.prepareStatement("SELECT * FROM PRODUCT WHERE PRODUCTID = ?");
          productStatement.setString(1, productId);
          ResultSet productResultSet = productStatement.executeQuery();

          if (productResultSet.next()) {
            String uploadedFileName = productResultSet.getString("UPLOADEDFILENAME");
            String orderDate = formatDate(rs.getString("ORDER_DATE"));
            String expDate = formatDate(rs.getString("EXPECTED_DELIVERY_DATE"));// Format the date
        %> 
        <img class="img1" src="prouductimg/<%= uploadedFileName %>" alt="<%= productResultSet.getString("PRODUCTNAME") %>">
         <p><strong>Order ID:</strong> <%= rs.getString("ORDERID") %></p>
              <p><strong>Quantity:</strong> <%= rs.getString(8) %></p>
            <p><strong>Order Date:</strong> <%= orderDate %></p>
             <p><strong>Delivery Date:</strong> <%= expDate %></p><!-- Use formatted date -->
              <p><strong>Total price:</strong> <%= rs.getString(9) %></p> 
        <img class="img2" src="<%= imageSrc %>" alt="<%= orderStatus %>">
          <p><%= orderStatus %></p>
    </div>
    <% }
} 
                rs.close();
                st.close();
                con.close();
            } 
          catch (Exception e) {
                
            }
        }
    %>
    <%!
private String formatDate(String dateStr) {
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
</body>
</html>
