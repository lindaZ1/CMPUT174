import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class Asn2Sample extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		String SQLStatement = request.getParameter("SQLStatement");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
			"Transitional//EN\">\n" +
			"<HTML>\n" +
			"<HEAD><TITLE>Asn2Sample</TITLE></HEAD>\n" +
			"<BODY>\n" +
			"<H1>" +
                            exec(SQLStatement) + 
			"</H1>\n" +
			"</BODY></HTML>");
	}

       public String exec(String sql) {
         String ans="";
         String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
         String m_driverName = "oracle.jdbc.driver.OracleDriver";

         String m_userName = "dzhang4";
         String m_password = "Horsey26";

         Connection m_con;

         Statement stmt;

         try
         {

           Class drvClass = Class.forName(m_driverName);
           DriverManager.registerDriver((Driver)
           drvClass.newInstance());

         } catch(Exception e)
         {

           System.err.print("ClassNotFoundException: ");
           System.err.println(e.getMessage());

         }

         try
         {

           m_con = DriverManager.getConnection(m_url, m_userName,
                                               m_password);

           stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
           ResultSet rset=stmt.executeQuery(sql);

           Object o;
           ResultSetMetaData rsetMetaData=rset.getMetaData();
           int ccount=rsetMetaData.getColumnCount();

           while(rset.next()) {
             for(int i=1;i<=ccount;i++) {
               o=rset.getObject(i);
               if(o!=null) {
                 ans+=o.toString();
               }
               else {
                 ans+="null";
               }
               ans+=" ";
             }
             ans+="<br>\n";
           }
             
           stmt.close();
           m_con.close();

         } catch(SQLException ex) {

           System.err.println("SQLException: " +
                              ex.getMessage());

         }
         return ans;
}
}
