<%-- 
    Document   : logout
    Created on : 19-Apr-2024, 11:47:21
    Author     : DELL
--%>

<%
    // Get the current session
   

    // Invalidate the session if it exists

        session.invalidate();
    
    // Redirect the user to the login page
  
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
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
            width: 250px;
            height: 250px;
        }

        .card {
            width: 300px;
    padding: 20px;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    text-align: center;
    position: relative;
    display: flex; /* Add this */
    flex-direction: column; /* Add this */
    align-items: center; /* Add this */
        }

        .card h1 {
            margin-top: 0;
            color: #333;
            position: relative;
        }

        .card h1:before {
            content: "";
            background-image: url('image.png'); /* Replace with the path to your image */
            background-size: cover;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            position: absolute;
            left: -30px;
            top: 50%;
            transform: translateY(-50%);
        }

        .card p {
            color: #555;
        }

        .card a {
            color: #007bff;
            text-decoration: none;
        }

        .circle {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            overflow: hidden;
            position: relative;
            align-self: center;
            margin-left: 55px;
        }

        .circle img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <!-- Preloader -->
    <div class="preloader" id="preloader">
        <img src="k.gif" alt="Loading...">
    </div>

    <!-- Content -->
    <div class="card" id="content" style="display: none;">
        <div class="circle">
            <img src="log.gif" alt="Image">
        </div>
        <h1>Logout Successful</h1>
        <p>You have been logged out.</p>
        <p><a href="index.html">Login</a></p>
    </div>

    <!-- Disable back button -->
    <script>
        window.onload = function () {
            document.getElementById("content").style.display = "block";
            document.getElementById("preloader").style.opacity = "0";
            setTimeout(function() {
                document.getElementById("preloader").style.display = "none";
            }, 1000);
            
            history.pushState(null, null, location.href); window.onpopstate = function () { history.go(1); }; 

        };
        window.onload = function() {
            window.location.href = "logout.html";
        };
     
    </script>
    
</body>
</html>
