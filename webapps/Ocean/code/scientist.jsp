<html>
<body>
<div id="image" style="background: url(bg.jpg) no-repeat fixed; width: 100%; min-height: 100%; background-size: cover;">
<center>
<br>
<H2>Ocean Observation System</H2>
<br><br>
<%
String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin.equals("false")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='login.html'");
    out.print("</script>");
}
String UserRole = (String) session.getAttribute("userrole");
if (!UserRole.equals("s")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='account.jsp'");
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
</center>
<center><h3>
<br><br>
<a href='../document/UserDocumentation.html' target='_blank'>Help</a>
</h3></center>
</div>
</body>
</html>
