<!DOCTYPE html>
<html>
<head>
<% String temp=request.getSession().getAttribute("error").toString();
System.out.println("ffdfd"+temp);%>
<script type="text/javascript">
function f1(){
	
	mywindow=window.open('','','width=300,height=300');
	//mywindow.
	mywindow.alert("<%=temp%>");
	
	<%request.getSession().invalidate();%>
	//mywindow.focus()
f2(mywindow);
}

function f2(mywindow)
{
	//alert("werf");
	//window.opener="something"; 
	//window.history.back();
	mywindow.close();
	
	}
</script>
</head>
<body onLoad="f1()">
</body>