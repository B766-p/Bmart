<%-- 
    Document   : frog
    Created on : 22-Apr-2024, 16:24:38
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

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
  height: 100vh;
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
.header-section input[type="text"],
.header-section input[type="submit"] {
  padding: 8px;
 margin-bottom: 20px;
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
.form-card{
    position: absolute;
    
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
/* Footer styles */
footer {
  background-color: #0b0b0b;
  color: white;
  padding: 20px 0;
  text-align: center;
}

.footer-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.l img {
  height: 250px;
}

.contact-info {
  text-align: left;
}

.footer-form {
  text-align: right;
  margin-right: 30px;
}

.footer-form input {
  padding: 10px;
  margin-right: 10px;
  border-radius: 5px;
  border: none;
}

.footer-form button {
  padding: 10px 20px;
  background-color: #fff;
  color: #0b0b0b;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.footer-form button:hover {
  background-color: #0a81ab;
  color: white;
}
.alert {
  padding: 15px;
  margin-bottom: 20px;
  border: 1px solid transparent;
  border-radius: 4px;
}

.error-message {
    color: red;
    font-weight: bold;
    margin-top: 10px;
}


.alert-success {
  color: #155724;
  background-color: #d4edda;
  border-color: #c3e6cb;
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
    
   
      <div class="header-section">
        <img src="h1.webp" alt="Image on the right">
 
      
        <div class="form-card">
<%
    String email = request.getParameter("email");
    String securityCode = request.getParameter("scode");
    int attemptCount = 0;
    session.setAttribute("em", email);

    // Retrieve the attempt count from session
    if (session.getAttribute("attemptCount") != null) {
        attemptCount = (int) session.getAttribute("attemptCount");
    }

    if (email != null && securityCode != null) {
        // Check if the email and security code match in the database
       
        try {
           Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123"); 

            // Query to check if the email and security code match
            String query = "SELECT * FROM users3 WHERE EMAIL = ? AND MOBILE = ?";
            PreparedStatement pr= connection.prepareStatement(query);
            pr.setString(1, email);
            pr.setString(2, securityCode);

            ResultSet rs = pr.executeQuery();

            if (rs.next()) {
                // Email and security code are valid, allow password reset
                // Redirect to a password reset page or perform the password reset logic here
                 session.setAttribute("em", email);
                response.sendRedirect("rs.jsp");
            } else {
                // Invalid email or security code

                if (attemptCount < 3) {
                    // Increment the attempt count
                    attemptCount++;
                    session.setAttribute("attemptCount", attemptCount);
                  out.println("<div class=\"error-message\">Invalid email or security code. Attempt " + attemptCount + " of 3.</div>");

                } 
                else {
            String query1 = "SELECT mobile FROM users3 WHERE EMAIL = ?";
            PreparedStatement pr1= connection.prepareStatement(query1);
            pr1.setString(1, email);
            ResultSet rs1 = pr1.executeQuery();

           if (rs1.next()) {
            String fullSecurityCode = rs1.getString("mobile");
           String partialSecurityCode = fullSecurityCode.substring(0, 3);

          out.println("<div class=\"error-message\">Invalid email or security code. Showing part of the security code: " + partialSecurityCode + "xxxx</div>");

             } else {
 out.println("<div class=\"error-message\">Invalid email or security code. Security code not found.</div>");

                  }

            }
        } }catch (SQLException e) {
            e.printStackTrace();
            // Handle database connection or query errors
            out.println(e);
        } 
    }
%>


            <h1>Forgot password/verified your self </h1>
         <form action="frog.jsp" method="post">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>

    <label for="scode">Security Code(mobile):</label>
    <input type="text" id="scode" name="scode" required>

    <input type="submit" value="Submit">
</form>
            <button onclick="window.location.href='signup.jsp'"> If you don'st have any acount Sign Up Here</button>
        </div>
    </div>
    <footer>
        <div class="footer-content">
          <div class="l">
            <img src="k.gif" alt="Logo">
          </div>
          <div class="contact-info">
            <p><b>Contact Us</b></p>
            <p>123 Street Name</p>
            <p>City, Country</p>
            <p>Email: info@example.com</p>
            <p>Phone: +123-456-7890</p>
          </div>
          <div class="footer-form">
            <p><b>Subscribe to our newsletter</b></p>
            <input type="email" placeholder="Enter your email">
            <button>Subscribe</button>
          </div>
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

  
  </script>
</body>
</html>


