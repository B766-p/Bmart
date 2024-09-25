<%-- 
    Document   : admin
    Created on : 21-Apr-2024, 21:26:15
    Author     : DELL
--%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!----======== CSS ======== -->
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600&display=swap');
*{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
}

:root{
    /* ===== Colors ===== */
    
    --primary-color: #3A3B3C;
    --panel-color: #242526;
    --text-color: #CCC;
    --black-light-color: #CCC;
    --border-color: #4D4C4C;
    --toggle-color: #FFF;
    --box1-color: #3A3B3C;
    --box2-color: #3A3B3C;
    --box3-color: #3A3B3C;
    --title-icon-color: #CCC;
    
    /* ====== Transition ====== */
    --tran-05: all 0.5s ease;
    --tran-03: all 0.3s ease;
    --tran-03: all 0.2s ease;
}

body{
    min-height: 100vh;
    overflow: hidden;
}
body.dark{
    --primary-color: #3A3B3C;
    --panel-color: #242526;
    --text-color: #CCC;
    --black-light-color: #CCC;
    --border-color: #4D4C4C;
    --toggle-color: #FFF;
    --box1-color: #3A3B3C;
    --box2-color: #3A3B3C;
    --box3-color: #3A3B3C;
    --title-icon-color: #CCC;
}
/* === Custom Scroll Bar CSS === */
::-webkit-scrollbar {
    width: 8px;
}
::-webkit-scrollbar-track {
    background: #f1f1f1;
}
::-webkit-scrollbar-thumb {
    background: var(--primary-color);
    border-radius: 12px;
    transition: all 0.3s ease;
}

::-webkit-scrollbar-thumb:hover {
    background: #0b3cc1;
}

body.dark::-webkit-scrollbar-thumb:hover,
body.dark .activity-data::-webkit-scrollbar-thumb:hover{
    background: #3A3B3C;
}
.profile-info {
    display: flex;
    flex-direction: row;
    align-items: center;
}

.profile-info img {
    width: 40px;
    border-radius: 50%;
    margin-right: 15px; /* Add some spacing between the image and text */
}

.profile-info p {
    font-size: 14px;
    color: black; /* Set the text color */
}

nav{
    position: fixed;
    top: 0;
    left: 0;
    height: 100%;
    width: 250px;
    padding: 10px 14px;
    background-color: var(--panel-color);
    border-right: 1px solid var(--border-color);
    transition: var(--tran-05);
}
nav.close{
    width: 73px;
}
nav .logo-name{
    display: flex;
    align-items: center;
}
nav .logo-image{
    display: flex;
    justify-content: center;
    min-width: 45px;
}
nav .logo-image img{
    width: 50px;
    object-fit: cover;
    border-radius: 80%;
}

nav .logo-name .logo_name{
    font-size: 22px;
    font-weight: 600;
    color: var(--text-color);
    margin-left: 14px;
    transition: var(--tran-05);
}
nav.close .logo_name{
    opacity: 0;
    pointer-events: none;
}
nav .menu-items{
    margin-top: 40px;
    height: calc(100% - 90px);
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
.menu-items li{
    list-style: none;
}
.menu-items li a{
    display: flex;
    align-items: center;
    height: 50px;
    text-decoration: none;
    position: relative;
}
.nav-links li a:hover:before{
    content: "";
    position: absolute;
    left: -7px;
    height: 5px;
    width: 5px;
    border-radius: 50%;
    background-color: var(--primary-color);
}
body.dark li a:hover:before{
    background-color: var(--text-color);
}
.menu-items li a i{
    font-size: 24px;
    min-width: 45px;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--black-light-color);
}
.menu-items li a .link-name{
    font-size: 18px;
    font-weight: 400;
    color: white;    
    transition: var(--tran-05);
}
nav.close li a .link-name{
    opacity: 0;
    pointer-events: none;
}
.nav-links li a:hover i,
.nav-links li a:hover .link-name{
    color: var(--primary-color);
}
body.dark .nav-links li a:hover i,
body.dark .nav-links li a:hover .link-name{
    color: var(--text-color);
}
.menu-items .logout-mode{
    padding-top: 10px;
    border-top: 1px solid var(--border-color);
}
.menu-items .mode{
    display: flex;
    align-items: center;
    white-space: nowrap;
}
.menu-items .mode-toggle{
    position: absolute;
    right: 14px;
    height: 50px;
    min-width: 45px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
}
.mode-toggle .switch{
    position: relative;
    display: inline-block;
    height: 22px;
    width: 40px;
    border-radius: 25px;
    background-color: var(--toggle-color);
}
.switch:before{
    content: "";
    position: absolute;
    left: 5px;
    top: 50%;
    transform: translateY(-50%);
    height: 15px;
    width: 15px;
    background-color: var(--panel-color);
    border-radius: 60%;
    transition: var(--tran-03);
}
body.dark .switch:before{
    left: 20px;
}

