<%@ page import="java.sql.*" %>
<html>
<%
	String sensor_id=request.getParameter("sensor_id");
	out.println(sensor_id);

	String date=request.getParameter("date");

	String description=request.getParameter("description");
	out.println(description);

	Boolean sensorExist=false;

	Connection conn=null;
        Statement stmt;
        String driverName="oracle.jdbc.driver.OracleDriver";
        String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
        try{        
	    //load and register driver
	    Class drvClass=Class.forName(driverName);
	    DriverManager.registerDriver((Driver)drvClass.newInstance());

	    //establish connection here
	    conn=DriverManager.getConnection(dbstring,"dzhang4","Horsey26");
	    String query="select sensor_id from sensors";
	    
	    stmt=conn.createStatement();
	    ResultSet rset=stmt.executeQuery(query);

	    Object o;
	    ResultSetMetaData rsetMetaData=rset.getMetaData();
	    int ccount=rsetMetaData.getColumnCount();
	    while(rset.next()) {
	        if(sensorExist==false) {
		    o=(rset.getObject(1)).toString();

		    //check if entered sensor exists
		    if(o.equals(sensor_id.trim())) {
		        sensorExist=true;
		        out.println("exist");
		    }
	        }
	    }

	    if(sensorExist==false) {
		out.println("sensor_id: "+sensor_id +" does not exist");
	    }
	}catch(Exception e) {out.println(e.toString());}

	if(sensorExist) {
	//upload after form is filled out correctly
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
<% }
%>
<P><a href="dataCurator.jsp"> Return </a></P>
</html>
