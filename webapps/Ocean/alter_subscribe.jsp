<%@ page import="java.sql.*" %>
<html>
<head></head>
<body>
	<br><br>
	<%
		String sensor_id = request.getParameter("sensor_id");
		out.println(sensor_id);
		
		String action=request.getParameter("action");
		out.print(action);
		
		String person_id=request.getParameter("person");
		out.print(person_id);

		Boolean sensorExist=false;
		Boolean sensorSubscribed=true;


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
		    stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		    ResultSet rset=stmt.executeQuery(query);

		    Object o;
		    ResultSetMetaData rsetMetaData=rset.getMetaData();
		    int ccount=rsetMetaData.getColumnCount();
		    while(rset.next()) {
		        if(sensorExist==false) {
			    o=rset.getObject(1);
			    out.println(o.toString().trim());
			    out.println(sensor_id.trim());
			    if(o.toString().trim()==sensor_id.trim()) {
			        sensorExist=true;
			        out.println("exist");
			    }
		        }
		    }

		    if(action=="add" && sensorExist) {
		        query="INSERT INTO subscriptions VALUES ("+sensor_id+","+person_id+");";
		    }
		    else if(action=="remove" && sensorSubscribed) {}
		}catch(Exception e) {out.println(e.toString());}

	%>
</body>
</html>
