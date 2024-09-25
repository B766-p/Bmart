<%-- 
    Document   : cart1
    Created on : 23-Mar-2024, 14:49:29
    Author     : DELL
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart Details</title>
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

        .card {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            transition: 0.3s;
            width: 100%;
            border-radius: 5px;
            margin-bottom: 20px; /* Add some space between cards */
            display: flex; /* Use flexbox for layout */
        }

        .card:hover {
            box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
        }

        .container {
            padding: 2px 16px;
            display: flex; /* Use flexbox for layout */
            flex-direction: column; /* Stack items vertically */
            justify-content: center; /* Center items vertically */
            flex: 1; /* Expand container to fill remaining space */
        }

        /* Style for the image */
        .card img {
            width: 100px;
            height: 100px;
            border-radius: 5px 5px 0 0; /* Rounded corners for top */
            object-fit: cover; /* Prevent image distortion */
        }

        /* Style for the details */
        .card .details {
            padding: 10px;
        }

        /* Style for the checkout link */
        .card a.checkout {
            background-color: #4CAF50; /* Green background color */
            color: white; /* White text color */
            padding: 8px 16px; /* Add padding */
            text-align: center; /* Center text */
            text-decoration: none; /* Remove underline */
            border-radius: 5px; /* Add border radius */
            display: inline-block; /* Display as inline-block */
            margin-top: 10px; /* Add some space from the top */
        }

        /* Hover effect for the checkout link */
        .card a.checkout:hover {
            background-color: #45a049; /* Darker green background color */
        }
        .card .details label {
    display: block; /* Display the label as a block element */
    margin-top: 10px; /* Add some space above the label */
}

.card .details input[type="number"] {
    width: 60px; /* Set a specific width for the input */
    padding: 5px; /* Add some padding inside the input */
    margin-top: 5px; /* Add some space above the input */
}
.checkout-button {
        background-color: #0b0b0b; /* Dark background color */
        color: white; /* Text color */
        padding: 10px 20px; /* Padding around the text */
        border: none; /* Remove border */
        border-radius: 5px; /* Rounded corners */
        cursor: pointer; /* Cursor style on hover */
        margin-top: 10px; /* Space above the button */
    }

    /* Hover effect */
    .checkout-button:hover {
        background-color: #0a81ab; /* Darker background color on hover */
    }.card2 {
    width: 600px;
    margin-left: 400px;
    border-radius: 8px;
    padding: 10px;
    text-align: center;
    transition: transform 0.3s;
    margin-top: 70px;
}

.card2 img {
    width: 100%;
    border-radius: 8px;
}

    </style>
</head>
<body>    <!-- Preloader -->
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
    </div><%if (session != null&& session.getAttribute("b") != null) {%>
    <h2>Cart Details</h2>
    <%-- Assuming the user's email is passed as a request parameter --%>
    <% String email = (String) session.getAttribute("b"); %>
    <%-- Example database connection --%>
    <% 
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");

        // Query to retrieve product_id from Cart table based on user's email
        PreparedStatement cartPS = connection.prepareStatement("SELECT product_id FROM Cart WHERE email = ?");
        cartPS.setString(1, email);
        ResultSet cartRS = cartPS.executeQuery();

        while (cartRS.next()) {
            // Retrieve product_id from Cart
            String productId = cartRS.getString("product_id");

            // Query to retrieve product details from Product table based on product_id
            PreparedStatement productPS = connection.prepareStatement("SELECT * FROM Product WHERE productid = ?");
            productPS.setString(1, productId);
            ResultSet productRS = productPS.executeQuery();

            if (productRS.next()) {
                // Retrieve product details
                String productName = productRS.getString("productName");
                String description = productRS.getString("description");
                double price = productRS.getDouble("price");
                String uploadedFileName = productRS.getString("uploadedFileName");
    %>
 <div class="card">
    <img src="prouductimg/<%= uploadedFileName %>" alt="<%= productName %>">
    <div class="container">
        <div class="details">
            <h4><b><%= productName %></b></h4>
            <p><%= description %></p>
            <p>Price: <%= price %></p>
  <form id="checkout-form" action="checkout.jsp">
    <label for="quantity-">Quantity:</label>
    <input type="number" id="quantity-" name="quantity" min="1" value="1" onchange="updateCheckoutLink()">
    <input type="hidden" id="product-id" name="productid" value="<%= productId %>">
    <input type="submit" value="Checkout" class="checkout-button">
</form>

<script>
    function updateCheckoutLink() {
        var productId = document.getElementById("product-id").value;
        var quantity = document.getElementById("quantity-").value;
        var checkoutForm = document.getElementById("checkout-form");
        checkoutForm.action = "checkout.jsp?productid=" + productId + "&quantity=" + quantity;
    }
</script>

        </div>
    </div>
</div>

    <%
            } else {
    %>
    <p>Product with ID <%= productId %> not found in Product database.</p>
    <%
            }

            productRS.close();
            productPS.close();
        }

        // Close resources
        cartRS.close();
        cartPS.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>An error occurred: " + e.getMessage() + "</p>");
    }
      }
else {
  %>
   <div class="container">
       <div class="card2">
        <img src="404.gif" alt="Page Not Found">
        <h1>404 - Page Not Found</h1>
        <p>Sorry, the page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
        <a href="logout.jsp"><button class="checkout-button">Logout</button></a>

       </div>
    </div><% }%>
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
