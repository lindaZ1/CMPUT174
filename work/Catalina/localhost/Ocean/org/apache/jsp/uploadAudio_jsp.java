package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class uploadAudio_jsp extends org.apache.jasper.runtime.HttpJspBase
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

String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin == "false"){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='login.html'");
    out.print("</script>");
}

      out.write('\n');


	
	if (request.getParameter(".submit") != null) {
		String sensor_id=request.getParameter("sensor_id");

		String date=request.getParameter("date");
		String year=date.substring(0,4);
		String month=date.substring(5,7);
		String day=date.substring(8,10);
		date=month+"/"+day+"/"+year;

		String description=request.getParameter("description");

		String time=request.getParameter("time");
		String datetime=date+" "+time;

		String length=request.getParameter("length");

		Boolean sensorExist=false;
		Boolean desc=true;
	
		if(description=="") {
			out.println("please enter a description");
			desc=false;
		}

		String driverName="oracle.jdbc.driver.OracleDriver";
		String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		try{        
		    //load and register driver
		    Class drvClass=Class.forName(driverName);
		    DriverManager.registerDriver((Driver)drvClass.newInstance());

		    //establish connection here
		    Connection conn=null;	
		    conn=DriverManager.getConnection(dbstring,"dzhang4","Horsey26");
		    String query="select sensor_id from sensors where sensor_type='a'";
		    
		    Statement stmt;
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
			    }
			}
		    }

		    if(sensorExist==false) {
			out.println("sensor_id: "+sensor_id +" does not exist");
		    }

		    if(sensorExist && desc) {
			    int recording_id=(Integer)session.getAttribute("currentid");


out.println("update audio_recordings set date_created=TO_DATE('"+datetime+"','mm/dd/yyyy hh24:mi:ss'),sensor_id="+sensor_id+",description='"+description+"',length="+length+" where recording_id="+recording_id);


			    stmt.execute("update audio_recordings set date_created=TO_DATE('"+datetime+"','mm/dd/yyyy hh24:mi:ss'),sensor_id="+sensor_id+",description='"+description+"',length="+length+" where recording_id="+recording_id);
			    stmt.execute("commit");
			    session.removeAttribute("currentid");

      out.write("\n");
      out.write("\t\t\t<h3>file uploaded</h3>\n");
      out.write("\t\t\t<P><a href=\"dataCurator.jsp\"> Return </a></P>\n");
      out.write("\n");

		    }
		}catch(Exception e) {out.println(e.toString());}

	}

	else {

      out.write("\n");
      out.write("\t\n");
      out.write("\t\n");
      out.write("\t       <table>\n");
      out.write("\t       <h3>All Sensors:</h3>\n");
      out.write("\t       <TABLE BORDER=2>\n");
      out.write("\t\t<TR>\n");
      out.write("\t\t    <TH>SENSOR_ID</TH>\n");
      out.write("\t\t    <TH>LOCATION</TH>\n");
      out.write("\t\t    <TH>SENSOR TYPE</TH>\n");
      out.write("\t\t    <TH>DESCRIPTION</TH>\n");
      out.write("\t\t</TR>\n");
		

		String driverName="oracle.jdbc.driver.OracleDriver";
		String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		       
	        //load and register driver
	        Class drvClass=Class.forName(driverName);
	        DriverManager.registerDriver((Driver)drvClass.newInstance());

	        //establish connection here
	        Connection conn=null;	
	        conn=DriverManager.getConnection(dbstring,"dzhang4","Horsey26");
	    

		String query="select * from sensors where sensor_type='a'";
		Statement stmt;
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
      out.write("\t<form action=\"uploadAudio.jsp\" method=\"post\" >\n");
      out.write("\tSensor_ID: <input type=\"text\" value=\"sensor_id\" name=\"sensor_id\"><br></br>\n");
      out.write("\tDate Created: <input type=\"date\" value=\"\" name=\"date\"><br></br>\n");
      out.write("\tTime: <input type=\"time\" value=\"time\" name=\"time\" step=\"1\"><br></br>\n");
      out.write("\tLength(seconds): <input type=\"number\" value=\"\" name=\"length\"><br></br>\n");
      out.write("\tDescription: <input type=\"text\" value=\"\"><br></br>\n");
      out.write("\t<input name=\".submit\" value=\"Upload\" type=\"submit\">\n");
      out.write("\t</form>\n");
 } 
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<form  action= \"account.jsp\" method=\"post\">\n");
      out.write("<input type=\"submit\" name=\"account\" value=\"My Account\">\n");
      out.write("</form>\n");
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
