<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.fileupload.*, java.util.List, java.util.Iterator"%>
<%@ page import="org.apache.commons.io.*" %>
<html>
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

	//establish the connection to the underlying database
	Connection conn = null;
	//load and register the driver
	Class drvClass = Class.forName("oracle.jdbc.driver.OracleDriver"); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	//establish the connection 
	conn = DriverManager.getConnection("jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS","tshen","ad50064051");
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement();

	DiskFileUpload fu=new DiskFileUpload();
	List FileItems=null;
	
        try {
	    FileItems = fu.parseRequest(request);
        }
        catch (FileUploadException e) {
	    e.printStackTrace();
        }
	byte fileData[]=null;

	Iterator itr=FileItems.iterator();
	
	while(itr.hasNext()) {
		FileItem item=(FileItem) itr.next();
		if(!item.isFormField()) {

			try{
				String filename=item.getName();
				InputStream stream=application.getResourceAsStream(filename);
				fileData=item.get();
				
				if(fileData.length==0) {
					response.sendRedirect("uploadFinish.jsp");
				}
				int id=0;
				String line;
				StringBuilder contents=new StringBuilder();
				BufferedReader input=new BufferedReader(new InputStreamReader(stream));

				while((line=input.readLine())!=null) {	
					//line=input.readLine();
					contents.append(line);
					String info[]=line.split(",");
					
					if(info[0]!="") {
						//generate id
						ResultSet rset1 = stmt.executeQuery("SELECT SEQ_IMAGE_ID.nextval from dual");
						if(rset1!=null && rset1.next()) {
						    id=rset1.getInt(1);
						    rset1.close();
				    		}
					
						//extract info
						String sensor_id=info[0];
						String date=info[1];
						String value=info[2];
						date="'"+date+"'";

						stmt.execute("insert into scalar_data values ("+id+","+sensor_id+",to_date("+date+",'dd/mm/yyyy hh24:mi:ss'),"+value+")");
						stmt.execute("commit");
						
		
					}

					
				}
				
			}catch(Exception e) {}
			
		}
	}
	//response.sendRedirect("uploadFinish.jsp");
%>
data inserted
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

