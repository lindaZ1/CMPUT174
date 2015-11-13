<html>
<body>
<div id="image" style="background: url(bg.jpg) no-repeat; width: 100%; height: 100%; background-size: 100%;">

<%@page import="java.sql.*" %>
<%
String checklogin = (String) session.getAttribute("logstatus");
checklogin = "false";
session.setAttribute("logstatus", checklogin);
%>
					
<center>
<br><br><br><br><br><br>
<h1>User logged out.</h1>
<h1>Thank you for using Ocean Observation System.</h1>
</center>

<script language=javascript type=text/javascript>
setTimeout("javascript:location.href='login.html'", 2500);
</script>

</div>
</body>
</html>
