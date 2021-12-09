<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../style.css">
<title>Drop Shop Admin Product Page</title>
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

	
	
	<h1 align = "center"> All Products </h1>
	<h1>Select warehouse:</h1>

<form method="get" action="updateProdInv.jsp">
  <label for="warehouse">
  <select id="warehouse" name="warehouse">
	<option value="0">All warehouses</option>
	<option value="1">Warehouse 1</option>
    <option value="2">Warehouse 2</option>
  </select>
  </label>
<input type="submit" value="Submit" >
<hr>

<%


String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

Connection con = null;
Locale.setDefault(Locale.US);
try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}

  String wId = request.getParameter("warehouse");
  
try {
     
    con = DriverManager.getConnection(url, uid, pw);

	String sql = "SELECT productId,productName,productPrice,categoryId,productDesc from product";
	String sql2 = "select sum(quantity) from productinventory  where productId = ? ";
	PreparedStatement pstmt = con.prepareStatement(sql);
    ResultSet rst = pstmt.executeQuery();	
	out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Price $</th><th>Category Id</th><th>Description</th><th>Delete Product</th><th>Inventory</th>");

	boolean hasWarehouse = wId !=null && !wId.equals("");
    PreparedStatement pstmt2 = null;

	if(hasWarehouse && !wId.equals("0")){
		out.print("<th>Update Inventory</th>");
			int warehouseId = Integer.valueOf(wId);
			sql2 += "AND warehouseId = ? group by productId";
			pstmt2 = con.prepareStatement(sql2);
			pstmt2.setInt(2,warehouseId);
		}
		else{
			sql2 += "group by productId";
			pstmt2 = con.prepareStatement(sql2);
			
		}
	out.print("</tr>");
	while (rst.next())
	{	
	
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		int prodId = rst.getInt(1);
		String text = ("<tr><td>"+prodId+"</td>"+"<td>"+rst.getString(2)+"</td><td> "+rst.getString(3)+"</td>"+"<td>"+rst.getString(4)+"<td>"+rst.getString(5)+"</td>"+"<td><a href=\"delete.jsp?delProd="+prodId+"\">Delete</a></td>");
		
		
		pstmt2.setInt(1,prodId);
		ResultSet rs = pstmt2.executeQuery();
		int inv = 0;
		if(rs.next()) {
			 inv += rs.getInt(1); 
		}
		
		text+="<td>"+inv+"</td>";
		if(hasWarehouse && !wId.equals("0")){
		text+="<form method=\"get\">";
		text+= ("<td><input type = \"text\" name = \"_inv\" size = 5 maxlength=10 >");
		text+=("<input type=\"hidden\" name=\"prodId\" value ="+prodId+">");
		text+=("<input type=\"hidden\" name=\"_wId\" value ="+wId+">");
		text+= ("<input type=\"submit\" value = \"Update\" formaction=\"updateInventory.jsp\"></td>");
		text+= "</form>";
		}
		text+= "</tr>";	
		out.println(text);
	    
    } 
	out.println("</table>");

	con.close();
}catch (SQLException ex) 
{ 	out.println(ex); 
}

// Print prior error login message if present
if (session.getAttribute("delProdMsg") != null)
	out.println("<p>"+session.getAttribute("delProdMsg").toString()+"</p>");
session.setAttribute("delProdMsg",null);
%>

</body>
</html>
