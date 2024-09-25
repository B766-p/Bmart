<%-- 
    Document   : car
    Created on : 21-Mar-2024, 18:02:33
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
  /* Card styles */
  .card-container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
    gap: 200px;
    margin-top: 80px;
  }
  .card {
    width: 300px;
    height: 350px;
    background-color: #f8f4f4;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    padding: 20px;
    transition: transform 0.3s;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
  }
  .card:hover {
    transform: scale(1.1);
  }
  .card img {
    width: 250px; /* Adjust size as needed */
    height: 250px; /* Adjust size as needed */
    border-radius: 50%;
    margin-bottom: 10px;
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
    text-decoration: none; /* Remove default underline */
  }
  .shop-now-btn:hover {
    background-color: #0a81ab; /* Change background color on hover */
    color: #fff; /* Change text color on hover */
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
        <a href="#" style="background-color: black; color: white; border-radius: 0;">career</a>
        <a href="login.jsp" >Login/Signup</a>
      </div>
    </div>
    
    <!-- Cards -->
    <div class="card-container">
      <div class="card">
        <img src="shop.webp" alt="Image 1">
        <a href="regv.jsp"><button class="shop-now-btn"> Registation as vendor</button></a>
       
      </div>
      
      <div class="card">
        <img src="delivery.webp" alt="Image 2">
        <a href="regd.jsp"><button class="shop-now-btn">Registation as delivery</button></a>
      </div>
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
  </script>
</body>
</html>




