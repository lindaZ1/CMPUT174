package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.io.*;
import org.apache.commons.fileupload.*;
import java.util.List;
import java.util.Iterator;
import org.apache.commons.io.*;

public final class uploadScalar_jsp extends org.apache.jasper.runtime.HttpJspBase
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


	//establish the connection to the underlying database
	Connection conn = null;
	//load and register the driver
	Class drvClass = Class.forName("oracle.jdbc.driver.OracleDriver"); 
	DriverManager.registerDriver((Driver) drvClass.newInstance());
	//establish the connection 
	conn = DriverManager.getConnection("jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS","tshen","ad50064051");
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement();

	DiskFileUpload fu=new DiskFileUpload();
	List FileItems=null;
	
        try {
	    FileItems = fu.parseRequest(request);
        }
        catch (FileUploadException e) {
	    e.printStackTrace();
        }
	byte fileData[]=null;

	Iterator itr=FileItems.iterator();
	
	while(itr.hasNext()) {
		FileItem item=(FileItem) itr.next();
		if(!item.isFormField()) {

			try{
				String filename=item.getName();
				if(filename.length()<5 || (filename.substring(filename.length()-4))!=".csv") {
					response.sendRedirect("uploadFinish.jsp");
				}

				else{
					InputStream stream=application.getResourceAsStream(filename);
					fileData=item.get();
				
					if(fileData.length==0) {
						response.sendRedirect("uploadFinish.jsp");
					}
					if(fileData.length<5 || fileData.substring(fileData.length-4))!=".csv") {
						response.sendRedirect("uploadFinish.jsp");
					}
					int id=0;
					String line;
					StringBuilder contents=new StringBuilder();
					BufferedReader input=new BufferedReader(new InputStreamReader(stream));

					while((line=input.readLine())!=null) {	
						//line=input.readLine();
						contents.append(line);
						String info[]=line.split(",");
					
						if(info[0]!="") {
							//generate id
							ResultSet rset1 = stmt.executeQuery("SELECT SEQ_IMAGE_ID.nextval from dual");
							if(rset1!=null && rset1.next()) {
							    id=rset1.getInt(1);
							    rset1.close();
					    		}
					
							//extract info
							String sensor_id=info[0];
							String date=info[1];
							String value=info[2];
							date="'"+date+"'";

							stmt.execute("insert into scalar_data values ("+id+","+sensor_id+",to_date("+date+",'dd/mm/yyyy hh24:mi:ss'),"+value+")");
							stmt.execute("commit");
						
		
						}

					
					}
					out.println("data inserted");
				}
				
				}catch(Exception e) {}
			
			}
		}
	

      out.write("\n");
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
      out.write("\n");
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
