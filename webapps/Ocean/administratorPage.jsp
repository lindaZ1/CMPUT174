<HTML> 
    <BODY> 
<%
String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin == "false"){
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
	<h1 style="font-size:160%">Role: Administrator</h1>
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
    </BODY> 
</HTML> 
