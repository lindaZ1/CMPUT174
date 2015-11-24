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
if (!UserRole.equals("s")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='account.jsp'");
    out.print("</script>");
}
%>
	<br></br>
	<%
		String sensor_id = request.getParameter("sensor_id");
		
		String action=request.getParameter("action");
		
		String person_id=request.getParameter("person");

		Boolean sensorExist=false;
		Boolean sensorSubscribed=false;


		Connection conn=null;
	        Statement stmt;
	        String driverName="oracle.jdbc.driver.OracleDriver";
	        String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	        try{        
		    //load and register driver
		    Class drvClass=Class.forName(driverName);
		    DriverManager.registerDriver((Driver)drvClass.newInstance());

		    //establish connection here
		    conn=DriverManager.getConnection(dbstring,"tshen","ad50064051");
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
			    }
		        }
		    }

		    if(sensorExist==false) {
			out.println("sensor_id: "+sensor_id +" does not exist");
		    }

		    if(sensorExist==true) {
			    query="select sensor_id from subscriptions where person_id='"+person_id+"'";
			    //stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			    stmt=conn.createStatement();
			    rset=stmt.executeQuery(query);

			    while(rset.next()) {
				if(sensorSubscribed==false) {
				    o=(rset.getObject(1)).toString();

				    //check if entered sensor is already subscribed by user
				    if(o.equals(sensor_id.trim())) {
					sensorSubscribed=true;
					out.println("already subscribed");
				    }
				}
			    }
		    }
		    
		    if(action.equals("add") && sensorExist && sensorSubscribed==false) {
			//add subscription to sensor
		        query="INSERT INTO subscriptions VALUES ("+sensor_id+","+person_id+")";
			//stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			stmt=conn.createStatement();
		        rset=stmt.executeQuery(query);
			out.println("sensor added");
		    }

		    else if(action.equals("remove") && sensorSubscribed) {
			//delete subscription
			query="DELETE FROM subscriptions WHERE person_id='"+person_id+"' AND sensor_id='"+sensor_id+"'";
			//stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			stmt=conn.createStatement();
		        rset=stmt.executeQuery(query);
			out.println("sensor removed");
		    }

		    else if(action.equals("remove") && sensorSubscribed==false) {
			out.println("sensor not subscribed");
		    }
		    stmt.close();
		    conn.close();
		}catch(Exception e) {
out.println(e.toString());
out.print("<script language=javascript type=text/javascript>");
out.print("javascript:location.href='account.jsp'");
out.print("</script>");
}

	%>

<form action="subscribe.jsp" method="post">
    <br></br><input type="submit" value="Return to Subscriptions">
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
