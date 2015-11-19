<%@ page import="java.sql.*" %>
<html>
<head></head>
<body>
 <TABLE BORDER=2>
        <TR>
            <TH>SENSOR_ID</TH>
	    <TH>LOCATION</TH>
	    <TH>SENSOR TYPE</TH>
	    <TH>DESCRIPTION</TH>
        </TR>
<%
    String keywords = request.getParameter("keywords");
    String type = request.getParameter("type");
    String location = request.getParameter("location");
    String startTime = request.getParameter("begin");
    String endTime = request.getParameter("end");

    Connection conn=null;
    String driverName="oracle.jdbc.driver.OracleDriver";
    String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

    try{    
        //load and register driver
        Class drvClass=Class.forName(driverName);
        DriverManager.registerDriver((Driver)drvClass.newInstance());

        //establish connection here
        conn=DriverManager.getConnection(dbstring,"dzhang4","Horsey26");
	
	//avoid empty keywords and dates---------------------------
	boolean valid = true;
    	if(keywords.length()==0 || startTime.length()==0 || endTime.length()==0 ){
		out.print("Please enter keywords and time period"+"<br>");
		valid = false;
	}
	
	//avoid invalid sensor type----------------------
	if(type.length() !=0){
		if(type.equals("a") || type.equals("i") || type.equals("s")){
			//do nothing
		}else{
			out.print("Invalid sensor type"+"<br>");
			valid = false;
		}
	}
	
	//select query----------------------------------
	boolean sensorDesFound = false;
	Statement stmt = conn.createStatement() ;

	String query ="create table matched as (SELECT * FROM sensors WHERE sensors.description LIKE '%"+keywords+"%'";


	if(location.length()!=0){
		query=query+"AND sensors.location LIKE '%"+location+"%'";
	}
	
	if(type.length()!=0){
		query=query+ "AND sensors.sensor_type = '"+ type.charAt(0)+"'";
	}
	
	query = query+")";

	stmt.executeQuery(query);
	
	//show partly matched sensor-----------------------
	query = "select * from matched";
	stmt.executeQuery(query);
	ResultSet rset = stmt.executeQuery(query);

	Object o;

	ResultSetMetaData rsetMetaData=rset.getMetaData();
	int ccount=rsetMetaData.getColumnCount();

	String ans="";
	
	while(rset.next()) {
	    sensorDesFound=true;
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
 	
	//if Des,Loc,type matches with sensor, show its images, record, scalar data---------------
	if(sensorDesFound){	
		out.print("here");
		query ="SELECT images.image_id, images.sensor_id, images.date_created,images.description FROM images,matched WHERE images.sensor_id = matched.sensor_id";
		rset = stmt.executeQuery(query);
		rsetMetaData=rset.getMetaData();
		ccount=rsetMetaData.getColumnCount();
		
		ans="";
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
	}


	//drop table ----------------------------
	query = "Drop table matched";
	stmt.executeQuery(query);	
	stmt.close();
	conn.close();
	
    }catch(Exception e) {
	out.println(e.toString());
    }
%> 
</Table>
    <br>
    <form action= "editSensor.jsp" method="post">
    <input type="submit" name="submit" value= "Back to edit sensor">

</body>
</html>
