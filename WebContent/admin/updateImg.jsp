<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="./../jdbc.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.util.Enumeration" %>
java.io.File;
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	boolean created = false;
    
	try{
		 created = (boolean) updPrdInv(out,request,session);
	}catch(IOException e){	
		System.err.println(e); 
	}
	
	response.sendRedirect("updateProd.jsp");		
	 
%>

<%!
	boolean updPrdInv(JspWriter out,HttpServletRequest req, HttpSession session) throws IOException
	{
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";
        boolean retStr = false;
		
		
        String sFile = req.getHeader("myFile");
        File file = new File("img/"+sFile);
		String prodId = req.getParameter("prodId");
        

        InputStream inputStream = req.getInputStream();
        FileOutputStream outputStream = new FileOutputStream(file);

		String sql = ("UPDATE Product SET productImageURL="+ outputStream + "WHERE ProductId ="+prodId+";");
		try 
		{
			Connection con = DriverManager.getConnection(url,uid,pw);
			Statement stmt = con.createStatement();
			stmt.executeUpdate(sql);
			con.close();
			
			session.setAttribute("delProdMsg","Inventory for product #"+prodId+" succesfully updated"); 
			retStr =  true;
		}			
		catch (SQLException ex) {
			session.setAttribute("delProdMsg","Could not update Product Image.\n"+ex); 
			retStr =  false;
		}
		finally{
		return retStr;
		}
		
	}
%>