<%@ page import="java.sql.*" %>
<html>
<head></head>
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
if (!UserRole.equals("a")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='account.jsp'");
    out.print("</script>");
}
%>

<%	
    String rId= request.getParameter("removeSensorId");
    //out.print(rId);
    Connection conn=null;
    Statement stmt;
    String driverName="oracle.jdbc.driver.OracleDriver";
    String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    try{
	//avoid empty value---------------------------
	boolean valid = true;
    	if(rId.length()==0){
		out.print("Please enter sensor id to create sensor"+"<br>");
		valid = false;
	}

	//avoid rId not numbric
	try{
		Integer rId1 = Integer.valueOf(rId);
        }catch(NumberFormatException e){
		out.print("Sensor id should be an integer"+"<br>");
       		valid = false;
   	}
         
        //load and register driver
        Class drvClass=Class.forName(driverName);
        DriverManager.registerDriver((Driver)drvClass.newInstance());

        //establish connection here
        conn=DriverManager.getConnection(dbstring,"tshen","ad50064051");

	//ensure sensor id exists
	Statement statement = conn.createStatement() ;
    	ResultSet resultset = statement.executeQuery("SELECT * FROM sensors") ;
	
	boolean exist = false;
	if(valid){
		Integer rId1 = Integer.valueOf(rId);
		while(resultset.next()){
		     if(resultset.getInt("sensor_id") == rId1){
			  exist = true;
		     }
		}
	}
	statement.close();

	if(! exist){
		out.print("sensor does not exist");
	}
	
	//delete sensor
	if (valid&&exist){
		//delete records in table with foreign key= sensor_id
		String query="DELETE from subscriptions where sensor_id= "+rId;
		stmt=conn.createStatement();
		stmt.executeQuery(query);
	
		query="DELETE from audio_recordings where sensor_id= "+rId;
		stmt=conn.createStatement();
		stmt.executeQuery(query);

		query="DELETE from images where sensor_id= "+rId;
		stmt=conn.createStatement();
		stmt.executeQuery(query);

		query="DELETE from scalar_data where sensor_id= "+rId;
		stmt=conn.createStatement();
		stmt.executeQuery(query);
	
		//delete from sensor table
		query="DELETE from sensors where sensor_id= "+rId;
		stmt=conn.createStatement();
		stmt.executeQuery(query);
		
		stmt.close();
		conn.close();
		out.print("Sensor has been removed"+"<br>");
	}

    }catch(Exception e) {
out.println(e.toString());
out.print("<script language=javascript type=text/javascript>");
out.print("javascript:location.href='account.jsp'");
out.print("</script>");
    }
%>


  <form action= "editSensor.jsp" method="post">
    <input type="submit" name= "return" value = "return"><br>
  </form>
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
