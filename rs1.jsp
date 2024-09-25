<%-- 
    Document   : rs1
    Created on : 22-Apr-2024, 16:44:19
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
.header-section input[type="submit"] {
  padding: 8px;
  margin-bottom: 40px;
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
  color: #721c24;
  background-color: #f8d7da;
  border-color: #f5c6cb;
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



            <h1>reset password</h1>
       <%
    String email = (String) session.getAttribute("em");

    // Add more logic to ensure email is valid and exists in the database

    // You should add more validation logic and handle database updates
    if (email != null) {
        // Logic to update the password in the database (Replace this with your actual logic)
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");

            // Assuming you have a table named userinfo1 with columns EMAIL and UPASS
            String updateQuery = "UPDATE users3 SET UPASS = ? WHERE EMAIL = ?";
            PreparedStatement updateStatement = connection.prepareStatement(updateQuery);

            // Replace "newPassword" and "confirmPassword" with the parameter names from your form
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (newPassword.equals(confirmPassword)) {
                // Passwords match, proceed with the update
                updateStatement.setString(1, newPassword);
                updateStatement.setString(2, email);

                int rowsUpdated = updateStatement.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<p>Password reset successfully!</p>" + email);
                    session.invalidate();
                     response.sendRedirect("login.jsp");
                } else {
                    out.println("<p class=\"error-message\">Failed to reset the password.</p>");
                }
            } else {
                // Passwords don't match, display an error message
                out.println("<p class=\"error-message\">New password and confirm password do not match.</p>");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<p class=\"error-message\">An error occurred while processing your request.</p>");
        }
    }
%>
<form action="rs1.jsp" method="post">
    <label for="newPassword">New Password:</label>
    <input type="password" id="newPassword" name="newPassword" required>

    <label for="confirmPassword">Confirm Password:</label>
    <input type="password" id="confirmPassword" name="confirmPassword" required>

    <input type="hidden" name="email" value="<%= email %>">

    <input type="submit" value="Reset Password">
</form>

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


