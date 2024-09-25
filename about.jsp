<%-- 
    Document   : about
    Created on : 21-Mar-2024, 16:17:51
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>About Us - Bmart</title>
<style>
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
    font-size: 24px;
    margin-left: 10px;
  }
  /* Header styles */
  .header-section {
    position: relative;
    background-color: whitesmoke;
    padding: 20px;
    text-align: left;
    height: 70vh;
    margin-top: 20px;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    overflow: hidden;
  }
  .header-section img {
    position: absolute;
    top: 0;
    right: 0;
    width: 450px;
    height: auto;
    z-index: 1;
  }
  .header-section img.move {
    animation: moveLeft 5s linear infinite;
  }
  .header-section img:first-child {
    z-index: 0;
  }
  .header-section h1 {
    margin-top: 0;
    font-size: 60px;
    font-weight: bold;
  }
  .header-section h3 {
    margin-top: 0;
    font-size: 50px;
    font-weight: bold;
  }
  .shop-now-btn {
    background-color: #0b0b0b;
    color: white;
    padding: 10px 20px;
    border-radius: 20px;
    border: none;
    cursor: pointer;
    margin-top: 20px;
    font-size: 18px;
    transition: background-color 0.3s, color 0.3s;
  }
  .shop-now-btn:hover {
    background-color: #0a81ab;
    color: #fff;
  }
  .card-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 50px;
  }
  .card {
    background-color:antiquewhite;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }
  .card h3 {
    margin-top: 0;
  }
  .card img {
  width: 250px; /* Adjust the width as needed */
  height: 250px; /* Adjust the height as needed */
  margin-bottom: 15px;
}
  /* Footer styles */
footer {
  background-color: #333;
  color: #fff;
  padding: 20px 0;
  margin: top 50px; 

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
  <div class="navbar">
    <div class="logo">
      <img src="k.gif" alt="Logo">
      <span><b>Bmart</b></span>
    </div>
    <div>
      <a href="index.jsp">Home</a>
      <a href="about.html" style="background-color: black; color: white; border-radius: 0;">About Us</a>
      <a href="car.jsp">career</a>
      <a href="login.jsp">Login/Signup</a>
    </div>
  </div>
  
  <!-- Header section -->
  <div class="header-section">
    <div>
      <h1>Welcome to Bmart</h1>
      <h3>Your one-stop shop for </br>all your electronic and<br> <span id="typewriter"></span></h3>
      <h3>Home/<span id="ab"></span></h3></h3>
    </div>
    <img src="h1.webp" alt="Image on the right">
    <img src="h.webp" alt="Another Image on the right" class="move">
  </div>
  
  <!-- About Us content -->
  <h2>Our Services</h2>
  
  <div class="card-container">
    <div class="card">
      <img src="ps.webp" alt="Customer Support">
      <h3>Product Sales</h3>
      <p>Introducing the latest in electronic innovation: Crafted with precision and designed for excellence, electronic is here to revolutionize your fast dilivery. With best prouducts, gurenty, and warent, it's the perfect companion for all user.</p>
    </div>
    <div class="card">
      <img src="cs.webp" alt="Customer Support">
      <h3>Customer Support</h3>
      <p>Welcome to our 24/7 customer support service. Our team is available around the clock to assist you with any queries or issues you may have. Please feel free to reach out to us at any time, and we will do our best to provide you with the assistance you need.</p>
    </div>
    <div class="card">
      <img src="tcs.webp" alt="Customer Support">
      <h3>Technical Assistance</h3>
      <p>Ensure your e-commerce platform is scalable to handle increasing traffic and transactions, especially during peak times such as holidays or sales events.Optimize your website's performance for fast loading times, which is crucial for providing a good user experience and improving SEO.</p>
    </div>
    <div class="card">
      <img src="dc.webp" alt="Customer Support">
      <h3>Discount Offers</h3>
      <p>If you are taking membership you can get a deal of 20%discount over every prouducts.</p>
    </div>
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
</div>

  <!-- JavaScript for typewriter effect -->
 <!-- JavaScript for typewriter effect -->
<script>
    const texts = ["fashion needs", "Laptops and Mobile", "accessories", "get discount on Items"];
    let textIndex = 0;
    let charIndex = 0;
    let isDeleting = false;
  
    function typeWriter(elementId, textsArray) {
      let currentIndex = 0;
      let currentText = textsArray[currentIndex];
      let charIndex = 0;
      let isDeleting = false;
  
      function type() {
        if (!isDeleting) {
          document.getElementById(elementId).textContent += currentText[charIndex];
          charIndex++;
          if (charIndex === currentText.length) {
            isDeleting = true;
            setTimeout(() => {
              charIndex = 0;
              document.getElementById(elementId).textContent = "";
              currentIndex = (currentIndex + 1) % textsArray.length;
              currentText = textsArray[currentIndex];
              isDeleting = false;
              setTimeout(type, 500);
            }, 2000);
          } else {
            setTimeout(type, 100);
          }
        } else {
          document.getElementById(elementId).textContent = currentText.substring(0, charIndex);
          charIndex--;
          if (charIndex === 0) {
            isDeleting = false;
          }
          setTimeout(type, 100);
        }
      }
      type();
    }
  
    // Call the function for each element
    typeWriter("typewriter", texts);
    typeWriter("ab", ["Know more", "About Us", "Regarding us", "In relation to us"]);
  </script>
  
</body>
</html>