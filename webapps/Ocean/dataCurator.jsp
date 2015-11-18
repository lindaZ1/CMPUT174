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
<H1>Data Curator</H1>
<form action="upload.jsp" method="post">
   <input type="submit" value="Upload Data">
</form>

<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>
</body>
</html>
