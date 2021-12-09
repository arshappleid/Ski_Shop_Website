<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Drop Shop Ski Shop Review</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<%
 
   
   	//Note: Forces loading of SQL Server driver
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";

	//Note: Forces loading of SQL Server driver
	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}
	//parameters from the url for the searchs, category or by product
	String prodId = request.getParameter("prodId");
   String custId = request.getParameter("custId");
	String prodName = request.getParameter("name");
   String stars = request.getParameter("stars");
   String review = request.getParameter("review");

	try(Connection con = DriverManager.getConnection(url,uid,pw);){
		
	   String sqlReview = "INSERT INTO review(reviewRating,reviewDate,customerId,productId,reviewComment) VALUES(?,?,?,?,?)";
		
     // String updateTotal = "UPDATE ordersummary SET totalAmount = ?,orderDate = ? WHERE orderId = ?";
		PreparedStatement pstmtReview = con.prepareStatement(sqlReview);
      int intStars = Integer.parseInt(stars);
		pstmtReview.setInt(1, intStars);
		pstmtReview.setDate(2,new java.sql.Date(System.currentTimeMillis()));
      int intCustId = Integer.parseInt(custId);
		pstmtReview.setInt(3, intCustId);
      int intProdId = Integer.parseInt(prodId);
      pstmtReview.setInt(4,intProdId);
      pstmtReview.setString(5,review);

		pstmtReview.executeUpdate();

		
	// Close connection
	con.close();
	}
	catch(SQLException ex){
		out.println(ex);
	}


%>
<!--<jsp:forward page="listprod.jsp" />-->
</html>

