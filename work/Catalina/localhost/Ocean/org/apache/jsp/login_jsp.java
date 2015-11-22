package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<title>Login</title>\n");
      out.write("</head>\n");
      out.write("\n");
      out.write("<body>\n");
      out.write("<div id=\"image\" style=\"background: url(bg.jpg) no-repeat; width: 100%; height: 100%; background-size: 100%;\">\n");
      out.write("<H2>Loading...</H2>\n");
      out.write("<br><br>\n");
      out.write("\n");

String LogName = (request.getParameter("logname")).trim();
String LogPW = (request.getParameter("logpw")).trim();

      out.write('\n');
      out.write('\n');
      out.write('\n');

String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
String m_driverName = "oracle.jdbc.driver.OracleDriver";
String m_userName = "tshen";
String m_password = "ad50064051";

Connection m_con;
String action = "select * from users where users.user_name = '" + LogName + "'";
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

String TruePW = "a";
String UserRole = "b";
String UserID = "c";
String checklogin = "false";
if (rs.next() == false) {
out.print("<H1>Invalid Username. Please try again.</H1>");
m_con.close();
out.print("<script language=javascript type=text/javascript>");
out.print("setTimeout("+"\"javascript:location.href='login.html'\""+", 2500);");
out.print("</script>");

} else {
  TruePW = rs.getString(2);
  UserRole = rs.getString(3);
  UserID = rs.getString(4);
  if (!LogPW.equals(TruePW)) {
    out.print("<H1>Invalid Password. Please try again.</H1>");
    m_con.close();
    out.print("<script language=javascript type=text/javascript>");
    out.print("setTimeout("+"\"javascript:location.href='login.html'\""+", 2500);");
    out.print("</script>");

  } else {
    out.print("<H2>Welcome back! </H2>");
    checklogin = "true";
    session.setAttribute("logstatus", checklogin);
    session.setAttribute("username", LogName);
    session.setAttribute("userpw", LogPW);
    session.setAttribute("userid", UserID);
    session.setAttribute("userrole", UserRole);
    m_con.close();

    if (UserRole.equals("a")){
      out.print("<H2>Now you can edit users and sensors.</H2>");
      out.print("<script language=javascript type=text/javascript>");
      out.print("setTimeout("+"\"javascript:location.href='administratorPage.jsp'\""+", 2500);");
      out.println("</script>");}

    else if (UserRole.equals("d")) {
      out.print("<H2>Now you can upload data.</H2>");
      out.print("<script language=javascript type=text/javascript>");
      out.print("setTimeout("+"\"javascript:location.href='dataCurator.jsp'\""+", 2500);");
      out.println("</script>");}


    else if (UserRole.equals("s")) {
      out.print("<H2>Now you can view, query and download data.</H2>");
      out.print("<script language=javascript type=text/javascript>");
      out.print("setTimeout("+"\"javascript:location.href='scientist.jsp'\""+", 2500);");
      out.println("</script>");} 
  }
}



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
