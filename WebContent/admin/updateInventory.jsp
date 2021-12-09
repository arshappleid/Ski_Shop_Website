<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="./../jdbc.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	boolean created = false;
	try{
		 created = (boolean) updPrdInv(out,request,session);
	}catch(IOException e){	
		System.err.println(e); 
	}
	
	response.sendRedirect("updateProdInv.jsp");		
	 
%>

<%!
	boolean updPrdInv(JspWriter out,HttpServletRequest req, HttpSession session) throws IOException
	{
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";
		
		
        String prodId = req.getParameter("prodId");
		String newAmount = req.getParameter("_inv");
		String warehouseId = req.getParameter("_wId");
		

		boolean retStr = false;

		String sql1 = ("update productinventory set quantity="+newAmount+" where productId ="+prodId+"and warehouseId ="+warehouseId);
		
		
		
		try 
		{
			Connection con = DriverManager.getConnection(url,uid,pw);
			Statement stmt = con.createStatement();
			stmt.executeUpdate(sql1);
			con.close();
			
			session.setAttribute("delProdMsg","Inventory for product #"+prodId+" succesfully updated"); 
			retStr =  true;
		}			
		catch (SQLException ex) {
			session.setAttribute("delProdMsg","Could not update Product Incentory.\n"+ex+sql1); 
			retStr =  false;
		}
		finally{
		return retStr;
		}
		
	}
%>