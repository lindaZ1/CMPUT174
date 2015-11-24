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
import java.lang.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

//http://stackoverflow.com/questions/23836728/how-to-export-the-data-in-a-list-to-a-csv-file-in-the-server-side

public class DownloadScalar extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				String imageId = request.getQueryString();
		
		
		Connection conn=null;
		String driverName="oracle.jdbc.driver.OracleDriver";
		String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		Statement stmt;
		
		String Id = request.getQueryString();		
	
		try{    
			//load and register driver
			Class drvClass=Class.forName(driverName);
			DriverManager.registerDriver((Driver)drvClass.newInstance());

			//establish connection here
			conn=DriverManager.getConnection(dbstring,"tshen","ad50064051");
			
			String query = "select * from scalar_data where id = "+ Id;
			stmt = conn.createStatement() ;
			stmt.executeQuery(query);
			ResultSet rset = stmt.executeQuery(query);

			ResultSetMetaData rsetMetaData=rset.getMetaData();
			int ccount=rsetMetaData.getColumnCount();
	
			while(rset.next()){
				
				int sid = rset.getInt("id");
				String sId = Integer.toString(sid)+",";
				byte[] b = sId.getBytes();

				int sensor_id = rset.getInt("sensor_id");
				String sensorId = Integer.toString(sensor_id)+",";
				byte[] b1 = sensorId.getBytes();
				
				Date create = rset.getDate("date_created");
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				String createDate = df.format(create)+",";
				byte[]b2 = createDate.getBytes();	
				
				float value = rset.getFloat("value");
				String svalue = Float.toString(value);		
				byte[] b3 = svalue.getBytes();				

				response.setContentType("application/csv");
				response.setHeader("Content-Disposition","inline; filename=scalar" + ".csv");
				OutputStream outs = response.getOutputStream();
				outs.write(b);
				outs.write(b1);
				outs.write(b2);
				outs.write(b3);
				outs.flush();
			

			}		
			
				
		}catch(Exception e){
			//out.println(e.getMessage());
			System.out.println("no picture available");
		}
	

	}
	    
}
