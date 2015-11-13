package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class uploadImage_jsp extends org.apache.jasper.runtime.HttpJspBase
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

	String sensor_id=request.getParameter("sensor_id");
	out.println(sensor_id);

	String date=request.getParameter("date");

	String description=request.getParameter("description");
	out.println(description);

	Boolean sensorExist=false;

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
	}catch(Exception e) {out.println(e.toString());}

	if(sensorExist) {
	//upload after form is filled out correctly

      out.write("\n");
      out.write("\t\n");
      out.write("\tUpload Image (.jpg).\n");
      out.write("\tPlease input or select the path of the image!\n");
      out.write("\t<form name=\"upload-file\" method=\"post\" enctype=\"multipart/form-data\" action=\"UploadImage\">\n");
      out.write("\t<table border=\"0\" width=\"30%\" cellpadding=\"5\">\n");
      out.write("\t<tr>\n");
      out.write("\t<td><B>File path: </B></td>\n");
      out.write("\t<td>\n");
      out.write("\t<input name=\"file-path\"\" type=\"file\" class=\"upload\" multiple=\"\">\n");
      out.write("\t</td>\n");
      out.write("\t</tr>\n");
      out.write("\t<tr>\n");
      out.write("\t<td><input name=\".submit\" value=\"Upload\" type=\"submit\"></td>\n");
      out.write("\t<td><input name=\".reset\" value=\"Reset\" type=\"reset\"></td>\n");
      out.write("\t</tr>\n");
      out.write("\t</table><br></br>\n");
      out.write("\t</form>\n");
 }

      out.write("\n");
      out.write("<P><a href=\"dataCurator.jsp\"> Return </a></P>\n");
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
