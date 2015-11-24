<%@ page import="java.sql.*" %>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
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
String UserRole = (String) session.getAttribute("userrole");
if (!UserRole.equals("a")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='account.jsp'");
    out.print("</script>");
}
%>

<%
    String name = request.getParameter("createName");
    String password = request.getParameter("password");
    String role = request.getParameter("role");
    String id = request.getParameter("id");
    String date = request.getParameter("date");
    boolean valid = true;
    Date d1;

    //avoid invalid dates--------
    try{
	DateFormat df = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
	df.setLenient(false);
	d1 = df.parse(date);
	
    }catch(Exception e){
	valid= false;
	out.print("Invalid date"+"<br>");
	
    }
	
    //avoid Id not numbric--------------------
    try{
	Integer Id1 = Integer.valueOf(id);
    }catch(NumberFormatException e){
	out.print("Person id should be an integer"+"<br>");
       	valid = false;
    }

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
	
    	if(name.length()==0 || password.length()==0 || role.length()==0 || id.length()==0 || date.length()==0){
		out.print("Please complete all information to create user"+"<br>");
		valid = false;
	}
	
	//avoid invalid user type
	if(role.equals("a") || role.equals("i") || role.equals("s")){
		//do nothing
	}else{
		out.print("invalid user type"+"<br>");
		valid = false;
	}	    

	//check duplicates before insertion--------------------
	Statement statement = conn.createStatement() ;
    	ResultSet resultset = statement.executeQuery("SELECT * FROM users") ;
	
	boolean unique = true;
	if(valid){
		while(resultset.next()){
		     if(resultset.getString("user_name").equals(name)){
			  unique = false;
			  out.print("User already exists,chose another user name"+ "<br>");
		     }
		}
	}
	
	statement = conn.createStatement() ;
    	resultset = statement.executeQuery("SELECT * FROM persons") ;
	
	Boolean exist = false;

	if(valid){
		Integer Id1 = Integer.valueOf(id);
		while(resultset.next()){
		     if(resultset.getInt("person_id")== Id1){
			exist = true;
		     }
		}
	}

	if(! exist){
		out.print("Person id does not exist");
	}
	
	statement.close();
    
    	// If value to be added is unique,create user----------
  	if(valid && unique && exist){
	    Integer Id1 = Integer.valueOf(id);
	    DateFormat df = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
            df.setLenient(false);
	    d1 = df.parse(date);

	    out.print("User has been created");
	    String query="INSERT INTO users VALUES (?,?,?,?,?)";
	    PreparedStatement stmt =conn.prepareStatement(query);
	    stmt.setString(1,name);
	    stmt.setString(2,password);
	    stmt.setString(3,role);
	    stmt.setInt(4,Id1);
	    stmt.setDate(5, new java.sql.Date(d1.getTime()));

	    stmt.executeUpdate();
	    //stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    //stmt.executeQuery(query);
	    stmt.close();
	    conn.close();
	} 

    }catch(Exception e) {
	out.println(e.toString());
    }
%> 
    <br>
    <form action= "editAUser.jsp" method="post">
    <input type="submit" name="submit" value= "Back to edit user">
    </form>
<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>

