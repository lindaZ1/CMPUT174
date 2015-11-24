package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class editPerson_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<title>Edit Personal Info</title>\n");
      out.write("</head>\n");
      out.write("\n");
      out.write("<body>\n");
      out.write("<div id=\"image\" style=\"background: url(bg.jpg) no-repeat fixed; width: 100%; min-height: 100%; background-size: cover;\">\n");
      out.write("<center>\n");
      out.write("<br>\n");
      out.write("<H2>Ocean Observation System</H2>\n");
      out.write("<br><br>\n");
      out.write("\n");
      out.write("\n");

String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin.equals("false")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='login.html'");
    out.print("</script>");
}

      out.write('\n');
      out.write('\n');

String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";

String UserID = (String) session.getAttribute("userid");

Connection m_con;
String action = "select * from persons where persons.person_id = '" + UserID + "'";
ResultSet rs;
Statement stmt;

try
{
Class drvClass = Class.forName(m_driverName);
DriverManager.registerDriver((Driver)
drvClass.newInstance());
} catch(Exception e) {
System.err.print("ClassNotFoundException: ");
System.err.println(e.getMessage());
}

m_con = DriverManager.getConnection(m_url, m_userName, m_password);
stmt = m_con.createStatement();
rs = stmt.executeQuery(action);

String person_id = "a";
String first_name = "b";
String last_name = "c";
String address = "d";
String email = "e";
String phone = "f";

// get user's information
try
{
if (rs != null) {
  while(rs.next())
  {
    person_id = rs.getString("person_id");
    first_name = rs.getString("first_name");
    last_name = rs.getString("last_name");
    address = rs.getString("address");
    email = rs.getString("email");
    phone = rs.getString("phone");
  }
 }
}
catch(SQLException e)
{
e.printStackTrace();
}
stmt.close();
rs.close();


      out.write("\n");
      out.write("\n");
      out.write("<FORM action= \"editPersonProcess.jsp\" method=\"post\">\n");
      out.write("<TABLE>\n");
      out.write("\n");
      out.write("<TR VALIGN=TOP ALIGN=LEFT>\n");
      out.write("<TD><B>Person ID: </B></TD>\n");
      out.write("<TD>");
      out.print(person_id);
      out.write("<BR></TD>\n");
      out.write("</TR>\n");
      out.write("\n");
      out.write("<TR VALIGN=TOP ALIGN=LEFT>\n");
      out.write("<TD><B>First Name: </B></TD>\n");
      out.write("<TD><INPUT TYPE=\"text\" NAME=\"userfn\" MAXLENGTH=\"24\" VALUE=\"");
      out.print(first_name);
      out.write("\"></TD>\n");
      out.write("</TR>\n");
      out.write("\n");
      out.write("<TR VALIGN=TOP ALIGN=LEFT>\n");
      out.write("<TD><B>Last Name: </B></TD>\n");
      out.write("<TD><INPUT TYPE=\"text\" NAME=\"userln\" MAXLENGTH=\"24\" VALUE=\"");
      out.print(last_name);
      out.write("\"></TD>\n");
      out.write("</TR>\n");
      out.write("\n");
      out.write("<TR VALIGN=TOP ALIGN=LEFT>\n");
      out.write("<TD><B>Address: </B></TD>\n");
      out.write("<TD><INPUT TYPE=\"text\" NAME=\"useraddr\" MAXLENGTH=\"128\" VALUE=\"");
      out.print(address);
      out.write("\"></TD>\n");
      out.write("</TR>\n");
      out.write("\n");
      out.write("<TR VALIGN=TOP ALIGN=LEFT>\n");
      out.write("<TD><B>Email: </B></TD>\n");
      out.write("<TD><INPUT TYPE=\"email\" NAME=\"useremail\" MAXLENGTH=\"128\" VALUE=\"");
      out.print(email);
      out.write("\"></TD>\n");
      out.write("</TR>\n");
      out.write("\n");
      out.write("<TR VALIGN=TOP ALIGN=LEFT>\n");
      out.write("<TD><B>Phone: </B></TD>\n");
      out.write("<TD><INPUT TYPE=\"tel\" NAME=\"userphone\" MAXLENGTH=\"10\" VALUE=\"");
      out.print(phone);
      out.write("\"></TD>\n");
      out.write("</TR>\n");
      out.write("\n");
      out.write("</TABLE>\n");
      out.write("\n");
      out.write("<br>\n");
      out.write("<INPUT TYPE=\"submit\" NAME=\"Save\" VALUE=\"Save\">\n");
      out.write("</FORM>\n");
      out.write("<INPUT TYPE=\"button\" NAME=\"Cancel\" VALUE=\"Cancel\" onclick=\"cancel()\">\n");
      out.write("\n");
      out.write("<script language=\"JavaScript\" type=\"text/javascript\">\n");
      out.write("function cancel()\n");
      out.write("{\n");
      out.write("javascript:location.href=\"account.jsp\"\n");
      out.write("}\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("</center>\n");
      out.write("\n");
      out.write("<center><h3>\n");
      out.write("<br><br>\n");
      out.write("<a href='UserDocumentation.html' target='_blank'>Help</a>\n");
      out.write("</h3></center>\n");
      out.write("\n");
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
