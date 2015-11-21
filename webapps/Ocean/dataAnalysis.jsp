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

<H3>Please Choose Details</H3>

<%@ page import = "java.sql.*"%>
<%
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";

String person_id="222";

Connection m_con;
String action = "select sensor_id from subscriptions where person_id="+person_id;
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

Object o;
ResultSetMetaData rsetMetaData=rs.getMetaData();
int ccount=rsetMetaData.getColumnCount();
%>
<form action= "analysisResult.jsp" method="post">
<select name="sensorSelect">
<%
while(rs.next()) {
for(int i=1;i<=ccount;i++) {
o=rs.getObject(i);
o.toString();
%>
<option value=<%=o.toString()%>><%=o.toString()%></option>
<%
}
}
stmt.close();
rs.close();
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
</div>
</body>
</html>
