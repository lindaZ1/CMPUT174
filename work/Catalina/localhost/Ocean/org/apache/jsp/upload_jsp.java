package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class upload_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("<!doctype html public \"-//w3c//dtd html 4.0 transitional//en\">\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <title>upload</title>\n");
      out.write("    </head>\n");
      out.write("</html>\n");
      out.write("<body>\n");
      out.write("    <h1>Data Upload</h1>\n");
      out.write("\n");

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
	conn.close();

      out.write("\n");
      out.write("\n");
      out.write("<h3>Choose data type to upload: </h3>\n");
      out.write("<input type=\"radio\" value=\"add\" name=\"action\">Add Data\n");
      out.write("<input type=\"radio\" value=\"remove\" name=\"action\">Add Image\n");
      out.write("<input type=\"radio\" value=\"remove\" name=\"action\">Add Audio\n");
      out.write("<form action=\"uploadData.jsp\" method=\"post\">\n");
      out.write("    <input type=\"submit\" value=\"Add\">\n");
      out.write("</form>\n");
      out.write("\n");
      out.write("<p>\n");
      out.write("<font size=\"8\" face=\"Verdana\" color=\"#0080ff\">\n");
      out.write("Upload Your Image.\n");
      out.write("</font>\n");
      out.write("</p>\n");
      out.write("\n");
      out.write("<p>\n");
      out.write("</p>\n");
      out.write("\n");
      out.write("Please input or select the path of the image!\n");
      out.write("<form name=\"upload-image\" method=\"POST\" enctype=\"multipart/form-data\" action=\"upload.jsp\">\n");
      out.write("<table border=\"0\" width=\"30%\" cellpadding=\"5\">\n");
      out.write("<tr>\n");
      out.write("<td><B>File path: </B></td>\n");
      out.write("<td>\n");
      out.write("<input name=\"file-path\"\" type=\"file\" class=\"upload\" multiple=\"\">\n");
      out.write("</td>\n");
      out.write("</tr>\n");
      out.write("<tr>\n");
      out.write("<td><input name=\".submit\" value=\"Upload\" type=\"submit\"></td>\n");
      out.write("<td><input name=\".reset\" value=\"Reset\" type=\"reset\"></td>\n");
      out.write("</tr>\n");
      out.write("</table>\n");
      out.write("</form>\n");
      out.write("<P><a href=\"profile.jsp\"> Return </a></P>\n");
      out.write("\n");
      out.write("</body>\n");
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
