<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
String id=request.getParameter("id");
//if the product is in the session productlist remove it
if(productList.containsKey(id)){
    productList.remove(id);
}

session.setAttribute("productList", productList);
%>
<jsp:forward page="listprod.jsp" />