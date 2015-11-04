package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class alter_005fsubscribe_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("<html>\n");
      out.write("<head></head>\n");
      out.write("<body>\n");
      out.write("\t<br></br>\n");
      out.write("\t");

		String sensor_id = request.getParameter("sensor_id");
		out.println(sensor_id);
		
		String action=request.getParameter("action");
		out.print(action);
		
		String person_id=request.getParameter("person");
		out.print(person_id);

		Boolean sensorExist=false;
		Boolean sensorSubscribed=false;


		Connection conn=null;
	        Statement stmt;
	        String driverName="oracle.jdbc.driver.OracleDriver";
	        String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	        try{        
		    //load and register driver
		    Class drvClass=Class.forName(driverName);
		    DriverManager.registerDriver((Driver)drvClass.newInstance());

		    //establish connection here
		    conn=DriverManager.getConnection(dbstring,"dzhang4","Horsey26");
		    String query="select sensor_id from sensors";
		    //stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		    stmt=conn.createStatement();
		    ResultSet rset=stmt.executeQuery(query);

		    Object o;
		    ResultSetMetaData rsetMetaData=rset.getMetaData();
		    int ccount=rsetMetaData.getColumnCount();
		    while(rset.next()) {
		        if(sensorExist==false) {
			    o=(rset.getObject(1)).toString();

			    //check if entered sensor exists
			    if(o.equals(sensor_id.trim())) {
			        sensorExist=true;
			        out.println("exist");
			    }
		        }
		    }

		    if(sensorExist==false) {
			out.println("sensor_id: "+sensor_id +" does not exist");
		    }

		    if(sensorExist==true) {
			    query="select sensor_id from subscriptions where person_id='"+person_id+"'";
			    //stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			    stmt=conn.createStatement();
			    rset=stmt.executeQuery(query);

			    while(rset.next()) {
				if(sensorSubscribed==false) {
				    o=(rset.getObject(1)).toString();

				    //check if entered sensor is already subscribed by user
				    if(o.equals(sensor_id.trim())) {
					sensorSubscribed=true;
					out.println("already subscribed");
				    }
				}
			    }
		    }
		    
		    if(action.equals("add") && sensorExist && sensorSubscribed==false) {
			//add subscription to sensor
		        query="INSERT INTO subscriptions VALUES ("+sensor_id+","+person_id+")";
			//stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			stmt=conn.createStatement();
		        rset=stmt.executeQuery(query);
			out.println("sensor added");
		    }

		    else if(action.equals("remove") && sensorSubscribed) {
			//delete subscription
			query="DELETE FROM subscriptions WHERE person_id='"+person_id+"' AND sensor_id='"+sensor_id+"'";
			//stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			stmt=conn.createStatement();
		        rset=stmt.executeQuery(query);
			out.println("sensor removed");
		    }

		    else if(action.equals("remove") && sensorSubscribed==false) {
			out.println("sensor not subscribed");
		    }
		    stmt.close();
		    conn.close();
		}catch(Exception e) {out.println(e.toString());}

	
      out.write("\n");
      out.write("\n");
      out.write("<form action=\"subscribe.jsp\" method=\"post\">\n");
      out.write("    <br></br><input type=\"submit\" value=\"Return to Subscriptions\">\n");
      out.write("</form>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else log(t.getMessage(), t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
