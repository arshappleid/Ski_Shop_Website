<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="./../jdbc.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%
	boolean changed = false;
	session = request.getSession(true);

	try
	{
		changed = chngpass(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }
	if(changed){
		session.setAttribute("loginMessage","Password changed.");
		response.sendRedirect("login.jsp");
	}else{
		response.sendRedirect("forgotPassword.jsp");
	}
	
%>


<%!
	boolean chngpass(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";
		
		String username = (String) request.getParameter("username");
		String newpass = (String) request.getParameter("newpass");
		

		newpass = newpass.toLowerCase().trim();
		boolean retStr = false;
		
		String sql1 = "update customer set password = '"+newpass+"' where userid = '"+username+"';";
		try {
			Connection con = DriverManager.getConnection(url,uid,pw);
			Statement stmt = con.createStatement();
			stmt.executeUpdate(sql1);
			con.close();
			retStr = true;
		} 
		catch (Exception ex) {
			out.println(ex);
		}
		
		return retStr;
	
	}
%>



