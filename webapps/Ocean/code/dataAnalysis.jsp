<html>
<head>
<title>Data Analysis</title>
</head>

<body>
<div id="image" style="background: url(bg.jpg) no-repeat fixed; width: 100%; min-height: 100%; background-size: cover;">
<center>
<br>
<H2>Ocean Observation System</H2>

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

<h3>All Sensors:</h3>
<TABLE BORDER=2>
<TR>
<TH>SENSOR_ID</TH>
<TH>LOCATION</TH>
<TH>SENSOR TYPE</TH>
<TH>DESCRIPTION</TH>
</TR>

<%@ page import = "java.sql.*"%>
<%
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";


Connection m_con;
String action1 = "select * from sensors";
ResultSet rs1;
Statement stmt1;

try
{
Class drvClass = Class.forName(m_driverName);
DriverManager.registerDriver((Driver)
drvClass.newInstance());
} catch(Exception e) {
System.err.print("ClassNotFoundException: ");
System.err.println(e.getMessage());
}

m_con = DriverManager.getConnection(m_url, m_userName, m_password);
stmt1 = m_con.createStatement();
rs1 = stmt1.executeQuery(action1);

// show all sensors information
Object o1;
ResultSetMetaData rsetMetaData1=rs1.getMetaData();
int ccount1=rsetMetaData1.getColumnCount();
String ans1="";
while(rs1.next()) {
	    ans1+="<TR>";
	    for(int i=1;i<=ccount1;i++) {
		o1=rs1.getObject(i);
		ans1+="<TD>";
		if(o1!=null){
		    ans1+=o1.toString();
		}
		else{
		    ans1+="null";
		}
		ans1+="</TD>";
	    }
	    ans1+="</TR>";
	}
	out.println(ans1);
stmt1.close();
rs1.close();
%>
</TABLE>
a=audio; i=image; s=scalar value;
<br>

<h3>Subscribed Sensors:</h3>
<TABLE BORDER=2>
<TR><TH>SENSOR_ID</TH></TR>
<%
String UserID = (String) session.getAttribute("userid");
String action2 = "select sensor_id from subscriptions where person_id='"+UserID+"'";
ResultSet rs2;
Statement stmt2;
stmt2 = m_con.createStatement();
rs2 = stmt2.executeQuery(action2);

// show user's subscribed sensors
String ans2="";
Object o2;
ResultSetMetaData rsetMetaData2=rs2.getMetaData();
int ccount2=rsetMetaData2.getColumnCount();

while(rs2.next()) {
ans2+="<TR>";
for(int i=1;i<=ccount2;i++) {
o2=rs2.getObject(i);
ans2+="<TD>";
ans2+=o2.toString();
ans2+="</TD>";
}
ans2+="</TR>";
}
out.println(ans2);
stmt2.close();
rs2.close();
%>
</TABLE>  
<br>
<form  action= "subscribe.jsp" method="post">
<input type="submit" name="subscribe" value="Go To Subscribe">
</form>
<H3>Please Choose Your Analysis Details</H3>
<%
String action3 = "select sensor_id from subscriptions where person_id='"+UserID+"'";
ResultSet rs3;
Statement stmt3;
stmt3 = m_con.createStatement();
rs3 = stmt3.executeQuery(action3);

// let user select sensors and time hierarchies
Object o3;
ResultSetMetaData rsetMetaData3=rs3.getMetaData();
int ccount3=rsetMetaData3.getColumnCount();
%>
<form action= "analysisResult.jsp" method="post">
<select name="sensorSelect">
<%
while(rs3.next()) {
for(int i=1;i<=ccount3;i++) {
o3=rs3.getObject(i);
o3.toString();
%>
<option value=<%=o3.toString()%>><%=o3.toString()%></option>
<%
}
}
stmt3.close();
rs3.close();
m_con.close();
%>
</select> 

<select name="timeHierarchies"> 
<option value="year">yearly</option> 
<option value="quarter">quarterly</option> 
<option value="month">monthly</option> 
<option value="week">weekly</option>
<option value="day">daily</option> 
</select>
<INPUT TYPE="submit" NAME="Submit" VALUE="Submit">
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
