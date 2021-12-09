<!DOCTYPE html>
<html>
<head>
        <title>Drop Shop Ski Shop</title>
        <link rel="stylesheet" href="style.css">
</head>

<body>
<h1 align="center">Welcome to Drop Shop Ski Shop</h1>
<%
 String username = (String) session.getAttribute("authenticatedUser");
 if(username!=null)
 	out.println("<h2 align='center'>Welcome to the store! You're logged in as: "+username+"</h2>");
 else
	out.println("<h2 align='center'>Welcome to the store guest,</h2>");
 %>
<h2 align="center"><a href="./login/login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listPreviousOrder.jsp">List Previous Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin/adminLogin/adminLogin.jsp">Admin</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)	
%>
</body>
</head>


