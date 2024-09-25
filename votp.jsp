<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.*,java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP</title>
    <style>
        /* Card styles */
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }
        .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            width: 80%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card h2 {
            margin-bottom: 10px;
        }
        .card p {
            margin-bottom: 5px;
        }
        /* Styled button */
        .go-back-button {
            background-color: #007bff;
            color: white;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .go-back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","bmart","bmart123");

            String orderId = request.getParameter("orderId");
            String userEnteredOTP = request.getParameter("otp");

            // Retrieve OTP from OTP table for the given order ID
            PreparedStatement otpStatement = connection.prepareStatement("SELECT * FROM OTP_TABLE WHERE ORDERID = ?");
            otpStatement.setString(1, orderId);
            ResultSet otpResultSet = otpStatement.executeQuery();

            if (otpResultSet.next()) {
                String otpFromTable = otpResultSet.getString("OTP");
                if (otpFromTable.equals(userEnteredOTP)) {
                    // OTP is correct, update order status to "Delivered"
                    PreparedStatement updateStatement = connection.prepareStatement("UPDATE orders1 SET ORDER_STATUS = ? WHERE ORDERID = ?");
                    updateStatement.setString(1, "Delivered");
                    updateStatement.setString(2, orderId);
                    updateStatement.executeUpdate();

                    out.println("<div class='card'><h2>Success</h2><p>Order with ID " + orderId + " has been successfully delivered.</p></div>");
                } else {
                    out.println("<div class='card'><h2>Error</h2><p>Invalid OTP. Please try again.</p><a class='go-back-button' href='javascript:history.back()'>Go Back</a></div>");
                }
            } else {
                out.println("<div class='card'><h2>Error</h2><p>OTP not found for order ID " + orderId + "</p><a class='go-back-button' href='javascript:history.back()'>Go Back</a></div>");
            }

            otpResultSet.close();
            otpStatement.close();
            connection.close();
        } catch (Exception e) {
            out.println("<div class='card'><h2>Error</h2><p>An error occurred: " + e.getMessage() + "</p><a class='go-back-button' href='javascript:history.back()'>Go Back</a></div>");
        }
        %>
    </div>
</body>
</html>
