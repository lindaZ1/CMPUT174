
<%@ page import="java.sql.*" %>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>Sensors</title>
    </head>
</html>
<body>
<%
String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin == "false"){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='login.html'");
    out.print("</script>");
}
%>
    <h1>Edit Sensors</h1>

    <h3>All Sensors:</h3>
    <TABLE BORDER=2>
        <TR>
            <TH>SENSOR_ID</TH>
	    <TH>LOCATION</TH>
	    <TH>SENSOR TYPE</TH>
	    <TH>DESCRIPTION</TH>
        </TR>

<%
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

	String query="select * from sensors";
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
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
    }catch(Exception e) {
	out.println(e.toString());
    }
%> 
</Table>

    <h3>Remove a Sensor:</h3>
    <form action= "removeSensor.jsp" method="post">
    Sensor Id:
    <input type="text" name= "removeSensorId"><br>
    <input type="submit" name="submit" value= "remove">
  </form>

    <h3>Create a Sensor:</h3>
    <form action= "createSensor.jsp" method="post">
    Sensor Id:
    <input type="text" name= "createSensorId"><br>
    Location:
    <input type="text" name="location"><br>
    Sensor Type:
    <input type = "text" name="sensorType"><br>
    Description:
    <input type = "text" name="description"><br>
    <input type="submit" name="submit" value= "create">
  </form>
   
    <form action= "administratorPage.jsp" method="post">
    <input type="submit" name="submit" value= "Main Menu">
  </form>
<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form> 
</body>
