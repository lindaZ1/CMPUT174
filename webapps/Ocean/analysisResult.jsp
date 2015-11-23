<html>
<head>
<title>Data Analysis</title>
</head>

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

<%
try {
String Sensor = (request.getParameter("sensorSelect")).trim();
String Time = (request.getParameter("timeHierarchies")).trim();
%>

<%@ page import = "java.sql.*"%>
<%@ page import="java.text.DecimalFormat" %>
<%
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";

Connection m_con;

String show = "select * from sensors where sensor_id = '"+Sensor+"'";
ResultSet rs0;
Statement stmt0;

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
stmt0 = m_con.createStatement();
rs0 = stmt0.executeQuery(show);

try
{
if (rs0 != null) {
%>

<H3>Sensor Details</H3>
<table border = "1" style = "width:30%">

<%
// show the selected sensor information
while(rs0.next())
{
%>
<tr>
  <td style = "width:100px">Sensor Id</td>
  <td><%=rs0.getString("sensor_id")%></td>
</tr>
<tr>
  <td>Location</td>
  <td><%=rs0.getString("location")%></td>
</tr>
<tr>
  <td>Sensor Type</td>
  <td><%=rs0.getString("sensor_type")%></td>
</tr>
<tr>
  <td>Description</td>
  <td><%=rs0.getString("description")%></td>
</tr>
<%
}
}
}
catch(SQLException e)
{
e.printStackTrace();
}
stmt0.close();
rs0.close();
%>
</table>
<%
// detect time hierarchies and use the correct SQL statement
String action = "";
if (Time.equals("year")) {
action = "SELECT to_char(date_created, 'yyyy') as Time, avg(sd.value), max(sd.value), min(sd.value) FROM scalar_data sd WHERE sd.sensor_id = '"+Sensor+"' GROUP BY to_char(date_created, 'yyyy') ORDER BY to_char(date_created, 'yyyy')";
} else if (Time.equals("quarter")) {
action = "SELECT to_char(date_created, 'yyyy-q') as Time, avg(sd.value), max(sd.value), min(sd.value) FROM scalar_data sd WHERE sd.sensor_id = '"+Sensor+"' GROUP BY to_char(date_created, 'yyyy-q') ORDER BY to_char(date_created, 'yyyy-q')";
} else if (Time.equals("month")) {
action = "SELECT to_char(date_created, 'yyyy-mm') as Time, avg(sd.value), max(sd.value), min(sd.value) FROM scalar_data sd WHERE sd.sensor_id = '"+Sensor+"' GROUP BY to_char(date_created, 'yyyy-mm') ORDER BY to_char(date_created, 'yyyy-mm')";
} else if (Time.equals("week")) {
action = "SELECT to_char(date_created, 'yyyy-mm-w') as Time, avg(sd.value), max(sd.value), min(sd.value) FROM scalar_data sd WHERE sd.sensor_id = '"+Sensor+"' GROUP BY to_char(date_created, 'yyyy-mm-w') ORDER BY to_char(date_created, 'yyyy-mm-w')";
} else if (Time.equals("day")) {
action = "SELECT to_char(date_created, 'yyyy-mm-dd') as Time, avg(sd.value), max(sd.value), min(sd.value) FROM scalar_data sd WHERE sd.sensor_id = '"+Sensor+"' GROUP BY to_char(date_created, 'yyyy-mm-dd') ORDER BY to_char(date_created, 'yyyy-mm-dd')";
}

ResultSet rs;
Statement stmt;
stmt = m_con.createStatement();
rs = stmt.executeQuery(action);

// show the scalar values
try
{
if (rs != null) {
if (Time.equals("year")) {
%>
<H3>Scalar Value</H3>
<table border = "1" style = "width:50%">
<tr>
<td>Time (Year)</td>
<td>Average Value</td>
<td>Maxmimun Value</td>
<td>Minmimun Value</td>
</tr>
<%
} else if (Time.equals("quarter")) {
%>
<H3>Scalar Value</H3>
<table border = "1" style = "width:50%">
<tr>
<td>Time (Year-Quarter)</td>
<td>Average Value</td>
<td>Maxmimun Value</td>
<td>Minmimun Value</td>
</tr>
<%
} else if (Time.equals("month")) {
%>
<H3>Scalar Value</H3>
<table border = "1" style = "width:50%">
<tr>
<td>Time (Year-Month)</td>
<td>Average Value</td>
<td>Maxmimun Value</td>
<td>Minmimun Value</td>
</tr>
<%
} else if (Time.equals("week")) {
%>
<H3>Scalar Value</H3>
<table border = "1" style = "width:50%">
<tr>
<td>Time (Year-Month-Week)</td>
<td>Average Value</td>
<td>Maxmimun Value</td>
<td>Minmimun Value</td>
</tr>
<%
} else if (Time.equals("day")) {
%>
<H3>Scalar Value</H3>
<table border = "1" style = "width:50%">
<tr>
<td>Time (Year-Month-day)</td>
<td>Average Value</td>
<td>Maxmimun Value</td>
<td>Minmimun Value</td>
</tr>
<%
}

while(rs.next())
{
double avg = Double.parseDouble(rs.getString("AVG(SD.VALUE)"));
double max = Double.parseDouble(rs.getString("MAX(SD.VALUE)"));
double min = Double.parseDouble(rs.getString("MIN(SD.VALUE)"));
DecimalFormat df = new DecimalFormat("#0.00");
%>
<tr>
<td><%=rs.getString("Time")%></td>
<td><%=df.format(avg)%></td>
<td><%=df.format(max)%></td>
<td><%=df.format(min)%></td>
</tr>
<%
}
}
}
catch(SQLException e)
{
e.printStackTrace();
}
stmt.close();
rs.close();
m_con.close();
}catch(Exception e) {
out.println(e.toString());
out.print("<script language=javascript type=text/javascript>");
out.print("javascript:location.href='account.jsp'");
out.print("</script>");
}
%>
</table>
<br>

<form  action= "dataAnalysis.jsp" method="post">
<input type="submit" name="Back" value="Back">
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
