import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import oracle.sql.*;
import oracle.jdbc.*;
import java.awt.Image;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

/**
 *  The package commons-fileupload-1.0.jar is downloaded from 
 *         http://jakarta.apache.org/commons/fileupload/ 
 *  and it has to be put under WEB-INF/lib/ directory in your servlet context.
 *  One shall also modify the CLASSPATH to include this jar file.
 */

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;

public class UploadAudio extends HttpServlet {


    public String response_message;
    public void doPost(HttpServletRequest request,HttpServletResponse response)
	throws ServletException, IOException {
	//  change the following parameters to connect to the oracle database
	String username = "tshen";
	String password = "ad50064051";
	String drivername = "oracle.jdbc.driver.OracleDriver";
	String dbstring ="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	int recording_id=0;

	try {
	    //Parse the HTTP request to get the image stream
	    DiskFileUpload fu = new DiskFileUpload();
	    
	    List FileItems=null;
	    try {
		FileItems = fu.parseRequest(request);
	    }
	    catch (FileUploadException e) {
		e.printStackTrace();
	    }
	   
		
	    // Process the uploaded items, assuming only 1 audio file uploaded
	    int nbFiles = FileItems.size();
	    FileItem[] items = new FileItem[nbFiles];
	    Iterator i = FileItems.iterator();
	    int j = 0;
	    items[j] = (FileItem)i.next();
 
	    while (i.hasNext() && !items[j].isFormField() ) {
		if("file-path".equals(items[j].getFieldName())){
			if (items[j].getName()==null || items[j].getName().isEmpty()){
				response.sendRedirect("uploadFinish.jsp");
			}
		}
	    	j++;
	    	items[j] = (FileItem) i.next();
	    }

	    // Connect to the database and create a statement
	    Connection conn = getConnected(drivername,dbstring, username,password);
	    //conn.setAutoCommit(false);
	    Statement stmt = conn.createStatement();
	    response_message = "";

	    for (int n=0;n<j;n++) {
	    	InputStream instream = items[n].getInputStream();

	    	/*
		     *  First, to generate a unique recording_id using an SQL sequence
		     */
		    
		    ResultSet rset1 = stmt.executeQuery("SELECT recording_id.nextval from dual");
		    if(rset1!=null && rset1.next()) {
			recording_id=rset1.getInt(1);
			rset1.close();
		    }
		    stmt.executeUpdate("commit");
		    stmt.close();
System.out.print("a");	
		    HttpSession session = request.getSession();
		    session.setAttribute("currentid",recording_id);

		    String query="INSERT INTO audio_recordings VALUES(?,?,?,?,?,?)";
		    PreparedStatement statement=conn.prepareStatement(query);

	System.out.print("a");	    
		    int number=3333;
		    statement.setInt(1, recording_id);
		    statement.setInt(2, number);
		    statement.setDate(3, java.sql.Date.valueOf("2013-09-04"));
		    statement.setInt(4, number);
		    statement.setString(5, "testdesc");
	            statement.setBlob(6, instream);
   	    
		   
		    statement.executeUpdate();
System.out.print("a");
		    statement.executeUpdate("commit");
		    //conn.commit();
		    statement.close();	
		    
		    instream.close();
	            
		    response_message = " Upload Ok! ";
	    }
        	conn.close();
        	response.sendRedirect("uploadAudio.jsp");

	} catch( Exception ex ) {
	    //System.out.println( ex.getMessage());
	    response_message = ex.getMessage();
	    
	}

	//Output response to the client
    }

    /*
      /*   To connect to the specified database
    */
    private static Connection getConnected( String drivername,
					    String dbstring,
					    String username, 
					    String password  ) 
	throws Exception {
	Class drvClass = Class.forName(drivername); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	return( DriverManager.getConnection(dbstring,username,password));
    } 

}
