<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Page Preloader</title>
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
  .header-section {
    position: relative;
    background-color: whitesmoke;
    padding: 20px;
    text-align: left;
    height: 85vh;
    margin-top: 20px; /* Adjust margin-top as needed */
    display: flex;
    justify-content: space-between;
    align-items: flex-start; /* Align items at the top */
    overflow: hidden; /* Ensure the image is clipped */
  }
  .header-section img {
    position: absolute;
    top: 0;
    right: 0;
    width: 450px; /* Adjust image width as needed */
    height: auto;
    z-index: 1; /* Ensure this image is on top */
  }
  .header-section img.move {
    animation: moveLeft 5s linear infinite; /* Animation for moving left */
  }
  .header-section img:first-child {
    z-index: 0; /* Lower the z-index of the first image */
  }
  .header-section h1 {
    margin-top: 0; /* Remove default margin */
    font-size: 60px; /* Adjust font size as needed */
    font-weight: bold;
  }
  .header-section h3 {
    margin-top: 0; /* Remove default margin */
    font-size: 50px; /* Adjust font size as needed */
    font-weight: bold; /* Make the text bold */
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
.product-section {
display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
    gap: 150px; /* Increased gap between product cards */
    padding: 20px;
    background-color: white;
}

.product-card {
  width: 250px;
    padding: 20px;
    background-color: whitesmoke;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    text-align: center;
}

.product-card img {
  width: 200px;
  height: 200px;
  border-radius: 10px;
  margin-bottom: 10px;
}

.product-card h4 {
  margin-top: 0;
  margin-bottom: 10px;
}

.product-card p {
  color: #555;
  margin-bottom: 15px;
}

.add-to-cart-btn {
  background-color: #0b0b0b;
  color: white;
  padding: 10px 20px;
  border-radius: 20px;
  border: none;
  cursor: pointer;
  margin-top: 10px;
  font-size: 16px;
  transition: background-color 0.3s, color 0.3s;
}

.add-to-cart-btn:hover {
  background-color: #0a81ab;
  color: #fff;
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

  @keyframes moveLeft {
    0% {
      transform: translateX(0%);
    }
    100% {
      transform: translateX(-100%);
    }
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
    <div class="navbar">
      <div class="logo">
        <img src="k.gif" alt="Logo">
        <span><b>Bmart</b></span>
      </div>
      <div>
        <a href="index.jsp">Home</a>
        <a href="about.jsp">About Us</a>
        <a href="car.jsp">career</a>
        <a href="login.jsp" style="background-color: black; color: white; border-radius: 0;">Login/Signup</a>
      </div>
    </div>
    <div class="sub-navbar">
      <a href="login.jsp">
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
    <div class="header-section">
      <div>
        <h1>Welcome to Bmart</h1><br><br>
        <h3>Your one-stop shop for <br>all your electronic and <br><span id="typewriter"></span></h3>
        <button class="shop-now-btn">Shop Now</button> <!-- Added Shop Now button -->
      </div>
      <img src="h1.webp" alt="Image on the right">
      <img src="h.webp" alt="Another Image on the right" class="move">
    </div>
      


   <div class="product-section">
        <%
        int productCount = 0; // Counter variable for tracking the number of product cards displayed

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123"); 

            String sql = "SELECT * FROM Product";
            PreparedStatement statement = connection.prepareStatement(sql);
            

            ResultSet resultSet = statement.executeQuery();
              while (resultSet.next()) {
                    String productid = resultSet.getString("productid");
                    String productName = resultSet.getString("productName");
                    String description = resultSet.getString("description");
                    double price = resultSet.getDouble("price");
                    String category = resultSet.getString("category");
                    String uploadedFileName = resultSet.getString("uploadedFileName");
                
    %>
  <!-- Add product card for each product -->
<div class="product-card">
  <img src="prouductimg/<%= uploadedFileName %>" alt="<%= productName %>">
  <h4><%= productName %></h4>
  <p>Price: rs<%= price %></p>
  <p>Category: <%= category %></p>
  <a href="login.jsp"><button class="shop-now-btn">Buy Now</button></a>
  <a href="login.jsp"><button   class="add-to-cart-btn">Add to Cart</button></a>
</div>
    <%
          productCount++;   }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println(e);
        }
    %>  <!-- Add more product cards as needed -->
</div>
    <!-- Footer section -->
 

 
  </div>
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

  <!-- JavaScript to hide preloader after delay -->
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

    const texts = ["fashion needs", "Laptops and  Mobile", "accessories", "get discount on Items"];
    let textIndex = 0;
    let charIndex = 0;
    let isDeleting = false;

    function typeWriter() {
      const currentText = texts[textIndex];
      if (!isDeleting) {
        document.getElementById("typewriter").textContent += currentText[charIndex];
        charIndex++;
        if (charIndex === currentText.length) {
          isDeleting = true;
          setTimeout(() => {
            charIndex = 0;
            document.getElementById("typewriter").textContent = "";
            textIndex++;
            if (textIndex === texts.length) {
              textIndex = 0;
            }
            setTimeout(typeWriter, 500); // Delay before starting to delete
            isDeleting = false;
          }, 2000); // Time to display the complete word
        } else {
          setTimeout(typeWriter, 100); // Typing speed
        }
      } else {
        document.getElementById("typewriter").textContent = currentText.substring(0, charIndex);
        charIndex--;
        if (charIndex === 0) {
          isDeleting = false;
        }
        setTimeout(typeWriter, 100); // Deleting speed
      }
    }
    typeWriter(); // Initial call to start the typewriter effect
  </script>
   
</body>
</html>