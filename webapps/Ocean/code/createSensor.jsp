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

<%/*
    String cId = request.getParameter("createSensorId");
    //out.print(cId);
    String cLoc = request.getParameter("location");
    //out.print(cLoc);
    String cType = request.getParameter("sensorType");
    //out.print(cType);
    String cDes = request.getParameter("description");
    //out.print(cDes);*/

    Connection conn=null;
    String driverName="oracle.jdbc.driver.OracleDriver";
    String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    try{
	String cId = request.getParameter("createSensorId");
   	 //out.print(cId);
  	String cLoc = request.getParameter("location");
    	//out.print(cLoc);
    	String cType = request.getParameter("sensorType");
    	//out.print(cType);
    	String cDes = request.getParameter("description");
    	//out.print(cDes);      
  
        //load and register driver
        Class drvClass=Class.forName(driverName);
        DriverManager.registerDriver((Driver)drvClass.newInstance());

        //establish connection here
        conn=DriverManager.getConnection(dbstring,"tshen","ad50064051");

	//avoid empty value---------------------------
	boolean valid = true;
    	if(cId.length()==0 || cLoc.length()==0 || cType.length()==0 || cDes.length()==0 ){
		out.print("Please complete all information to create sensor"+"<br>");
		valid = false;
	}
	//avoid invalid sensor type
	if(cType.equals("a") || cType.equals("i") || cType.equals("s")){
		//do nothing
	}else{
		out.print("invalid sensor type"+"<br>");
		valid = false;
	}

	//avoid cId not numbric
	try{
		Integer cId1 = Integer.valueOf(cId);
        }catch(NumberFormatException e){
		out.print("Sensor id should be an integer"+"<br>");
       		valid = false;
   	}

	//check duplicates before insertion--------------------
	Statement statement = conn.createStatement() ;
    	ResultSet resultset = statement.executeQuery("SELECT * FROM sensors") ;
	
	boolean unique = true;
	if(valid){
		Integer cId1 = Integer.valueOf(cId);
		while(resultset.next()){
		     if(resultset.getInt("sensor_id") == cId1){
			  unique = false;
			  throw new SQLException("Duplicate sensor id " + cId );
		     }
		}
	}
	statement.close();
    
    	// If value to be added is unique,create sensor----------
  	if(valid && unique){
	    Integer cId1 = Integer.valueOf(cId);
	    out.print("Sensor has been created");
	    String query="INSERT INTO sensors VALUES (?,?,?,?)";
	    PreparedStatement stmt =conn.prepareStatement(query);
	    stmt.setInt(1,cId1);
	    stmt.setString(2,cLoc);
	    stmt.setString(3,cType);
	    stmt.setString(4,cDes);
	    stmt.executeUpdate();
	    //stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    //stmt.executeQuery(query);
	    stmt.close();
	    conn.close();
	} 


    }catch(Exception e) {
out.println(e.toString());
out.print("<script language=javascript type=text/javascript>");
out.print("javascript:location.href='account.jsp'");
out.print("</script>");
    }
%> 
    <br>
    <form action= "editSensor.jsp" method="post">
    <input type="submit" name="submit" value= "Back to edit sensor">
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
