<%-- 
    Document   : signup
    Created on : 22-Mar-2024, 21:06:21
    Author     : DELL
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
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
            height: 110vh;
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

        .header-section input[type="text"],
        .header-section input[type="email"],
        .header-section input[type="tel"],
        .header-section input[type="password"],
        .header-section input[type="submit"] {
            padding: 8px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .header-section input[type="submit"] {
            background-color: #0b0b0b;
            color: white;
            cursor: pointer;
            border: none;
            margin-top: 10px;
            padding: 10px;
        }

        .header-section input[type="submit"]:hover {
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
          <a href="#news">Home</a>
          <a href="#contact">About Us</a>
          <a href="#about">Categories</a>
          <a href="#login" style="background-color: black; color: white; border-radius: 0;">Login/Signup</a>
        </div>
      </div>
<%
if (request.getMethod().equalsIgnoreCase("post")) {
    // Form was submitted, handle database insertion
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");

        String mobile = request.getParameter("mobile");
        if (mobile.length() != 10) {
            // Mobile number must be 10 digits
            out.println("<div style='text-align: center; color: red;'>Registration unsuccessful. Mobile number must be 10 digits</div>");
        } else {
            // Check if email already exists with utype 'delivery'
            String email = request.getParameter("email");
            String checkSql = "SELECT * FROM users3 WHERE EMAIL = ?";
            ps = conn.prepareStatement(checkSql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                // Email already exists with utype 'delivery'
                out.println("<div style='text-align: center; color: red;'>Registration unsuccessful. Email already exists. Please <a href='login.jsp'>login</a></div>");
            } else {
                // Insert new user
                String sql = "INSERT INTO users3 (NAME,EMAIL,MOBILE,upass,USERS) VALUES (?, ?, ?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, request.getParameter("name"));
                ps.setString(2, email);
                ps.setString(3, mobile);
                ps.setString(4, request.getParameter("password"));
                ps.setString(5 , "user");
                ps.executeUpdate();

                // Show registration success message with check mark
                out.println("<div class='registration-success'><svg class='checkmark' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 52 52'><circle class='checkmark__circle' cx='26' cy='26' r='25' fill='none' stroke='green' stroke-width='2'/><path class='checkmark__check' fill='none' stroke='green' stroke-width='2' d='M14.1 27.2l7.1 7.2 16.7-16.8'/></svg><span class='message'>Registration successful!</span></div>");

                // Redirect to login.jsp after 3 seconds
                out.println("<script>");
                out.println("setTimeout(function() { window.location.href = 'login.jsp'; }, 3000);");
                out.println("</script>");
            }
        }
    } 
    catch (ClassNotFoundException | SQLException e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
}
%>

      <div class="header-section">
        <img src="h1.webp" alt="Image on the right">
        <img src="h.webp" alt="Another Image on the right" class="move">
        <div class="form-card">
            <h1>Sign Up</h1>
            <form action="#" method="POST">
                <label for="name">Name:</label><br>
                <input type="text" id="name" name="name" required><br>
                <label for="email">Email:</label><br>
                <input type="email" id="email" name="email" required><br>
                <label for="mobile">Mobile Number:</label><br>
                <input type="tel" id="mobile" name="mobile" pattern="[0-9]{10}" required><br>
                <label for="password">Password:</label><br>
                <input type="password" id="password" name="password" required><br><br>
                <input type="submit" value="Sign Up">
            </form>
            <button onclick="window.location.href='login.jsp'"> If you  have  acount please login Here</button>
        </div>
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
