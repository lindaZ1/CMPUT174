<%@ page import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.math.*"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

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
    String person_id="222";//---------------------NEED SESSION
  
    String keywords = request.getParameter("keywords");
    String type = request.getParameter("type");
    String location = request.getParameter("location");
    String startTime = request.getParameter("begin");
    String endTime = request.getParameter("end");
    /*
    out.print("<br>"+"key   "+keywords+"<br>");
    out.print("type   "+type+"<br>");
    out.print("loc   "+location+"<br>");
    out.print(startTime+"<br>"); 
    */    

    String query ="";
    String queryImage = "";
    String queryAudio = "";
    String queryScalar = "";
    String ans = "";
	
    Connection conn=null;
    String driverName="oracle.jdbc.driver.OracleDriver";
    String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    Statement stmt;

    boolean sensorDesFound = false;
    boolean valid = true;

    //avoid invalid dates--------
    try{
	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	df.setLenient(false);
	Date d1 = df.parse(startTime);
	Date d2 = df.parse(endTime);
	
    }catch(Exception e){
	valid= false;
	out.print("Invalid date"+"<br>");
	
    }
	
	
    try{    
        //load and register driver
        Class drvClass=Class.forName(driverName);
        DriverManager.registerDriver((Driver)drvClass.newInstance());

        //establish connection here
        conn=DriverManager.getConnection(dbstring,"tshen","ad50064051");
	
	//avoid empty keywords and dates---------------------------

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

if(valid){

	//select matched sensors----------------------------------
	
	query = "create table sensors1 as (Select sensors.sensor_id, sensors.location, sensors.sensor_type, sensors.description FROM sensors, subscriptions WHERE sensors.sensor_id = subscriptions.sensor_id AND subscriptions.person_id ="+person_id+")";
	stmt = conn.createStatement() ;
	stmt.executeQuery(query);	
	
	query ="create table matched as (SELECT * FROM sensors1 WHERE sensors1.description LIKE '%"+keywords+"%'";

	if(location.length()!=0){
		query=query+"AND sensors1.location LIKE '%"+location+"%'";
	}
	
	if(type.length()!=0){
		query=query+ "AND sensors1.sensor_type = '"+ type.charAt(0)+"'";
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

	ans+="<h3>"+"Sensors with description,location,type matched"+"</h3>";
	ans+= "<TABLE BORDER=2><TR><TH>SENSOR_ID</TH><TH>LOCATION</TH><TH>SENSOR TYPE</TH><TH>DESCRIPTION</TH></TR>";
	
	while(rset.next()) {

	    sensorDesFound=true; //-----------sensor found
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

	    
	}
	ans+="</TR></Table>";
	if( valid && sensorDesFound){
		out.println(ans);
        }
%>


<%
	if(valid && sensorDesFound){
		queryImage ="SELECT images.image_id, images.sensor_id, images.date_created, images.description FROM images,matched WHERE images.sensor_id = matched.sensor_id AND images.date_created between to_date('" +startTime+ "', 'DD/MM/YYYY') AND to_date('" + endTime + "', 'DD/MM/YYYY')";
		
		queryAudio ="SELECT audio_recordings.recording_id, audio_recordings.sensor_id, audio_recordings.date_created,audio_recordings.length, audio_recordings.description FROM audio_recordings,matched WHERE audio_recordings.sensor_id = matched.sensor_id AND audio_recordings.date_created between to_date('" +startTime+ "', 'DD/MM/YYYY') AND to_date('" + endTime + "', 'DD/MM/YYYY')";
		
		queryScalar ="SELECT scalar_data.id,scalar_data.sensor_id,scalar_data.date_created,scalar_data.value FROM scalar_data,matched WHERE scalar_data.sensor_id = matched.sensor_id AND scalar_data.date_created between to_date('" +startTime+ "', 'DD/MM/YYYY') AND to_date('" + endTime + "', 'DD/MM/YYYY')";

	}else if(valid && (!sensorDesFound)){ //---------partialMatched table

		ans="<TABLE BORDER=2><TR><TH>SENSOR_ID</TH><TH>LOCATION</TH><TH>SENSOR TYPE</TH><TH>DESCRIPTION</TH></TR>";

		if(location.length() != 0 && type.length()!=0){
			query= "create table partialMatched as (SELECT * FROM sensors1 WHERE sensors1.location LIKE '%"+location+"%' AND sensors1.sensor_type = '"+ type.charAt(0)+"')";
		}else if(location.length()!=0){
			query= "create table partialMatched as (SELECT * FROM sensors1 WHERE sensors1.location LIKE '%"+location+"%')";
		}else if(type.length()!=0){
			query= "create table partialMatched as (SELECT * FROM sensors1 WHERE sensors1.sensor_type = '"+ type.charAt(0)+"')";
		}else{
			query= "create table partialMatched as (SELECT * FROM sensors1)";
		}

		stmt.executeQuery(query);	

		query = "select * from partialMatched";
		stmt.executeQuery(query);
		rset = stmt.executeQuery(query);

		rsetMetaData=rset.getMetaData();
		ccount=rsetMetaData.getColumnCount();

		out.print("<br><br><h3>"+"No sensors have description matched with keywords"+"</h3><br>"+"Here shows sensors with location and type matched");
		while(rset.next()) {
		    //sensorDesFound=true;
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
		ans+="</Table>";
		out.println(ans);
		
		queryImage ="SELECT images.image_id, images.sensor_id, images.date_created,images.description FROM images,partialMatched WHERE images.sensor_id = partialMatched.sensor_id AND images.description LIKE '%"+keywords+"%' AND images.date_created between to_date('" +startTime+ "', 'DD/MM/YYYY') AND to_date('" + endTime + "', 'DD/MM/YYYY')";

		queryAudio ="SELECT audio_recordings.recording_id, audio_recordings.sensor_id, audio_recordings.date_created,audio_recordings.length, audio_recordings.description FROM audio_recordings,partialMatched WHERE audio_recordings.sensor_id = partialMatched.sensor_id AND audio_recordings.description LIKE '%"+keywords+"%' AND audio_recordings.date_created between to_date('" +startTime+ "', 'DD/MM/YYYY') AND to_date('" + endTime + "', 'DD/MM/YYYY')";
		
	}
%>

<%//image-----------------------------------------
	//queryImage = "select * from images";
	rset = stmt.executeQuery(queryImage);
	rsetMetaData=rset.getMetaData();
	ccount=rsetMetaData.getColumnCount();
	
	ans = "<TABLE BORDER=2><TR><TH>IMAGE_ID</TH><TH>SENSOR_ID</TH><TH>DATE_CREATED</TH><TH>DESCRIPTION</TH><TH>THUMBNAIL</TH></TR>";
	
	if(!sensorDesFound){
		ans+= "<br>"+"Images with description matched and created within time period ";
	}else{
		ans+= "<br>"+"Sensor's images created within time period";
	}
	
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
			
		    String image_id = rset.getString("image_id");
		    
		    ans+="<TD><img src=\"/Ocean/Thumbnail?" + image_id + "\"><br>";
		    ans+="<a href=\"/Ocean/DownloadImage?" + image_id + "\">download</a>";
		    ans+="</TD></TR>";
		}
	
	ans+="</Table>";
	if(valid){
		out.print(ans);
	}
		
%>

<%
//audio----------------------------------------------
	
	rset = stmt.executeQuery(queryAudio);
	rsetMetaData=rset.getMetaData();
	ccount=rsetMetaData.getColumnCount();
	
	ans = "<TABLE BORDER=2><TR><TH>RECORDING_ID</TH><TH>SENSOR_ID</TH><TH>DATE_CREATED</TH><TH>LENGTH</TH><TH>DESCRIPTION</TH></TR>";
	
	if(!sensorDesFound){
		ans+= "<br>"+"Audio recordings with description matched and created within time period ";
	}else{
		ans+= "<br>"+"Sensor's audio recordings created within time period";
	}

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
		String audio_id = rset.getString("recording_id");
		ans+="<TD><a href=\"/Ocean/DownloadAudio?" + audio_id + "\">download</a></TD>";
		ans+="</TR>";
	}
	
	ans+="</Table>";

	if(valid){	
		out.print(ans);
	}

//scalar data-----------------------------------------
if(valid && sensorDesFound){

	rset = stmt.executeQuery(queryScalar);
	rsetMetaData=rset.getMetaData();
	ccount=rsetMetaData.getColumnCount();
	
	ans = "<TABLE BORDER=2><TR><TH>ID</TH><TH>SENSOR_ID</TH><TH>DATE_CREATED</TH><TH>VALUE</TH></TR>";
	
	ans+= "<br>"+"Scalar data created within time period";

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

		String scalar_id = rset.getString("id");
		ans+="<TD><a href=\"/Ocean/DownloadScalar?" + scalar_id + "\">download</a></TD>";
		ans+="</TR>";
	}
	ans+="</Table>";

	out.print(ans);
}	
}

    }catch(Exception e) {
	out.println(e.toString());
    }

//drop table -------------------------------------------    

    try{
	if(valid){
	query = "Drop table sensors1";
	stmt = conn.createStatement() ;
	stmt.executeQuery(query);

	query = "Drop table matched";
	stmt.executeQuery(query);

	if(!sensorDesFound){
		query = "Drop table partialMatched";
		stmt.executeQuery(query);
	}
	stmt.close();
	conn.close();
        }
    }catch(Exception e){
out.println(e.toString());
out.print("<script language=javascript type=text/javascript>");
out.print("javascript:location.href='account.jsp'");
out.print("</script>");
    }


%>
    <br>
    <form action= "search.jsp" method="post">
    <input type="submit" name="submit" value= "Back to search">
    </form>

<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>
</center>
<center><h3>
<br><br>
<a href='UserDocumentation.html' target='_blank'>Help</a>
</h3></center>
</div>
</body>
</html>
