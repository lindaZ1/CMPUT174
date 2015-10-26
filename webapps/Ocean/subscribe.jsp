
<%@ page import="java.sql.*" %>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>subscribe</title>
    </head>
</html>
<body>
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
	//stmt.close();
	//conn.close();
    }catch(Exception e) {
	out.println(e.toString());
    }
%>
</TABLE>

<h3>Subscribed Sensors:</h3>
<TABLE BORDER=2>
<TR><TH>SENSOR_ID</TH></TR>
<%
    String person_id="222";
    String query="select sensor_id from subscriptions where person_id="+person_id;
    stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
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
%>
</TABLE>  


</body>