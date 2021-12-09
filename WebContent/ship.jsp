<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Shipment Processing</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

        
<%@ include file="header.jsp" %>

<%
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";

	String ordId = request.getParameter("orderId"); //get order id
	int orderId = Integer.valueOf(ordId);
	
	out.println("<h2>Order Id:  "+ ordId+"</h2>");
 
	try(Connection con = DriverManager.getConnection(url,uid,pw);){         
	
		//retrieves all items with given id
		Statement stmt = con.createStatement();
		con.setAutoCommit(false); //turn off auto commit
		String sql = "SELECT OP.productId, OP.quantity AS orderQty, PI.quantity as Inventory FROM orderproduct OP JOIN productinventory PI ON OP.productid = PI.productid WHERE OP.orderId = ? AND PI.wareHouseId =1 ";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1,orderId);
		ResultSet rst = pstmt.executeQuery();
		
		//if there are products with that orderid, meaning orderid would be valid
		if(rst.isBeforeFirst() ) {
			
			out.print("<table><tr><th></th><th> </th><th></th><th></th><th></th></tr>");
			boolean sufficient = true;
			while(rst.next()){
				int productId = rst.getInt(1);
				int quantity = rst.getInt(2);
				int inventory = rst.getInt(3);
				int newInventory = inventory - quantity;
				
				//if the calculated inventory is available then make the update statement
				if(newInventory >= 0){
					String sqlUpdate = "UPDATE productinventory SET quantity= ? WHERE productId = ?";
					PreparedStatement pstmtUpdate = con.prepareStatement(sqlUpdate);
					pstmtUpdate.setInt(1,newInventory);
					pstmtUpdate.setInt(2,productId);
					pstmtUpdate.executeUpdate();
					out.println("<tr><td><h2>Ordered Product: "+ productId + "</h2></td><td><h2>Quantity: "+ quantity+"</h2></td><td><h2>Previous Inventory: "+inventory +"</h2></td><td><h2>New Inventory: "+newInventory +"</h2></td></tr>");
					stmt.execute("UPDATE productinventory SET quantity= "+newInventory+" WHERE productId = "+productId);
				}else{
					//a flag if one of the items there are not enough of
					sufficient = false;
					out.println("<tr><h2> Shipment not done. Insufficient inventory for product id: "+productId+" </h2></tr>");
				
				}
			}
			out.print("</table>");
			//enough inventory on all items
			if(sufficient == true){
				con.commit();
				out.println("<h2>Shipment succesfully proccesed.</h2>");
			}else{
				//wasn't inventory
				con.rollback();
			}
			
		}else{
			out.println("<h2>Not a valid order</h2>");
		}
		
		con.setAutoCommit(true); //turn back on auto commit
	}catch(SQLException ex){
		out.println("Invalid orderid or doesn't exist.");
	}
	
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>