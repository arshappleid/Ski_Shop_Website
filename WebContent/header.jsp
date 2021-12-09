<H1><a href="index.jsp">Drop Shop Ski Shop</a></H1>      


<%
 
String username = (String) session.getAttribute("authenticatedUser");
if(username==null)
  username="Guest";

out.println("<div class='topnav'> <a class='active' href='index.jsp'>Home</a><a href='listprod.jsp'>Store</a><a href='about.jsp'>About Us</a><a href='customer.jsp'>Logged in as: "+username+" </a></div><hr>");
%>