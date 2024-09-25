<%-- 
    Document   : sucessup
    Created on : 13-Mar-2024, 20:16:29
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.util.UUID" %>
<%
// Generate a unique ID for the product
String productId = UUID.randomUUID().toString();
 String emailId=(String) session.getAttribute("b");
// Retrieve the session attributes
String productName = (String) session.getAttribute("productName");
String description = (String) session.getAttribute("description");
String  price = String.valueOf((Double) session.getAttribute("price"));
String category = (String) session.getAttribute("category");
String uploadedFileName = (String) session.getAttribute("uploadedFileName");

// Convert session attributes to a string format
out.println(productId );
out.println(productName );
out.println( description);
out.println(category );
out.println(uploadedFileName);
out.println(price);

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bmart", "bmart123"); 
            String sql = "INSERT INTO Product (emailId, productId, productName, description, price, category, uploadedFileName) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
             statement.setString(1, emailId);
             statement.setString(2, productId);
             statement.setString(3, productName);
             statement.setString(4, description);
             statement.setString(5, price);
             statement.setString(6, category);
             statement.setString(7, uploadedFileName);

                // Execute the query
                ResultSet resultSet = statement.executeQuery(); 
               if (resultSet.next()) {
            response.sendRedirect("s.html");
            }
            else
            {
                  response.sendRedirect("f.html");   }
                } 
            catch (Exception e) 
            {
            e.printStackTrace();
            out.println(e);
            }
%>
