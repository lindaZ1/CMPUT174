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
if (checklogin == "false"){
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
            <TH>USER NAME</TH>
	    <TH>PASSWORD</TH>
	    <TH>ROLE</TH>
	    <TH>PERSON ID</TH>
	    <TH>DATE REGISTERED</TH>
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

	String query="select * from users";
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
	out.print("<script language=javascript type=text/javascript>");
	out.print("javascript:location.href='account.jsp'");
	out.print("</script>");
    }
%> 
</Table>

    <h3>Remove a User:</h3>
    <form action= "removeAUser.jsp" method="post">
    User Name:
    <input type="text" name= "removeName"><br>
    <input type="submit" name="submit" value= "remove">
  </form>

    <h3>Create a User:</h3>
    <form action= "createAUser.jsp" method="post">
<TABLE>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>User Name:</TD>
    <TD><input type="text" name= "createName"><br></TD></TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Password:</TD>
    <TD><input type="text" name="password"><br></TD></TR>
<TR VALIGN=TOP ALIGN=LEFT>
   <TD> Role:</TD>
    <TD><input type="text" name="role"><br></TD></TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Person Id:</TD>
    <TD><input type = "text" name="id"><br></TD></TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Date Registered:</TD>
    <TD><input type = "text" name="date"><br></TD></TR>
</Table>
    <input type="submit" name="submit" value= "create">
  </form>


    <h3>Update a User:</h3>
    <form action= "updateAUser.jsp" method="post">
<TABLE>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>User Name:</TD>
    <TD><input type="text" name= "updateName"><br></TD></TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Password:</TD>
    <TD><input type="text" name="password1"><br></TD></TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Role:</TD>
    <TD><input type="text" name="role1"><br></TD></TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Person Id:</TD>
    <TD><input type = "text" name="id1"><br></TD></TR>
<TR VALIGN=TOP ALIGN=LEFT>
    <TD>Date Registered:</TD>
    <TD><input type = "text" name="date1"><br></TD></TR>
</Table>
    <input type="submit" name="submit" value= "update">
  </form>

    <form action= "administratorPage.jsp" method="post">
    <input type="submit" name="submit" value= "Main Menu">
  </form>

    <form  action= "account.jsp" method="post">
    <input type="submit" name="account" value="My Account">
    </form>

</center>

<center><h3><br><br><a href='UserDocumentation.html' target='_blank'>Help</a></h3></center>
</div>
</body>

