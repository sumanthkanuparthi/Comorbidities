<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Co-Morbidities Home Page</title>
<script type="text/javascript">

               function checkEnctr()
               {
                       var enteredEnctrId = document.forms["comorb"]["encounterid"].value
                       if(enteredEnctrId == "" || enteredEnctrId == null)
                               {
                               alert("Please Enter EncounterID!");
                               return false;
                               }
               }
</script>

</head>
<body bgcolor = "FCFCF8">
	<br/><br/><br/><br/><br/>
	
	<div style="border: 2px solid black; width: 600px; height: 400px; margin-left:25%; background-color: #EEEDD8;">
	<h1 align="center">ED Checklist of Co-Morbidities/Clinical Conditions</h1>

	<form name="comorb" action="CoMorbMain.jsp" onSubmit="return checkEnctr()" method="post" style="text-align: center">

		<h2>Please enter Encounter ID below:</h2>
		<input type="text" value="" name="encounterid" /> <br></br> <br></br>
		<input type="submit" value="Submit" />

	</form>
	</div>
</body>
</html>