<html>
<head>
<title>Change Password</title>

<script language = "JavaScript" type = "text/javascript">
function checkEmpty(table) {
  if (table.newPW.value == "") {
    alert("Please Enter Your New Password");
    table.newPW.focus();
    return false;
  }
  if (table.newPW2.value == "") {
    alert("Please Re-Enter Your New Password");
    table.newPW2.focus();
    return false;
  }
  if (table.newPW.value != table.newPW2.value) {
    alert("Your New Password Inputs Are Not Matched");
    table.newPW.focus();
    return false;
  }
  return true;
}
function cancel()
{
javascript:location.href="account.jsp"
}
</script>

</head>

<body>
<div id="image" style="background: url(bg.jpg) no-repeat fixed; width: 100%; min-height: 100%; background-size: cover;">
<center>
<br>
<H2>Ocean Observation System</H2>
<br><br>

<%
String checklogin = "false";
checklogin = (String) session.getAttribute("logstatus");
if (checklogin.equals("false")){
    out.print("<script language=javascript type=text/javascript>");
    out.print("javascript:location.href='login.html'");
    out.print("</script>");
}
%>


<FORM action= "passwordProcess.jsp" method="post" onSubmit = "return checkEmpty(this);">
</H1>

<H2>
<center>
<TABLE>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>New Password: </B></TD>
<TD><INPUT TYPE="password" NAME="newPW" MAXLENGTH="32"></TD>
</TR>

<TR VALIGN=TOP ALIGN=LEFT>
<TD><B>Re-enter New Password: </B></TD>
<TD><INPUT TYPE="password" NAME="newPW2" MAXLENGTH="32"></TD>
</TR>

</TABLE>

<BR>
<INPUT TYPE="submit" NAME="Submit" VALUE="Save">
</FORM>
<INPUT TYPE="button" NAME="CancelPW" VALUE="Cancel" onclick="cancel()">
</center>
</H2>
<center><h3>
<br><br>
<a href='../document/UserDocumentation.html' target='_blank'>Help</a>
</h3></center>
</div>
</body>
</html>
