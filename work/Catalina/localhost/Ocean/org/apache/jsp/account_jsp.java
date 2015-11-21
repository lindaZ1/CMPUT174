package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class account_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<title>My Account</title>\n");
      out.write("</head>\n");
      out.write("\n");
      out.write("<body>\n");
      out.write("<div id=\"image\" style=\"background: url(bg.jpg) no-repeat; width: 100%; height: 100%; background-size: 100%;\">\n");
      out.write("<center>\n");
      out.write("<br>\n");
      out.write("<H2>Ocean Observation System</H2>\n");
      out.write("<br><br>\n");
      out.write("\n");

String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin == "false"){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='login.html'");
    out.print("</script>");
}

      out.write('\n');
      out.write('\n');
      out.write('\n');

String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";

String UserID = (String) session.getAttribute("userid");
String UserRole = (String) session.getAttribute("userrole");

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

try
{
if (rs != null) {

      out.write("\n");
      out.write("<table border = \"1\" style = \"width:30%\">\n");
      out.write("\n");

while(rs.next())
{

      out.write("\n");
      out.write("<tr>\n");
      out.write("  <td style = \"width:100px\">Person Id</td>\n");
      out.write("  <td>");
      out.print(rs.getString("person_id"));
      out.write("</td>\n");
      out.write("</tr>\n");
      out.write("<tr>\n");
      out.write("  <td>First Name</td>\n");
      out.write("  <td>");
      out.print(rs.getString("first_name"));
      out.write("</td>\n");
      out.write("</tr>\n");
      out.write("<tr>\n");
      out.write("  <td>Last Name</td>\n");
      out.write("  <td>");
      out.print(rs.getString("last_name"));
      out.write("</td>\n");
      out.write("</tr>\n");
      out.write("<tr>\n");
      out.write("  <td>Address</td>\n");
      out.write("  <td>");
      out.print(rs.getString("address"));
      out.write("</td>\n");
      out.write("</tr>\n");
      out.write("<tr>\n");
      out.write("  <td>Email</td>\n");
      out.write("  <td>");
      out.print(rs.getString("email"));
      out.write("</td>\n");
      out.write("</tr>\n");
      out.write("<tr>\n");
      out.write("  <td>Phone</td>\n");
      out.write("  <td>");
      out.print(rs.getString("phone"));
      out.write("</td>\n");
      out.write("  </tr>\n");

}
}
}
catch(SQLException e)
{
e.printStackTrace();
}
stmt.close();
rs.close();
m_con.close();

      out.write("\n");
      out.write("</table>\n");
      out.write("<br>\n");
      out.write("<INPUT TYPE=\"button\" NAME=\"EditPerson\" VALUE=\"Modify Personal Information\"\n");
      out.write(" onclick=\"EditPerson()\">\n");
      out.write("<br><br>\n");
      out.write("<INPUT TYPE=\"button\" NAME=\"ChangePW\" VALUE=\"Change Password\"\n");
      out.write(" onclick=\"ChangePW()\">\n");
      out.write("<br><br>\n");
      out.write("\n");

if (UserRole.equals("a")) {
      out.write("\n");
      out.write("<form action= \"administratorPage.jsp\" method=\"post\">\n");
      out.write("<INPUT TYPE=\"submit\" NAME=\"Homepage\" VALUE=\"Go to HomePage\">\n");
      out.write("</form>\n");
 } 
      out.write('\n');
      out.write('\n');

if (UserRole.equals("d")) {
      out.write("\n");
      out.write("<form action= \"dataCurator.jsp\" method=\"post\">\n");
      out.write("<INPUT TYPE=\"submit\" NAME=\"Homepage\" VALUE=\"Go to HomePage\">\n");
      out.write("</form>\n");
 } 
      out.write('\n');
      out.write('\n');

if (UserRole.equals("s")) {
      out.write("\n");
      out.write("<form action= \"scientist.jsp\" method=\"post\">\n");
      out.write("<INPUT TYPE=\"submit\" NAME=\"Homepage\" VALUE=\"Go to HomePage\">\n");
      out.write("</form>\n");
 } 
      out.write("\n");
      out.write("\n");
      out.write("<br><br>\n");
      out.write("<INPUT TYPE=\"button\" NAME=\"LogOut\" VALUE=\"Log Out\" onclick=\"LogOut()\">   \n");
      out.write("\n");
      out.write("<script language=\"JavaScript\" type=\"text/javascript\">\n");
      out.write("function EditPerson()\n");
      out.write("{\n");
      out.write("javascript:location.href=\"editPerson.jsp\"\n");
      out.write("}\n");
      out.write("function ChangePW()\n");
      out.write("{\n");
      out.write("javascript:location.href=\"password.jsp\"\n");
      out.write("}\n");
      out.write("function LogOut()\n");
      out.write("{\n");
      out.write("javascript:location.href=\"logout.jsp\"\n");
      out.write("}\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("\n");
      out.write("</center>\n");
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
