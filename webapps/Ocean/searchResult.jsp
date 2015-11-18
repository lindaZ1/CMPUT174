<%@ page import="java.sql.*" %>
<html>
<head></head>
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
		if(type.equals("a") || type.equals("t") || type.equals("o") || type.equals("i")){
			//do nothing
		}else{
			out.print("Invalid sensor type"+"<br>");
			valid = false;
		}
	}
	
	
	//select query----------------------------------
	Statement stmt = conn.createStatement() ;
	String query = "SELECT * from sensors";
	/*
	String query = "SELECT * FROM sensors WHERE sensors.description contains("+keywords+")";
	
	if(location.length()!=0){
		query=query+"AND sensors.location = " +location;
	}
	
	if(type.length()!=0){
		query=query+"AND sensors.type = " +type;
	}
	*/

    	ResultSet rset = stmt.executeQuery(query);

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

	
	//query ="SELECT images.image_id, images.sensor_id, images.date_created,images.description FROM images WHERE";	
    
    }catch(Exception e) {
	out.println(e.toString());
    }
%> 
</Table>
    <br>
    <form action= "editSensor.jsp" method="post">
    <input type="submit" name="submit" value= "Back to edit sensor">
    </form>
<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>
</body>
</html>
