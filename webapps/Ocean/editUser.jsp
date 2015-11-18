<%@ page import="java.sql.*" %>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>Users</title>
    </head>
</html>
<body>
<%
String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin == "false"){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='login.html'");
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
        conn=DriverManager.getConnection(dbstring,"dzhang4","Horsey26");

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
    Person Id:
    <input type="text" name= "createPersonId"><br>
    First Name:
    <input type="text" name="firstName"><br>
    Last Name:
    <input type="text" name="lastName"><br>
    Address:
    <input type = "text" name="address"><br>
    Email:
    <input type = "text" name="email"><br>
    Phone:
    <input type = "text" name="phone"><br>

    <input type="submit" name="submit" value= "create">
  </form>
   
    <h3>Update a User:</h3>
    <form action= "updateUser.jsp" method="post">
    Person Id:
    <input type="text" name= "updatePersonId"><br>
    First Name:
    <input type="text" name="firstName1"><br>
    Last Name:
    <input type="text" name="lastName1"><br>
    Address:
    <input type = "text" name="address1"><br>
    Email:
    <input type = "text" name="email1"><br>
    Phone:
    <input type = "text" name="phone1"><br>

    <input type="submit" name="submit" value= "update">
  </form>

    <form action= "administratorPage.jsp" method="post">
    <input type="submit" name="submit" value= "Main Menu">
  </form>
<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>
</body>
