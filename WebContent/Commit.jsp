<!DOCTYPE html>
<html>
<head>
<%@page import="javax.servlet.ServletContext"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.http.Cookie"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="java.util.*"%>


<% String temp=request.getSession().getAttribute("error").toString();
HashMap<String,String> commitHM = new HashMap<String,String>();
commitHM=(HashMap)request.getSession().getAttribute("prevURLHM");

request.getSession().setAttribute("flag","1");

//System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhhh "+request.getSession().getAttribute("prevURL").toString());
%>


<!--%System.out.println("new executed !!!!!!!!!!!!!!!!");
	ServletContext xt = getServletContext();
	RequestDispatcher xyzServlet = xt.getRequestDispatcher("/CoMorbMain.jsp?"+request.getSession().getAttribute("prevURL").toString());
	xyzServlet.forward(request,response);
	 172.31.133.123    request.getSession().getServletContext().getAttribute("prevURL").toString()%-->
</head>
<body>
<p>Result of commit is <%=temp %></p>
<form name="input" action="CoMorbMain.jsp" method="POST">
<% Iterator it = commitHM.entrySet().iterator();
	while (it.hasNext()) {
    Map.Entry pairs = (Map.Entry)it.next();
    %>
    <input type="hidden" id='<%=pairs.getKey() %>' name="<%=pairs.getKey()%>" value ="<%=pairs.getValue()%>">
     
   <% System.out.println("Main !!!! "+pairs.getKey() + " = " + pairs.getValue());
    it.remove(); // avoids a ConcurrentModificationException
}
%>
<input type="submit" value="Go Back">
</form>

</body>