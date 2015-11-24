<%@ page import="java.sql.*" %>
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
if (!UserRole.equals("d")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='account.jsp'");
    out.print("</script>");
}
%>
<%
try{
	String action=request.getParameter("action");


	if(action.equals("addScalar")) {  
%>
		<p>
		<font size="8" face="Verdana" color="#0080ff">
		Upload File (.csv).
		</font>
		</p>

		<p>
		</p>

		Please input or select the path of the file!
		<form name="upload-file" method="POST" enctype="multipart/form-data" action="uploadScalar.jsp">
		<table border="0" width="30%" cellpadding="5">
		<tr>
		<td><B>File path: </B></td>
		<td>
		<input name="file-path"" type="file" class="upload" multiple="">
		</td>
		</tr>
		<tr>
		<td><input name=".submit" value="Upload" type="submit"></td>
		<td><input name=".reset" value="Reset" type="reset"></td>
		</tr>
		</table>
		</form>
		<P><a href="dataCurator.jsp"> Return </a></P>
		
<%	}   

	else if(action.equals("addImage")) {
%>

		Upload Image (.jpg).
		Please input or select the path of the image!
		<form name="upload-file" method="post" enctype="multipart/form-data" action="UploadImage">
		<table border="0" width="30%" cellpadding="5">
		<tr>
		<td><B>File path: </B></td>
		<td>
		<input name="file-path"" type="file" class="upload" multiple="">
		</td>
		</tr>
	
		<tr>
		<td><input name=".submit" value="Upload" type="submit"></td>
		<td><input name=".reset" value="Reset" type="reset"></td>
		</tr>
		</table><br></br>
		</form>
		<br></br>
		<P><a href="dataCurator.jsp"> Return </a></P>
	<%}
	  else if(action.equals("addAudio")) {   %>
		Upload Audio File
		
		<p>
		<font size="8" face="Verdana" color="#0080ff">
		Upload Audio (.wav).
		<form name="upload-file" method="POST" enctype="multipart/form-data" action="UploadAudio">
		<table border="0" width="30%" cellpadding="5">
		<tr>
		<td><B>File path: </B></td>
		<td>
		<input name="file-path"" type="file" class="upload" multiple="">
		</td>
		</tr>
		<tr>
		<td><input name=".submit" value="Upload" type="submit"></td>
		<td><input name=".reset" value="Reset" type="reset"></td>
		</tr>
		</table>
		</form>
		<P><a href="dataCurator.jsp"> Return </a></P>
<%     } 
}catch(Exception e) {
out.println(e.toString());
out.print("<script language=javascript type=text/javascript>");
out.print("javascript:location.href='account.jsp'");
out.print("</script>");
}
	%>
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
