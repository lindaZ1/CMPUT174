<%@ page import="java.sql.*" %>
<html>
<%

	
	if (request.getParameter(".submit") != null) {
		String sensor_id=request.getParameter("sensor_id");

		String date=request.getParameter("date");
		String year=date.substring(0,4);
		String monthday=date.substring(5);
		date=monthday+"-"+year;
		String description=request.getParameter("description");
		String time=request.getParameter("time");
		String datetime=date+" "+time;

		Boolean sensorExist=false;
		Boolean desc=true;
	
		if(description=="") {
			out.println("please enter a description");
			desc=false;
		}

		String driverName="oracle.jdbc.driver.OracleDriver";
		String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		try{        
		    //load and register driver
		    Class drvClass=Class.forName(driverName);
		    DriverManager.registerDriver((Driver)drvClass.newInstance());

		    //establish connection here
		    Connection conn=null;	
		    conn=DriverManager.getConnection(dbstring,"dzhang4","Horsey26");
		    String query="select sensor_id from sensors";
		    
		    Statement stmt;
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
			    }
			}
		    }

		    if(sensorExist==false) {
			out.println("sensor_id: "+sensor_id +" does not exist");
		    }

		    if(sensorExist && desc) {
			    int image_id=(Integer)session.getAttribute("currentid");


out.println("update images set date_created=TO_DATE('"+datetime+"','mm/dd/yyyy hh24:mi:ss'),sensor_id='"+sensor_id+"',description='"+description+"'where image_id='"+image_id+"'");


			    stmt.execute("update images set date_created=TO_DATE('"+datetime+"','mm/dd/yyyy hh24:mi:ss'),sensor_id='"+sensor_id+"',description='"+description+"' where image_id='"+image_id+"'");
			    stmt.execute("commit");
			
		    }
		}catch(Exception e) {out.println(e.toString());}

	}
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
<%		

		String driverName="oracle.jdbc.driver.OracleDriver";
		String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		       
	        //load and register driver
	        Class drvClass=Class.forName(driverName);
	        DriverManager.registerDriver((Driver)drvClass.newInstance());

	        //establish connection here
	        Connection conn=null;	
	        conn=DriverManager.getConnection(dbstring,"dzhang4","Horsey26");
	    

		String query="select * from sensors";
		Statement stmt;
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
	Upload Image
	<form action="uploadImage.jsp" method="post" >
	Sensor_ID: <input type="text" value="sensor_id" name="sensor_id"><br></br>
	Date Created: <input type="date" value="date" name="date"><br></br>
	Time: <input type="time" value="time" name="time" step="1"><br></br>
	Description: <input type="text" value="description" name="description"><br></br>
	<input name=".submit" value="Upload" type="submit">
	</form>

<P><a href="dataCurator.jsp"> Return </a></P>
</html>
