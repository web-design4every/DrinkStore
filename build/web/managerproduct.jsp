<%-- 
    Document   : product
    Created on : Nov 4, 2020, 2:57:28 PM
    Author     : Admin
--%>

<%@page import="dal.ProductDAO"%>
<%@page import="model.Order"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <link rel="stylesheet" type="text/css" href="https://cdn.powered-by-nitrosell.com/assets/beta/assets/stylesheets/bootstrap-3.3.5.min.css"/>
      <link rel="stylesheet" type="text/css" href="https://cdn.powered-by-nitrosell.com/assets/beta/assets/stylesheets/font-awesome-4.6.3.min.css"/>
      <link rel="stylesheet" type="text/css" href="https://cdn.powered-by-nitrosell.com/assets/beta/assets/stylesheets/systemv2.css?fb47c41a31603799213" />
      <link rel="stylesheet" type="text/css" href="https://cdn.powered-by-nitrosell.com/public_html/9/2091/themes/stylesheet.css?fb47c41a31603799213" />
      <script src="https://cdn.powered-by-nitrosell.com/assets/beta/assets/js/systemv2.js?fb47c41a31603799213"></script>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .container .para1{
                padding-left: auto;
            }
            .container .para1 a{
                color: red;
            }
            .container .para1 h5{
                font-family: sans-serif;
            }
            .container .para2{
                float: right;
                height: 400px;
                width: 400px;
                margin-top: -300px;
            }
            .account a{
                padding-right: 25px;
                text-decoration: none;
                opacity: 1;
            }
            .account a:hover{
                opacity: 0.5;
            }
            p{
                color: red;
            }
            footer .container .row a{
                text-decoration: none;
            }
            /* Drop down */
            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
                list-style-type: none;
            }
            .dropdown:hover .dropdown-content {
                display: block;
            }
            .dropdown-content a {
                color: black;
                padding: 10px;
                text-decoration: none;
                display: block;
                text-align: left;
                font-size: 15px;
            }
            .dropdown-content a:hover{
                color: chocolate;
            }
            /* Content */
            #mainContainer .about{
                text-align: center;
                margin-top: -150px;
                margin-bottom: -100px;
            }
            #mainContainer .about h2{
                padding-bottom: 50px;
            }
            #mainContainer .about img{
                width: 100px;
                height: 100px;
            }
            #mainContainer .about a{
                border-style: solid;
                border-width: 1px;
                text-decoration: none;
                padding: 5px;
            }
                        .pagination {
                display: inline-block;
            }

            .pagination a {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                margin-top: 40px;
            }
            .pagination a.active {
                background-color: #4CAF50;
                color: white;
            }
            .pagination a:hover:not(.active) {
                background-color: chocolate;
            }   
        </style>
    </head>
    <body>
        <%
            HttpSession s = request.getSession(true);
            String us = (String) s.getAttribute("username");
            String admin = (String) s.getAttribute("admin");
        %>
        <% if (us != null){%>
                <p style="text-transform: uppercase;"><img src="img/user.png" style="height: 25px; width: 25px">Hello <%=us%>!</p>
                <%} else if(admin != null){%>
                <p style="text-transform: uppercase;"><img src="img/admin.jpg" style="height: 25px; width: 25px">Welcome back admin!</p>
                <%}%>
        <header>
            <div class="container">
                <div class="search">
               <div class="form-inline hidden-xs findPanel">
                      <form method="post" action="search" >
                     <input type="text" name="txtSearch" class="form-control typeahead" placeholder="Search"> 
                     <input type="submit" value="Go" class="btn btn-default" />  
                     </form>
                  </div>
                  <!--findPanel-->
                  <!--END FIND-->
               </div>
                <div class="image">
                    <a href="home" role="button">
                    <img src="img/logo5.png" style="height:100px;padding: 0 160px 0 160px" alt="Drinkstore logo">
                    </a>
                </div>
                <div class="account">
                    <a  href="shop" style="color:cyan;">Shop</a>
                    <% if (us != null) {%>
                    <li class="dropdown">
                       <a href="javascript:void(0)" class="dropbtn"> Profile</a>
                       <div class="dropdown-content">
                           <a href="profile" role="button">Update Profile</a>
                           <a  href="myorder?username=<%=us%>" role="button">My Order</a>
                       </div>
                    </li>
                   <a  href="logout" role="button">Logout</a>
                   <%} else if (admin != null) {%>
                   <li class="dropdown">
                       <a href="javascript:void(0)" class="dropbtn"> Manager</a>
                       <div class="dropdown-content">
                           <a href="managerproduct">Manager Product</a>
                           <a href="manageruser">Manager User</a>
                           <a href="feedback">View Feedback</a>
                       </div>
                   </li> 
                   <a  href="logout" role="button">Logout</a>
                    <%} else {%>
                    <a href="login" role="button">Login</a>
                    <a href="register.jsp" role="button">Register</a>
                    <%}%>
                </div>
            </div>
         </header>
        <!-- end Header-->
        <!-- start Body-->
        <section id="mainContainer">
            <div class="about" >
                <h2>MANAGE PRODUCT</h2>
                <button><a href="addproduct.jsp">ADD PRODUCT</a></button>
                <table style="width: 70%;height: 100%;" border="1px solid black" align="center">
                    <tr>
                        <td style="font-size:20px;"><b>ProductID</b></td>
                        <td style="font-size:20px;"><b>ProductName</b></td>
                        <td style="font-size:20px;"><b>CategoryName</b></td>
                        <td style="font-size:20px;"><b>Price</b></td>
                        <td style="font-size:20px;"><b>Image</b></td>
                        <td style="font-size:20px;"><b>Manager</b></td>
                    </tr>
             <%
                ProductDAO pdb=new ProductDAO();
                List<Product> arr=pdb.getAllProducts();
                int start=0,end=6;
                if(arr.size()<6){
                    end=arr.size();
                }
                if(request.getParameter("start")!=null){
                    start=Integer.parseInt(request.getParameter("start"));
                }
                if(request.getParameter("end")!=null){
                    end=Integer.parseInt(request.getParameter("end"));
                }
                List<Product> list=pdb.getListByPage(arr, start, end);
                for(Product y:list){
            %>
            <tr>
                <td><%=y.getId()%></td>
                <td><%=y.getName()%></td>
                <td><%=y.getCategory().getCatname()%></td>
                <td><%=y.getPrice()%></td>
                <td><img src="img/<%=y.getImage()%>"></td>
                <td><a href="updateproduct?pid=<%=y.getId()%>">Update</a>
                    <a href="managerproduct?pname=<%=y.getId()%>">Delete</a></td>                           
            </tr>
            <%
                }
            %>
                </table>
                <ul>
            <%
                int a,b;
                int numPage=arr.size()/6;
                if((numPage*6)<arr.size()){
                    numPage +=1;
                }
                for(int i=1;i<=numPage;i++){
                    a=(i-1)*6;
                    b=i*6;
                    if(b>arr.size()){
                        b=arr.size();
                    }
            %>
            <li class="pagination">
                <a href="managerproduct.jsp?start=<%=a%>&end=<%=b%>"><%=i%></a>
            </li>
            <%
                }
            %> 
        </ul>
            </div>
        </section>
        <!-- end Body-->
        <!-- start Footer-->
        <footer>
        <div class="container">
            <div class="row">
                <div class="col-sm-4 hidden-xs sslCertified">
                    <h6>Help</h6>
                    <a href="about.jsp">About Us</a></br>
                    <a href="contact.jsp">Contact Us</a></br>
                </div>
                <div class="col-sm-4 hidden-xs sslCertified" id="social">
                    <h6>Connect</h6>
                    <h6>
                    <a href=""> <i class="fa fa-facebook"></i></a>   
                    <a href=""> <i class="fa fa-twitter"></i></a>    
                    <a href=""> <i class="fa fa-instagram"></i></a>   
                    </h6>
                </div>
                <div class="col-sm-4">
                     <h6>Payment</h6>
                     <i class='fa fa-cc-visa fa-2x '></i> 
                     <i class='fa fa-cc-mastercard fa-2x '></i> 
                     <i class='fa fa-cc-amex fa-2x '></i> 
                     <i class='fa fa-cc-discover fa-2x '></i> 
                     <i class='fa fa-cc-diners-club fa-2x '></i> 
                     <i class='fa fa-cc-jcb fa-2x '></i>  
                </div>
            </div>
        </div>
            <div class="smallprint">
               <a href="trangchu.jsp" class="footerLogo" style="background:url(img/logo5.png);"></a> 
               <p class="pull-right"><a href="#" class="btn btn-default btn-backToTop"><i class="fa fa-chevron-up"></i></a></p>
               <p class = "footerCredits"> <span class="current-year" style="margin-left: 50px">©2020</span> From my store with love <i>·</i> <a href=''>Hoang Tung Lam Drink Store</a></p>
            </div>
        </footer>
        <script src="https://kit.fontawesome.com/e06505cf69.js" crossorigin="anonymous"></script>
        <!-- end Footer-->
    </body>
    </body>
</html>
