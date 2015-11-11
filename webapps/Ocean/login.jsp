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

<%
String LogName = (request.getParameter("logname")).trim();
String LogPW = (request.getParameter("logpw")).trim();
%>

<%@ page import = "java.sql.*"%>
<%
String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";

Connection m_con;
String action1 = "select * from users where users.user_name = '" + LogName + "'";
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

String TruePW = "a";
String UserRole = "b";
String UserID = "c";
if (rs1.next() == false) {
out.print("<H1>Invalid Username. Please try again.</H1>");
m_con.close();
out.print("<script language=javascript type=text/javascript>");
out.print("setTimeout("+"\"javascript:location.href='login.html'\""+", 2500);");
out.print("</script>");

} else {
  TruePW = rs1.getString(2);
  UserRole = rs1.getString(3);
  UserID = rs1.getString(4);
  if (!LogPW.equals(TruePW)) {
    out.print("<H1>Invalid Password. Please try again.</H1>");
    m_con.close();
    out.print("<script language=javascript type=text/javascript>");
    out.print("setTimeout("+"\"javascript:location.href='login.html'\""+", 2500);");
    out.print("</script>");

  } else {
    out.print("<H2>Welcome back! </H2>");

    if (UserRole.equals("a")){
      out.print("<H2>Now you can edit users and sensors.</H2>");
      %>
      <br>
      <INPUT TYPE="button" NAME="Enter1" VALUE="Go to Administrator Page"
        onclick="GoToPage1()" />
      <br><br><br>
      <%
      String action2 = "select * from persons where persons.person_id = '" + UserID + "'";
      ResultSet rs2;
      Statement stmt2;

      try
      {
        Class drvClass = Class.forName(m_driverName);
        DriverManager.registerDriver((Driver)
        drvClass.newInstance());
       } catch(Exception e) {
         System.err.print("ClassNotFoundException: ");
         System.err.println(e.getMessage());
       }

      stmt2 = m_con.createStatement();
      rs2 = stmt2.executeQuery(action2);

      try
      {
      if (rs2 != null) {
      %>
      <table border = "1" style = "width:30%">

      <%
      while(rs2.next())
      {
      %>
        <tr>
          <td style = "width:100px">Person Id</td>
          <td><%=rs2.getString("person_id")%></td>
        </tr>
        <tr>
          <td>First Name</td>
          <td><%=rs2.getString("first_name")%></td>
        </tr>
        <tr>
          <td>Last Name</td>
          <td><%=rs2.getString("last_name")%></td>
        </tr>
        <tr>
          <td>Address</td>
          <td><%=rs2.getString("address")%></td>
        </tr>
        <tr>
          <td>Email</td>
          <td><%=rs2.getString("email")%></td>
        </tr>
        <tr>
          <td>Phone</td>
          <td><%=rs2.getString("phone")%></td>
        </tr>
      <%
      }
      }
      }
      catch(SQLException e)
      {
        e.printStackTrace();
      }
      stmt2.close();
      rs2.close();
      %>
      </table>
      <br>
      <INPUT TYPE="button" NAME="EditPerson" VALUE="Modify Personal Information"
        onclick="EditPerson()">   
      <br><br><br>
      <INPUT TYPE="button" NAME="LogOut" VALUE="Log Out" onclick="LogOut()">   
<%}


    else if (UserRole.equals("d")) {
      out.print("<H2>Now you can upload data.</H2>");

      %>
      <br>
      <INPUT TYPE="button" NAME="Enter2" VALUE="Go to Data Curator Page"
        onclick="GoToPage2()" />
      <br><br><br>
      <%
      String action2 = "select * from persons where persons.person_id = '" + UserID + "'";
      ResultSet rs2;
      Statement stmt2;

      try
      {
        Class drvClass = Class.forName(m_driverName);
        DriverManager.registerDriver((Driver)
        drvClass.newInstance());
       } catch(Exception e) {
         System.err.print("ClassNotFoundException: ");
         System.err.println(e.getMessage());
       }

      stmt2 = m_con.createStatement();
      rs2 = stmt2.executeQuery(action2);

      try
      {
      if (rs2 != null) {
      %>
      <table border = "1" style = "width:30%">

      <%
      while(rs2.next())
      {
      %>
        <tr>
          <td style = "width:100px">Person Id</td>
          <td><%=rs2.getString("person_id")%></td>
        </tr>
        <tr>
          <td>First Name</td>
          <td><%=rs2.getString("first_name")%></td>
        </tr>
        <tr>
          <td>Last Name</td>
          <td><%=rs2.getString("last_name")%></td>
        </tr>
        <tr>
          <td>Address</td>
          <td><%=rs2.getString("address")%></td>
        </tr>
        <tr>
          <td>Email</td>
          <td><%=rs2.getString("email")%></td>
        </tr>
        <tr>
          <td>Phone</td>
          <td><%=rs2.getString("phone")%></td>
        </tr>
      <%
      }
      }
      }
      catch(SQLException e)
      {
        e.printStackTrace();
      }
      stmt2.close();
      rs2.close();
      %>
      </table>
      <br>
      <INPUT TYPE="button" NAME="EditPerson" VALUE="Modify Personal Information"
        onclick="EditPerson()">   
      <br><br><br>
      <INPUT TYPE="button" NAME="LogOut" VALUE="Log Out" onclick="LogOut()">   
<%}


    else if (UserRole.equals("s")) {
      out.print("<H2>Now you can view, query and download data.</H2>");

      %>
      <br>
      <INPUT TYPE="button" NAME="Enter3" VALUE="Go to Scientist Page"
        onclick="GoToPage3()" />
      <br><br><br>
      <%
      String action2 = "select * from persons where persons.person_id = '" + UserID + "'";
      ResultSet rs2;
      Statement stmt2;

      try
      {
        Class drvClass = Class.forName(m_driverName);
        DriverManager.registerDriver((Driver)
        drvClass.newInstance());
       } catch(Exception e) {
         System.err.print("ClassNotFoundException: ");
         System.err.println(e.getMessage());
       }

      stmt2 = m_con.createStatement();
      rs2 = stmt2.executeQuery(action2);

      try
      {
      if (rs2 != null) {
      %>
      <table border = "1" style = "width:30%">

      <%
      while(rs2.next())
      {
      %>
        <tr>
          <td style = "width:100px">Person Id</td>
          <td><%=rs2.getString("person_id")%></td>
        </tr>
        <tr>
          <td>First Name</td>
          <td><%=rs2.getString("first_name")%></td>
        </tr>
        <tr>
          <td>Last Name</td>
          <td><%=rs2.getString("last_name")%></td>
        </tr>
        <tr>
          <td>Address</td>
          <td><%=rs2.getString("address")%></td>
        </tr>
        <tr>
          <td>Email</td>
          <td><%=rs2.getString("email")%></td>
        </tr>
        <tr>
          <td>Phone</td>
          <td><%=rs2.getString("phone")%></td>
        </tr>
      <%
      }
      }
      }
      catch(SQLException e)
      {
        e.printStackTrace();
      }
      stmt2.close();
      rs2.close();
      %>
      </table>
      <br>
      <INPUT TYPE="button" NAME="EditPerson" VALUE="Modify Personal Information"
        onclick="EditPerson()">   
      <br><br><br>
      <INPUT TYPE="button" NAME="LogOut" VALUE="Log Out" onclick="LogOut()">   
<%} 
  }
}


%>

<script language="JavaScript" type="text/javascript">
function GoToPage1()
{
javascript:location.href="administratorPage.html"
}    
function GoToPage2()
{
javascript:location.href="dataCurator.jsp"
} 
function GoToPage3()
{
javascript:location.href="scientist.jsp"
}
function LogOut()
{
javascript:location.href="logout.jsp"
}
function EditPerson()
{
javascript:location.href="editPerson.jsp"
}
</script>


</center>
</div>
</body>
</html>
