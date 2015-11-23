<%@ page import="java.sql.*" %>
<html>
<head></head>
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

<%
    String Id = request.getParameter("updatePersonId");
    String first = request.getParameter("firstName1");
    String last = request.getParameter("lastName1");
    String address = request.getParameter("address1");
    String email = request.getParameter("email1");
    String phone = request.getParameter("phone1"); 

    Connection conn=null;
    String driverName="oracle.jdbc.driver.OracleDriver";
    String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    try{
      
        //load and register driver
        Class drvClass=Class.forName(driverName);
        DriverManager.registerDriver((Driver)drvClass.newInstance());

        //establish connection here
        conn=DriverManager.getConnection(dbstring,"tshen","ad50064051");

	//avoid empty value---------------------------
	boolean valid = true;
    	if(Id.length()==0 || first.length()==0 || last.length()==0 || address.length()==0 || email.length()==0 || phone.length()==0 ){
		out.print("Please complete all information to create person"+"<br>");
		valid = false;
	}
	
	//avoid Id not numbric--------------------
	try{
		Integer Id1 = Integer.valueOf(Id);
        }catch(NumberFormatException e){
		out.print("Person id should be an integer"+"<br>");
       		valid = false;
   	}
	
	//avoid length of phone exceeds 10
	if(phone.length() != 0 && phone.length()>10){
		out.print("Length of phone number should be less than or equal to 10");
		valid = false;
	}

	//check person id exists--------------------
	Statement statement = conn.createStatement() ;
    	ResultSet resultset = statement.executeQuery("SELECT * FROM persons") ;
	
	boolean exist = false;
	if(valid){
		Integer Id1 = Integer.valueOf(Id);
		while(resultset.next()){
		     if(resultset.getInt("person_id") == Id1){
			  exist = true;
		     }
		}
	}

	if(! exist){
		out.print("Person does not exist"+"<br>");
	}
	
	//check duplicate emails---------------------
	statement = conn.createStatement();
    	resultset = statement.executeQuery("SELECT * FROM persons WHERE person_id <>"+ Id);
	
	boolean unique = true;
	if(valid){
		while(resultset.next()){
		     if(resultset.getString("email").equals(email)){
			  unique = false;
			  out.print("email already exists, chose another email"+ "<br>");
		     }
		}
	}
	
	statement.close();
    
    	// If value to be added is unique,create sensor----------
  	if(valid && exist && unique){
	    out.print("Person has been created");
	    String query="UPDATE persons SET first_name = ?,last_name=?,address = ?,email=?,phone = ? WHERE person_id ="+Id;
	    PreparedStatement stmt =conn.prepareStatement(query);
	    stmt.setString(1,first);
	    stmt.setString(2,last);
	    stmt.setString(3,address);
	    stmt.setString(4,email);
	    stmt.setString(5,phone);

	    stmt.executeUpdate();
	    
	    stmt.close();
	    conn.close();
	} 

    }catch(Exception e) {
	out.println(e.toString());
    }
%> 
    <br>
    <form action= "editUser.jsp" method="post">
    <input type="submit" name="submit" value= "Back to edit user">
    </form>
<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>
</center>
<center><h3>
<br><br>
<a href='UserDocumentation.html' target='_blank'>Help</a>
</h3></center>
</div>
</body>
</html>
