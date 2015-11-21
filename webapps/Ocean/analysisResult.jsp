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
String action = "SELECT EXTRACT(year FROM date_created), avg(sd.value), max(sd.value), min(sd.value) FROM scalar_data sd, subscriptions sc WHERE sd.sensor_id = '"+Sensor+"' GROUP BY EXTRACT(year FROM date_created) ORDER BY EXTRACT(year FROM date_created)";
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
%>
<table border = "1" style = "width:50%">
<tr>
<td>Year</td>
<td>Average Value</td>
<td>Maxmimun Value</td>
<td>Minmimun Value</td>
</tr>
<%
while(rs.next())
{
%>
<tr>
<td><%=rs.getString("EXTRACT(YEARFROMDATE_CREATED)")%></td>
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
