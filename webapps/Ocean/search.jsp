<html>
    <head>
        <title>Enter search conditions</title>
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
    
    <h3> Enter search conditions </h3>
	
    <form action= "searchResult.jsp" method="post">
    List of Keywords:
    <input type="text" name= "keywords"> AND/OR<br>
    Sensor Type:
    <input type="text" name="type"> AND/OR<br>
    Sensor Location:
    <input type = "text" name="location"> AND<br>
    Time Period:<br>
    Date after (DD/MM/YYYY) <input type = "text" name="begin"><br>
    Date before(DD/MM/YYYY) <input type = "text" name ="end"><br>

    <input type="submit" name="submit" value= "search">
  </form>
   
    <form action= "scientist.jsp" method="post">
    <input type="submit" name="submit" value= "Main Menu">
  </form>

<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>
    
</body>