iframe {
    width: 100%;
   
    border: none;
  }

.dashboard {
    position: relative;
    left: 250px;
    min-height: 100vh;
    width: calc(100% - 250px);
    padding: 10px 14px;
    transition: var(--tran-05);
   
}

.dashboard .top {
    position: fixed;
    top: 0;
    left: 250px;
    display: flex;
    background-color: #90EE90; /* Change to light green */
    width: calc(100% - 250px);
    justify-content: space-between ;
   
    padding: 10px 14px;
    background-color: #90EE90; /* Change to light green */
    transition: var(--tran-05);
    z-index: 10;
}

nav.close ~ .dashboard{
    left: 73px;
    width: calc(100% - 73px);
}

nav.close ~ .dashboard .top{
    left: 73px;
    width: calc(100% - 73px);
}
.dashboard .top .sidebar-toggle{
    font-size: 26px;
    color:black;
    cursor: pointer;
}
.dashboard .top .search-box{
    position: relative;
    height: 45px;
    max-width: 600px;
    width: 100%;
    margin: 0 30px;
}
.top .search-box input{
    position: absolute;
    border: 1px solid var(--border-color);
    background-color: var(--panel-color);
    padding: 0 25px 0 50px;
    border-radius: 5px;
    height: 100%;
    width: 100%;
    color: var(--text-color);
    font-size: 15px;
    font-weight: 400;
    outline: none;
}
.top  i {
    color: #242526;
}
.top .search-box i{
    position: absolute;
    left: 15px;
    font-size: 22px;
    z-index: 10;
    top: 50%;
    transform: translateY(-50%);
    color: var(--black-light-color);
}
.top img{
    width: 50px;
    border-radius: 50%;
}
.dashboard .dash-content{
    padding-top: 70px;
}
.dash-content .title{
    display: flex;
    align-items: center;
    margin: 60px 0 30px 0;
}
.dash-content .title i{
    position: relative;
    height: 35px;
    width: 35px;
    background-color: var(--primary-color);
    border-radius: 6px;
    color: var(--title-icon-color);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
}
.dash-content .title .text{
    font-size: 24px;
    font-weight: 500;
    color: var(--text-color);
    margin-left: 10px;
}
.dash-content .boxes{
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
}
.dash-content .boxes .box{
    display: flex;
    flex-direction: column;
    align-items: center;
    border-radius: 12px;
    width: calc(100% / 3 - 15px);
    padding: 15px 20px;
    background-color: var(--box1-color);
    transition: var(--tran-05);
}
.boxes .box i{
    font-size: 35px;
    color: var(--text-color);
}
.boxes .box .text{
    white-space: nowrap;
    font-size: 18px;
    font-weight: 500;
    color: var(--text-color);
}
.boxes .box .number{
    font-size: 40px;
    font-weight: 500;
    color: var(--text-color);
}
.boxes .box.box2{
    background-color: var(--box2-color);
}
.boxes .box.box3{
    background-color: var(--box3-color);
}
.dash-content .activity .activity-data{
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
}
.activity .activity-data{
    display: flex;
}
.activity-data .data{
    display: flex;
    flex-direction: column;
    margin: 0 15px;
}
.activity-data .data-title{
    font-size: 20px;
    font-weight: 500;
    color: var(--text-color);
}
.activity-data .data .data-list{
    font-size: 18px;
    font-weight: 400;
    margin-top: 20px;
    white-space: nowrap;
    color: var(--text-color);
}

