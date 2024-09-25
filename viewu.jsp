<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Information</title>
    <style>
        /* Your CSS styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .user-section {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .card {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            box-sizing: border-box;
            padding-bottom: 10px;
        }

        .admin {
            background-color: #e74c3c;
            color: #fff;
        }

        .teacher {
            background-color: #2ecc71;
            color: #fff;
        }

        .parents {
            background-color: #3498db;
            color: #fff;
        }

        .delivery {
            background-color: #9b59b6;
            color: #fff;
        }

        .card p {
            margin: 8px 0;
        }
        .delete-form {
            display: inline-block;
            margin-top: 10px;
        }

        .delete-form input[type="submit"] {
            background-color: #e74c3c;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .delete-form input[type="submit"]:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>

<%
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");

    // Count of Admins
    String adminType = "admin";
    PreparedStatement adminCountPs = con.prepareStatement("SELECT COUNT(*) FROM users3 WHERE users = ?");
    adminCountPs.setString(1, adminType);
    ResultSet adminCountRs = adminCountPs.executeQuery();
    int adminCount = 0;
    if (adminCountRs.next()) {
        adminCount = adminCountRs.getInt(1);
    }

    // Count of Teachers
    String teacherType = "user";
    PreparedStatement teacherCountPs = con.prepareStatement("SELECT COUNT(*) FROM users3 WHERE users = ?");
    teacherCountPs.setString(1, teacherType);
    ResultSet teacherCountRs = teacherCountPs.executeQuery();
    int teacherCount = 0;
    if (teacherCountRs.next()) {
        teacherCount = teacherCountRs.getInt(1);
    }

    // Count of Parents
    String parentType = "shop";
    PreparedStatement parentCountPs = con.prepareStatement("SELECT COUNT(*) FROM users3 WHERE users = ?");
    parentCountPs.setString(1, parentType);
    ResultSet parentCountRs = parentCountPs.executeQuery();
    int parentCount = 0;
    if (parentCountRs.next()) {
        parentCount = parentCountRs.getInt(1);
    }

    // Count of Deliveries
    String deliveryType = "delivery";
    PreparedStatement dCountPs = con.prepareStatement("SELECT COUNT(*) FROM users3 WHERE users = ?");
    dCountPs.setString(1, deliveryType);
    ResultSet dRs = dCountPs.executeQuery();
    int dCount = 0;
    if (dRs.next()) {
        dCount = dRs.getInt(1);
    }
%>

<div class="user-section">
    <div class="container">
        <div class="card admin">
            <img src="AD.webp" alt="Admin" style="width: 100%; height: auto;">
            <p><strong>Admins Count:</strong> <%= adminCount %></p>
        </div>
    </div>

    <div class="container">
        <div class="card teacher">
            <img src="4.png" alt="Teacher" style="width: 100%; height: auto;">
            <p><strong>user Count:</strong> <%= teacherCount %></p>
        </div>
    </div>

    <div class="container">
        <div class="card parents">
            <img src="sp.webp" alt="Parent" style="width: 100%; height: auto;">
            <p><strong>Shop Count:</strong> <%= parentCount %></p>
        </div>
    </div>

    <div class="container">
        <div class="card parents1">
            <img src="delivery.webp" alt="Parent" style="width: 100%; height: auto;">
            <p><strong>delivery Count:</strong> <%= dCount %></p>
        </div>
    </div>
</div>

<h2>Admin</h2>
<hr style="border:none; height: 5px; background-color: red; margin: 20px 0">

<div class="user-section">
    <%  
    // Display Admins
    String aType = "admin";
    PreparedStatement adminPs = con.prepareStatement("SELECT * FROM users3 WHERE users = ?");
    adminPs.setString(1, aType);
    ResultSet adminRs = adminPs.executeQuery();
    while (adminRs.next()) {
        String utype = adminRs.getString(1);
        String uname = adminRs.getString(2);
        String m = adminRs.getString(4);
        String em = adminRs.getString(5);
        String sc = adminRs.getString(6);
    %>

    <div class="card admin">
        <img src="AD.webp" alt="Admin" style="width: 50%; height: auto;">
        <p> <%= utype %></p>
        <p><strong> Name:</strong> <%= uname %></p>
        <p><strong>Email:</strong> <%= em %></p>
        <p><strong>mobile:</strong> <%= m %></p>
 
    </div>
    <%  
    }
    %>
</div>

<h2>users</h2>
<hr style="border:none; height: 5px; background-color: greenyellow; margin: 20px 0;">

<div class="user-section">
    <%  
    // Display Teachers
    PreparedStatement teacherPs = con.prepareStatement("SELECT * FROM users3 WHERE users = ?");
    teacherPs.setString(1, teacherType);
    ResultSet teacherRs = teacherPs.executeQuery();
    while (teacherRs.next()) {
        String utype = teacherRs.getString(7);
        String uname = teacherRs.getString(1);
        String m = teacherRs.getString(2);
        String em = teacherRs.getString(3);
    %>

    <div class="card teacher">
        <img src="4.png" alt="Admin" style="width: 50%; height: auto;">
        <p> <%= utype %></p>
        <p><strong> Name:</strong> <%= uname %></p>
        <p><strong>Email:</strong> <%= em %></p>
        <p><strong>mobile:</strong> <%= m %></p>
        <form class="delete-form" method="post" action="delu.jsp">
            <input type="hidden" name="userId" value="<%= uname %>">
            <input type="submit" value="Delete">
        </form>
    </div>
    <%  
    }
    %>
</div>

<h2>shop</h2>
<hr style="border:none; height: 5px; background-color: blueviolet; margin: 20px 0;">

<div class="user-section">
    <%  
    // Display Parents
    PreparedStatement parentPs = con.prepareStatement("SELECT * FROM users3 WHERE users = ?");
    parentPs.setString(1, parentType);
    ResultSet parentRs = parentPs.executeQuery();
    while (parentRs.next()) {
        String utype = parentRs.getString(7);
        String uname = parentRs.getString(1);
        String m = parentRs.getString(2);
        String em = parentRs.getString(3);
    %>

    <div class="card parents">
        <img src="sp.webp" alt="Admin" style="width: 50%; height: auto;">
        <p>Student</p>
        <p><strong> Name:</strong> <%= uname %></p>
        <p><strong>Email:</strong> <%= em %></p>
        <p><strong>mobile:</strong> <%= m %></p>
        <form class="delete-form" method="post" action="delu.jsp">
            <input type="hidden" name="userId" value="<%= uname %>">
            <input type="submit" value="Delete">
        </form>
    </div>
    <%  
    }
    %>
</div>

<h2>delivery</h2>
<hr style="border:none; height: 5px; background-color: yellow; margin: 20px 0;">

<div class="user-section">
    <%  
    // Display Deliveries
    PreparedStatement dPs = con.prepareStatement("SELECT * FROM users3 WHERE users = ?");
    dPs.setString(1, deliveryType);
    ResultSet dRs2 = dPs.executeQuery();
    while (dRs2.next()) {
        String utype = dRs2.getString(7);
        String uname = dRs2.getString(1);
        String m = dRs2.getString(2);
        String em = dRs2.getString(3);
    %>

    <div class="card delivery">
        <img src="delivery.webp" alt="Admin" style="width: 50%; height: auto;">
        <p> <%= utype %></p>
        <p><strong> Name:</strong> <%= uname %></p>
        <p><strong>Email:</strong> <%= em %></p>
        <p><strong>mobile:</strong> <%= m %></p>
        <form class="delete-form" method="post" action="delu.jsp">
            <input type="hidden" name="userId" value="<%= uname %>">
            <input type="submit" value="Delete">
        </form>
    </div>
    <%  
    }
    %>
</div>

<%
    con.close();
} catch (Exception e) {
    out.println(e);
}
%>

</body>
</html>
