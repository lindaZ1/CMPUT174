<html>
<head>
<title>Processing</title>
</head>

<body>
<div id="image" style="background: url(bg.jpg) no-repeat fixed; width: 100%; min-height: 100%; background-size: cover;">
<center>
<br>
<H2>Ocean Observation System</H2>
<br><br>

<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%
String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin.equals("false")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='login.html'");
    out.print("</script>");
}
%>

<%
String UserFN = (request.getParameter("userfn")).trim();
String UserLN = (request.getParameter("userln")).trim();
String UserAddr = (request.getParameter("useraddr")).trim();
String UserEmail = (request.getParameter("useremail")).trim();
String UserPhone = (request.getParameter("userphone")).trim();
%>

<%
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";

String UserID = (String) session.getAttribute("userid");

Connection m_con;
String action = "update persons set first_name = '" + UserFN + "', last_name = '" + UserLN + "', address = '" + UserAddr + "', email = '" + UserEmail + "', phone = '" + UserPhone + "' where persons.person_id = '" + UserID + "'";
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

rs.close();
stmt.close();
m_con.close();
%>

<H2>Change Saved</H2>
<script language=javascript type=text/javascript>
setTimeout("javascript:location.href='account.jsp'", 2000);
</script>
</center>
<center><h3>
<br><br>
<a href='UserDocumentation.html' target='_blank'>Help</a>
</h3></center>
</div>
</body>
</html>
