<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.fileupload.*, java.util.List, java.io.File, java.util.Iterator"%>
<%@ page import="org.apache.commons.io.*" %>
<html>
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

	//establish the connection to the underlying database
	Connection conn = null;
	//load and register the driver
	Class drvClass = Class.forName("oracle.jdbc.driver.OracleDriver"); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	//establish the connection 
	conn = DriverManager.getConnection("jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS","dzhang4","Horsey26");
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
			//File file=new File(item.getName());
			//File saveFile=new File(getServletContext().getRealPath("/"),file.getName());
			//item.write(saveFile);

			try{
				String filename=item.getName();
				InputStream stream=application.getResourceAsStream(filename);
				fileData=item.get();

				int id=0;
				String line;
				StringBuilder contents=new StringBuilder();
				BufferedReader input=new BufferedReader(new InputStreamReader(stream));
				while((line=input.readLine())!=null) {	
					//line=input.readLine();
					contents.append(line);
					String info[]=line.split(",");
					out.println("line "+line);
					
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
						date="'"+date.substring(1,20)+"'";
out.println(date);
						out.println("insert into scalar_data values ("+id+",'"+sensor_id+"',to_date("+date+",'mm/dd/yyyy hh24:mi:ss'),'"+value+"')");
						stmt.execute("insert into scalar_data values ("+id+","+sensor_id+",to_date("+date+",'mm/dd/yyyy hh24:mi:ss'),"+value+")");
						stmt.execute("commit");

		
					}

					
				}
			}catch(Exception e) {}
		}
	}
	//response.sendRedirect("uploadFinish.jsp");
%>
<form  action= "account.jsp" method="post">
<input type="submit" name="account" value="My Account">
</form>
</html>

