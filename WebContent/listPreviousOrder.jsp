<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="style.css">
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

	
	
	<h1 >Order History</h1>


<%			
		if (session.getAttribute("CustOrderMessage") != null)
				out.println("<p>"+session.getAttribute("CustOrderMessage").toString()+"</p>");
			String username = (String) session.getAttribute("authenticatedUser");
			if(username == null) {
				response.sendRedirect("login/login.jsp");
			}
			try{
			getOrders(out,request,session,username);
			}catch(Exception e){
				session.setAttribute("CustOrderMessage","Could not find orders.");
			}
			session.setAttribute("CustOrderMessage",null);
%>
<%!
	void getOrders(JspWriter out,HttpServletRequest request, HttpSession session, String userid) throws Exception
	{
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";
		Locale.setDefault(Locale.US);
		String sql1  = "select customerId from customer where userid = '"+userid+"'";

		String sql2 = "SELECT O.orderId, O.orderDate, O.totalAmount FROM ordersummary O JOIN customer C on O.customerId = C.customerId where O.customerId = ?";

		String sql3  = "Select P.productId ,P.productName,P.productPrice, O.quantity from orderproduct O  JOIN product P on O.productId = P.productId where O.orderId = ?";

		StringBuilder sb = new StringBuilder();
		boolean retStr = false;
		try {
			Connection con = DriverManager.getConnection(url,uid,pw);
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery(sql1);
			
			boolean hasOrders = false;
			int custId = -1;
			while(rst.next()){
				custId = rst.getInt(1);
			} 

			if(custId != -1){
				PreparedStatement pstmt = con.prepareStatement(sql2);
				pstmt.setInt(1, custId);
				rst = pstmt.executeQuery();
				out.println("<table><tr><th>OrderId</th><th>Order Date</th><th>Total Amount</th></tr>");
				while(rst.next()){

				// get the order details	
				NumberFormat currFormat = NumberFormat.getCurrencyInstance();
				int orderId = rst.getInt(1);
				out.println("<tr><td>"+rst.getInt(1)+"</td>"+"<td>"+rst.getDate(2)+"<td>"+rst.getString(3)+"</td></tr></table>");



				// get the product list, for each order.
				PreparedStatement pstmt2 = con.prepareStatement(sql3);
				pstmt2.setString(1,(orderId+""));
				ResultSet rst2= pstmt2.executeQuery();
				out.println("<br><table><tr><th>Product Id</th><th>Product Name</th><th>Price </th><th>Quantity</th></tr>");
				while(rst2.next()){
				out.println("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getString(2)+"</td><td>"+rst2.getString(3)+"</td><td>"+rst2.getInt(4)+"</td></tr>");

				}
				out.println("</table><br><br>");
				
			
				}
				out.println("</table>");
				retStr = true;

			}

			con.close();
		}			
		catch (SQLException ex) {
			out.println(ex);
			session.setAttribute("CustOrderMessage","Could not load your orders."); 
			retStr =  false;
		}
		//session.setAttribute("loginMessage",sb.toString()); 		
	}
%>

</body>
</html>
