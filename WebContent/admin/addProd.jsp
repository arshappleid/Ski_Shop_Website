<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="./../jdbc.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	boolean created = false;
	try{
		 created = (boolean) addProd(out,request,session);
	}catch(IOException e){	
		System.err.println(e); 
	}
	if(created){
		session.setAttribute("addProdMessage","Product Added Successfully.");
		out.println("Account created successfully.");
	}
	response.sendRedirect("addNewProd.jsp");		
	 
%>

<%!
	boolean addProd(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";

		String prodName = request.getParameter("productName");
		String price = request.getParameter("productPrice");
		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		String imgUrl = request.getParameter("productImageURL");
		String desc = request.getParameter("productDesc");

		boolean retStr = false;
		String info = (""+categoryId+",'"+prodName+"'"+","+price+""+",'"+imgUrl+"'"+",'"+desc+"'");
		//String deletesql = "delete from customer where userid like '%arsh%'";
		String sql2 = "Insert into product (categoryId,productName,productPrice,productImageURL,productDesc) values("+info+");";
		String sql1 = "Select productName from product where productName like '"+prodName+"';";
		String sql3 = "Select categoryId from category where categoryId = "+categoryId+";";
		
		try 
		{
			Connection con = DriverManager.getConnection(url,uid,pw);
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery(sql1);
			
		
			
			int prods = 0;
			String names = "\n";

			while(rst.next()){
				names += rst.getString(1)+"\n";
				prods++;
			}

			boolean catExists = false;
			ResultSet rst2 = stmt.executeQuery(sql3);
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
			if(prods == 0 && catExists == true)
				stmt.executeUpdate(sql2);
			else if (prods > 0){
				session.setAttribute("addProdMessage","Product Already Exists."+names);
				return false;
			}else if (catExists == false){
				session.setAttribute("addProdMessage","Category Does not Exist."); 
				return false;
			}
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