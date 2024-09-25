<%-- 
    Document   : order
    Created on : 24-Mar-2024, 15:39:33
    Author     : DELL
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%! 
    // Generate a unique order ID
    String generateUniqueOrderID(Connection connection) throws Exception {
        String orderID;
        do {
            orderID = String.format("%06d", (int) (Math.random() * 1000000)); // Generate a random 6-digit number
            PreparedStatement checkPS = connection.prepareStatement("SELECT * FROM Orders1 WHERE orderid = ?");
            checkPS.setString(1, orderID);
            ResultSet checkRS = checkPS.executeQuery();
            if (!checkRS.next()) {
                // Order ID is unique
                checkRS.close();
                checkPS.close();
                return orderID;
            }
            checkRS.close();
            checkPS.close();
        } while (true);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Place Order</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
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

       .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            position: relative;
        }

        .img1 {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
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
          .error {
            color: #d9534f;
          }

        .success {
            color: #5cb85c;
          
        }
    </style>
</head>
<body>
      <!-- Preloader -->
  <div class="preloader" id="preloader">
    <img src="k.gif" alt="Loading..."><br><br>
  </div>
    <div class="navbar">
      <div class="logo">
        <img src="k.gif" alt="Logo">
        <span><b>Bmart</b></span>
      </div>
      <div>
        <a href="index.jsp">Home</a>
        <a href="about.jsp">About Us</a>
        <a href="car.jsp">career</a>
         <a href="cart1.jsp" style="background-color: black; color: white; border-radius: 0;">cart</a>
        <a href="profile.jsp" >MY account</a>
      </div>
    </div>
    <div class="sub-navbar">
      <a href="mobile.jsp.">
        <img src="1.webp" alt="Image 1">
        <span><b>MOBILE</b></span>
      </a>
      <a href="login.jsp">
        <img src="2.webp" alt="Image 2">
        <span><b>LAPTOP</b></span>
      </a>
      <a href="login.jsp">
        <img src="3.webp" alt="Image 3">
        <span><b>COMPONENTS</b></span>
      </a>
      <a href="login.jsp">
        <img src="4.png" alt="Image 4">
        <span><b>CLOTHES</b></span>
      </a>
    </div>

    <div class="container">
        <%
            String productId = request.getParameter("productid");
            String uemail = request.getParameter("uemail");
            String semail = request.getParameter("semail");
            String city = request.getParameter("city");
            String area = request.getParameter("area");
            String address = request.getParameter("address");
         int quantity = 0;
          double totalPrice = 0.0;
         String quantityParam = request.getParameter("qantity");
         String totalPriceParam = request.getParameter("totalprice");
         
            
        
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");

                Date currentDate = new Date();
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(currentDate);
                calendar.add(Calendar.DAY_OF_YEAR, 7);
                Date expectedDeliveryDate = calendar.getTime();

                String orderID = generateUniqueOrderID(connection); 
           // Generate a unique order ID

                  PreparedStatement orderPS = connection.prepareStatement("INSERT INTO Orders1 (orderid, productid, uemail, semail, city, area, address, quantity, totalprice, order_date, expected_delivery_date, order_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                quantity = Integer.parseInt(quantityParam);
                totalPrice = Double.parseDouble(totalPriceParam);
                // Generate a unique order ID
              
                orderPS.setString(1, orderID);
                orderPS.setString(2, productId);
                orderPS.setString(3, uemail);
                orderPS.setString(4, semail);
                orderPS.setString(5, city);
                orderPS.setString(6, area);
                orderPS.setString(7, address);
                orderPS.setInt(8, quantity);
                orderPS.setDouble(9, totalPrice);
                orderPS.setDate(10, new java.sql.Date(currentDate.getTime()));
                orderPS.setDate(11, new java.sql.Date(expectedDeliveryDate.getTime()));
                orderPS.setString(12, "Pending"); 
                //the order status to Pending

                int rowsAffected = orderPS.executeUpdate();

                if (rowsAffected > 0) {
        %>
                    <div class="card success ">
                        <img class="img1" src="sucess.webp" alt="Success Image">
                        <h2>Order Placed Successfully</h2>
                        <img src="od.webp" alt="Image 2" style="display: block; margin: 0 auto; max-width: 50%; height: auto; margin-bottom: 20px;">
                        <p>Your order has been placed. Thank you for shopping with us!</p>
                        <p>Order ID: <%= orderID %></p>
                        <p>Order Date: <%= currentDate %></p>
                        <p>Expected Delivery Date: <%= expectedDeliveryDate %></p>
                        <p>Order Status: Pending</p>
                    </div>
        <%
                } else {
        %>
                    <div class="card error">
                         <img src="error .webp" alt="Error Image">
                        <h2>Failed to Place Order</h2>
                        <p>Sorry, there was an error processing your order. Please try again later.</p>
                    </div>
        <%
                }

                orderPS.close();
                connection.close();
}
      catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='card'><p>An error occurred: " + e + "</p></div>");
            }
        %>
    </div>
      <!-- Footer section -->
  <footer>
    <div class="footer-content">
      <div class="footer-left">
        <h3>Contact Information</h3>
        <p><strong>Email:</strong> Bmart.email@gmail.com</p>
        <p><strong>Phone:</strong> 789012222</p>
        <p><strong>Address:</strong> Trident achademy of technology, Bhubaneswar, India</p>
      </div>
      <div class="footer-right">
        <h3>Contact Us</h3>
        <form action="#" method="POST">
          <input type="text" name="name" placeholder="Your Name" required>
          <input type="email" name="email" placeholder="Your Email" required>
          <textarea name="message" placeholder="Your Message" required></textarea>
          <button type="submit">Send Message</button>
        </form>
      </div>
    </div>
    <div class="footer-bottom">
      <p>&copy; 2024 Bmart. All rights reserved.</p>
    </div>
  </footer>
<script>
  setTimeout(function() {
    const preloader = document.getElementById('preloader');
    const content = document.getElementById('content');
    preloader.style.opacity = 0;
    setTimeout(() => {
      preloader.style.display = 'none';
      content.style.display = 'block';
    }, 500); // Adjust the fade-out delay as needed
  }, 3000); // Adjust the delay before preloader fades out as needed (in milliseconds)
</script>

</body>
</html>
