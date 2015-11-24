<html>
<head>
<title>Login</title>
</head>

<body>
<div id="image" style="background: url(bg.jpg) no-repeat fixed; width: 100%; min-height: 100%; background-size: cover;">
<H2>Loading...</H2>
<br><br>

<%
try{
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
String action = "select * from users where users.user_name = '" + LogName + "'";
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

String TruePW = "a";
String UserRole = "b";
String UserID = "c";
String checklogin = "false";
if (rs.next() == false) {
// detect wrong username
out.print("<H1>Invalid Username. Please try again.</H1>");
m_con.close();
out.print("<script language=javascript type=text/javascript>");
out.print("setTimeout("+"\"javascript:location.href='login.html'\""+", 2500);");
out.print("</script>");

} else {
  TruePW = rs.getString(2);
  UserRole = rs.getString(3);
  UserID = rs.getString(4);

  // detect wrong password
  if (!LogPW.equals(TruePW)) {
    out.print("<H1>Invalid Password. Please try again.</H1>");
    m_con.close();
    out.print("<script language=javascript type=text/javascript>");
    out.print("setTimeout("+"\"javascript:location.href='login.html'\""+", 2500);");
    out.print("</script>");

  } else {
    // log in successfully
    out.print("<H2>Welcome back! </H2>");
    checklogin = "true";
    session.setAttribute("logstatus", checklogin);
    session.setAttribute("username", LogName);
    session.setAttribute("userpw", LogPW);
    session.setAttribute("userid", UserID);
    session.setAttribute("userrole", UserRole);
    m_con.close();

    // detect user role
    if (UserRole.equals("a")){
      out.print("<H2>Now you can edit users and sensors.</H2>");
      out.print("<script language=javascript type=text/javascript>");
      out.print("setTimeout("+"\"javascript:location.href='administratorPage.jsp'\""+", 2500);");
      out.println("</script>");}

    else if (UserRole.equals("d")) {
      out.print("<H2>Now you can upload data.</H2>");
      out.print("<script language=javascript type=text/javascript>");
      out.print("setTimeout("+"\"javascript:location.href='dataCurator.jsp'\""+", 2500);");
      out.println("</script>");}


    else if (UserRole.equals("s")) {
      out.print("<H2>Now you can view, query and download data.</H2>");
      out.print("<script language=javascript type=text/javascript>");
      out.print("setTimeout("+"\"javascript:location.href='scientist.jsp'\""+", 2500);");
      out.println("</script>");} 
  }
}
}catch(Exception e) {
out.println(e.toString());
out.print("<script language=javascript type=text/javascript>");
out.print("javascript:location.href='account.jsp'");
out.print("</script>");
}

%>
<center><h3>
<br><br>
<a href='../document/UserDocumentation.html' target='_blank'>Help</a>
</h3></center>
</div>
</body>
</html>
