<%@ page import="java.sql.*" %>
<html>
<head></head>
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

<%	
    String rName= request.getParameter("removeName");
    //out.print(rId);
    Connection conn=null;
    Statement stmt;
    String driverName="oracle.jdbc.driver.OracleDriver";
    String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    boolean valid = true;

    try{
	//avoid empty value---------------------------
    	if(rName.length()==0){
		out.print("Please enter user name to create user"+"<br>");
		valid = false;
	}
         
        //load and register driver
        Class drvClass=Class.forName(driverName);
        DriverManager.registerDriver((Driver)drvClass.newInstance());

        //establish connection here
        conn=DriverManager.getConnection(dbstring,"tshen","ad50064051");

	//ensure user name exists
	Statement statement = conn.createStatement() ;
    	ResultSet resultset = statement.executeQuery("SELECT * FROM users") ;
	
	boolean exist = false;
	if(valid){
		while(resultset.next()){
		     if(resultset.getString("user_name").equals(rName)){
			  exist = true;
		     }
		}
	}
	statement.close();

	if(! exist){
		out.print("User does not exist");
	}
	
	//delete user
	if (valid && exist){

		String query="DELETE from users where user_name = '" +rName+"'";
		stmt=conn.createStatement();
		stmt.executeQuery(query);

		stmt.close();
		conn.close();
		out.print("User has been removed"+"<br>");
	}

    }catch(Exception e) {
	out.println(e.toString());
    }
%>


  <form action= "editAUser.jsp" method="post">
    <input type="submit" name= "return" value = "return"><br>
  </form>
<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>

</body>
</html>
