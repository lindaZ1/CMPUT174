import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import oracle.sql.*;
import oracle.jdbc.*;

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

public class Thumbnail extends HttpServlet {

	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		String imageId = request.getQueryString();
		
		
		Connection conn=null;
		String driverName="oracle.jdbc.driver.OracleDriver";
		String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		Statement stmt;

		try{    
			//load and register driver
			Class drvClass=Class.forName(driverName);
			DriverManager.registerDriver((Driver)drvClass.newInstance());

			//establish connection here
			conn=DriverManager.getConnection(dbstring,"tshen","ad50064051");
			
			String query = "select * from images where image_id = "+ imageId;
			stmt = conn.createStatement() ;
			stmt.executeQuery(query);
			ResultSet rset = stmt.executeQuery(query);

			ResultSetMetaData rsetMetaData=rset.getMetaData();
			int ccount=rsetMetaData.getColumnCount();
	
			while(rset.next()){
				Blob b = rset.getBlob("thumbnail");
				long size = b.length();
				byte[] bs = b.getBytes(1, (int)size);
				//String  = rset.get
				//ServletContext context = context.getServletContext();
				//String type = context.getMimeType(
				response.setContentType("image/jpeg");
				OutputStream outs = response.getOutputStream();
				outs.write(bs);
				outs.flush();
			}		
				
		}catch(Exception e){
			//out.println(e.getMessage());
			System.out.println("no picture available");
		}
	

	}
}
