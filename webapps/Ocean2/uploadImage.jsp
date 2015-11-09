<%@ page import="java.sql.*" %>
<html>
<%
	String image_id=request.getParameter("image_id");
	out.println(image_id);
%>
<P><a href="dataCurator.jsp"> Return </a></P>
</html>
