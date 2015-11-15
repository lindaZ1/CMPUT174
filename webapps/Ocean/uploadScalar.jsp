<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
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

	String contentType=request.getContentType();
	if((contentType!=null) && (contentType.indexOf("multipart/form-data")>=0)) {
		DataInputStream in=new DataInputStream(request.getInputStream());
		int formDataLength = request.getContentLength();
		byte dataBytes[] = new byte[formDataLength];
		int byteRead = 0;
		int totalBytesRead = 0;
		 
		while (totalBytesRead < formDataLength) {
			byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
			totalBytesRead += byteRead;
		}
		String file=new String(dataBytes);
		
		String saveFile = file.substring(file.indexOf("filename=\"") + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\")+ 1,saveFile.indexOf("\""));
		/*int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex + 1,contentType.length());
		int pos;
		 
		pos = file.indexOf("filename=\"");
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;


		File ne=new File(saveFile);		 
		FileOutputStream fileOut = new FileOutputStream(ne);
		fileOut.write(dataBytes, startPos, (endPos - startPos));
*/
		int id;
		String line;
		out.println(saveFile);
		try{
			StringBuilder contents=new StringBuilder();
			BufferedReader input=new BufferedReader(new FileReader(saveFile));
			while((line=input.readLine())!=null) {	
				//line=input.readLine();
				contents.append(line);
				out.println("line "+line);
				if(line!=null) {
					String info[]=line.split(",");
					out.println(line);
					
					//generate id
					ResultSet rset1 = stmt.executeQuery("SELECT SEQ_IMAGE_ID.nextval from dual");
					if(rset1!=null && rset1.next()) {
					    id=rset1.getInt(1);
					    out.println(id);
					    rset1.close();
			    		}
					
				}
			}
		}catch(Exception e) {}
	}
%>
</html>

