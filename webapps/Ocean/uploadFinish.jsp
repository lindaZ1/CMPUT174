<%@ page import="java.sql.*" %>
<html>

<%
if (request.getParameter(".submit") != null){
	int pic_id;
	int current_pic_id;
	//establish the connection to the underlying database
	Connection conn = null;
	//load and register the driver
	Class drvClass = Class.forName("oracle.jdbc.driver.OracleDriver"); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	//establish the connection 
	conn = DriverManager.getConnection("jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS","***","****");
	conn.setAutoCommit(false);
	
	Statement stmt = conn.createStatement();
	
	String name = request.getParameter("OWNER");
	String subject = request.getParameter("SUBJ").trim();
	String place = request.getParameter("PLACE").trim();
	String permitted = request.getParameter("PERMITTED").trim();
	String desc = request.getParameter("DESC").trim();
	String date = request.getParameter("Date");
	pic_id = (Integer)session.getAttribute("getid") + 1;
	current_pic_id = (Integer)session.getAttribute("currentid");
	while (pic_id <= current_pic_id){
		//stmt.execute("INSERT INTO imagesviewer VALUES('"+pic_id+"','"+name+"')");
		//stmt.execute("commit");
		stmt.execute("update images set timing=TO_DATE('"+date+"','mm/dd/yyyy hh24:mi:ss'),owner_name='"+name+"',permitted='"+permitted+"',subject='"+subject+"',place='"+place+"',description='"+desc+"'where photo_id='"+pic_id+"'");
		pic_id++;
	}
	session.removeAttribute("getid");
	session.removeAttribute("currentid");
    stmt.execute("commit");
    conn.close();
    
    response.sendRedirect("profile.jsp");
}
%>
</html>