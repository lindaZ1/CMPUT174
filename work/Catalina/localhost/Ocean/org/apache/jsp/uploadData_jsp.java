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
      out.write("<body>\n");
      out.write("<div id=\"image\" style=\"background: url(bg.jpg) no-repeat fixed; width: 100%; min-height: 100%; background-size: cover;\">\n");
      out.write("<center>\n");
      out.write("<br>\n");
      out.write("<H2>Ocean Observation System</H2>\n");
      out.write("<br><br>\n");

String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin.equals("false")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='login.html'");
    out.print("</script>");
}
String UserRole = (String) session.getAttribute("userrole");
if (!UserRole.equals("d")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='account.jsp'");
    out.print("</script>");
}

      out.write('\n');

try{
	String action=request.getParameter("action");


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
      out.write("\t\tPlease input or select the path of the file!\n");
      out.write("\t\t<form name=\"upload-file\" method=\"POST\" enctype=\"multipart/form-data\" action=\"uploadScalar.jsp\">\n");
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
      out.write("\n");
      out.write("\t\tUpload Image (.jpg).\n");
      out.write("\t\tPlease input or select the path of the image!\n");
      out.write("\t\t<form name=\"upload-file\" method=\"post\" enctype=\"multipart/form-data\" action=\"UploadImage\">\n");
      out.write("\t\t<table border=\"0\" width=\"30%\" cellpadding=\"5\">\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t<td><B>File path: </B></td>\n");
      out.write("\t\t<td>\n");
      out.write("\t\t<input name=\"file-path\"\" type=\"file\" class=\"upload\" multiple=\"\">\n");
      out.write("\t\t</td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t<td><input name=\".submit\" value=\"Upload\" type=\"submit\"></td>\n");
      out.write("\t\t<td><input name=\".reset\" value=\"Reset\" type=\"reset\"></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t</table><br></br>\n");
      out.write("\t\t</form>\n");
      out.write("\t\t<br></br>\n");
      out.write("\t\t<P><a href=\"dataCurator.jsp\"> Return </a></P>\n");
      out.write("\t");
}
	  else if(action.equals("addAudio")) {   
      out.write("\n");
      out.write("\t\tUpload Audio File\n");
      out.write("\t\t\n");
      out.write("\t\t<p>\n");
      out.write("\t\t<font size=\"8\" face=\"Verdana\" color=\"#0080ff\">\n");
      out.write("\t\tUpload Audio (.wav).\n");
      out.write("\t\t<form name=\"upload-file\" method=\"POST\" enctype=\"multipart/form-data\" action=\"UploadAudio\">\n");
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
}catch(Exception e) {
out.println(e.toString());
out.print("<script language=javascript type=text/javascript>");
out.print("javascript:location.href='account.jsp'");
out.print("</script>");
}
	
      out.write("\n");
      out.write("<form  action= \"account.jsp\" method=\"post\">\n");
      out.write("<input type=\"submit\" name=\"account\" value=\"My Account\">\n");
      out.write("</form>\n");
      out.write("</center>\n");
      out.write("<center><h3>\n");
      out.write("<br><br>\n");
      out.write("<a href='UserDocumentation.html' target='_blank'>Help</a>\n");
      out.write("</h3></center>\n");
      out.write("</div>\n");
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
