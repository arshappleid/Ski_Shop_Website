<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="style.css"  >
<%@ include file="header.jsp" %>
<title>Drop Shop Ski Shop</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<!--pull down menu for searching skis and snowboards-->
<form method="get" action="listprod.jsp">
  <label for="skis">
  <select id="skis" name="skis">
	<option value="0">Categories</option>
    <option value="1">All Mountain Skis</option>
    <option value="2">Racing Skis</option>
    <option value="3">Freeride Skis</option>
	<option value="4">Carving Skis</option>
	<option value="5">Park Boards</option>
	<option value="6">AM Boards</option>
	<option value="7">Freeride Boards</option>
    <option value="8">Powder Boards</option>
  </select>
  </label>

<input type="text" name="productName" name="productName" size="50">
<input type="submit" value="Submit" ><input type="reset" value="Reset"> (Leave blank for all products)
</form>


<% 
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
	Locale.setDefault(Locale.US);	
	

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
	String name = request.getParameter("productName");
	String catId = request.getParameter("skis");

	try(Connection con = DriverManager.getConnection(url,uid,pw);){
		//Querying for the products
		String sql = "SELECT productId, productName, categoryId, productDesc, productPrice, productImageUrl FROM product";
		String sql2 = "select sum(quantity) from productinventory where productId = ? group by productId;";
		boolean hasProduct = name != null && !name.equals("");
		boolean hasCategory = catId !=null && !catId.equals("");
		
		PreparedStatement pstmt = null;
		ResultSet rst = null;

		//if the form was filled out for product or for category, depending it goes to that conditional
		if(hasProduct){
			name = "%"+name+"%";
			sql+= " WHERE productName LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,name);
			rst = pstmt.executeQuery();
		
		}else if(hasCategory && !catId.equals("0")){
			int categoryId = Integer.valueOf(catId);
			sql += " WHERE categoryId= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,categoryId);
			rst = pstmt.executeQuery();
		}
		//no searching it will just query the default sql
		else{
			pstmt = con.prepareStatement(sql);
			rst = pstmt.executeQuery();
		}
		//Execute query
		sql = pstmt.toString();

		NumberFormat currencyFor = NumberFormat.getCurrencyInstance();

		//table header
		out.print("<table><tr><th>     </th><th>Product Name</th><th>Product Price</th><th>Inventory</th></tr>");
		
		// Print out the ResultSet
		while(rst.next()){
			//the product query information for each product
			int productId = rst.getInt(1);
			String productName = rst.getString(2);
			int categoryId = rst.getInt(3);
			String productDesc = rst.getString(4);
			Double productPrice = rst.getDouble(5);
			String productImageURL = rst.getString(6);

			//querying for inventory of the product
			PreparedStatement pstmt2 = con.prepareStatement(sql2);
			pstmt2.setInt(1,productId);
			ResultSet rs = pstmt2.executeQuery();
			int inventory = 0;
			if(rs.next()) inventory = rs.getInt(1);
			String formatPrice = currencyFor.format(productPrice);
			String productNameAdjusted = java.net.URLEncoder.encode(productName,"UTF-8").replace("+","%20");
			String addCart = "addcart.jsp?id="+productId+"&name="+productNameAdjusted+"&price="+productPrice;
			String removeCart = "removecart.jsp?id="+productId;
			String productPage = "product.jsp?id="+productId;
			//the product images
			if(productImageURL != null)
                out.println("<tr><td><img src ="+productImageURL+" style='float:left' width = 200 height= 200></td></tr>");
			out.println("<tr><td><a href="+addCart+">Add to cart </a><a href="+removeCart+"> Remove Item</a></td><td><a href="+productPage+">"+productName+"</a></td><td>"+formatPrice+"</td><td>"+inventory+"</td></tr>");
				
		}
	// Close connection
	con.close();
	}
	catch(SQLException ex){
		out.println(ex);
	}

%>

</body>
</html>
