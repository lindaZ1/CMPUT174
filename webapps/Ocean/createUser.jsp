<%@ page import="java.sql.*" %>
<html>
<head></head>
<body>

<%
    String Id = request.getParameter("createPersonId");
    String first = request.getParameter("firstName");
    String last = request.getParameter("lastName");
    String address = request.getParameter("address");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone"); 

    Connection conn=null;
    String driverName="oracle.jdbc.driver.OracleDriver";
    String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    try{
      
        //load and register driver
        Class drvClass=Class.forName(driverName);
        DriverManager.registerDriver((Driver)drvClass.newInstance());

        //establish connection here
        conn=DriverManager.getConnection(dbstring,"dzhang4","Horsey26");

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
	if(phone.length()>10){
		out.print("Length of phone number should be less than or equal to 10");
		valid = false;
	}

	//check duplicates before insertion--------------------
	Statement statement = conn.createStatement() ;
    	ResultSet resultset = statement.executeQuery("SELECT * FROM persons") ;
	
	boolean unique = true;
	if(valid){
		Integer Id1 = Integer.valueOf(Id);
		while(resultset.next()){
		     if(resultset.getInt("person_id") == Id1){
			  unique = false;
			  out.print("person already exists,chose another person id"+ "<br>");
		     }
		}
	}
	
	statement = conn.createStatement() ;
    	resultset = statement.executeQuery("SELECT * FROM persons") ;

	if(valid){
		while(resultset.next()){
		     if(resultset.getString("email").equals(email)){
			  unique = false;
			  out.print("email already exists,chose another email"+ "<br>");
		     }
		}
	}
	
	statement.close();
    
    	// If value to be added is unique,create sensor----------
  	if(valid && unique){
	    Integer Id1 = Integer.valueOf(Id);
	    out.print("Person has been created");
	    String query="INSERT INTO persons VALUES (?,?,?,?,?,?)";
	    PreparedStatement stmt =conn.prepareStatement(query);
	    stmt.setInt(1,Id1);
	    stmt.setString(2,first);
	    stmt.setString(3,last);
	    stmt.setString(4,address);
	    stmt.setString(5,email);
	    stmt.setString(6,phone);

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
    <form action= "editUser.jsp" method="post">
    <input type="submit" name="submit" value= "Back to edit user">

