<html>
<head>
<title>Edit Personal Info</title>
</head>

<body>
<div id="image" style="background: url(bg.jpg) no-repeat fixed; width: 100%; min-height: 100%; background-size: cover;">
<center>
<br>
<H2>Ocean Observation System</H2>
<br><br>

<%@ page import = "java.sql.*"%>
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
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";

String UserID = (String) session.getAttribute("userid");

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

String person_id = "a";
String first_name = "b";
String last_name = "c";
String address = "d";
String email = "e";
String phone = "f";

// get user's information
try
{
if (rs != null) {
  while(rs.next())
  {
    person_id = rs.getString("person_id");
    first_name = rs.getString("first_name");
    last_name = rs.getString("last_name");
    address = rs.getString("address");
    email = rs.getString("email");
    phone = rs.getString("phone");
  }
 }
}
catch(SQLException e)
{
e.printStackTrace();
}
stmt.close();
rs.close();

%>

<FORM action= "editPersonProcess.jsp" method="post">
<TABLE>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>Person ID: </B></TD>
<TD><%=person_id%><BR></TD>
</TR>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>First Name: </B></TD>
<TD><INPUT TYPE="text" NAME="userfn" MAXLENGTH="24" VALUE="<%=first_name%>"></TD>
</TR>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>Last Name: </B></TD>
<TD><INPUT TYPE="text" NAME="userln" MAXLENGTH="24" VALUE="<%=last_name%>"></TD>
</TR>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>Address: </B></TD>
<TD><INPUT TYPE="text" NAME="useraddr" MAXLENGTH="128" VALUE="<%=address%>"></TD>
</TR>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>Email: </B></TD>
<TD><INPUT TYPE="email" NAME="useremail" MAXLENGTH="128" VALUE="<%=email%>"></TD>
</TR>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>Phone: </B></TD>
<TD><INPUT TYPE="tel" NAME="userphone" MAXLENGTH="10" VALUE="<%=phone%>"></TD>
</TR>

</TABLE>

<br>
<INPUT TYPE="submit" NAME="Save" VALUE="Save">
</FORM>
<INPUT TYPE="button" NAME="Cancel" VALUE="Cancel" onclick="cancel()">

<script language="JavaScript" type="text/javascript">
function cancel()
{
javascript:location.href="account.jsp"
}
</script>

</center>

<center><h3>
<br><br>
<a href='UserDocumentation.html' target='_blank'>Help</a>
</h3></center>

</div>
</body>
</html>
