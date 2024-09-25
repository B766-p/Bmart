<%-- 
    Document   : profile
    Created on : 23-Mar-2024, 12:55:40
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
    .container {
            display: flex;
            justify-content: space-around;
            align-items: flex-start;
        }
        form {
            width: 300px;
            float: left;
        }
        .profile-card {
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            float: left;
        }
        .profile-card img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin-bottom: 10px;
        }
        .profile-card button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        .card {
            width: 600px;
            height: 450px;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
        }
        label {
            display: block;
            margin-top: 10px;
        }
        input[type="text"], input[type="email"], input[type="password"], input[type="submit"] {
            width: 480px;
            padding: 10px;
            margin-top: 5px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .error {
            color: red;
        }
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }
    .card-container {
    display: flex;
    justify-content: space-around;
    align-items: flex-start;
    margin-top: 20px;
    margin-bottom: 30px;
}

.card1 {
    width: 200px;
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 10px;
    text-align: center;
    transition: transform 0.3s;
}

.card1 img {
    width: 100%;
    border-radius: 8px;
}
.card2 {
    width: 500px;
    
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

.card-button {
    background-color: #4CAF50;
    color: white;
    padding: 5px 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 10px;
}

.card-button:hover {
    background-color: #45a049;
}

.card1:hover {
    transform: translateY(-5px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
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


</style>
</head>
<body>
  <!-- Preloader -->
  <div class="preloader" id="preloader">
    <img src="k.gif" alt="Loading..."><br><br>
  </div>

  <!-- Navbar -->
  <div class="navbar">
    <div class="logo">
      <img src="k.gif" alt="Logo">
      <span><b>Bmart</b></span>
    </div>
    <div>
      <a href="index1.jsp">Home</a>
      <a href="about.jsp">About Us</a>
      <a href="cart1.jsp">cart</a>
      <a href="profile.jsp" style="background-color: black; color: white; border-radius: 0;">MY account</a>
    </div>
  </div><%if (session != null&& session.getAttribute("b") != null) {%>
      <h1>Profile</h1>
    <div class="container">
        <div class="profile-card">
            <h2>Profile Details</h2>
            <%
                // Connect to the database
                String uid = (String) session.getAttribute("b");

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bmart","bmart123"); 
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM users3 WHERE email = ?");
                    // Assuming you have a user id available
                    ps.setString(1, uid);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        String name = rs.getString("name");
                        String email = rs.getString("email");
                        String utype = rs.getString(7);
                        String mobile = rs.getString(3);
                        String pass = rs.getString(4);
            %>
                        <img src="p.jpg" alt="Profile Image">
                        <p><strong>Name:</strong> <%= name %></p>
                        <p><strong>User:</strong><%= utype %></p>
           
            <button id="change-profile-btn">Change Profile Picture</button>
        </div>
        <div class="card">
            <h2>Update Details</h2>
            <form name="profileForm" action="pupdate.jsp" method="post" onsubmit="return validateForm()">
                <label for="first_name">First Name:</label>
                <input type="text" id="first_name" name="first_name" value="<%= name %>" required>

                <label for="email_address">Email Address:</label>
                <input type="email" id="email_address" name="email_address" value="<%= email %>" required>

                <label for="current_password">Mobile :</label>
                <input type="text" id="current_password" name="m" value="<%= mobile %>">

                <label for="new_password">PASSWORD</label>
                <input type="password" id="new_password" name="new_password" value="<%= pass %>" >

                <input type="submit" value="Save">
            </form>
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="card-container">
  <div class="card1">
    <img src="book.webp" alt="Card Image">
    <a href="myorder.jsp"><button class="card-button">My Order</button></a>
</div>
<div class="card1">
    <img src="stat.webp" alt="Card Image">
    <a href="orderstatus.jsp"><button class="card-button">View My Order Status</button></a>
</div>
<div class="card1">
    <img src="logout.webp" alt="Card Image">
    <a href="logout.jsp"><button class="card-button">Logout</button></a>
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
 
     <%
                    }
                   
                } catch (Exception e) {
                    out.println("<p class=\"error\">An error occurred: " + e.getMessage() + "</p>");
                }
      }
else {
  %>
   <div class="container">
       <div class="card2">
        <img src="404.gif" alt="Page Not Found">
        <h1>404 - Page Not Found</h1>
        <p>Sorry, the page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
          <a href="logout.jsp"><button class="card-button">Logout</button></a>
       </div>
    </div><% }%>
  <!-- JavaScript to hide preloader after delay -->
  <script>
    setTimeout(function() {
      const preloader = document.getElementById('preloader');
      preloader.style.opacity = 0;
      setTimeout(() => {
        preloader.style.display = 'none';
      }, 500); // Adjust the fade-out delay as needed
    }, 3000); // Adjust the delay before preloader fades out as needed (in milliseconds)
    window.addEventListener('pageshow', function(event) {
        // Check if the event persisted property is false, indicating a page reload
        if (event.persisted) {
            // Reload the page
            window.location.reload();
        }
    });
  </script>

</body>
</html>
