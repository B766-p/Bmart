<%-- 
    Document   : updateprushop
    Created on : 21-Apr-2024, 11:53:53
    Author     : DELL
--%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Order Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

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

        /* Footer styles */
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

        h2 {
            margin-bottom: 10px;
        }

        form {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="date"],
        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        .alert {
            padding: 15px;
            background-color: #f44336;
            color: white;
            margin-bottom: 15px;
            border-radius: 5px;
            display: none;
        }

        .alert-container {
            position: relative;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            width: 300px;
            z-index: 9999;
            text-align: center;
        }
        select#status {
        padding: 8px;
        border-radius: 5px;
        border: 1px solid #ccc;
        width: 100%;
        font-size: 16px; /* Adjust font size as needed */
        color: #333; /* Text color */
        background-color: #fff; /* Background color */
    }

    /* Style for the options */
    select#status option {
        padding: 8px;
    }

    /* Style for the selected option */
    select#status option:checked {
        background-color: #007bff; /* Highlight color for selected option */
        color: #fff; /* Text color for selected option */
    }
    </style>
</head>
<body>
    <div class="preloader" id="preloader">
        <img src="k.gif" alt="Loading..."><br><br>
    </div>

    <!-- Page content -->
    <div id="content" style="display: none;">
        <!-- Navbar -->

        <div class="alert-container" id="alertContainer">
            <div class="alert" id="alertMsg"></div>
        </div>
        <div class="container">
            <%
                String orderId = request.getParameter("oi");

                if (orderId != null && !orderId.isEmpty()) {
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");
                        PreparedStatement ps = con.prepareStatement("SELECT EXPECTED_DELIVERY_DATE, ORDER_STATUS FROM orders1 WHERE ORDERID = ?");
                        ps.setString(1, orderId);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            String expd = rs.getString("EXPECTED_DELIVERY_DATE");
                            String status = rs.getString("ORDER_STATUS");
            %>

                            <h2>Update Delivery Date</h2>
                            <form method="POST">
                                <input type="hidden" name="orderId" value="<%= orderId %>">
                                <label for="expd">Delivery Date:<%= formatDate(expd) %></label>
                                <input type="date" id="expd" name="expd" value="<%= formatDate(expd) %>"><br><br>
                                <button type="submit">Update Delivery Date</button>
                            </form>

                            <h2>Update Order Status</h2>
                            <form method="POST">
                                <input type="hidden" name="orderId" value="<%= orderId %>">
                                <label for="status">Order Status:</label>
                                <select id="status" name="status">
                                    <option value="Shipped" <%= status.equals("Shipped") ? "selected" : "" %>>Shipped</option>
                                    <option value="Arrived" <%= status.equals("Arrived") ? "selected" : "" %>>Arrived</option>
                                  
                                </select><br><br>
                                <button type="submit">Update Order Status</button>
                            </form>
            <%
                        } else {
                            out.println("Order not found.");
                        }

                        rs.close();
                        ps.close();
                        con.close();
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                } else {
                    out.println("Invalid orderId.");
                }
            %>
        </div>
    </div>

    <script>
        window.onload = function() {
            document.getElementById("content").style.display = "block";
            document.getElementById("preloader").style.opacity = "0";
            setTimeout(function() {
                document.getElementById("preloader").style.display = "none";
            }, 500);
        };

        function showAlert(message, redirectUrl) {
            var alertMsg = document.getElementById("alertMsg");
            alertMsg.textContent = message;
            alertMsg.style.display = "block";

            setTimeout(function() {
                alertMsg.style.display = "none";
                window.location.href = redirectUrl; // Redirect after 3 seconds
            }, 3000);
        }
    </script>
</body>
</html>

<%!
    String formatDate(String dateStr) {
        if (dateStr == null || dateStr.isEmpty()) {
            return "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = sdf.parse(dateStr);
            sdf.applyPattern("dd MMMM yyyy");
            return sdf.format(date);
        } catch (ParseException e) {
            return dateStr;
        }
    }
%>

<%
    String oId = request.getParameter("orderId");
    String expd1 = request.getParameter("expd");
    String status1 = request.getParameter("status");

    if (oId != null && !oId.isEmpty()) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123");

            if (expd1 != null && !expd1.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date parsedDate = sdf.parse(expd1);
                java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());

                PreparedStatement psExpd = connection.prepareStatement("UPDATE orders1 SET EXPECTED_DELIVERY_DATE = ? WHERE ORDERID = ?");
                psExpd.setDate(1, sqlDate);
                psExpd.setString(2, oId);
                psExpd.executeUpdate();
                psExpd.close();
                out.println("<script>showAlert('Delivery date updated successfully', 'viewodersS.jsp');</script>");
            }

            if (status1 != null && !status1.isEmpty()) {
                PreparedStatement psStatus = connection.prepareStatement("UPDATE orders1 SET ORDER_STATUS = ? WHERE ORDERID = ?");
                psStatus.setString(1, status1);
                psStatus.setString(2, oId);
                psStatus.executeUpdate();
                psStatus.close();
                out.println("<script>showAlert('Order status updated successfully', 'viewodersS.jsp');</script>");
            }

            connection.close();
        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
    }
%>
