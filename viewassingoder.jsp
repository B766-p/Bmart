<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*,java.sql.*" %>
<%@page import="java.util.Date"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Assigned Orders</title>
<style>
  /* Card styles */
  .container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
    padding: 20px;
  }
  .card {
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    width: 80%;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: space-between;
  }
  .card div {
    flex: 1;
  }
  .card h2 {
    margin-bottom: 10px;
  }
  .card p {
    margin-bottom: 5px;
  }
  .otp-form-container {
        margin-top: 20px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #f9f9f9;
    }

    /* Form input styles */
    .otp-form-container label {
        display: block;
        margin-bottom: 5px;
    }
    .otp-form-container input[type="text"] {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    /* Submit button styles */
    .otp-form-container button {
        background-color: #4CAF50;
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .otp-form-container button:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
<div class="container">
<%
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bmart","bmart123");

    String email = (String) session.getAttribute("b");
    PreparedStatement otpStatement = connection.prepareStatement("SELECT * FROM delivery_assignments WHERE email = ?");
    otpStatement.setString(1, email);
    ResultSet otpResultSet = otpStatement.executeQuery();
    
    while (otpResultSet.next()) {
        String oderId = otpResultSet.getString("ORDER_ID");

        // Query to fetch product details
        PreparedStatement oderStatement = connection.prepareStatement("SELECT * FROM orders1 WHERE ORDERID = ?");
        oderStatement.setString(1, oderId);
        ResultSet oderResultSet = oderStatement.executeQuery();
        if (oderResultSet.next()) {
            String productId = oderResultSet.getString("PRODUCTID");
            String uemail = oderResultSet.getString("UEMAIL");
            String semail = oderResultSet.getString("SEMAIL");
            String city = oderResultSet.getString("CITY");
            String area = oderResultSet.getString("AREA");
            String address =oderResultSet.getString("ADDRESS");
            int quantity = oderResultSet.getInt("QUANTITY");
            double totalPrice = oderResultSet.getDouble("TOTALPRICE");
            String orderDate = oderResultSet.getString("ORDER_DATE");
            String expectedDeliveryDate = oderResultSet.getString("EXPECTED_DELIVERY_DATE");
            String orderStatus = oderResultSet.getString("ORDER_STATUS");
            if (!orderStatus.equals("Delivered")) {
                PreparedStatement userUStatement = connection.prepareStatement("SELECT * FROM users3 WHERE EMAIL = ?");
                userUStatement.setString(1, uemail);
                ResultSet userUResultSet = userUStatement.executeQuery();
                if (userUResultSet.next()) {
                    String uname = userUResultSet.getString("NAME");
                    String umobile = userUResultSet.getString("MOBILE");
                    PreparedStatement userSStatement = connection.prepareStatement("SELECT * FROM users3 WHERE EMAIL = ?");
                    userSStatement.setString(1, semail);
                    ResultSet userSResultSet = userSStatement.executeQuery();
                    if (userSResultSet.next()) {
                        String sname = userSResultSet.getString("NAME");
                        String smobile = userSResultSet.getString("MOBILE");
        %>
        <div class="card">
            <div>
                <h2>Order Details</h2>
                <p><strong>order ID:</strong> <%= oderId %></p>
                <p><strong>User Mobile:</strong> <%= uname %></p>

                <p><strong>User Mobile:</strong> <%= umobile %></p>
                <p><strong>Address:</strong><%= city %>,<%= area %>, <%= address %></p>
                <p><strong>Quantity:</strong> <%= quantity %></p>
                <p><strong>Total Price:</strong> RS:<%= totalPrice %></p>
                <p><strong>Order Date:</strong> <%= formatDate(orderDate) %></p>
                <p><strong>Expected Delivery Date:</strong> <%= formatDate(expectedDeliveryDate) %></p>
                <p><strong>Order Status:</strong> <%= orderStatus %></p>
            </div>
            <div>
                <h2>Seller Details</h2>
                <p><strong>Seller Name:</strong> <%= sname %></p>
                <p><strong>Seller Mobile:</strong> <%= smobile %></p>
                <% if (orderStatus.equals("Arrived")) { %>
                    <div class="otp-form-container">
    <form method="post" action="votp.jsp">
        <input type="hidden" name="orderId" value="<%= oderId %>">
        <label for="otp">Enter OTP:</label>
        <input type="text" id="otp" name="otp">
        <button type="submit">Verify OTP</button>
    </form>
</div>
                <% } %>
            </div>
        </div>
        <%                
                    }
                }
            }
        }
    }

    otpResultSet.close();
    otpStatement.close();
    connection.close();
} catch (Exception e) {
    out.println("An error occurred: " + e.getMessage());
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
</body>
</html>
