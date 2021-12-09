<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="./../../jdbc.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	boolean created = false;
	try{
		 created = (boolean) addAdmin(out,request,session);
	}catch(IOException e){	
		System.err.println(e); 
	}
	if(created){
		session.setAttribute("addAdminMessage","New Admin Added Successfully.");
		out.println("Account created successfully.");
	}
	response.sendRedirect("addAdmin.jsp");		
	 
%>

<%!
	boolean addAdmin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";

		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String cnfmpassword = request.getParameter("cnfmpassword");
		if(!cnfmpassword.equals(password)){
			session.setAttribute("addAdminMessage","Passwords do not match , try again.");
			return false;
		}
		
		boolean retStr = false;
		String info = ("'"+firstName+"','"+lastName+"'"+",'"+username+"'"+",'"+password+"'");
		//String deletesql = "delete from customer where userid like '%arsh%'";
		String sql2 = "Insert into admin (firstName,lastName,userid,password) values("+info+");";
		String sql1 = "Select userid from admin where userid like '"+username+"';";
		
		
		try 
		{
			Connection con = DriverManager.getConnection(url,uid,pw);
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery(sql1);
			
			String names = "";
			boolean catExists = false;
			while(rst.next()){
				names = rst.getString(1)+"\n";
				if(names.equals(username)){
					catExists = true;
				}
			}

			if(catExists == false)
				stmt.executeUpdate(sql2);
			else{
				session.setAttribute("addAdminMessage","A similar user already exists."); 
				return false;
			}
			con.close();
			retStr =  true;
		}			
		catch (SQLException ex) {
			out.println(ex);
			session.setAttribute("addAdminMessage","An Error Occured While adding product.\n"+ex); 
			retStr =  false;
		}
		finally{
		
		out.println("");
		return retStr;
		}
		
	}
%>