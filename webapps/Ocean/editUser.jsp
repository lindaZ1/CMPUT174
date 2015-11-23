<%@ page import="java.sql.*" %>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>Users</title>
    </head>
</html>
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
if (!UserRole.equals("a")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='account.jsp'");
    out.print("</script>");
}
%>
    <h1>User Table</h1>

    <h3>All users:</h3>
    <TABLE BORDER=2>
        <TR>
            <TH>PERSON ID</TH>
	    <TH>FIRST NAME</TH>
	    <TH>LAST NAME</TH>
	    <TH>ADDRESS</TH>
	    <TH>EMAIL</TH>
	    <TH>PHONE</TH>
        </TR>
<%
    Connection conn=null;
    Statement stmt;
    String driverName="oracle.jdbc.driver.OracleDriver";
    String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    try{        
        //load and register driver
        Class drvClass=Class.forName(driverName);
        DriverManager.registerDriver((Driver)drvClass.newInstance());

        //establish connection here
        conn=DriverManager.getConnection(dbstring,"tshen","ad50064051");

	String query="select * from persons";
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rset=stmt.executeQuery(query);

	Object o;
	ResultSetMetaData rsetMetaData=rset.getMetaData();
	int ccount=rsetMetaData.getColumnCount();

	String ans="";
	
	while(rset.next()) {
	    ans+="<TR>";
	    for(int i=1;i<=ccount;i++) {
		o=rset.getObject(i);
		ans+="<TD>";
		if(o!=null){
		    ans+=o.toString();
		}
		else{
		    ans+="null";
		}
		ans+="</TD>";
	    }
	    ans+="</TR>";
	}
	out.println(ans);
	stmt.close();
	conn.close();
    }catch(Exception e) {
	out.println(e.toString());
    }
%> 
</Table>

    <h3>Remove a User:</h3>
    <form action= "removeUser.jsp" method="post">
    Person Id:
    <input type="text" name= "removePersonId"><br>
    <input type="submit" name="submit" value= "remove">
  </form>

    <h3>Create a User:</h3>
    <form action= "createUser.jsp" method="post">
<TABLE>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Person Id:</TD>
    <TD><input type="text" name= "createPersonId"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>First Name:</TD>
    <TD><input type="text" name="firstName"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Last Name:</TD>
    <TD><input type="text" name="lastName"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Address:</TD>
    <TD><input type = "text" name="address"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Email:</TD>
    <TD><input type = "text" name="email"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Phone:</TD>
    <TD><input type = "text" name="phone"></TD>
</TR>
</TABLE>
    <input type="submit" name="submit" value= "create">
  </form>
   
    <h3>Update a User:</h3>
    <form action= "updateUser.jsp" method="post">
<TABLE>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Person Id:</TD>
    <TD><input type="text" name= "updatePersonId"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>First Name:</TD>
    <TD><input type="text" name="firstName1"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Last Name:</TD>
    <TD><input type="text" name="lastName1"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Address:</TD>
    <TD><input type = "text" name="address1"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Email:</TD>
    <TD><input type = "text" name="email1"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Phone:</TD>
    <TD><input type = "text" name="phone1"></TD>
</TR>
</TABLE>
    <input type="submit" name="submit" value= "update">
  </form>

    <form action= "administratorPage.jsp" method="post">
    <input type="submit" name="submit" value= "Main Menu">
  </form>
<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>
</center>
</H2>
<center><h3>
<br><br>
<a href='UserDocumentation.html' target='_blank'>Help</a>
</h3></center>
</div>
</body>
</html>
