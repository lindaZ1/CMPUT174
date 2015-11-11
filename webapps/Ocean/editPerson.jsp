<html>
<head>
<title>Login Page</title>
</head>

<body>
<div id="image" style="background: url(bg.jpg) no-repeat; width: 100%; height: 100%; background-size: 100%;">
<center>
<br>
<H2>Ocean Observation System</H2>
<br><br>

<%@ page import = "java.sql.*"%>
<%
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";

String UserID = "111";

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
m_con.close();
%>

<TABLE>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>Person ID: </B></TD>
<TD><INPUT TYPE="text" NAME="userid" VALUE="<%=person_id%>"><BR></TD>
</TR>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>First Name: </B></TD>
<TD><INPUT TYPE="text" NAME="userfn" VALUE="<%=first_name%>"></TD>
</TR>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>Last Name: </B></TD>
<TD><INPUT TYPE="text" NAME="userln" VALUE="<%=last_name%>"></TD>
</TR>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>Address: </B></TD>
<TD><INPUT TYPE="text" NAME="useraddr" VALUE="<%=address%>"></TD>
</TR>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>Email: </B></TD>
<TD><INPUT TYPE="text" NAME="useremail" VALUE="<%=email%>"></TD>
</TR>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>Phone: </B></TD>
<TD><INPUT TYPE="text" NAME="userphone" VALUE="<%=phone%>"></TD>
</TR>

</TABLE>
















</center>
</div>
</body>
</html>
