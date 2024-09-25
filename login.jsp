<%-- 
    Document   : login
    Created on : 22-Mar-2024, 10:58:44
    Author     : DELL
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
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
/* Header section styles */
.header-section {
  position: relative;
  background-color: whitesmoke;
  padding: 20px;
  text-align: left;
  height: 80vh;
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

.header-section .form-card {
  width: 300px;
  padding: 20px;
  margin: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease-in-out;
}

.header-section .form-card:hover {
  transform: scale(1.05);
}

.header-section form {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.header-section label {
  margin-bottom: 2px;
}

.header-section input[type="email"],
.header-section input[type="password"],
.header-section input[type="submit"] {
  padding: 8px;
 
  width: 100%;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.header-section input[type="submit"] 
                {
  background-color: #0b0b0b;
  color: white;
  cursor: pointer;
  border: none;
}

.header-section input[type="submit"]:hover 
{
  background-color: #0a81ab;
}
.form-card button {
    background-color: #0b0b0b;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 10px;
}

.form-card button:hover {
    background-color: #0a81ab;
}

.forgot-password {
    color: #0b0b0b;
    text-decoration: none;
}

.forgot-password:hover {
    text-decoration: underline;
}


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
  @keyframes moveLeft 
  {
    0% {
      transform: translateX(0%);
    }
    100% {
      transform: translateX(-100%);
    }
  }
  .alert {
  padding: 15px;
  margin-bottom: 20px;
  border: 1px solid transparent;
  border-radius: 4px;
}

.alert-fail {
  color: #721c24;
  background-color: #f8d7da;
  border-color: #f5c6cb;
}

.alert-success {
  color: #155724;
  background-color: #d4edda;
  border-color: #c3e6cb;
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
          <a href="#news">Home</a>
          <a href="#contact">About Us</a>
          <a href="#about">Categories</a>
          <a href="#login" style="background-color: black; color: white; border-radius: 0;">Login/Signup</a>
        </div>
      </div>
   
      <div class="header-section">
        <img src="h1.webp" alt="Image on the right">
        <img src="h.webp" alt="Another Image on the right" class="move">
        <div class="form-card">
             <div id="message"></div>
             <%
    String email = request.getParameter("email");
    String password = request.getParameter("pass");

    // Validate form data (add more validation as needed)
    if (email != null && password != null && !email.isEmpty() && !password.isEmpty()) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123"); 
            String sql = "SELECT users FROM users3 WHERE EMAIL = ?  AND upass = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, email);
                statement.setString(2, password);

                // Execute the query
                ResultSet resultSet = statement.executeQuery();
                String utype="";
                // Check if a user with the given credentials exists
                if (resultSet.next()) {
                    utype = resultSet.getString(1);
%>
                    <div class="alert alert-success">
                        Login successful!
                    </div>
                    <script>
                        alert("Successfully logged in!");
                    </script>
<%
                } else {
%>
                    <div class="alert alert-fail">
                        Login failed. Invalid username or password.
                    </div>
                    <script>
                        alert("Login failed. Invalid username or password.");
                    </script>
<%
                }
                if ("delivery".equals(utype)) 
                {
                    session.setAttribute("b",email);
                    response.sendRedirect("deliverydashbord.jsp");
                } 
                else if ("shop".equals(utype)) 
                {
                     session.setAttribute("b",email);
                    response.sendRedirect("shop.jsp");
                } 
                else if ("admin".equals(utype)) 
                {
                     session.setAttribute("b",email);
                    response.sendRedirect("admin.jsp");
                } 
                else if ("user".equals(utype)) 
                {
                     session.setAttribute("b",email);
                    response.sendRedirect("index1.jsp");
                }
               //
            } 
 
            
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<div class='alert alert-fail'>Database error occurred. Please try again later.</div>");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<div class='alert alert-fail'>Database driver error occurred. Please try again later.</div>");
        }
    } else {
%>
        <div class="alert alert-fail">
            Invalid form data. Please fill in all the fields.
        </div>
<%
    }
%>
            <h1>Login Here</h1>
            <form action="#" method="POST">
                <label for="name">Email:</label><br>
                <input type="email" id="name" name="email"><br>
                <label for="email">Password:</label><br>
                <input type="password" id="password" name="pass"><br><br>
                <a href="frog.jsp" class="forgot-password">Forgot Password?</a><br><br>
                <input type="submit" value="LOGIN">
            </form>
            <button onclick="window.location.href='signup.jsp'"> If you don'st have any acount Sign Up Here</button>
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