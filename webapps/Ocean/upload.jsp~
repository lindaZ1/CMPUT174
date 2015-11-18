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
<form action="uploadData.jsp" method="post">
<input type="radio" value="addScalar" name="action" checked="checked">Add Data
<input type="radio" value="addImage" name="action">Add Image
<input type="radio" value="addAudio" name="action">Add Audio
<br></br> <input type="submit" value="Add">
</form>

