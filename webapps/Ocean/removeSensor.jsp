<html>
<head></head>
<body>
	<h3>Following sensor has been removed</h3>
	<TABLE BORDER=2>
        <TR>
            <TH>SENSOR_ID</TH>
	    <TH>LOCATION</TH>
	    <TH>SENSOR TYPE</TH>
	    <TH>DESCRIPTION</TH>
        </TR>	

	<%
		String rSensor = request.getParameter("removeSensorId");
		out.print(rSensor);
	%>
</body>
</html>
