<%@ page import="java.sql.*" %>
<html>
<%
String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin == "false"){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='login.html'");
    out.print("</script>");
}
%>
<%
	String action=request.getParameter("action");
	out.print(action);

	//establish the connection to the underlying database
	Connection conn = null;
	//load and register the driver
	Class drvClass = Class.forName("oracle.jdbc.driver.OracleDriver"); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	//establish the connection 
	conn = DriverManager.getConnection("jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS","dzhang4","Horsey26");
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement();
	//ResultSet rset = stmt.executeQuery("SELECT pic_id_sequence.nextval from dual");
	//rset.next();
	//int pic_id = rset.getInt(1);
	//session.setAttribute("getid", pic_id);
	//session.setAttribute("currentid", pic_id);


	if(action.equals("addScalar")) {  
%>
		<p>
		<font size="8" face="Verdana" color="#0080ff">
		Upload File (.csv).
		</font>
		</p>

		<p>
		</p>

		Please input or select the path of the image!
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
	%>
<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>
</html>
