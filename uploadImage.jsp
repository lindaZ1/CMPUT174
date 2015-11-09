<%@ page import="java.sql.*" %>
<html>
<%
	String image_id=request.getParameter("image_id");

	String sensor_id=request.getParameter("sensor_id");

	String date=request.getParameter("date");
	out.println(date);

	Boolean sensorExist=false;
	Boolean dateValid=true;

	if(date.equals("")) {
		out.println("Please choose a date<br></br>");
		dateValid=false;
	}

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
%>
<P><a href="dataCurator.jsp"> Return </a></P>
</html>
