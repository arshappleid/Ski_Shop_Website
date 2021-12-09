<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="./../jdbc.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%
	String[] info = new String[3];
	session = request.getSession(true);

	try
	{
		info = validateInfo(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(info[0].equals("verified")){
		session.setAttribute("loginMessage","Password Changed to '123456789', Make sure to reset it After.");
		String username = (String)info[1];
		String text = "changePasswordPage.jsp?username="+username;
		response.sendRedirect(text);
	}
	else
		response.sendRedirect("forgotPassword.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String[] validateInfo(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";

		String username = request.getParameter("username");
		String lastName = request.getParameter("lastName").toLowerCase().trim();
		String email = request.getParameter("email").toLowerCase().trim();
		String[] info = new String[3];
		info[0] = "no";
 		boolean retStr = false;
		
		String query = "Select userid,lastName,email from customer where userid like '%"+username+"%'";

		try {
			Connection con = DriverManager.getConnection(url,uid,pw);
        	//PreparedStatement pstmt = con.prepareStatement(query);
			//pstmt.setString(1, username);
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery(query);
			String login = ""; String name = ""; String mail = "";
			
			while(rst.next()) {
                login = rst.getString(1); // userid
				name = rst.getString(2).toLowerCase().trim();
				mail = rst.getString(3).toLowerCase().trim(); 
            }
			boolean rightdetails = false;
			if(username.equals(login)&&lastName.equals(name)&&email.equals(mail))
				rightdetails = true;

			if(rightdetails){
				retStr = true;
				info[0] = "verified";
				info[1] = username;
				info[2] = "123456789";
			}
			else{
				session.setAttribute("forgotPassMsg","Invalid Details, try again."); 
				retStr =  false;
			}	
			con.close();
		} 
		catch (Exception ex) {
			out.println(ex);
			session.setAttribute("forgotPassMsg","An error occured in sql."+ex);
			retStr = false;
		}
		
		
		return info;
	
	}
%>



