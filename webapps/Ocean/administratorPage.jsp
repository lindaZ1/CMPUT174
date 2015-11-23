<HTML> 
<head>
<title>Administrator Page</title>
</head>
    <BODY> 
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
if (!UserRole.equals("a")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='account.jsp'");
    out.print("</script>");
}
%>
	<h1 style="font-size:160%">Administrator</h1>
	<p style="font-size:130%">
	Select tables you want to check:<br>
	<form  action= "editSensor.jsp" method="post">
   	 <input type="submit" name="Sensor Table" value="Sensor Table">
 	 </form>
	<form  action= "editUser.jsp" method="post">
   	 <input type="submit" name="User Table" value="User Table">
 	 </form>
	<form  action= "account.jsp" method="post">
   	 <input type="submit" name="account" value="My Account">
 	 </form>
	</p>
</center>
<center><h3>
<br><br>
<a href='UserDocumentation.html' target='_blank'>Help</a>
</h3></center>
</div>
    </BODY> 
</HTML> 
