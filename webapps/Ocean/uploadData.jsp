<%@ page import="java.sql.*" %>
<html>
<%
	String action=request.getParameter("action");
	out.print(action);

	if(action.equals("addScalar")) {  %>
		<p>
		<font size="8" face="Verdana" color="#0080ff">
		Upload File (.csv).
		</font>
		</p>

		<p>
		</p>

		Please input or select the path of the image!
		<form name="upload-file" method="POST" enctype="multipart/form-data" action="uploadData.jsp">
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

	if(action.equals("addImage")) {%>
		<p>
		<font size="8" face="Verdana" color="#0080ff">
		Upload Image (.jpg).
		</font>
		</p>

		<p>
		</p>

		Please input or select the path of the image!
		<form name="upload-file" method="POST" enctype="multipart/form-data" action="uploadData.jsp">
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
	<%}
	if(action.equals("addAudio")) {   %>

		<p>
		<font size="8" face="Verdana" color="#0080ff">
		Upload Audio (.wav).
		</font>
		</p>

		<p>
		</p>

		Please input or select the path of the image!
		<form name="upload-file" method="POST" enctype="multipart/form-data" action="uploadData.jsp">
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
<%     } %>
</html>
