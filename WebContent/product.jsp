<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Drop Shop Ski Shop - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="style.css">
<%@ include file="header.jsp" %>
</head>
<body>


<%
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
    
	String id = request.getParameter("id"); //get the product id parameter from url
   
    try(
		
		//connect to the db
		Connection con = DriverManager.getConnection(url,uid,pw);){
        PreparedStatement pstmt = null;
		ResultSet rst = null;

		//the initial query
		String sql = "SELECT productId, productName, categoryId, productDesc, productImageURL, productPrice FROM product WHERE productId=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1,id); //add the id to the query
        rst = pstmt.executeQuery(); //results of the query

		String sqlReview = "SELECT reviewRating,reviewDate,customerId,reviewComment FROM review WHERE productId=?"; //the reviews to be printed with the items
        PreparedStatement pstmtReview = con.prepareStatement(sqlReview);
        pstmtReview.setString(1,id);
        ResultSet rstReview = pstmtReview.executeQuery();
       
	    //to format the money 
		NumberFormat currencyFor = NumberFormat.getCurrencyInstance();

		while(rst.next()){
			
			//getting everything from 1st query
			int productId = rst.getInt(1);
			String productName = rst.getString(2);
			int categoryId = rst.getInt(3);
			String productDesc = rst.getString(4);
            String productImageURL = rst.getString(5);
			Double productPrice = rst.getDouble(6);
            
			String formatPrice = currencyFor.format(productPrice);
			
			//fixing the product name for the url for addcart
			String productNameAdjusted = java.net.URLEncoder.encode(productName,"UTF-8").replace("+","%20");
			String addCart = "addcart.jsp?id="+productId+"&name="+productNameAdjusted+"&price="+productPrice;
           
			//Start of the results table for the product  
		    out.println("<table>");


            //prints the product image or a default if there is no image
            if(productImageURL != null)
                out.println("<tr><td><img src ="+productImageURL+" style='float:left' width = 500 height= 500></td></tr>");
            else{
                out.println("<tr><td><img src ='./img/istockphoto.jpg' width='300' height='300' style='float:left'></td></tr>");
                 out.println("<tr><td> Sorry no photo of item available.</td></tr>");
            }
			
            out.println("<tr><td><b> Product ID: </b>"+id+"</td></tr>");
		    out.print("<tr><td><th> Product Name </th><th> Product Price</th></td></tr>");
			out.println("<tr><td><a href="+addCart+">Add to cart</a></td><td>"+productName+"</a></td><td>"+formatPrice+"</td></tr>");
			out.println("<tr></tr>");

			while(rstReview.next()){
				//bunch of the product info
				String reviewRating = rstReview.getString(1);
				String reviewDate =rstReview.getString(2);
				String reviewSub = reviewDate.substring(0,4);
				int reviewCust = rstReview.getInt(3);
				String reviewCustomer = String.valueOf(reviewCust);
				String reviewComment = rstReview.getString(4);
				
				//getting the customer name for the review
				String sqlCust = "SELECT firstName FROM customer WHERE customerId=?";
       			PreparedStatement pstmtCust= con.prepareStatement(sqlCust);
        		pstmtCust.setString(1,reviewCustomer);
        		ResultSet rstCust = pstmtCust.executeQuery();
				rstCust.next();
				String reviewCustomers = rstCust.getString(1);

				//printing out available reviews
				out.println("<tr><td><b> Review Rating: </b>"+reviewRating+" Stars</td></tr>");
				out.println("<tr><td><b>&nbsp; Reviewed in  </b>"+reviewSub+"<b> by </b> "+reviewCustomers+" </td></tr>");
				out.println("<tr><td><b>&nbsp; The Review </b>"+reviewComment+ "</td></tr>");

				out.println("<tr></tr>");

			}
			out.print("</table>");
	   	//table for the review inputs
 		if(username!="Guest"){
			out.println("<table>");
			out.println("<tr><td><h2>Type your review: </h2></tr></td>");
			
			out.println("<tr><td><form action='updatereview.jsp'></tr></td>");
			out.println("<input type='hidden' id='prodId' name='prodId' value="+productId+">");
			
			out.println("<tr><td>Your Customer Id: <input type='number' id='custId' name='custId' min='1' max='999' required minlength='1' maxlength='1' size='3'></tr></td>");
			out.println("<tr><td>How many stars: <input type='number' id='stars' name='stars' min='1' max='5' required minlength='1' maxlength='1' size='3'></tr></td>");
			out.println("<tr><td>The review: <input type='text' id='review' name='review' required minlength='4' maxlength='200' size='100'></tr></td>");

			out.println("<tr><td><input type='submit' value='submit'></form></tr></td>");
			out.println("</table>");
		 }else{
			 out.println("<h2>Please sign in to leave a review</h2>");
		 }

		}
        
       	con.close();
	}
	catch(SQLException ex){
		out.println(ex);
	}

%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2> 
</body>
</html>

