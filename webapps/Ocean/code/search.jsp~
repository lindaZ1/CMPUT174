<html>
    <head>
        <title>Enter search conditions</title>
    </head>
</html>
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
if (!UserRole.equals("a")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='account.jsp'");
    out.print("</script>");
}
%>
    
    <h3> Enter search conditions </h3>
<TABLE>
    <form action= "searchResult.jsp" method="post">
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>List of Keywords:</TD>
    <TD><input type="text" name= "keywords"> AND/OR</TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Sensor Type:</TD>
    <TD><input type="text" name="type"> AND/OR</TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Sensor Location:</TD>
    <TD><input type = "text" name="location"> AND</TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Time Period:</TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Date after (DD/MM/YYYY)</TD>
    <TD><input type = "text" name="begin"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Date before(DD/MM/YYYY)</TD>
    <TD><input type = "text" name ="end"></TD>
</TR>
</TABLE>
    <input type="submit" name="submit" value= "search">
  </form>
   <br><br>
    <form action= "scientist.jsp" method="post">
    <input type="submit" name="submit" value= "Main Menu">
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
