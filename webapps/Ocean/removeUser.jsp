<%@ page import="java.sql.*" %>
<html>
<head></head>
<body>

<%	
    String rId= request.getParameter("removePersonId");
    //out.print(rId);
    Connection conn=null;
    Statement stmt;
    String driverName="oracle.jdbc.driver.OracleDriver";
    String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    try{
	//avoid empty value---------------------------
	boolean valid = true;
    	if(rId.length()==0){
		out.print("Please enter person id to create person"+"<br>");
		valid = false;
	}

	//avoid rId not numbric
	try{
		Integer rId1 = Integer.valueOf(rId);
        }catch(NumberFormatException e){
		out.print("Person id should be an integer"+"<br>");
       		valid = false;
   	}
         
        //load and register driver
        Class drvClass=Class.forName(driverName);
        DriverManager.registerDriver((Driver)drvClass.newInstance());

        //establish connection here
        conn=DriverManager.getConnection(dbstring,"dzhang4","Horsey26");

	//ensure person id exists
	Statement statement = conn.createStatement() ;
    	ResultSet resultset = statement.executeQuery("SELECT * FROM persons") ;
	
	boolean exist = false;
	if(valid){
		Integer rId1 = Integer.valueOf(rId);
		while(resultset.next()){
		     if(resultset.getInt("person_id") == rId1){
			  exist = true;
		     }
		}
	}
	statement.close();

	if(! exist){
		out.print("Person does not exist");
	}
	
	//delete sensor
	if (valid&&exist){
		//delete records in table with foreign key= sensor_id

		String query="DELETE from users where person_id= "+rId;
		stmt=conn.createStatement();
		stmt.executeQuery(query);

		query="DELETE from subscriptions where person_id= "+rId;
		stmt=conn.createStatement();
		stmt.executeQuery(query);
		
		query="DELETE from persons where person_id= "+rId;
		stmt=conn.createStatement();
		stmt.executeQuery(query);

		stmt.close();
		conn.close();
		out.print("Sensor has been removed"+"<br>");
	}

    }catch(Exception e) {
	out.println(e.toString());
    }
%>


  <form action= "editUser.jsp" method="post">
    <input type="submit" name= "return" value = "return"><br>
  </form>


</body>
</html>