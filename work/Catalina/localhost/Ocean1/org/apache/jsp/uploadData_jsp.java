package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class uploadData_jsp extends org.apache.jasper.runtime.HttpJspBase
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

	String action=request.getParameter("action");
	out.print(action);

	//establish the connection to the underlying database
	Connection conn = null;
	//load and register the driver
	Class drvClass = Class.forName("oracle.jdbc.driver.OracleDriver"); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	//establish the connection 
	conn = DriverManager.getConnection("jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS","dzhang4","Horsey26");
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement();
	//ResultSet rset = stmt.executeQuery("SELECT pic_id_sequence.nextval from dual");
	//rset.next();
	//int pic_id = rset.getInt(1);
	//session.setAttribute("getid", pic_id);
	//session.setAttribute("currentid", pic_id);


	if(action.equals("addScalar")) {  

      out.write("\n");
      out.write("\t\t<p>\n");
      out.write("\t\t<font size=\"8\" face=\"Verdana\" color=\"#0080ff\">\n");
      out.write("\t\tUpload File (.csv).\n");
      out.write("\t\t</font>\n");
      out.write("\t\t</p>\n");
      out.write("\n");
      out.write("\t\t<p>\n");
      out.write("\t\t</p>\n");
      out.write("\n");
      out.write("\t\tPlease input or select the path of the image!\n");
      out.write("\t\t<form name=\"upload-file\" method=\"POST\" enctype=\"multipart/form-data\" action=\"uploadData.jsp\">\n");
      out.write("\t\t<table border=\"0\" width=\"30%\" cellpadding=\"5\">\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t<td><B>File path: </B></td>\n");
      out.write("\t\t<td>\n");
      out.write("\t\t<input name=\"file-path\"\" type=\"file\" class=\"upload\" multiple=\"\">\n");
      out.write("\t\t</td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t<td><input name=\".submit\" value=\"Upload\" type=\"submit\"></td>\n");
      out.write("\t\t<td><input name=\".reset\" value=\"Reset\" type=\"reset\"></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t</table>\n");
      out.write("\t\t</form>\n");
      out.write("\t\t<P><a href=\"dataCurator.jsp\"> Return </a></P>\n");
      out.write("\t\t\n");
	}   

	else if(action.equals("addImage")) {

      out.write("\n");
      out.write("\t       <table>\n");
      out.write("\t       <h3>All Sensors:</h3>\n");
      out.write("\t       <TABLE BORDER=2>\n");
      out.write("\t\t<TR>\n");
      out.write("\t\t    <TH>SENSOR_ID</TH>\n");
      out.write("\t\t    <TH>LOCATION</TH>\n");
      out.write("\t\t    <TH>SENSOR TYPE</TH>\n");
      out.write("\t\t    <TH>DESCRIPTION</TH>\n");
      out.write("\t\t</TR>\n");
		String query="select * from sensors";
		stmt=conn.createStatement();
		ResultSet rset=stmt.executeQuery(query);

		Object o;
		ResultSetMetaData rsetMetaData=rset.getMetaData();
		int ccount=rsetMetaData.getColumnCount();

		String ans="";
	
		while(rset.next()) {
		    ans+="<TR>";
		    for(int i=1;i<=ccount;i++) {
			o=rset.getObject(i);
			ans+="<TD>";
			if(o!=null){
			    ans+=o.toString();
			}
			else{
			    ans+="null";
			}
			ans+="</TD>";
		    }
		    ans+="</TR>";
		}
		out.println(ans);
		stmt.close();
		conn.close();

      out.write("\n");
      out.write("</table>\n");
      out.write("\t\t<br></br>\n");
      out.write("\t\tUpload Image\n");
      out.write("\t\t<form action=\"uploadImage.jsp\" method=\"post\" >\n");
      out.write("\t\tSensor_ID: <input type=\"text\" value=\"sensor_id\" name=\"sensor_id\"><br></br>\n");
      out.write("\t\tDate Created: <input type=\"date\" value=\"date\" name=\"date\"><br></br>\n");
      out.write("\t\tDescription: <input type=\"text\" value=\"description\"><br></br>\n");
      out.write("\t\t<input name=\".submit\" value=\"Upload\" type=\"submit\">\n");
      out.write("\t\t</form>\n");
      out.write("\t\t<P><a href=\"dataCurator.jsp\"> Return </a></P>\n");
      out.write("\t");
}
	  else if(action.equals("addAudio")) {   
      out.write("\n");
      out.write("\t\t<table>\n");
      out.write("\t       <h3>All Sensors:</h3>\n");
      out.write("\t       <TABLE BORDER=2>\n");
      out.write("\t\t<TR>\n");
      out.write("\t\t    <TH>SENSOR_ID</TH>\n");
      out.write("\t\t    <TH>LOCATION</TH>\n");
      out.write("\t\t    <TH>SENSOR TYPE</TH>\n");
      out.write("\t\t    <TH>DESCRIPTION</TH>\n");
      out.write("\t\t</TR>\n");
		String query="select * from sensors";
		stmt=conn.createStatement();
		ResultSet rset=stmt.executeQuery(query);

		Object o;
		ResultSetMetaData rsetMetaData=rset.getMetaData();
		int ccount=rsetMetaData.getColumnCount();

		String ans="";
	
		while(rset.next()) {
		    ans+="<TR>";
		    for(int i=1;i<=ccount;i++) {
			o=rset.getObject(i);
			ans+="<TD>";
			if(o!=null){
			    ans+=o.toString();
			}
			else{
			    ans+="null";
			}
			ans+="</TD>";
		    }
		    ans+="</TR>";
		}
		out.println(ans);
		stmt.close();
		conn.close();

      out.write("\n");
      out.write("</table>\n");
      out.write("\t\t<br></br>\n");
      out.write("\t\tUpload Audio File\n");
      out.write("\t\t<form action=\"uploadAudio.jsp\" method=\"post\" >\n");
      out.write("\t\tRecording ID(integer only): <input type=\"text\" value=\"recording_id\" name=\"recording_id\"> <br></br>\n");
      out.write("\t\tSensor_ID: <input type=\"text\" value=\"sensor_id\" name=\"sensor_id\"><br></br>\n");
      out.write("\t\tDate Created: <input type=\"date\" value=\"date\" name=\"date\"><br></br>\n");
      out.write("\t\tLength(integer only): <input type=\"text\" value=\"1\" name=\"length\"><br></br>\n");
      out.write("\t\tDescription: <input type=\"text\" value=\"description\"><br></br>\n");
      out.write("\t\t<p>\n");
      out.write("\t\t<font size=\"8\" face=\"Verdana\" color=\"#0080ff\">\n");
      out.write("\t\tUpload Audio (.wav).\n");
      out.write("\t\t<form name=\"upload-file\" method=\"POST\" enctype=\"multipart/form-data\" action=\"uploadData.jsp\">\n");
      out.write("\t\t<table border=\"0\" width=\"30%\" cellpadding=\"5\">\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t<td><B>File path: </B></td>\n");
      out.write("\t\t<td>\n");
      out.write("\t\t<input name=\"file-path\"\" type=\"file\" class=\"upload\" multiple=\"\">\n");
      out.write("\t\t</td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t<td><input name=\".submit\" value=\"Upload\" type=\"submit\"></td>\n");
      out.write("\t\t<td><input name=\".reset\" value=\"Reset\" type=\"reset\"></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t</table>\n");
      out.write("\t\t</form>\n");
      out.write("\t\t<P><a href=\"dataCurator.jsp\"> Return </a></P>\n");
     } 
	
      out.write("\n");
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
