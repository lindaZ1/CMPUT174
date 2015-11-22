
<%@ page import="java.sql.*" %>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>subscribe</title>
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
    <h1>Subscriptions</h1>

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
	//stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
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
	//stmt.close();
	//conn.close();
    }catch(Exception e) {
	out.println(e.toString());
    }
%>
</TABLE>

<h4>Legend<h4>
a=audio;
i=image;
s=scalar;


<h3>Subscribed Sensors:</h3>
<TABLE BORDER=2>
<TR><TH>SENSOR_ID</TH></TR>
<%
    String person_id=(String)session.getAttribute("userid");
    String query="select sensor_id from subscriptions where person_id="+person_id;
    
    stmt=conn.createStatement();
    ResultSet rset=stmt.executeQuery(query);
    String ans="";
    Object o;
    ResultSetMetaData rsetMetaData=rset.getMetaData();
    int ccount=rsetMetaData.getColumnCount();

    while(rset.next()) {
	ans+="<TR>";
	for(int i=1;i<=ccount;i++) {
	    o=rset.getObject(i);
	    ans+="<TD>";
	    ans+=o.toString();
	    ans+="</TD>";
	}
	ans+="</TR>";
    }
    out.println(ans);
    stmt.close();
    conn.close();

%>
</TABLE>  
<br></br>
<form action="alter_subscribe.jsp" method="post">
    <input type="text" value="sensor_id" name="sensor_id">
    <br></br><input type="radio" value="add" name="action" checked="checked">Add Sensor
    <input type="radio" value="remove" name="action">Remove Sensor
<%  out.println("<input type='hidden' value="+person_id+" name='person'>");     %>
    <br></br><input type="submit" value="submit">
</form>

<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>



</body>
