<html>
<body>
<%
String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin == "false"){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='login.html'");
    out.print("</script>");
}
%>
<H1>Scientist</H1>
<form action="subscribe.jsp" method="post">
   <input type="submit" value="Subscriptions">
</form>

<form action="search.jsp" method="post">
   <input type="submit" value="Search">
</form>

<form action="dataAnalysis.jsp" method="post">
   <input type="submit" value="Data Analysis">
</form>

<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>
</body>
</html>
