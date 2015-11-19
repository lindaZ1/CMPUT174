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
	String username = "dzhang4";
	String password = "Horsey26";
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
	    ArrayList info=new ArrayList();
	    items[j] = (FileItem)i.next();
 
	    while (i.hasNext() && !items[j].isFormField() ) {
	    	j++;
	    	items[j] = (FileItem) i.next();
	    }

	    
	    // Connect to the database and create a statement
	    Connection conn = getConnected(drivername,dbstring, username,password);
	    Statement stmt = conn.createStatement();
	    response_message = "";

	    for (int n=0;n<j;n++) {
	    	InputStream instream = items[n].getInputStream();
	    	//BufferedImage img = ImageIO.read(instream);
	    	

	    	/*
		     *  First, to generate a unique recording_id using an SQL sequence
		     */
		    
		    ResultSet rset1 = stmt.executeQuery("SELECT recording_id.nextval from dual");
		    if(rset1!=null && rset1.next()) {
			recording_id=rset1.getInt(1);
			rset1.close();
		    }

		    HttpSession session = request.getSession();
		    session.setAttribute("currentid",recording_id);

		    String query="INSERT INTO audio_recordings VALUES(?,?,?,?,?,?)";
		    PreparedStatement statement=conn.prepareStatement(query);
		    
		    if(instream!=null) {
			int number=3333;
			statement.setInt(1, recording_id);
			statement.setInt(2, number);
			statement.setDate(3, java.sql.Date.valueOf("2013-09-04"));
			statement.setInt(4, number);
			statement.setString(5, "testdesc");
		        statement.setBlob(6, instream);
    		    }		
		    statement.executeUpdate();
System.out.println("here");
		    
		    //stmt.execute("INSERT INTO audio_recordings VALUES("+recording_id+",3333,SYSDATE,0,'testdesc',?)");

		    //stmt.execute("commit");

	
		    // to retrieve the lob_locator 
		    // Note that you must use "FOR UPDATE" in the select statement
		    //String cmd = "SELECT * FROM audio_recordings WHERE recording_id = "+recording_id+" FOR UPDATE";
		    
		    //ResultSet rset = stmt.executeQuery(cmd);
		    //rset.next();
		    
		    
		    //BLOB myblob = ((OracleResultSet)rset).getBLOB(6); // 6 column index is audio file

		    //Write audio file to the blob object
		   // OutputStream outstream = myblob.setBinaryStream(1);
		   // ImageIO.write(audio, "wav", outstream);
		    
		    instream.close();
		   // outstream.close();
	            stmt.executeUpdate("commit");
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
