<!DOCTYPE html>
<html>
<head>
<title>Add New Product</title>
<link rel="stylesheet" href="../style.css">
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Enter Product Details.</h3>


<%
// Print prior error login message if present
if (session.getAttribute("addProdMessage") != null)
	out.println("<p>"+session.getAttribute("addProdMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=get >
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Product Name:</font></div></td>
	<td><input type="text" name="productName"  size=30 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Product Price:</font></div></td>
	<td><input type="text" name="productPrice" size=30 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Category:</font></div></td>
	<td><input type="text" name="categoryId" size=30 maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Product Image Url:</font></div></td>
	<td><input type="text" name="productImageURL" size=100 maxlength="10000"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="4">Description:</font></div></td>
	<td><input type="text" name="productDesc" size=100 maxlength="1000"></td>
</tr>
</table>
<br/>

<button type="submit" formaction="addProd.jsp">Add</button>

