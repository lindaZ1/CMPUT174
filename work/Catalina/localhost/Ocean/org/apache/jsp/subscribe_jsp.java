package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class subscribe_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("<!doctype html public \"-//w3c//dtd html 4.0 transitional//en\">\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <title>subscribe</title>\n");
      out.write("    </head>\n");
      out.write("</html>\n");
      out.write("<body>\n");
      out.write("    <h1>Subscriptions</h1>\n");
      out.write("\n");
      out.write("    <h3>All Sensors:</h3>\n");
      out.write("    <TABLE BORDER=2>\n");
      out.write("        <TR>\n");
      out.write("            <TH>SENSOR_ID</TH>\n");
      out.write("\t    <TH>LOCATION</TH>\n");
      out.write("\t    <TH>SENSOR TYPE</TH>\n");
      out.write("\t    <TH>DESCRIPTION</TH>\n");
      out.write("        </TR>\n");

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

	String query="select * from sensors";
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
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
	//stmt.close();
	//conn.close();
    }catch(Exception e) {
	out.println(e.toString());
    }

      out.write("\n");
      out.write("</TABLE>\n");
      out.write("\n");
      out.write("<h4>Legend<h4>\n");
      out.write("a=audio;\n");
      out.write("i=image;\n");
      out.write("t=text;\n");
      out.write("o=other;\n");
      out.write("\n");
      out.write("<h3>Subscribed Sensors:</h3>\n");
      out.write("<TABLE BORDER=2>\n");
      out.write("<TR><TH>SENSOR_ID</TH></TR>\n");

    String person_id="222";
    String query="select sensor_id from subscriptions where person_id="+person_id;
    stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    ResultSet rset=stmt.executeQuery(query);
    String ans="";
    Object o;
    ResultSetMetaData rsetMetaData=rset.getMetaData();
    int ccount=rsetMetaData.getColumnCount();

    while(rset.next()) {
	ans+="<TR>";
	for(int i=1;i<=ccount;i++) {
	    o=rset.getObject(i);
	    ans+="<TD>";
	    ans+=o.toString();
	    ans+="</TD>";
	}
	ans+="</TR>";
    }
    out.println(ans);

      out.write("\n");
      out.write("</TABLE>  \n");
      out.write("<br></br>\n");
      out.write("<form action=\"add_subscribe.jsp\" method=\"post\">\n");
      out.write("    <input type=\"submit\" value=\"add sensor\">\n");
      out.write("</form>\n");
      out.write("\n");
      out.write("<form action=\"remove_subscribe.jsp\" method=\"post\">\n");
      out.write("    <input type=\"submit\" value=\"remove sensor\">\n");
      out.write("</form>\n");
      out.write("\n");
      out.write("\n");
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
