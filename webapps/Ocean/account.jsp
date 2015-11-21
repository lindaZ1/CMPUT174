<html>
<head>
<title>My Account</title>
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
%>

<%@ page import = "java.sql.*"%>
<%
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";

String UserID = (String) session.getAttribute("userid");
String UserRole = (String) session.getAttribute("userrole");

Connection m_con;
String action = "select * from persons where persons.person_id = '" + UserID + "'";
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
<table border = "1" style = "width:30%">

<%
while(rs.next())
{
%>
<tr>
  <td style = "width:100px">Person Id</td>
  <td><%=rs.getString("person_id")%></td>
</tr>
<tr>
  <td>First Name</td>
  <td><%=rs.getString("first_name")%></td>
</tr>
<tr>
  <td>Last Name</td>
  <td><%=rs.getString("last_name")%></td>
</tr>
<tr>
  <td>Address</td>
  <td><%=rs.getString("address")%></td>
</tr>
<tr>
  <td>Email</td>
  <td><%=rs.getString("email")%></td>
</tr>
<tr>
  <td>Phone</td>
  <td><%=rs.getString("phone")%></td>
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
<INPUT TYPE="button" NAME="EditPerson" VALUE="Modify Personal Information"
 onclick="EditPerson()">
<br><br>
<INPUT TYPE="button" NAME="ChangePW" VALUE="Change Password"
 onclick="ChangePW()">
<br><br>

<%
if (UserRole.equals("a")) {%>
<form action= "administratorPage.jsp" method="post">
<INPUT TYPE="submit" NAME="Homepage" VALUE="Go to HomePage">
</form>
<% } %>

<%
if (UserRole.equals("d")) {%>
<form action= "dataCurator.jsp" method="post">
<INPUT TYPE="submit" NAME="Homepage" VALUE="Go to HomePage">
</form>
<% } %>

<%
if (UserRole.equals("s")) {%>
<form action= "scientist.jsp" method="post">
<INPUT TYPE="submit" NAME="Homepage" VALUE="Go to HomePage">
</form>
<% } %>

<br><br>
<INPUT TYPE="button" NAME="LogOut" VALUE="Log Out" onclick="LogOut()">   

<script language="JavaScript" type="text/javascript">
function EditPerson()
{
javascript:location.href="editPerson.jsp"
}
function ChangePW()
{
javascript:location.href="password.jsp"
}
function LogOut()
{
javascript:location.href="logout.jsp"
}
</script>


</center>
</div>
</body>
</html>
