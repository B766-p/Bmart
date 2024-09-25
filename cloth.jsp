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
    height: 70vh;
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
    background-color: #0b0b0b; /* Button background color */
    color: white; /* Button text color */
    padding: 10px 20px; /* Button padding */
    border-radius: 20px; /* Button border radius for curved shape */
    border: none; /* Remove button border */
    cursor: pointer; /* Add pointer cursor on hover */
    margin-top: 10px; /* Adjust margin-top as needed */
    font-size: 16px; /* Button text size */
    transition: background-color 0.3s, color 0.3s; /* Smooth transition effect for hover */
  }
  .add-to-cart-btn:hover {
    background-color: #0a81ab; /* Change background color on hover */
    color: #fff; /* Change text color on hover */
  }
  @keyframes moveLeft {
    0% {
      transform: translateX(0%);
    }
    100% {
      transform: translateX(-100%);
    }
  }
   .pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
  }
  .pagination a {
    color: black;
    float: left;
    padding: 8px 16px;
    text-decoration: none;
    transition: background-color .3s;
    border: 1px solid #ddd;
    margin: 0 4px;
  }
  .pagination a.active {
    background-color: #0b0b0b;
    color: white;
    border: 1px solid #0b0b0b;
  }
  .pagination a:hover:not(.active) {background-color: #ddd;}
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
         <a href="cart1.jsp">cart</a>
        <a href="profile.jsp" style="background-color: black; color: white; border-radius: 0;">MY account</a>
      </div>
    </div>
    <div class="sub-navbar">
      <a href="mobile.jsp">
        <img src="1.webp" alt="Image 1">
        <span><b>MOBILE</b></span>
      </a>
      <a href="laptop.jsp">
        <img src="2.webp" alt="Image 2">
        <span><b>LAPTOP</b></span>
      </a>
      <a href="campnets.jsp">
        <img src="3.webp" alt="Image 3">
        <span><b>COMPONENTS</b></span>
      </a>
      <a href="cloth.jsp">
        <img src="4.png" alt="Image 4">
        <span><b>CLOTHES</b></span>
      </a>
    </div>
    <div class="header-section">
      <div>
        <h1>Welcome to Bmart</h1><br><br>
        <h3>Your one-stop shop for <br>all types of cloths <br><span id="typewriter"></span></h3>
        <button class="shop-now-btn">Shop Now</button> <!-- Added Shop Now button -->
      </div>
      <img src="h1.webp" alt="Image on the right">
      <img src="h.webp" alt="Another Image on the right" class="move">
    </div>
    <div class="product-section">
      <!-- Add product card for each product -->
      <%
        int productsPerPage = 6;
        int currentPage = 1;
        if (request.getParameter("page") != null) {
          currentPage = Integer.parseInt(request.getParameter("page"));
        }
        int start = (currentPage - 1) * productsPerPage + 1;
        int end = currentPage * productsPerPage;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123"); 

             String sql = "SELECT * FROM (SELECT p.*, ROWNUM r FROM Product p WHERE CATEGORY = 'Clothing') WHERE r BETWEEN ? AND ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, start);
            statement.setInt(2, end);

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                String productid = resultSet.getString("productid");
                String productName = resultSet.getString("productName");
                String description = resultSet.getString("description");
                double price = resultSet.getDouble("price");
                String category = resultSet.getString("category");
                String uploadedFileName = resultSet.getString("uploadedFileName");
      %>
      <div class="product-card">
        <img src="prouductimg/<%= uploadedFileName %>" alt="<%= productName %>">
        <h4><%= productName %></h4>
        <p>Price: rs<%= price %></p>
        <p>Category: <%= category %></p>
        <a href="cart.jsp?productid=<%= productid %>"><button class="shop-now-btn">Buy Now</button></a>
  <a href="cart.jsp?productid=<%= productid %>"><button class="add-to-cart-btn">Add to Cart</button></a>
      </div>
     
 
        
        
      <%
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println(e);
        }
      %>
    </div>
    <div class="pagination">
      <% 
        int totalProducts = 21; // Assuming total products is 21
        int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
        for (int i = 1; i <= totalPages; i++) {
          if (i == currentPage) {
            %>
            <a href="?page=<%= i %>" class="active"><%= i %></a>
            <%
          } else {
            %>
            <a href="?page=<%= i %>"><%= i %></a>
            <%
          }
        }
      %>
    </div>
  </div>

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

    const texts = ["cloth", "dress", "t-shirt", "shirt"];
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