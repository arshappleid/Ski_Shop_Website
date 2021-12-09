<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="./../jdbc.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	boolean created = false;
	try{
		 created = (boolean) delPrd(out,request,session);
	}catch(IOException e){	
		System.err.println(e); 
	}
	if(created){
		session.setAttribute("delProdMsg","Product Deleted!.");
	}
	response.sendRedirect("updateProd.jsp");		
	 
%>

<%!
	boolean delPrd(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";

		String prodId = request.getParameter("delProd");

		
		boolean retStr = false;

		String sql1 = ("delete from product where productId ="+prodId+";");
		
		
		try 
		{
			Connection con = DriverManager.getConnection(url,uid,pw);
			Statement stmt = con.createStatement();
			
			stmt.executeUpdate(sql1);
			con.close();
			
			
			retStr =  true;
		}			
		catch (SQLException ex) {
			session.setAttribute("delProdMsg","Could not delete Product.\n"+ex); 
			retStr =  false;
		}
		finally{
		return retStr;
		}
		
	}
%>