<html>
<head>
<title>Data Analysis</title>
</head>

<body>
<div id="image" style="background: url(bg.jpg) no-repeat; width: 100%; height: 100%; background-size: 100%;">
<center>
<br>
<H2>Ocean Observation System</H2>
<br><br>

<%
String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin == "false"){
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
String Sensor = (request.getParameter("sensorSelect")).trim();
String Time = (request.getParameter("timeHierarchies")).trim();
%>

<%@ page import = "java.sql.*"%>
<%
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";

Connection m_con;

String action = "";
if (Time.equals("year")) {
action = "SELECT to_char(date_created, 'yyyy') as Time, avg(sd.value), max(sd.value), min(sd.value) FROM scalar_data sd WHERE sd.sensor_id = '"+Sensor+"' GROUP BY to_char(date_created, 'yyyy') ORDER BY to_char(date_created, 'yyyy')";
} else if (Time.equals("quarter")) {
action = "SELECT to_char(date_created, 'yyyy-q') as Time, avg(sd.value), max(sd.value), min(sd.value) FROM scalar_data sd WHERE sd.sensor_id = 1111 GROUP BY to_char(date_created, 'yyyy-q') ORDER BY to_char(date_created, 'yyyy-q')";
} else if (Time.equals("month")) {
action = "SELECT to_char(date_created, 'yyyy-mm') as Time, avg(sd.value), max(sd.value), min(sd.value) FROM scalar_data sd WHERE sd.sensor_id = 1111 GROUP BY to_char(date_created, 'yyyy-mm') ORDER BY to_char(date_created, 'yyyy-mm')";
} else if (Time.equals("week")) {
action = "SELECT to_char(date_created, 'yyyy-ww') as Time, avg(sd.value), max(sd.value), min(sd.value) FROM scalar_data sd WHERE sd.sensor_id = 1111 GROUP BY to_char(date_created, 'yyyy-ww') ORDER BY to_char(date_created, 'yyyy-ww')";
} else if (Time.equals("day")) {
action = "SELECT to_char(date_created, 'yyyy-mm-dd') as Time, avg(sd.value), max(sd.value), min(sd.value) FROM scalar_data sd WHERE sd.sensor_id = 1111 GROUP BY to_char(date_created, 'yyyy-mm-dd') ORDER BY to_char(date_created, 'yyyy-mm-dd')";
}

ResultSet rs;
Statement stmt;

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
stmt = m_con.createStatement();
rs = stmt.executeQuery(action);

try
{
if (rs != null) {
if (Time.equals("year")) {
%>
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
<table border = "1" style = "width:50%">
<tr>
<td>Time (Year-week)</td>
<td>Average Value</td>
<td>Maxmimun Value</td>
<td>Minmimun Value</td>
</tr>
<%
} else if (Time.equals("day")) {
%>
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
%>
<tr>
<td><%=rs.getString("Time")%></td>
<td><%=rs.getString("AVG(SD.VALUE)")%></td>
<td><%=rs.getString("MAX(SD.VALUE)")%></td>
<td><%=rs.getString("MIN(SD.VALUE)")%></td>
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
</div>
</body>
</html>
