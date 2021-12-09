<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../style.css">
<title>Drop Shop Order List</title>
<style type="text/css" media="screen">

	table{
	border-collapse:collapse;
	border:1px solid #000000;
	}
	
	table td{
	border:1px solid #000000;
	}
	</style>
</head>
<body>

	
	
	<h1 >All Products :</h1>


<%

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
session.setAttribute("delProdMsg",null);
Connection con = null;
Locale.setDefault(Locale.US);

try {

    con = DriverManager.getConnection(url, uid, pw);

	String sql = "SELECT productId,productName,productPrice,categoryId,productDesc from product";
	PreparedStatement pstmt = con.prepareStatement(sql);
    ResultSet rst = pstmt.executeQuery();	
	out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Price $</th><th>Category Id</th><th>Description</th></tr>");
    
	while (rst.next())
	{	

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		out.println("<tr><td>"+rst.getString(1)+"</td>"+"<td>"+rst.getString(2)+"</td><td> "+rst.getString(3)+"</td>"+"<td>"+rst.getString(4)+"<td>"+rst.getString(5)+"</td>"+"</tr>");
	    
	
	  
    } 
	out.println("</table>");

	con.close();
}catch (SQLException ex) 
{ 	out.println(ex); 
}


%>

</body>
</html>
