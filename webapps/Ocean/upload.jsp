<%@ page import="java.sql.*" %>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>upload</title>
    </head>
</html>
<body>
    <h1>Data Upload</h1>

<%
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
	conn.close();
%>

<h3>Choose data type to upload: </h3>
<input type="radio" value="add" name="action">Add Data
<input type="radio" value="remove" name="action">Add Image
<input type="radio" value="remove" name="action">Add Audio
<form action="uploadData.jsp" method="post">
    <input type="submit" value="Add">
</form>

<p>
<font size="8" face="Verdana" color="#0080ff">
Upload Your Image.
</font>
</p>

<p>
</p>

Please input or select the path of the image!
<form name="upload-image" method="POST" enctype="multipart/form-data" action="upload.jsp">
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
<P><a href="profile.jsp"> Return </a></P>

</body>
