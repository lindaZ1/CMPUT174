<%@ page import="java.sql.*" %>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>upload</title>
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
    <h1>Data Upload</h1>

<h3>Choose data type to upload: </h3>
<form action="uploadData.jsp" method="post">
<input type="radio" value="addScalar" name="action" checked="checked">Add Scalar Data
<input type="radio" value="addImage" name="action">Add Image
<input type="radio" value="addAudio" name="action">Add Audio
<br></br> <input type="submit" value="Add">
</form>
<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>
</center>
<center><h3>
<br><br>
<a href='UserDocumentation.html' target='_blank'>Help</a>
</h3></center>
</div>
</body>
</html>