@media (max-width: 1000px) {
    nav{
        width: 73px;
    }
    nav.close{
        width: 250px;
    }
    nav .logo_name{
        opacity: 0;
        pointer-events: none;
    }
    nav.close .logo_name{
        opacity: 1;
        pointer-events: auto;
    }
    nav li a .link-name{
        opacity: 0;
        pointer-events: none;
    }
    nav.close li a .link-name{
        opacity: 1;
        pointer-events: auto;
    }
    nav ~ .dashboard{
        left: 73px;
        width: calc(100% - 73px);
    }
    nav.close ~ .dashboard{
        left: 250px;
        width: calc(100% - 250px);
    }
    nav ~ .dashboard .top{
        left: 73px;
        width: calc(100% - 73px);
    }
    nav.close ~ .dashboard .top{
        left: 250px;
        width: calc(100% - 250px);
    }
    .activity .activity-data{
        overflow-X: scroll;
    }
}

@media (max-width: 780px) {
    .dash-content .boxes .box{
        width: calc(100% / 2 - 15px);
        margin-top: 15px;
    }
}
@media (max-width: 560px) {
    .dash-content .boxes .box{
        width: 100% ;
    }
}
@media (max-width: 400px) {
    nav{
        width: 0px;
    }
    nav.close{
        width: 73px;
    }
    nav .logo_name{
        opacity: 0;
        pointer-events: none;
    }
    nav.close .logo_name{
        opacity: 0;
        pointer-events: none;
    }
    nav li a .link-name{
        opacity: 0;
        pointer-events: none;
    }
    nav.close li a .link-name{
        opacity: 0;
        pointer-events: none;
    }
    nav ~ .dashboard{
        left: 0;
        width: 100%;
    }
    nav.close ~ .dashboard{
        left: 73px;
        width: calc(100% - 73px);
    }
    nav ~ .dashboard .top{
        left: 0;
        width: 100%;
    }
    nav.close ~ .dashboard .top{
        left: 0;
        width: 100%;
    }
}
.card2 {
    width: 500px;
    margin-left: 30%;
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
.shop-now-btn {
    background-color: #0b0b0b; /* Button background color */
    color: white; /* Button text color */
    padding: 10px 20px; /* Button padding */
    border-radius: 20px; /* Button border radius for curved shape */
    border: none; /* Remove button border */
    cursor: pointer; /* Add pointer cursor on hover */
    margin-top: 20px; /* Adjust margin-top as needed */
    font-size: 18px; /* Button text size */
    transition: background-color 0.3s, color 0.3s; /* Smooth transition effect for hover */
  }
  .shop-now-btn:hover {
    background-color: #0a81ab; /* Change background color on hover */
    color: #fff; /* Change text color on hover */
  }
    </style>
     
    <!----===== Iconscout CSS ===== -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

    <title>vendor Dashboard Panel</title> 
</head>
<body>
    
    <%if (session != null&& session.getAttribute("b") != null) {%>
    <nav>
        <div class="logo-name">
            <div class="logo-image">
                <img src="k.gif" alt="">
            </div>

            <span class="logo_name">BMART</span>
        </div>

        <div class="menu-items">
            <ul class="nav-links">
                <li><a href="wv1.html">
                    <i class="uil uil-estate"></i>
                    <span class="link-name">Dahsboard</span>
                </a></li>
                <li><a href="adp.jsp">
                    <i class="uil uil-files-landscapes"></i>
                    <span class="link-name">View Profile</span>
                </a></li>
                <li><a href="viewu.jsp">
                    <i class="uil uil-files-landscapes"></i>
                    <span class="link-name">View Users</span>
                </a></li>
                <li><a href="vp.jsp">
                    <i class="uil uil-files-landscapes"></i>
                    <span class="link-name">View prouduct</span>
                </a></li>
                  <li><a href="vo.jsp">
                    <i class="uil uil-files-landscapes"></i>
                    <span class="link-name">View oders</span>
                </a></li>
                <li><a href="vd.jsp">
                    <i class="uil uil-chart"></i>
                    <span class="link-name">view delivered</span>
                </a></li>
               
            </ul>
            
            <ul class="logout-mode" >
                <li  id="log"><a>
                    <i class="uil uil-signout"></i>
                    <span class="link-name">Logout</span>
                </a></li>

                <li class="mode">
                    <a href="#">
                        <i class="uil uil-moon"></i>
                    <span class="link-name">Dark Mode</span>
                </a>

                <div class="mode-toggle">
                  <span class="switch"></span>
                </div>
            </li>
            </ul>
        </div>
    </nav>

    <section class="dashboard">
        <div class="top">
            <i class="uil uil-bars sidebar-toggle"></i>

            
            
            <div class="profile-info">
                <img src="ad.svg" alt="">
                <p><b>Admin</b></p>
            </div>
       
        </div>
        <div class="dash-content">
            <iframe id="iframe"src="wv1.html" width="100%" height="600"></iframe>
        </div>
        
    </section>

    <script>
    const body = document.querySelector("body"),
        modeToggle = body.querySelector(".mode-toggle");
        sidebar = body.querySelector("nav");
        sidebarToggle = body.querySelector(".sidebar-toggle");
  
  let getMode = localStorage.getItem("mode");
  if(getMode && getMode ==="dark"){
      body.classList.toggle("dark");
  }
  
  let getStatus = localStorage.getItem("status");
  if(getStatus && getStatus ==="close"){
      sidebar.classList.toggle("close");
  }
  
  modeToggle.addEventListener("click", () =>{
      body.classList.toggle("dark");
      if(body.classList.contains("dark")){
          localStorage.setItem("mode", "dark");
      }else{
          localStorage.setItem("mode", "light");
      }
  });
  
  sidebarToggle.addEventListener("click", () => {
      sidebar.classList.toggle("close");
      if(sidebar.classList.contains("close")){
          localStorage.setItem("status", "close");
      }else{
          localStorage.setItem("status", "open");
      }
  })
  
  /* === iframe function === */
  const iframe = document.getElementById("iframe");
        const navLinks = document.querySelectorAll(".nav-links li a");

        // Function to handle click on navigation links
        function handleNavLinkClick(event) {
            // Prevent default link behavior
            event.preventDefault();
            
            // Get the href attribute of the clicked link
            const href = this.getAttribute("href");

            // Set the src attribute of the iframe to the link's href
            iframe.src = href;
        }

        // Add click event listener to each navigation link
        navLinks.forEach(link => {
            link.addEventListener("click", handleNavLinkClick);
        });
        // JavaScript to handle the click event
      document.getElementById('log').addEventListener('click', function() {
    // Change the URL to the desired page
    window.location.href = 'logout.jsp';
});
  window.addEventListener('pageshow', function(event) {
        // Check if the event persisted property is false, indicating a page reload
        if (event.persisted) {
            // Reload the page
            window.location.reload();
        }
    });
  </script>
  <% }
else {
  %>
   <div class="container">
       <div class="card2">
        <img src="404.gif" alt="Page Not Found">
        <h1>404 - Page Not Found</h1>
        <p>Sorry, the page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
          <a href="logout.jsp"><button class="shop-now-btn">Logout</button></a>
       </div>
    </div><% }%>
</body>
</html>