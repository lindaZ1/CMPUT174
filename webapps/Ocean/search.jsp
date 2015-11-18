<html>
    <head>
        <title>Enter search conditions</title>
    </head>
</html>
<body>
    
    <h3> Enter search conditions </h3>
	
    <form action= "searchResult.jsp" method="post">
    List of Keywords:
    <input type="text" name= "keywords"> AND/OR<br>
    Sensor Type:
    <input type="text" name="type"> AND/OR<br>
    Sensor Location:
    <input type = "text" name="location"> AND<br>
    Time Period:<br>
    Date after (YYYY-MM-DD) <input type = "text" name="begin"><br>
    Date before(YYYY-MM-DD) <input type = "text" name ="end"><br>

    <input type="submit" name="submit" value= "search">
  </form>
   
    <form action= "scientist.jsp" method="post">
    <input type="submit" name="submit" value= "Main Menu">
  
    
</body>
