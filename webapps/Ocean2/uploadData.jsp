<%@ page import="java.sql.*" %>
<html>
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

	else if(action.equals("addImage")) {
%>
	       <table>
	       <h3>All Sensors:</h3>
	       <TABLE BORDER=2>
		<TR>
		    <TH>SENSOR_ID</TH>
		    <TH>LOCATION</TH>
		    <TH>SENSOR TYPE</TH>
		    <TH>DESCRIPTION</TH>
		</TR>
<%		String query="select * from sensors";
		stmt=conn.createStatement();
		ResultSet rset=stmt.executeQuery(query);

		Object o;
		ResultSetMetaData rsetMetaData=rset.getMetaData();
		int ccount=rsetMetaData.getColumnCount();

		String ans="";
	
		while(rset.next()) {
		    ans+="<TR>";
		    for(int i=1;i<=ccount;i++) {
			o=rset.getObject(i);
			ans+="<TD>";
			if(o!=null){
			    ans+=o.toString();
			}
			else{
			    ans+="null";
			}
			ans+="</TD>";
		    }
		    ans+="</TR>";
		}
		out.println(ans);
		stmt.close();
		conn.close();
%>
</table>
		<br></br>
		Upload Image
		<form action="uploadImage.jsp" method="post" >
		Image ID(integer only): <input type="text" name="image_id"> <br></br>
		Sensor_ID: <input type="text" value="sensor_id"><br></br>
		Date Created: <input type="date" value="date"><br></br>
		Description: <input type="text" value="desciption"><br></br>
		Upload Thumbnail: 
		<table border="0" width="30%" cellpadding="5">
		<tr>
		<td><B>File path: </B></td>
		<td>
		<input name="file-path"" type="file" class="upload" multiple="">
		</td>
		</tr>
		<tr>
		<td><input name=".reset" value="Reset" type="reset"></td>
		</tr>
		</table>

		Upload Image (.jpg).
		Please input or select the path of the image!
		<!--<form name="upload-file" method="POST" enctype="multipart/form-data" action="uploadFinish.jsp">-->
		<table border="0" width="30%" cellpadding="5">
		<tr>
		<td><B>File path: </B></td>
		<td>
		<input name="file-path"" type="file" class="upload" multiple="">
		</td>
		</tr>
		<tr>
		<td><input name=".reset" value="Reset" type="reset"></td>
		</tr>
		</table><br></br>
		<input name=".submit" value="Upload" type="submit">
		</form>
		<P><a href="dataCurator.jsp"> Return </a></P>
	<%}
	  else if(action.equals("addAudio")) {   %>

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
<%     } 
	%>
</html>
