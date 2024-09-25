<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delivery Registration</title>
    <style>
     body
    {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f1f1f1;
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

    .card {
        width: 400px;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    h1 {
        text-align: center;
        margin-bottom: 20px;
    }

    label {
        font-weight: bold;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"],
    select {
        width: calc(100% - 12px);
        margin: 8px 0;
        padding: 6px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    input[type="submit"] {
        width: 100%;
        margin-top: 20px;
        padding: 10px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    input[type="submit"]:hover {
        background-color: #0056b3;
    }

    .avatar {
        display: block;
        margin: 0 auto 20px;
        width: 100px;
        height: 100px;
        border-radius: 50%;
        object-fit: cover;
    }

    .left-image,
    .right-image {
        display: block;
        width: 400px;
        height: 400px;
        border-radius: 50%;
        object-fit: cover;
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
    }

    .left-image {
        left: 0;
    }

    .right-image {
        right: 0;
    }
     h1 {
        text-align: center;
        margin-bottom: 20px;
    }
    h1 {
        text-align: center;
        margin-bottom: 20px;
    }

    .registration-success {
        text-align: center;
        margin-bottom: 20px;
    }

    .checkmark {
        display: inline-block;
        width: 50px;
        height: 50px;
        color: greenyellow;
    }

    .checkmark__circle {
        stroke-dasharray: 166;
        stroke-dashoffset: 166;
        stroke-width: 2;
        fill: none;
        stroke: green;
        animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
    }

    .checkmark__check {
        transform-origin: 50% 50%;
        stroke-dasharray: 48;
        stroke-dashoffset: 48;
        animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) 0.3s forwards;
    }

    @keyframes stroke {
        100% {
            stroke-dashoffset: 0;
        }
    }

    .message {
        display: inline-block;
        vertical-align: middle;
        font-size: 18px;
        color: green;
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
        <a href="about.jsp">About Us</a>
        <a href="#" style="background-color: black; color: white; border-radius: 0;">career</a>
        <a href="login.jsp" >Login/Signup</a>
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

            String mobile = request.getParameter("phone");
            if (mobile.length() != 10) {
                // Mobile number must be 10 digits
                out.println("<div style='text-align: center; color: red;'>Registration unsuccessful. Mobile number must be 10 digits</div>");
            } else {
                // Check if email already exists with utype 'delivery'
                String email = request.getParameter("email");
                String checkSql = "SELECT * FROM users3 WHERE EMAIL = ? AND users = ?";
                ps = conn.prepareStatement(checkSql);
                ps.setString(1, email);
                ps.setString(2, "delivery");
                rs = ps.executeQuery();
                if (rs.next()) {
                    // Email already exists with utype 'delivery'
                    out.println("<div style='text-align: center; color: red;'>Registration unsuccessful. Email already exists please login</div>");
                     out.println("<script>");
                    out.println("setTimeout(function() { window.location.href = 'login.jsp'; }, 3000);");
                    out.println("</script>");
                } else {
                    // Insert new user
                    String sql = "INSERT INTO users3 VALUES (?, ?, ?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, request.getParameter("name"));
                    ps.setString(2, email);
                    ps.setString(3, mobile);
                    ps.setString(4, request.getParameter("password"));
                    ps.setString(5, request.getParameter("address"));
                    ps.setString(6, request.getParameter("vehicle"));
                    ps.setString(7, "delivery");
                    ps.executeUpdate();

                    // Show registration success message with check mark
                    out.println("<div class='registration-success'><svg class='checkmark' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 52 52'><circle class='checkmark__circle' cx='26' cy='26' r='25' fill='none' stroke='green' stroke-width='2'/><path class='checkmark__check' fill='none' stroke='green' stroke-width='2' d='M14.1 27.2l7.1 7.2 16.7-16.8'/></svg><span class='message'>Registration successful!</span></div>");

                    // Redirect to login.jsp after 3 seconds
                    out.println("<script>");
                    out.println("setTimeout(function() { window.location.href = 'login.jsp'; }, 3000);");
                    out.println("</script>");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
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

<div class="container">
    <img src="del1.webp" alt="Left Image" class="left-image">
    <div class="card">
        <h1>Delivery Boy Registration</h1>
        <form action="#" method="post">
            <label for="name">Name</label><br>
            <input type="text" id="name" name="name" required><br>
            <label for="email">Email</label><br>
            <input type="email" id="email" name="email" required><br>
            <label for="phone">Phone Number</label><br>
            <input type="text" id="phone" name="phone" required><br>
            <label for="password">Password</label><br>
            <input type="password" id="password" name="password" required><br>
            <label for="address">Area</label><br>
            <input  type="text" id="address" name="address" required><br>
            <label for="vehicle">Vehicle Type</label><br>
            <select id="vehicle" name="vehicle" required>
                <option value="">Select Vehicle Type</option>
                <option value="car">Car</option>
                <option value="motorcycle">Motorcycle</option>
                <option value="bicycle">Bicycle</option>
            </select><br>
            <input type="submit" value="Register">
        </form>
    </div>
    <img src="del2.webp" alt="Right Image" class="right-image">
</div>
</body>
</html>

