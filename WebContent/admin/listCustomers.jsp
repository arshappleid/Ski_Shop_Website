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

	
	
	<h1 >All Customers :</h1>


<%

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

Connection con = null;
Locale.setDefault(Locale.US);
session.setAttribute("delProdMsg",null);

try {

    con = DriverManager.getConnection(url, uid, pw);

	String sql = "SELECT customerId,firstName,lastName,phonenum,email,address,city,state,country from customer";
	PreparedStatement pstmt = con.prepareStatement(sql);
    ResultSet rst = pstmt.executeQuery();	
	out.println("<table><tr><th>Customer Id</th><th>Customer Name</th><th>Phone Number</th><th>Customer Email</th><th>Customer Address</th></tr>");
    
	while (rst.next())
	{	

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		out.println("<tr><td>"+rst.getString(1)+"</td>"+"<td>"+rst.getString(2)+" "+rst.getString(3)+"</td>"+"<td>"+rst.getString(4)+"<td>"+rst.getString(5)+"</td><td>"+rst.getString(6)+","+rst.getString(7)+","+rst.getString(8)+","+rst.getString(9)+"</td>"+"</tr>");
	    
	
	  
    } 
	out.println("</table>");

	con.close();
}catch (SQLException ex) 
{ 	out.println(ex); 
}


%>

</body>
</html>
