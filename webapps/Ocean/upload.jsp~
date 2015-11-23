<%@ page import="java.sql.*" %>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>upload</title>
    </head>
</html>
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
