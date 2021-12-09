<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="./../../jdbc.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%
	boolean updated = false;
	session = request.getSession(true);

	try
	{
		updated = updateOrd(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(updated){
		session.setAttribute("updtOrderMsg","Order updated."); 
	}
	response.sendRedirect("./chngOrderStatus.jsp");		
	
%>


<%!
	boolean updateOrd(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";

		String orderid = request.getParameter("orderId");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String postCode = request.getParameter("postalCode");
		String country = request.getParameter("country");

		boolean retStr = false;
		

		String sql1 = "Select orderid from ordersummary where orderid = "+orderid+";";
		String sql2 = ("update ordersummary set shiptoAddress ='"+address+"' where orderid = "+orderid+";");
		String sql3 = ("update ordersummary set shiptoPostalCode ='"+postCode+"' where orderid = "+orderid+";");
		String sql4 = ("update ordersummary set shiptoCountry ='"+country+"' where orderid = "+orderid+";");
		String sql5 = ("update ordersummary set shiptoCity ='"+address+"' where orderid = "+orderid+";");
		try {
			Connection con = DriverManager.getConnection(url,uid,pw);
        	//PreparedStatement pstmt = con.prepareStatement(query);
			//pstmt.setString(1, username);
			Statement stmt = con.createStatement();
			ResultSet rst =stmt.executeQuery(sql1);			
			int cols = rst.getMetaData().getColumnCount();
			boolean orderIdExists = false;
			while(rst.next()) {
                if(orderid.equals(rst.getString(1))){
					 orderIdExists = true;
					 break;
				}
            }
			if(orderIdExists){
				//con.setAutocommit(false);
				if(address != null)
					stmt.executeUpdate(sql2);
				if(postCode != null)
					stmt.executeUpdate(sql3);
				if(country != null)
					stmt.executeUpdate(sql4);
				if(city != null)
					stmt.executeUpdate(sql5);
				//con.commit();
				//con.setAutocommit(true);
				retStr =  true;
			}
			else{
				session.setAttribute("updtOrderMsg","Order ID does not exist in system."); 
				return false;
			}	
			con.close();
		} 
		catch (Exception ex) {
			out.println(ex);
			session.setAttribute("updtOrderMsg","Could not update Order , check info  and try again."+ex);
		}
		
		return retStr;
	
	}
%>



