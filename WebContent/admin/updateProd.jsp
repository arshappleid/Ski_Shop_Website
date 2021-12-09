<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="./../jdbc.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	boolean created = false;
	try{
		 created = (boolean) updateProd(out,request,session);
	}catch(IOException e){	
		System.err.println(e); 
	}
	if(created){
		session.setAttribute("addProdMessage","Product Added Successfully.");
		out.println("Account created successfully.");
	}
	response.sendRedirect("updateNewProd.jsp");		
	 
%>

<%!
	boolean addProd(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";

		int prodId = Integer.parseInt(request.getParameter("productId");
		String prodName = request.getParameter("productName");
		String desc = request.getParameter("productDesc");
		String categoryId = Integer.parseInt(request.getParameter("categoryId"));
		
		String info = (""+categoryId+",'"+prodId+"'"+","+desc+""+",'"+prodName+"'");
		
		boolean retStr = false;
		//String info = (""+categoryId+",'"+prodName+"'"+","+price+""+",'"+imgUrl+"'"+",'"+desc+"'");
		//String deletesql = "delete from customer where userid like '%arsh%'";
		//String sql2 = "Insert into product (categoryId,productName,productPrice,productImageURL,productDesc) values("+info+");";
		String sql1 = "Select productId FROM customer where customerId ="+customerId";";
		String sql2 = "Select categoryId from category where categoryId = "+categoryId+";";
		String sql3 = "UPDATE product SET productName ="+prodName+",productDesc ="+desc+",categoryId ="+categoryId+";";
		//String sql1 = "Select productName from product where productName like '"+prodName+"';";
		//String sql1 = "Select productName from product where productName like '"+prodName+"';";
		//String sql3 = "Select categoryId from category where categoryId = "+categoryId+";";
		
		try 
		{
			Connection con = DriverManager.getConnection(url,uid,pw);
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery(sql1);
			
		
			
			int prods = 0;
			String ids = "\n";

			while(rst.next()){
				ids += rst.getInt(1)+"\n";
				prods++;
			}

			boolean catExists = false;
			ResultSet rst2 = stmt.executeQuery(sql2);
			try{
			while(rst2.next()){
				int catID = rst2.getInt(1);
				if(categoryId == catID){
					catExists = true;
					break;
				}
			}}catch(Exception e){
				catExists = false;
			}
			if(prods > 0 && catExists == true)
				stmt.executeUpdate(sql3);
				
			else if (prods == 0){
				session.setAttribute("addProdMessage","Product does not exist"+ids);
				return false;
			}else if (catExists == false){
				session.setAttribute("addProdMessage","Category Does not Exist."+ids); 
				return false;
			}
			session.setAttribute("addProdMessage","Update successful"+info);
			con.close();
			retStr =  true;
		}			
		catch (SQLException ex) {
			out.println(ex);
			session.setAttribute("addProdMessage","An Error Occured While adding product.\n"+ex); 
			retStr =  false;
		}
		finally{
		
		out.println("");
		return retStr;
		}
		
	}
%>