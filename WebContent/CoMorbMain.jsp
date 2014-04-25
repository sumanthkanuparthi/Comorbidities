<!-- 
This file receives the form submitted from the html. 
The jsp file then takes the value of these variables, 
verifies them (via the isNumeric() function and stringOrNot() function)
Also, for cases where both normal and whole blood values are available,
	 jsp also verifies which of the maximum or minimum value has to be considered
The second part of the file consists of html, where the iframe consists of 
http://uhmc-ed-admitd.uhmc.sunysb.edu:8080/CoMorbidities/forwardData.jsp
This page then calculates the comorbidities
 -->

<%@page import="java.net.URLDecoder"%>
<%@page import="com.itextpdf.text.log.SysoLogger.*"%>
<%@page import="java.text.ParseException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="comorb.*"%>
<%@page import="java.awt.Toolkit.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.logging.*" %>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.net.URLEncoder" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- CSS -->
<link rel="stylesheet" href="css/screen.css" media="screen" type="text/css" />
<link href="css/SpryTooltip.css" rel="stylesheet" type="text/css" />
<link href="css/SpryAccordion.css" rel="stylesheet" type="text/css" />

<style type="text/css">
#lightbox_right{
width:600px;
height:500px;}
</style>

<!-- JavaScript -->
<script type="text/javascript" src="javascript/prototype.js"></script>
<script type="text/javascript" src="javascript/lightbox.js"></script>
<script src="javascript/SpryTooltip.js" type="text/javascript"></script>
<script src="javascript/SpryAccordion.js" type="text/javascript"></script>

<script language="javascript"> 
function toggle() {
	var ele = document.getElementById("toggleText");
	var text = document.getElementById("displayText");
	var right_text = document.getElementById("lightbox_right");
	if(ele.style.display == "block") {
    		ele.style.display = "none";
    		right_text.innerHTML = "";
		text.innerHTML = "Comorbidities Rules";
  	}
	else {
		ele.style.display = "block";
		text.innerHTML = "Hide Rules";
	}
} 
</script>


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ED Current Co-Morbidities/Current Clinical Conditions Checklist</title>
<script src="javascript/CoMorbMain.js"> </script>




</head>
<%
//String queryString = "";

//path += ("?"+request.getQueryString());
//path=path.substring(15);

//String queryString="";

//Cookie firstName = new Cookie("first_name",request.getQueryString());
//response.addCookie( firstName );
//request.getSession().setAttribute("prevURL", request.getQueryString());
 //ServletContext application1 = request.getSession().getServletContext();
 //application1.setAttribute("prevURL",request.getQueryString());
// Cookie cookiee = new Cookie("prevURL", request.getQueryString());
//Interface.setURL(request.getQueryString());
 //response.addCookie(cookiee);
//request.getSession().setAttribute("prevURL",request.getQueryString());
//System.out.println("nkkkkkk ------------------------->>>>><<<<>>>>>>>"+path+"?"+request.getQueryString());
//String encounterID=stringOrNot(request.getParameter("encntr_id"));
//WebDriver driver = new HtmlUnitDriver();
//String pageHead="";
//String link="http://172.31.133.112:8080/test/test.jsp";

//driver.get(link);
  
  
  //driver.findElement(By.id("tbInput")).sendKeys("encounterID");
 
  //driver.findElement(By.id("submit")).submit();
  //pageHead=driver.getTitle();
  
  //String result= driver.findElement(By.id("tbXML")).getText();
  //if(!result.equals("-1")){
	  
	  //write the code here for parsing the xml
	  
  //}


%>

<%!
/*
Function to verify the values received
*/
	public String stringOrNot(String val)
	{
		// check for double template		
		final String double_reg = "\\s*[-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?\\s*"; 
		return val!=null && Pattern.matches(double_reg, val)?val:"";
	}
%>

<%
String HIGH = "99999";
String LOW = "-99999";
String encounterID=stringOrNot(request.getParameter("encntr_id"));

String userID=stringOrNot(request.getParameter("user_id"));

HashMap<String,String> hm=new HashMap<String,String>();

Enumeration en=request.getParameterNames();
while(en.hasMoreElements()){
String str=en.nextElement().toString();

hm.put(str,request.getParameter(str));

}

request.getSession().setAttribute("prevURLHM", hm);
//Sodium
//@modified by Abhishek
//0 = Normal Sodium, 1 = Sodium Whole Blood, if both are empty, no readings (Considered Sodium Values are empty anyway)

	/* System.out.println("Before logging");
	Logger logger=Logger.getLogger(this.getClass().getName());
	logger.addHandler(new FileHandler("C:\\ComorbLogs\\CoMorbMainlogfile.txt")); */
	//logger.addHandler(new FileHandler("C:\\bit_bucket\\CoMorbidities\\CoMorbMainlogfile.txt"));


String  sodiumLow = stringOrNot(request.getParameter("sodium_low")), 
		sodiumHigh = stringOrNot(request.getParameter("sodium_high")), 
	    sodiumMaxResult = stringOrNot(request.getParameter("sodium_max_val")),
	    sodiumMaxDate = request.getParameter("sodium_max_date"),
	    sodiumMinResult = stringOrNot(request.getParameter("sodium_min_val")),
		sodiumMinDate = request.getParameter("sodium_min_date");



String  sodiumLowWb = stringOrNot(request.getParameter("wb_sodium_low")), 
		sodiumHighWb = stringOrNot(request.getParameter("wb_sodium_high")), 
		sodiumMinResultWb = stringOrNot(request.getParameter("wb_sodium_min_val")),
		sodiumMaxResultWb = stringOrNot(request.getParameter("wb_sodium_max_val")),
		sodiumMinDateWb = request.getParameter("wb_sodium_min_date"),
		sodiumMaxDateWb = request.getParameter("wb_sodium_max_date");


System.out.println("Sodium Min Result 1: " + sodiumMinResult);
System.out.println("Sodium Max Result 1: " + sodiumMaxResult);

/*
* Logging to file here
*/
/* logger.log(Level.INFO, sodiumMinResult);
logger.log(Level.INFO, sodiumMaxResult); */

String  sodiumLowConsidered = "", 
		sodiumHighConsidered = "", 
		sodiumMinResultConsidered = "", 
		sodiumMaxResultConsidered = "", 
		sodiumMinDateConsidered = "", 
		sodiumMaxDateConsidered = "";

if(sodiumMinResult.isEmpty() == true){
	sodiumMinResult = HIGH;
}
if(sodiumMaxResult.isEmpty() == true){
	sodiumMaxResult = LOW;
}
if(sodiumMinResultWb.isEmpty() == true){
	sodiumMinResultWb = HIGH;
}
if(sodiumMaxResultWb.isEmpty() == true){
	sodiumMaxResultWb = LOW;
}

System.out.println("Sodium Min Result 2: " + sodiumMinResult);
System.out.println("Sodium Max Result 2: " + sodiumMaxResult);

sodiumMinResultConsidered = Double.toString(Math.min(Double.parseDouble(sodiumMinResult), Double.parseDouble(sodiumMinResultWb)));
sodiumMaxResultConsidered = Double.toString(Math.max(Double.parseDouble(sodiumMaxResult), Double.parseDouble(sodiumMaxResultWb)));

System.out.println("Sodium Min considered 1: " + sodiumMinResultConsidered);
System.out.println("Sodium Max considered 1: " + sodiumMaxResultConsidered);


if(sodiumMinResultConsidered.equals(HIGH)) {
	sodiumMinResultConsidered = "";
	System.out.println("Sodium Min considered 2: " + sodiumMinResultConsidered);
}
if(sodiumMaxResultConsidered.equals(LOW)) {
	sodiumMaxResultConsidered = "";
	System.out.println("Sodium Max considered 2: " + sodiumMaxResultConsidered);
}

System.out.println("Sodium Min Result 3: " + sodiumMinResult);
System.out.println("Sodium Max Result 3: " + sodiumMaxResult);

if(Double.parseDouble(sodiumMinResultConsidered) == Double.parseDouble(sodiumMinResult)){
	sodiumMinDateConsidered = sodiumMinDate;
	System.out.println("Sodium Min date considered 1: " + sodiumMinDateConsidered);
}
else{
	if(sodiumMinDateWb.isEmpty()!= true)
		sodiumMinDateConsidered = sodiumMinDateWb;
	System.out.println("Sodium Min date considered 2: " + sodiumMinDateConsidered);
}

if(Double.parseDouble(sodiumMaxResultConsidered) == Double.parseDouble(sodiumMaxResult)){
	
		sodiumMaxDateConsidered = sodiumMaxDate;
		System.out.println("Sodium Max date considered 1: " + sodiumMaxDateConsidered);
}
else{
	if(sodiumMaxDateWb.isEmpty()!= true)
		sodiumMaxDateConsidered = sodiumMaxDateWb;
	System.out.println("Sodium Max date considered 2: " + sodiumMaxDateConsidered);
}

if(sodiumLow.isEmpty() == true && sodiumLowWb.isEmpty() == true){
	sodiumLowConsidered = sodiumLow; 
	 if(sodiumHigh.isEmpty() != true){
	        sodiumHighConsidered = sodiumHigh;
	        System.out.println("Sodium High considered 1: " + sodiumHighConsidered);
	    }
	 else{
	        sodiumHighConsidered = sodiumHighWb;
	        System.out.println("Sodium High considered 2: " + sodiumHighConsidered);
      }
}
else if(sodiumLow.isEmpty() != true && sodiumLowWb.isEmpty() == true){
	sodiumLowConsidered = sodiumLow; 
	sodiumHighConsidered = sodiumHigh;
}
else if(sodiumLow.isEmpty() == true && sodiumLowWb.isEmpty() != true){
	sodiumLowConsidered = sodiumLowWb; 
	sodiumHighConsidered = sodiumHighWb;
}
else if(sodiumLow.isEmpty() != true && sodiumLowWb.isEmpty() != true){
	sodiumLowConsidered = sodiumLow; 
	sodiumHighConsidered = sodiumHigh;
}
System.out.println("sodium min date:" + sodiumMinDateConsidered);
System.out.println("sodium max date:" + sodiumMaxDateConsidered);


//Potassium	
//@modified by Abhishek
//0 = Normal Potassium, 1 = Potassium Whole Blood, if both are empty, no readings (Considered Potassium Values are empty anyway)
String  potassiumLow = stringOrNot(request.getParameter("potassium_low")), 
		potassiumHigh = stringOrNot(request.getParameter("potassium_high")),
		potassiumMinResult = stringOrNot(request.getParameter("potassium_min_val")), 
		potassiumMaxResult = stringOrNot(request.getParameter("potassium_max_val")),
		potassiumMinDate = request.getParameter("potassium_min_date"),
		potassiumMaxDate = request.getParameter("potassium_max_date"); 



String  potassiumLowWb = stringOrNot(request.getParameter("wb_potassium_low")), 
		potassiumHighWb = stringOrNot(request.getParameter("wb_potassium_high")),
		potassiumMinResultWb = stringOrNot(request.getParameter("wb_potassium_min_val")),
		potassiumMaxResultWb = stringOrNot(request.getParameter("wb_potassium_max_val")),
		potassiumMinDateWb = request.getParameter("wb_potassium_min_date"),
		potassiumMaxDateWb = request.getParameter("wb_potassium_max_date");


String  potassiumLowConsidered = "", 
		potassiumHighConsidered = "", 
		potassiumMinResultConsidered = "", 
		potassiumMaxResultConsidered = "",
		potassiumMinDateConsidered = "",
		potassiumMaxDateConsidered = "";

if(potassiumMinResult.isEmpty()){
	potassiumMinResult = HIGH;
}
if(potassiumMaxResult.isEmpty() == true){
	potassiumMaxResult = LOW;
}
if(potassiumMinResultWb.isEmpty() == true){
	potassiumMinResultWb = HIGH;
}
if(potassiumMaxResultWb.isEmpty() == true){
	potassiumMaxResultWb = LOW;
}
potassiumMinResultConsidered = Double.toString(Math.min(Double.parseDouble(potassiumMinResult), Double.parseDouble(potassiumMinResultWb)));
potassiumMaxResultConsidered = Double.toString(Math.max(Double.parseDouble(potassiumMaxResult), Double.parseDouble(potassiumMaxResultWb)));
if(potassiumMinResultConsidered.equals(HIGH)) {
	potassiumMinResultConsidered = "";
}
if(potassiumMaxResultConsidered.equals(LOW)) {
	potassiumMaxResultConsidered = "";
}
if(Double.parseDouble(potassiumMinResultConsidered) == Double.parseDouble(potassiumMinResult)){
	potassiumMinDateConsidered = potassiumMinDate;
}
else{
	potassiumMinDateConsidered = potassiumMinDateWb;
}

if(Double.parseDouble(potassiumMaxResultConsidered) == Double.parseDouble(potassiumMaxResult)){
	potassiumMaxDateConsidered = potassiumMaxDate;
}
else{
	potassiumMaxDateConsidered = potassiumMaxDateWb;
}


if(potassiumLow.isEmpty() == true && potassiumLowWb.isEmpty() == true){
	potassiumLowConsidered = potassiumLow; 
	 if(potassiumHigh.isEmpty() != true){
		 potassiumHighConsidered = potassiumHigh;
	    }
	    else{
	    	potassiumHighConsidered = potassiumHighWb;
	    }
}
else if(potassiumLow.isEmpty() != true && potassiumLowWb.isEmpty() == true){
	potassiumLowConsidered = potassiumLow; 
	potassiumHighConsidered = potassiumHigh;
}
else if(potassiumLow.isEmpty() == true && potassiumLowWb.isEmpty() != true){
	potassiumLowConsidered = potassiumLowWb; 
	potassiumHighConsidered = potassiumHighWb;
}
else if(potassiumLow.isEmpty() != true && potassiumLowWb.isEmpty() != true){
	potassiumLowConsidered = potassiumLow; 
	potassiumHighConsidered = potassiumHigh;
}

//Calcium
String  calciumLow = stringOrNot(request.getParameter("calcium_low")), 
		calciumHigh = stringOrNot(request.getParameter("calcium_high")),
	    calciumMinResult = stringOrNot(request.getParameter("calcium_min_val")), 
	    calciumMaxResult = stringOrNot(request.getParameter("calcium_max_val")),  
	    calciumMinDate = request.getParameter("calcium_min_date"),
	    calciumMaxDate =request.getParameter("calcium_max_date");




//Glucose
//@modified by Abhishek
//0 = Normal glucose, 1 = glucose Whole Blood, if both are empty, no readings (Considered glucose Values are empty anyway) 
String  glucMinResult = stringOrNot(request.getParameter("glucose_min_val")), 
		glucMaxResult = stringOrNot(request.getParameter("glucose_max_val")),
		glucMinDate = request.getParameter("glucose_min_date"), 
		glucMaxDate = request.getParameter("glucose_max_date"),
		glucLow = stringOrNot(request.getParameter("glucose_low")), 
		glucHigh = stringOrNot(request.getParameter("glucose_high"));



String  glucLowWb = stringOrNot(request.getParameter("wb_glucose_low")), 
		glucHighWb = stringOrNot(request.getParameter("wb_glucose_high")),
		glucMinResultWb = stringOrNot(request.getParameter("wb_glucose_min_val")),
		glucMaxResultWb = stringOrNot(request.getParameter("wb_glucose_max_val")),
		glucMinDateWb = request.getParameter("wb_glucose_min_date"),
		glucMaxDateWb = request.getParameter("wb_glucose_max_date");



String  glucLowConsidered = "", 
		glucHighConsidered = "", 
		glucMinResultConsidered = "", 
		glucMaxResultConsidered = "",
		glucMinDateConsidered = "",
		glucMaxDateConsidered = "";

if(glucMinResult.isEmpty() == true){
	glucMinResult = HIGH;
}
if(glucMaxResult.isEmpty() == true){
	glucMaxResult = LOW;
}
if(glucMinResultWb.isEmpty() == true){
	glucMinResultWb = HIGH;
}
if(glucMaxResultWb.isEmpty() == true){
	glucMaxResultWb = LOW;
}

glucMinResultConsidered = Double.toString(Math.min(Double.parseDouble(glucMinResult), Double.parseDouble(glucMinResultWb)));
glucMaxResultConsidered = Double.toString(Math.max(Double.parseDouble(glucMaxResult), Double.parseDouble(glucMaxResultWb)));
if(glucMinResultConsidered.equals(HIGH)) {
	glucMinResultConsidered = "";
}
if(glucMaxResultConsidered.equals(LOW)) {
	glucMaxResultConsidered = "";
}

if(Double.parseDouble(glucMinResultConsidered) == Double.parseDouble(glucMinResult)){
	glucMinDateConsidered = glucMinDate;
}
else{
	glucMinDateConsidered = glucMinDateWb;
}

if(Double.parseDouble(glucMaxResultConsidered) == Double.parseDouble(glucMaxResult)){
	glucMaxDateConsidered = glucMaxDate;
}
else{
	glucMaxDateConsidered = glucMaxDateWb;
}

if(glucLow.isEmpty() == true && glucLowWb.isEmpty() == true){
	glucLowConsidered = glucLow; 
	if(glucHigh.isEmpty() != true){
		 glucHighConsidered = glucHigh;
	    }
	    else{
	    	glucHighConsidered = glucHighWb;
	    }
}
else if(glucLow.isEmpty() != true && glucLowWb.isEmpty() == true){
	glucLowConsidered = glucLow; 
	glucHighConsidered = glucHigh;
}
else if(glucLow.isEmpty() == true && glucLowWb.isEmpty() != true){
	glucLowConsidered = glucLowWb; 
	glucHighConsidered = glucHighWb;
}
else if(glucLow.isEmpty() != true && glucLowWb.isEmpty() != true){
	glucLowConsidered = glucLow; 
	glucHighConsidered = glucHigh;
}

//Height
String heightMinResult = stringOrNot(request.getParameter("height_min_val")),
	   heightMaxResult = stringOrNot(request.getParameter("height_max_val")),
	   heightMinDate = request.getParameter("height_min_date"), 
	   heightMaxDate = request.getParameter("height_max_date");


//queryString+="height_min_val="+heightMinResult+"&"+"height_max_val="+heightMaxResult+"&"+"height_min_date="+heightMinDate+"&"+"height_max_date="+heightMaxDate+"&";

//Weight
String weightMinResult = stringOrNot(request.getParameter("weight_min_val")), 
	   weightMaxResult = stringOrNot(request.getParameter("weight_max_val")), 
	   weightMinDate = request.getParameter("weight_min_date"),
	   weightMaxDate = request.getParameter("weight_max_date");


//queryString+="weight_min_val="+weightMinResult+"&"+"weight_max_val="+weightMaxResult+"&"+"weight_min_date="+weightMinDate+"&"+"weight_max_date="+weightMaxDate;

//Systolic Blood Pressure
String  sysBPMinResult = stringOrNot(request.getParameter("Systolic_Blood_Pressure_min_val")), 
		sysBPMaxResult = stringOrNot(request.getParameter("Systolic_Blood_Pressure_max_val")),
		sysBPMinDate = request.getParameter("Systolic_Blood_Pressure_min_date"), 
		sysBPMaxDate = request.getParameter("Systolic_Blood_Pressure_max_date"),
		sysBPLow = stringOrNot(request.getParameter("Systolic_Blood_Pressure_low")), 
		sysBPHigh = stringOrNot(request.getParameter("Systolic_Blood_Pressure_high"));





//Diastolic Blood Pressure
String  diasBPMinResult = stringOrNot(request.getParameter("Diastolic_Blood_Pressure_min_val")), 
		diasBPMaxResult = stringOrNot(request.getParameter("Diastolic_Blood_Pressure_max_val")),
		diasBPMinDate = request.getParameter("Diastolic_Blood_Pressure_min_date"), 
		diasBPMaxDate = request.getParameter("Diastolic_Blood_Pressure_max_date"),
		diasBPLow = stringOrNot(request.getParameter("Diastolic_Blood_Pressure_low")), 
		diasBPHigh = stringOrNot(request.getParameter("Diastolic_Blood_Pressure_high"));


 
//PCO2
String pco2MinResult = stringOrNot(request.getParameter("pco2_min_val")),
	   pco2MaxResult = stringOrNot(request.getParameter("pco2_max_val")),
	   pco2MinDate = request.getParameter("pco2_min_date"),
	   pco2MaxDate = request.getParameter("pco2_max_date"),
	   pco2High = stringOrNot(request.getParameter("pco2_high")), 
	   pco2Low = stringOrNot(request.getParameter("pco2_low"));



String prevPco2MinResult = stringOrNot(request.getParameter("pco2_prev_min_val")), 
	   prevPco2MaxResult = stringOrNot(request.getParameter("pco2_prev_max_val")),
	   prevPco2MinDate = request.getParameter("pco2_prev_min_date"), 
	   prevPco2MaxDate = request.getParameter("pco2_prev_max_date"),
	   prevPco2Low = stringOrNot(request.getParameter("pco2_prev_low")), 
	   prevPco2High = stringOrNot(request.getParameter("pco2_prev_high"));



//Etco
String etco2MinResult = stringOrNot(request.getParameter("etco2_min_val")), 
	   etco2MaxResult = stringOrNot(request.getParameter("etco2_max_val")),
       etco2MinDate = request.getParameter("etco2_min_date"),
       etco2MaxDate = request.getParameter("etco2_max_date"),
	   etco2Low = stringOrNot(request.getParameter("etco2_low")), 
	   etco2High = stringOrNot(request.getParameter("etco2_high"));



String prevEtco2MinResult = stringOrNot(request.getParameter("etco2_prev_min_val")),
	   prevEtco2MaxResult = stringOrNot(request.getParameter("etco2_prev_max_val")),
	   prevEtco2MinDate = request.getParameter("etco2_prev_min_date"),
	   prevEtco2MaxDate = request.getParameter("etco2_prev_max_date"),
	   prevEtco2Low = stringOrNot(request.getParameter("etco2_prev_low")), 
	   prevEtco2High = stringOrNot(request.getParameter("etco2_prev_high"));



//PO2
String  po2MinResult = stringOrNot(request.getParameter("po2_min_val")),
		po2MaxResult = stringOrNot(request.getParameter("po2_max_val")),
		po2MinDate = request.getParameter("po2_min_date"),
		po2MaxDate = request.getParameter("po2_max_date"), 
		po2High = stringOrNot(request.getParameter("po2_high")), 
		po2Low = stringOrNot(request.getParameter("po2_low"));



//O2sat
String  o2satMinResult = stringOrNot(request.getParameter("o2sat_min_val")), 
		o2satMaxResult = stringOrNot(request.getParameter("o2sat_max_val")),
		o2satMinDate = request.getParameter("o2sat_min_date"), 
		o2satMaxDate = request.getParameter("o2sat_max_date"),
		o2satLow = stringOrNot(request.getParameter("o2sat_low")), o2satHigh = stringOrNot(request.getParameter("o2sat_high"));



 //Pulse Oximetry
String  oximetryMinResult = stringOrNot(request.getParameter("oximetry_min_val")), 
		oximetryMaxResult = stringOrNot(request.getParameter("oximetry_max_val")),
		oximetryMinDate = request.getParameter("oximetry_min_date"), 
		oximetryMaxDate = request.getParameter("oximetry_max_date"),
		oximetryLow = stringOrNot(request.getParameter("oximetry_low")), oximetryHigh = stringOrNot(request.getParameter("oximetry_high")); 



//Bun
//@modified by Abhishek
//0 = Normal BUN, 1 = BUN Whole Blood, if both are empty, no readings (Considered BUN Values are empty anyway)
String  bunMinResult = stringOrNot(request.getParameter("bun_min_val")), 
		bunMaxResult = stringOrNot(request.getParameter("bun_max_val")),
		bunMinDate = request.getParameter("bun_min_date"), 
		bunMaxDate = request.getParameter("bun_max_date"),
		bunLow = stringOrNot(request.getParameter("bun_low")), 
		bunHigh = stringOrNot(request.getParameter("bun_high"));



String  bunLowWb = stringOrNot(request.getParameter("wb_bun_low")), 
		bunHighWb = stringOrNot(request.getParameter("wb_bun_high")), 
		bunMinResultWb = stringOrNot(request.getParameter("wb_bun_min_val")),
		bunMaxResultWb = stringOrNot(request.getParameter("wb_bun_max_val")),
		bunMinDateWb = request.getParameter("wb_bun_min_date"),
		bunMaxDateWb = request.getParameter("wb_bun_max_date");



String  bunLowConsidered = "", 
		bunHighConsidered = "", 
		bunMinResultConsidered = "", 
		bunMaxResultConsidered = "",
		bunMinDateConsidered = "",
		bunMaxDateConsidered = "";

if(bunMinResult.isEmpty() == true){
	bunMinResult = HIGH;
}
if(bunMaxResult.isEmpty() == true){
	bunMaxResult = LOW;
}
if(bunMinResultWb.isEmpty() == true){
	bunMinResultWb = HIGH;
}
if(bunMaxResultWb.isEmpty() == true){
	bunMaxResultWb = LOW;
}

bunMinResultConsidered = Double.toString(Math.min(Double.parseDouble(bunMinResult), Double.parseDouble(bunMinResultWb)));
bunMaxResultConsidered = Double.toString(Math.max(Double.parseDouble(bunMaxResult), Double.parseDouble(bunMaxResultWb)));
if(bunMinResultConsidered.equals(HIGH)) {
	bunMinResultConsidered = "";
}
if(bunMaxResultConsidered.equals(LOW)) {
	bunMaxResultConsidered = "";
}
if(Double.parseDouble(bunMinResultConsidered) == Double.parseDouble(bunMinResult)){
	bunMinDateConsidered = bunMinDate;
}
else{
	bunMinDateConsidered = bunMinDateWb;
}

if(Double.parseDouble(bunMaxResultConsidered) == Double.parseDouble(bunMaxResult)){
	bunMaxDateConsidered = bunMaxDate;
}
else{
	bunMaxDateConsidered = bunMaxDateWb;
}

if(bunLow.isEmpty() == true && bunLowWb.isEmpty() == true){
	bunLowConsidered = bunLow; 
	if(bunHigh.isEmpty() != true){
		 bunHighConsidered = bunHigh;
	    }
	    else{
	    	bunHighConsidered = bunHighWb;
	    }
}
else if(bunLow.isEmpty() != true && bunLowWb.isEmpty() == true){
	bunLowConsidered = bunLow; 
	bunHighConsidered = bunHigh;
}
else if(bunLow.isEmpty() == true && bunLowWb.isEmpty() != true){
	bunLowConsidered = bunLowWb; 
	bunHighConsidered = bunHighWb;
}
else if(bunLow.isEmpty() != true && bunLowWb.isEmpty() != true){
	bunLowConsidered = bunLow; 
	bunHighConsidered = bunHigh;
}


//Creatinine
String  creatMinResult = stringOrNot(request.getParameter("creat_min_val")), 
		creatMaxResult = stringOrNot(request.getParameter("creat_max_val")),
		creatMinDate = request.getParameter("creat_min_date"), 
		creatMaxDate = request.getParameter("creat_max_date"),
		creatLow = stringOrNot(request.getParameter("creat_low")), 
		creatHigh = stringOrNot(request.getParameter("creat_high"));



String  creatLowWb = stringOrNot(request.getParameter("wb_creat_low")), 
		creatHighWb = stringOrNot(request.getParameter("wb_creat_high")), 
		creatMinResultWb = stringOrNot(request.getParameter("wb_creat_min_val")),
		creatMaxResultWb = stringOrNot(request.getParameter("wb_creat_max_val")),
		creatMinDateWb = request.getParameter("wb_creat_min_date"),
		creatMaxDateWb = request.getParameter("wb_creat_max_date");



String  creatLowConsidered = "", 
		creatHighConsidered = "", 
		creatMinResultConsidered = "", 
		creatMaxResultConsidered = "",
		creatMinDateConsidered = "",
		creatMaxDateConsidered = "";


if(creatMinResult.isEmpty() == true){
	creatMinResult = HIGH;
}
if(creatMaxResult.isEmpty() == true){
	creatMaxResult = LOW;   
}
if(creatMinResultWb.isEmpty() == true){
	creatMinResultWb = HIGH;
}
if(creatMaxResultWb.isEmpty() == true){
	creatMaxResultWb = LOW;
}

creatMinResultConsidered = Double.toString(Math.min(Double.parseDouble(creatMinResult), Double.parseDouble(creatMinResultWb)));
creatMaxResultConsidered = Double.toString(Math.max(Double.parseDouble(creatMaxResult), Double.parseDouble(creatMaxResultWb)));

if(creatMinResultConsidered.equals(HIGH)) {
	creatMinResultConsidered = "";
}
if(creatMaxResultConsidered.equals(LOW)) {
	creatMaxResultConsidered = "";
}
if(Double.parseDouble(creatMinResultConsidered) == Double.parseDouble(creatMinResult)){
	creatMinDateConsidered = creatMinDate;
}
else{
	creatMinDateConsidered = creatMinDateWb;
}

if(Double.parseDouble(creatMaxResultConsidered) == Double.parseDouble(creatMaxResult)){
	creatMaxDateConsidered = creatMaxDate;
}
else{
	creatMaxDateConsidered = creatMaxDateWb;
}

if(creatLow.isEmpty() == true && creatLowWb.isEmpty() == true){
	creatLowConsidered = creatLow; 
	if(creatHigh.isEmpty() != true){
		 creatHighConsidered = creatHigh;
	    }
	    else{
	    	creatHighConsidered = creatHighWb;
	    }
}
else if(creatLow.isEmpty() != true && creatLowWb.isEmpty() == true){
	creatLowConsidered = creatLow; 
	creatHighConsidered = creatHigh;
}
else if(creatLow.isEmpty() == true && creatLowWb.isEmpty() != true){
	creatLowConsidered = creatLowWb; 
	creatHighConsidered = creatHighWb;
}
else if(creatLow.isEmpty() != true && creatLowWb.isEmpty() != true){
	creatLowConsidered = creatLow; 
	creatHighConsidered = creatHigh;
}
		

String prevCreatMinResult = stringOrNot(request.getParameter("creat_prev_min_val")), 
		prevCreatMaxResult = stringOrNot(request.getParameter("creat_prev_max_val")),
		prevCreatHigh = stringOrNot(request.getParameter("creat_prev_high")), 
		prevCreatLow = stringOrNot(request.getParameter("creat_prev_low")), 
		prevCreatMinDate = request.getParameter("creat_prev_min_date"),
		prevCreatMaxDate = request.getParameter("creat_prev_max_date");


String  prevCreatLowWb = stringOrNot(request.getParameter("wb_creat_prev_low")), 
		prevCreatHighWb = stringOrNot(request.getParameter("wb_creat_prev_high")), 
		prevCreatMinResultWb = stringOrNot(request.getParameter("wb_creat_prev_min_val")),
		prevCreatMaxResultWb = stringOrNot(request.getParameter("wb_creat_prev_max_val")),
		prevCreatMinDateWb = request.getParameter("wb_creat_prev_min_date"),
		prevCreatMaxDateWb = request.getParameter("wb_creat_prev_max_date");



String  prevCreatLowConsidered = "", 
		prevCreatHighConsidered = "", 
		prevCreatMinResultConsidered = "", 
		prevCreatMaxResultConsidered = "",
		prevCreatMinDateConsidered = "",
		prevCreatMaxDateConsidered = "";

if(prevCreatMinResult.isEmpty() == true){
	prevCreatMinResult = HIGH;
}
if(prevCreatMaxResult.isEmpty() == true){
	prevCreatMaxResult = LOW; 
}
if(prevCreatMinResultWb.isEmpty() == true){
	prevCreatMinResultWb = HIGH;
}
if(prevCreatMaxResultWb.isEmpty() == true){
	prevCreatMaxResultWb = LOW;
}

prevCreatMinResultConsidered = Double.toString(Math.min(Double.parseDouble(prevCreatMinResult), Double.parseDouble(prevCreatMinResultWb)));
prevCreatMaxResultConsidered = Double.toString(Math.max(Double.parseDouble(prevCreatMaxResult), Double.parseDouble(prevCreatMaxResultWb)));

if(prevCreatMinResultConsidered.equals(HIGH)) {
	prevCreatMinResultConsidered = "";
}
if(prevCreatMaxResultConsidered.equals(LOW)) {
	prevCreatMaxResultConsidered = "";
}

if(Double.parseDouble(prevCreatMinResultConsidered) == Double.parseDouble(prevCreatMinResult)){
	prevCreatMinDateConsidered = prevCreatMinDate;
}
else{
	prevCreatMinDateConsidered = prevCreatMinDateWb;
}

if(Double.parseDouble(prevCreatMaxResultConsidered) == Double.parseDouble(prevCreatMaxResult)){
	prevCreatMaxDateConsidered = prevCreatMaxDate;
}
else{
	prevCreatMaxDateConsidered = prevCreatMaxDateWb;
}

if(prevCreatLow.isEmpty() == true && prevCreatLowWb.isEmpty() == true){
	prevCreatLowConsidered = prevCreatLow; 
	if(prevCreatHigh.isEmpty() != true){
		 prevCreatHighConsidered = prevCreatHigh;
	    }
	    else{
	    	prevCreatHighConsidered = prevCreatHighWb;
	    }
}
else if(prevCreatLow.isEmpty() != true && prevCreatLowWb.isEmpty() == true){
	prevCreatLowConsidered = prevCreatLow; 
	prevCreatHighConsidered = prevCreatHigh;
}
else if(prevCreatLow.isEmpty() == true && prevCreatLowWb.isEmpty() != true){
	prevCreatLowConsidered = prevCreatLowWb; 
	prevCreatHighConsidered = prevCreatHighWb;
}
else if(prevCreatLow.isEmpty() != true && prevCreatLowWb.isEmpty() != true){
	prevCreatLowConsidered = prevCreatLow; 
	prevCreatHighConsidered = prevCreatHigh;
}

//GFR
String  gfrMinDate = request.getParameter("gfr_min_date"), 
		gfrMaxDate = request.getParameter("gfr_max_date"),
		gfrMinResult = request.getParameter("gfr_min_val"),
		gfrMaxResult = request.getParameter("gfr_max_val");



		//gfrLow = request.getParameter("gfr_low"), 
		//gfrHigh = request.getParameter("gfr_high");

 if((true != gfrMaxResult.isEmpty()) && gfrMaxResult.contains(">")){
	gfrMaxResult = gfrMaxResult.substring(1);
}
 
if((true != gfrMinResult.isEmpty()) && gfrMinResult.contains(">")){
	gfrMinResult = gfrMinResult.substring(1);
}

/* if((true != gfrLow.isEmpty()) && gfrLow.contains(">")){
	gfrLow = gfrLow.substring(1);
}

if((true != gfrHigh.isEmpty()) && gfrHigh.contains(">")){
	gfrHigh = gfrHigh.substring(1);
} 
 */

//Haemoglobin
String  hbMinResult = stringOrNot(request.getParameter("hb_min_val")), 
		hbMaxResult = stringOrNot(request.getParameter("hb_max_val")),
		hbMinDate = request.getParameter("hb_min_date"),
		hbMaxDate = request.getParameter("hb_max_date"), 
		hbLow = stringOrNot(request.getParameter("hb_low")), 
		hbHigh = stringOrNot(request.getParameter("hb_high")), 
		hbPrevMinResult = stringOrNot(request.getParameter("hb_prev_min_val")), 
		hbPrevMaxResult = stringOrNot(request.getParameter("hb_prev_max_val")),
		hbPrevMinDate = request.getParameter("hb_prev_min_date"),
		hbPrevMaxDate = request.getParameter("hb_prev_max_date"), 
		hbPrevLow = stringOrNot(request.getParameter("hb_prev_low")), 
		hbPrevHigh = stringOrNot(request.getParameter("hb_prev_high"));
 
 

//Haematocrit
String  hcMinResult = stringOrNot(request.getParameter("hc_min_val")), 
		hcMaxResult = stringOrNot(request.getParameter("hc_max_val")),
		hcMinDate = request.getParameter("hc_min_date"), 
		hcMaxDate = request.getParameter("hc_max_date"),
		hcLow = stringOrNot(request.getParameter("hc_low")), 
		hcHigh = stringOrNot(request.getParameter("hc_high")), 
		hcPrevMinResult = stringOrNot(request.getParameter("hc_prev_min_val")), 
		hcPrevMaxResult = stringOrNot(request.getParameter("hc_prev_max_val")),
		hcPrevMinDate = request.getParameter("hc_prev_min_date"),
		hcPrevMaxDate = request.getParameter("hc_prev_max_date"),
		hcPrevLow = stringOrNot(request.getParameter("hc_prev_low")), 
		hcPrevHigh = stringOrNot(request.getParameter("hc_prev_high"));



// Cardiac troponin
String  ctMinResult = stringOrNot(request.getParameter("ct_min_val")), 
		ctMaxResult = stringOrNot(request.getParameter("ct_max_val")),
		ctMinDate = request.getParameter("ct_min_date"),
		ctMaxDate = request.getParameter("ct_max_date"), 
		ctLow = request.getParameter("ct_low"), 
		ctHigh = stringOrNot(request.getParameter("ct_high"));



if((true != ctLow.isEmpty()) && ctLow.contains("<")){
	ctLow = ctLow.substring(1);
}	
//WBC 
String  wbcMinResult = stringOrNot(request.getParameter("wbc_min_val")), 
		wbcMaxResult = stringOrNot(request.getParameter("wbc_max_val")),
		wbcMinDate = request.getParameter("wbc_min_date"),
		wbcMaxDate = request.getParameter("wbc_max_date"), 
		wbcLow = stringOrNot(request.getParameter("wbc_low")), 
		wbcHigh = stringOrNot(request.getParameter("wbc_high"));


//UTI WBC 
String  utiWbcMinResult = stringOrNot(request.getParameter("utiWbc_min_val")),
		utiWbcMaxResult = stringOrNot(request.getParameter("utiWbc_max_val")),
		utiWbcMinDate = request.getParameter("utiWbc_min_date"), 
		utiWbcMaxDate = request.getParameter("utiWbc_max_date"),
		utiWbcLow = stringOrNot(request.getParameter("utiWbc_low")),
		utiWbcHigh = stringOrNot(request.getParameter("utiWbc_high"));



// Nitrite 
String  uriniMinResult = request.getParameter("leucocyte_nitrite_min_val"), 
		uriniMaxResult = request.getParameter("leucocyte_nitrite_max_val"),
		uriniMinDate = request.getParameter("leucocyte_nitrite_min_date"), 
		uriniMaxDate = request.getParameter("leucocyte_nitrite_max_date"),
		uriniLow = stringOrNot(request.getParameter("leucocyte_nitrite_low")), 
		uriniHigh = stringOrNot(request.getParameter("leucocyte_nitrite_high"));



// Leucocyte Esterate
String  urinestMinResult = request.getParameter("leucocyte_esterate_min_val"), 
		urinestMaxResult = request.getParameter("leucocyte_esterate_max_val"),
		urinestMinDate = request.getParameter("leucocyte_esterate_min_date"), 
		urinestMaxDate = request.getParameter("leucocyte_esterate_max_date"),
		urinestLow = request.getParameter("leucocyte_esterate_low"), 
		urinestHigh = request.getParameter("leucocyte_esterate_high");


	
// Heart Rate
String  hRateMinResult  = stringOrNot(request.getParameter("hr_min_val")),
		hRateMaxResult  = stringOrNot(request.getParameter("hr_max_val")),
	    hRateMinDate = request.getParameter("hr_min_date"),
	    hRateMaxDate = request.getParameter("hr_max_date"),
	    hRateLow = stringOrNot(request.getParameter("hr_low")),
	    hRateHigh = stringOrNot(request.getParameter("hr_high"));


		
// Respiratory Rate
String  rRateMinResult = stringOrNot(request.getParameter("rr_min_val")) ,
		rRateMaxResult = stringOrNot(request.getParameter("rr_max_val")) ,
	    rRateMinDate = request.getParameter("rr_min_date"),
	    rRateMaxDate = request.getParameter("rr_max_date"),
	    rRateLow = stringOrNot(request.getParameter("rr_low")),
	    rRateHigh = stringOrNot(request.getParameter("rr_high"));	   
	   



// Temperature
String  tempMinResult = stringOrNot(request.getParameter("temp_min_val")),
		tempMaxResult = stringOrNot(request.getParameter("temp_max_val")),
	   	tempMinDate = request.getParameter("temp_min_date"),
	   	tempMaxDate = request.getParameter("temp_max_date"),
	   	tempLow = stringOrNot(request.getParameter("temp_low")),
	   	tempHigh = stringOrNot(request.getParameter("temp_high"));



//Lactate
String  lactateMinResult = stringOrNot(request.getParameter("lactate_min_val")),
		lactateMaxResult = stringOrNot(request.getParameter("lactate_max_val")),
	    lactateMinDate = request.getParameter("lactate_min_date"),
	    lactateMaxDate = request.getParameter("lactate_max_date"),
	    lactateLow = stringOrNot(request.getParameter("lactate_low")),
	    lactateHigh = stringOrNot(request.getParameter("lactate_high"));



//Lactic Acid
String  lactic_acidMinResult = stringOrNot(request.getParameter("lactic_acid_min_val")), 
		lactic_acidMaxResult = stringOrNot(request.getParameter("lactic_acid_max_val")),
		lactic_acidMinDate = request.getParameter("lactic_acid_min_date"), 
		lactic_acidMaxDate = request.getParameter("lactic_acid_max_date"),
		lactic_acidLow = stringOrNot(request.getParameter("lactic_acid_low")), 
		lactic_acidHigh = stringOrNot(request.getParameter("lactic_acid_high"));



System.out.println("Lactic Acid Max Date Testing: " + lactic_acidMaxDate);
System.out.println("Lactic Acid Max Value Testing: " + lactic_acidMaxResult);

String  lactic_acidLowWb = stringOrNot(request.getParameter("wb_lactic_acid_low")), 
		lactic_acidHighWb = stringOrNot(request.getParameter("wb_lactic_acid_high")), 
		lactic_acidMinResultWb = stringOrNot(request.getParameter("wb_lactic_acid_min_val")),
		lactic_acidMaxResultWb = stringOrNot(request.getParameter("wb_lactic_acid_max_val")),
		lactic_acidMinDateWb = request.getParameter("wb_lactic_acid_min_date"),
		lactic_acidMaxDateWb = request.getParameter("wb_lactic_acid_max_date");



System.out.println("Lactic Acid WB Max Date Testing: " + lactic_acidMaxDateWb);
System.out.println("Lactic Acid WB Max Value Testing: " + lactic_acidMaxResultWb);
String  lactic_acidLowConsidered = "", 
		lactic_acidHighConsidered = "", 
		lactic_acidMinResultConsidered = "", 
		lactic_acidMaxResultConsidered = "",
		lactic_acidMinDateConsidered = "",
		lactic_acidMaxDateConsidered = "";


if(lactic_acidMinResult.isEmpty() == true){
	lactic_acidMinResult = HIGH;
}
if(lactic_acidMaxResult.isEmpty() == true){
	lactic_acidMaxResult = LOW;
}
if(lactic_acidMinResultWb.isEmpty() == true){
	lactic_acidMinResultWb = HIGH;
}
if(lactic_acidMaxResultWb.isEmpty() == true){
	lactic_acidMaxResultWb = LOW;
}

lactic_acidMinResultConsidered = Double.toString(Math.min(Double.parseDouble(lactic_acidMinResult), Double.parseDouble(lactic_acidMinResultWb)));
lactic_acidMaxResultConsidered = Double.toString(Math.max(Double.parseDouble(lactic_acidMaxResult), Double.parseDouble(lactic_acidMaxResultWb)));
if(lactic_acidMinResultConsidered.equals(HIGH)) {
	lactic_acidMinResultConsidered = "";
}
if(lactic_acidMaxResultConsidered.equals(LOW)) {
	lactic_acidMaxResultConsidered = "";
}
if(Double.parseDouble(lactic_acidMinResultConsidered) == Double.parseDouble(lactic_acidMinResult)){
	lactic_acidMinDateConsidered = lactic_acidMinDate;
}
else{
	lactic_acidMinDateConsidered = lactic_acidMinDateWb;
}

if(Double.parseDouble(lactic_acidMaxResultConsidered) == Double.parseDouble(lactic_acidMaxResult)){
	lactic_acidMaxDateConsidered = lactic_acidMaxDate;
}
else{
	lactic_acidMaxDateConsidered = lactic_acidMaxDateWb;
}

if(lactic_acidLow.isEmpty() == true && lactic_acidLowWb.isEmpty() == true){
	lactic_acidLowConsidered = lactic_acidLow; 
	 if(lactic_acidHigh.isEmpty() != true){
	        lactic_acidHighConsidered = lactic_acidHigh;
	    }
	    else{
	        lactic_acidHighConsidered = lactic_acidHighWb;
	    }
}
else if(lactic_acidLow.isEmpty() != true && lactic_acidLowWb.isEmpty() == true){
	lactic_acidLowConsidered = lactic_acidLow; 
	lactic_acidHighConsidered = lactic_acidHigh;
}
else if(lactic_acidLow.isEmpty() == true && lactic_acidLowWb.isEmpty() != true){
	lactic_acidLowConsidered = lactic_acidLowWb; 
	lactic_acidHighConsidered = lactic_acidHighWb;
}
else if(lactic_acidLow.isEmpty() != true && lactic_acidLowWb.isEmpty() != true){
	lactic_acidLowConsidered = lactic_acidLow; 
	lactic_acidHighConsidered = lactic_acidHigh;
}

//Phosphorous
String  phosphorusMinResult = stringOrNot(request.getParameter("phosphorus_min_val")), 
		phosphorusMaxResult = stringOrNot(request.getParameter("phosphorus_max_val")),
		phosphorusMinDate = request.getParameter("phosphorus_min_date"),
		phosphorusMaxDate = request.getParameter("phosphorus_max_date"),
		phosphorusLow = stringOrNot(request.getParameter("phosphorus_low")), 
		phosphorusHigh = stringOrNot(request.getParameter("phosphorus_high"));


		 

//Magnesium
String  magnesiumMinResult = stringOrNot(request.getParameter("magnesium_min_val")), 
		magnesiumMaxResult = stringOrNot(request.getParameter("magnesium_max_val")),
		magnesiumMinDate = request.getParameter("magnesium_min_date"),
		magnesiumMaxDate = request.getParameter("magnesium_max_date"),
		magnesiumLow = stringOrNot(request.getParameter("magnesium_low")), 
		magnesiumHigh = stringOrNot(request.getParameter("magnesium_high"));
	


//Cholesterol
String  cholesterolMinResult = stringOrNot(request.getParameter("cholesterol_min_val")), 
		cholesterolMaxResult = stringOrNot(request.getParameter("cholesterol_max_val")),
		cholesterolMinDate = request.getParameter("cholesterol_min_date"),
		cholesterolMaxDate = request.getParameter("cholesterol_max_date"),
		cholesterolLow = stringOrNot(request.getParameter("cholesterol_low")), 
		cholesterolHigh = stringOrNot(request.getParameter("cholesterol_high"));


		

//Neutrophil
String  neutrophilMinResult = stringOrNot(request.getParameter("neutrophil_min_val")), 
		neutrophilMaxResult = stringOrNot(request.getParameter("neutrophil_max_val")),
		neutrophilMinDate = request.getParameter("neutrophil_min_date"),
		neutrophilMaxDate = request.getParameter("neutrophil_max_date"),
		neutrophilLow = stringOrNot(request.getParameter("neutrophil_low")), 
		neutrophilHigh = stringOrNot(request.getParameter("neutrophil_high"));



if(!(neutrophilMinResult.isEmpty() || neutrophilMaxResult.isEmpty())) {
	if(Double.parseDouble(neutrophilMinResult) > Double.parseDouble(neutrophilMaxResult)) {
		String temp = neutrophilMinResult;
		neutrophilMinResult = neutrophilMaxResult;
		neutrophilMaxResult = temp;
	}
}

//Dehydration
String  dehydrationCreatDate = request.getParameter("dehydration_creat_date"), 
		dehydrationBunDate = request.getParameter("dehydration_bun_date"),
		creatinineValue = stringOrNot(request.getParameter("dehydration_creat")),
		bunValue = stringOrNot(request.getParameter("dehydration_bun"));

//queryString+="&";
//request.getSession().setAttribute("prevURL",queryString);

%>

<body  bgcolor="EEEDD8">

<!--   <input id="clock" type="text" value="00:00" style="float:right;text-align:center;background-color:white;border:1px solid gray;font-weight:bold;font-size:14pt;" readonly><br>

	<input id="startstoptimer" type="button" value="Start" onClick="startstop();" style=
		"font-weight:bold;display:none"><br>
-->
<!-- HTML part  -->

<input type="hidden" id='encntr_id' name="encntr_id" value=<%=encounterID%>>
<input type="hidden" id='user_id' name="user_id" value=<%=userID%>>
<input type="hidden" id='sodium_max_date' name="sodium_max_date" value=<%=sodiumMaxDateConsidered%>>
		<input type="hidden" id='sodium_min_date' name="sodium_min_date" value=<%=sodiumMinDateConsidered%>>
		<input type="hidden" id='sodium_low' name="sodium_low" value=<%=sodiumLowConsidered%>>
		<input type="hidden" id='sodium_high' name="sodium_high" value=<%=sodiumHighConsidered%>>
		<input type="hidden" id='sodium_max_val' name="sodium_max_val" value=<%=sodiumMaxResultConsidered%>>
		<input type="hidden" id='sodium_min_val' name="sodium_min_val" value=<%=sodiumMinResultConsidered%>>
		
		 <input type="hidden" id='potassium_max_date' name="potassium_max_date" value=<%=potassiumMaxDateConsidered%>>
		<input type="hidden" id='potassium_min_date' name="potassium_min_date" value=<%=potassiumMinDateConsidered%>>
		<input type="hidden" id='potassium_low' name="potassium_low" value=<%=potassiumLowConsidered%>>
		<input type="hidden" id='potassium_high' name="potassium_high" value=<%=potassiumHighConsidered%>>
		<input type="hidden" id='potassium_max_val' name="potassium_max_val" value=<%=potassiumMaxResultConsidered%>>
		<input type="hidden" id='potassium_min_val' name="potassium_min_val" value=<%=potassiumMinResultConsidered%>>
		 
		<input type="hidden" id='calcium_max_date' name="calcium_max_date" value=<%=calciumMaxDate%>>
		<input type="hidden" id='calcium_min_date' name="calcium_min_date" value=<%=calciumMinDate%>>
		
		<input type="hidden" id='calcium_low' name="calcium_low" value=<%=calciumLow%>>
		<input type="hidden" id='calcium_high' name="calcium_high" value=<%=calciumHigh%>>
		<input type="hidden" id='calcium_max_val' name="calcium_max_val" value=<%=calciumMaxResult%>>
		<input type="hidden" id='calcium_min_val' name="calcium_min_val" value=<%=calciumMinResult%>>
		

		<input type="hidden" id='glucose_max_date' name="glucose_max_date" value=<%=glucMaxDateConsidered%>>
		<input type="hidden" id='glucose_min_date' name="glucose_min_date" value=<%=glucMinDateConsidered%>>
		<input type="hidden" id='glucose_low' name="glucose_low" value=<%=glucLowConsidered%>>
		<input type="hidden" id='glucose_high' name="glucose_high" value=<%=glucHighConsidered%>>
		<input type="hidden" id='glucose_max_val' name="glucose_max_val" value=<%=glucMaxResultConsidered%>>
		<input type="hidden" id='glucose_min_val' name="glucose_min_val" value=<%=glucMinResultConsidered%>>
		
 		<input type="hidden" id='neutrophil_max_date' name="neutrophil_max_date" value=<%=neutrophilMaxDate%>>
		<input type="hidden" id='neutrophil_min_date' name="neutrophil_min_date" value=<%=neutrophilMinDate%>>
		<input type="hidden" id='neutrophil_low' name="neutrophil_low" value=<%=neutrophilLow%>>
		<input type="hidden" id='neutrophil_high' name="neutrophil_high" value=<%=neutrophilHigh%>>
		<input type="hidden" id='neutrophil_max_val' name="neutrophil_max_val" value=<%=neutrophilMaxResult%>>
		<input type="hidden" id='neutrophil_min_val' name="neutrophil_min_val" value=<%=neutrophilMinResult%>>
		

		 <input type="hidden" id='weight_max_date' name="weight_max_date" value=<%=weightMaxDate%>>
		<input type="hidden" id='weight_min_date' name="weight_min_date" value=<%=weightMinDate%>>
		<input type="hidden" id='weight_max_val' name="weight_max_val" value=<%=weightMaxResult%>>
		<input type="hidden" id='weight_min_val' name="weight_min_val" value=<%=weightMinResult%>>
		

		<input type="hidden" id='height_max_date' name="height_max_date" value=<%=heightMaxDate%>>
		<input type="hidden" id='height_min_date' name="height_min_date" value=<%=heightMinDate%>>
		<input type="hidden" id='height_max_val' name="height_max_val" value=<%=heightMaxResult%>>
		<input type="hidden" id='height_min_val' name="height_min_val" value=<%=heightMinResult%>>
		

		 <input type="hidden" id='Diastolic_Blood_Pressure_max_date' name="Diastolic_Blood_Pressure_max_date" value=<%=diasBPMaxDate%>>
		<input type="hidden" id='Diastolic_Blood_Pressure_min_date' name="Diastolic_Blood_Pressure_min_date" value=<%=diasBPMinDate%>>
		<input type="hidden" id='Diastolic_Blood_Pressure_low' name="Diastolic_Blood_Pressure_low" value=<%=diasBPLow%>>
		<input type="hidden" id='Diastolic_Blood_Pressure_high' name="Diastolic_Blood_Pressure_high" value=<%=diasBPHigh%>>
		<input type="hidden" id='Diastolic_Blood_Pressure_max_val' name="Diastolic_Blood_Pressure_max_val" value=<%=diasBPMaxResult%>>
		<input type="hidden" id='Diastolic_Blood_Pressure_min_val' name="Diastolic_Blood_Pressure_min_val" value=<%=diasBPMinResult%>>
		

		<input type="hidden" id='Systolic_Blood_Pressure_max_date' name="Systolic_Blood_Pressure_max_date" value=<%=sysBPMaxDate%>>
		<input type="hidden" id='Systolic_Blood_Pressure_min_date' name="Systolic_Blood_Pressure_min_date" value=<%=sysBPMinDate%>>
		<input type="hidden" id='Systolic_Blood_Pressure_low' name="Systolic_Blood_Pressure_low" value=<%=sysBPLow%>>
		<input type="hidden" id='Systolic_Blood_Pressure_high' name="Systolic_Blood_Pressure_high" value=<%=sysBPHigh%>>
		<input type="hidden" id='Systolic_Blood_Pressure_max_val' name="Systolic_Blood_Pressure_max_val" value=<%=sysBPMaxResult%>>
		<input type="hidden" id='Systolic_Blood_Pressure_min_val' name="Systolic_Blood_Pressure_min_val" value=<%=sysBPMinResult%>>
		

		 <input type="hidden" id='pco2_max_date' name="pco2_max_date" value=<%=pco2MaxDate%>>
		<input type="hidden" id='pco2_min_date' name="pco2_min_date" value=<%=pco2MinDate%>>
		<input type="hidden" id='pco2_low' name="pco2_low" value=<%=pco2Low%>>
		<input type="hidden" id='pco2_high' name="pco2_high" value=<%=pco2High%>>
		<input type="hidden" id='pco2_max_val' name="pco2_max_val" value=<%=pco2MaxResult%>>
		<input type="hidden" id='pco2_min_val' name="pco2_min_val" value=<%=pco2MinResult%>>
		

		 <input type="hidden" id='pco2_prev_max_date' name="pco2_prev_max_date" value=<%=prevPco2MaxDate%>>
		<input type="hidden" id='pco2_prev_min_date' name="pco2_prev_min_date" value=<%=prevPco2MinDate%>>
		<input type="hidden" id='pco2_prev_low' name="pco2_prev_low" value=<%=prevPco2Low%>>
		<input type="hidden" id='pco2_prev_high' name="pco2_prev_high" value=<%=prevPco2High%>>
		<input type="hidden" id='pco2_prev_max_val' name="pco2_prev_max_val" value=<%=prevPco2MaxResult%>>
		<input type="hidden" id='pco2_prev_min_val' name="pco2_prev_min_val" value=<%=prevPco2MinResult%>>
		

		<input type="hidden" id='etco2_max_date' name="etco2_max_date" value=<%=etco2MaxDate%>>
		<input type="hidden" id='etco2_min_date' name="etco2_min_date" value=<%=etco2MinDate%>>
		<input type="hidden" id='etco2_low' name="etco2_low" value=<%=etco2Low%>>
		<input type="hidden" id='etco2_high' name="etco2_high" value=<%=etco2High%>>
		<input type="hidden" id='etco2_max_val' name="etco2_max_val" value=<%=etco2MaxResult%>>
		<input type="hidden" id='etco2_min_val' name="etco2_min_val" value=<%=etco2MinResult%>>
		
		<input type="hidden" id='etco2_prev_max_date' name="etco2_prev_max_date" value=<%=prevEtco2MaxDate%>>
		<input type="hidden" id='etco2_prev_min_date' name="etco2_prev_min_date" value=<%=prevEtco2MinDate%>>
		<input type="hidden" id='etco2_prev_low' name="etco2_prev_low" value=<%=prevEtco2Low%>>
		<input type="hidden" id='etco2_prev_high' name="etco2_prev_high" value=<%=prevEtco2High%>>
		<input type="hidden" id='etco2_prev_max_val' name="etco2_prev_max_val" value=<%=prevEtco2MaxResult%>>
		<input type="hidden" id='etco2_prev_min_val' name="etco2_prev_min_val" value=<%=prevEtco2MinResult%>>
		
		

		<input type="hidden" id='po2_max_date' name="po2_max_date" value=<%=po2MaxDate%>>
		<input type="hidden" id='po2_min_date' name="po2_min_date" value=<%=po2MinDate%>>
		<input type="hidden" id='po2_low' name="po2_low" value=<%=po2Low%>>
		<input type="hidden" id='po2_high' name="po2_high" value=<%=po2High%>>
		<input type="hidden" id='po2_max_val' name="po2_max_val" value=<%=po2MaxResult%>>
		<input type="hidden" id='po2_min_val' name="po2_min_val" value=<%=po2MinResult%>>
		
		 

		<input type="hidden" id='o2sat_max_date' name="o2sat_max_date" value=<%=o2satMaxDate%>>
		<input type="hidden" id='o2sat_min_date' name="o2sat_min_date" value=<%=o2satMinDate%>>
		<input type="hidden" id='o2sat_low' name="o2sat_low" value=<%=o2satLow%>>
		<input type="hidden" id='o2sat_high' name="o2sat_high" value=<%=o2satHigh%>>
		<input type="hidden" id='o2sat_max_val' name="o2sat_max_val" value=<%=o2satMaxResult%>>
		<input type="hidden" id='o2sat_min_val' name="o2sat_min_val" value=<%=o2satMinResult%>>
		
	    <input type="hidden" id='oximetry_max_date' name="oximetry_max_date" value=<%=oximetryMaxDate%>>
		<input type="hidden" id='oximetry_min_date' name="oximetry_min_date" value=<%=oximetryMinDate%>>
		<input type="hidden" id='oximetry_low' name="oximetry_low" value=<%=oximetryLow%>>
		<input type="hidden" id='oximetry_high' name="oximetry_high" value=<%=oximetryHigh%>>
		<input type="hidden" id='oximetry_max_val' name="oximetry_max_val" value=<%=oximetryMaxResult%>>
		<input type="hidden" id='oximetry_min_val' name="oximetry_min_val" value=<%=oximetryMinResult%>>
		

		<input type="hidden" id='bun_max_date' name="bun_max_date" value=<%=bunMaxDateConsidered%>>
		<input type="hidden" id='bun_min_date' name="bun_min_date" value=<%=bunMinDateConsidered%>>
		<input type="hidden" id='bun_low' name="bun_low" value=<%=bunLowConsidered%>>
		<input type="hidden" id='bun_high' name="bun_high" value=<%=bunHighConsidered%>>
		<input type="hidden" id='bun_max_val' name="bun_max_val" value=<%=bunMaxResultConsidered%>>
		<input type="hidden" id='bun_min_val' name="bun_min_val" value=<%=bunMinResultConsidered%>>
		

	<input type="hidden" id='gfr_max_date' name="gfr_max_date" value=<%=gfrMaxDate%>>
		<input type="hidden" id='gfr_min_date' name="gfr_min_date" value=<%=gfrMinDate%>>
		
		<input type="hidden" id='gfr_max_val' name="gfr_max_val" value=<%=gfrMaxResult%>>
		<input type="hidden" id='gfr_min_val' name="gfr_min_val" value=<%=gfrMinResult%>>
				
		<input type="hidden" id='creat_max_date' name="creat_max_date" value=<%=creatMaxDateConsidered%>>
		<input type="hidden" id='creat_min_date' name="creat_min_date" value=<%=creatMinDateConsidered%>>
		<input type="hidden" id='creat_low' name="creat_low" value=<%=creatLowConsidered%>>
		<input type="hidden" id='creat_high' name="creat_high" value=<%=creatHighConsidered%>>
		<input type="hidden" id='creat_max_val' name="creat_max_val" value=<%=creatMaxResultConsidered%>>
		<input type="hidden" id='creat_min_val' name="creat_min_val" value=<%=creatMinResultConsidered%>>
		
		<input type="hidden" id='creat_prev_max_date' name="creat_prev_max_date" value=<%=prevCreatMaxDate%>>
		<input type="hidden" id='creat_prev_min_date' name="creat_prev_min_date" value=<%=prevCreatMinDate%>>
		<input type="hidden" id='creat_prev_low' name="creat_prev_low" value=<%=prevCreatLow%>>
		<input type="hidden" id='creat_prev_high' name="creat_prev_high" value=<%=prevCreatHigh%>>
		<input type="hidden" id='creat_prev_max_val' name="creat_prev_max_val" value=<%=prevCreatMaxResultConsidered%>>
		<input type="hidden" id='creat_prev_min_val' name="creat_prev_min_val" value=<%=prevCreatMinResultConsidered%>>



		<input type="hidden" id='lactic_acid_max_date' name="lactic_acid_max_date" value=<%=lactic_acidMaxDateConsidered%>>
        <input type="hidden" id='lactic_acid_min_date' name="lactic_acid_min_date" value=<%=lactic_acidMinDateConsidered%>>
        <input type="hidden" id='lactic_acid_max_val' name="lactic_acid_max_val" value=<%=lactic_acidMaxResultConsidered%>>
        <input type="hidden" id='lactic_acid_min_val'name="lactic_acid_min_val" value=<%=lactic_acidMinResultConsidered%>>		
        <input type="hidden" id='lactic_acid_low'name="lactic_acid_low" value=<%=lactic_acidLowConsidered%>>
        <input type="hidden" id='lactic_acid_high'name="lactic_acid_high" value=<%=lactic_acidHighConsidered%>>
                
		<input type="hidden" id='hb_max_date' name="hb_max_date" value=<%=hbMaxDate%>>
		<input type="hidden" id='hb_min_date' name="hb_min_date" value=<%=hbMinDate%>>
		<input type="hidden" id='hb_low' name="hb_low" value=<%=hbLow%>>
		<input type="hidden" id='hb_high' name="hb_high" value=<%=hbHigh%>>
		<input type="hidden" id='hb_max_val' name="hb_max_val" value=<%=hbMaxResult%>>
		<input type="hidden" id='hb_min_val' name="hb_min_val" value=<%=hbMinResult%>>
		
		<input type="hidden" id='hb_prev_max_date' name="hb_prev_max_date" value=<%=hbPrevMaxDate%>>
		<input type="hidden" id='hb_prev_min_date' name="hb_prev_min_date" value=<%=hbPrevMinDate%>>
		<input type="hidden" id='hb_prev_low' name="hb_prev_low" value=<%=hbPrevLow%>>
		<input type="hidden" id='hb_prev_high' name="hb_prev_high" value=<%=hbPrevHigh%>>
		<input type="hidden" id='hb_prev_max_val' name="hb_prev_max_val" value=<%=hbPrevMaxResult%>>
		<input type="hidden" id='hb_prev_min_val' name="hb_prev_min_val" value=<%=hbPrevMinResult%>>
		 
	    <input type="hidden" id='hc_max_date' name="hc_max_date" value=<%=hcMaxDate%>>
		<input type="hidden" id='hc_min_date' name="hc_min_date" value=<%=hcMinDate%>>
		<input type="hidden" id='hc_low' name="hc_low" value=<%=hcLow%>>
		<input type="hidden" id='hc_high' name="hc_high" value=<%=hcHigh%>>
		<input type="hidden" id='hc_max_val' name="hc_max_val" value=<%=hcMaxResult%>>
		<input type="hidden" id='hc_min_val' name="hc_min_val" value=<%=hcMinResult%>>
		
		<input type="hidden" id='hc_prev_max_date' name="hc_prev_max_date" value=<%=hcPrevMaxDate%>>
		<input type="hidden" id='hc_prev_min_date' name="hc_prev_min_date" value=<%=hcPrevMinDate%>>
		<input type="hidden" id='hc_prev_low' name="hc_prev_low" value=<%=hcPrevLow%>>
		<input type="hidden" id='hc_prev_high' name="hc_prev_high" value=<%=hcPrevHigh%>>
		<input type="hidden" id='hc_prev_max_val' name="hc_prev_max_val" value=<%=hcPrevMaxResult%>>
		<input type="hidden" id='hc_prev_min_val' name="hc_prev_min_val" value=<%=hcPrevMinResult%>>
		

		<input type="hidden" id='ct_max_date' name="ct_max_date" value=<%=ctMaxDate%>>
		<input type="hidden" id='ct_min_date' name="ct_min_date" value=<%=ctMinDate%>>
		<input type="hidden" id='ct_low' name="ct_low" value=<%=ctLow%>>
		<input type="hidden" id='ct_high' name="ct_high" value=<%=ctHigh%>>
		<input type="hidden" id='ct_max_val' name="ct_max_val" value=<%=ctMaxResult%>>
		<input type="hidden" id='ct_min_val' name="ct_min_val" value=<%=ctMinResult%>>
		

		<input type="hidden" id='wbc_max_date' name="wbc_max_date" value=<%=wbcMaxDate%>>
		<input type="hidden" id='wbc_min_date' name="wbc_min_date" value=<%=wbcMinDate%>>
		<input type="hidden" id='wbc_low' name="wbc_low" value=<%=wbcLow%>>
		<input type="hidden" id='wbc_high' name="wbc_high" value=<%=wbcHigh%>>
		<input type="hidden" id='wbc_max_val' name="wbc_max_val" value=<%=wbcMaxResult%>>
		<input type="hidden" id='wbc_min_val' name="wbc_min_val" value=<%=wbcMinResult%>>
		

		<input type="hidden" id='utiWbc_max_date' name="utiWbc_max_date" value=<%=utiWbcMaxDate%>>
		<input type="hidden" id='utiWbc_min_date' name="utiWbc_min_date" value=<%=utiWbcMinDate%>>
		<input type="hidden" id='utiWbc_low' name="utiWbc_low" value=<%=utiWbcLow%>>
		<input type="hidden" id='utiWbc_high' name="utiWbc_high" value=<%=utiWbcHigh%>>
		<input type="hidden" id='utiWbc_max_val' name="utiWbc_max_val" value=<%=utiWbcMaxResult%>>
		<input type="hidden" id='utiWbc_min_val' name="utiWbc_min_val" value=<%=utiWbcMinResult%>>
		

		<input type="hidden" id='cardiac_troponin_max_date' name="cardiac_troponin_max_date" value=<%=ctMaxDate%>>
		<input type="hidden" id='cardiac_troponin_min_date' name="cardiac_troponin_min_date" value=<%=ctMinDate%>>
		<input type="hidden" id='cardiac_troponin_low' name="cardiac_troponin_low" value=<%=ctLow%>>
		<input type="hidden" id='cardiac_troponin_high' name="cardiac_troponin_high" value=<%=ctHigh%>>
		<input type="hidden" id='cardiac_troponin_max_val' name="cardiac_troponin_max_val" value=<%=ctMaxResult%>>
		<input type="hidden" id='cardiac_troponin_min_val' name="cardiac_troponin_min_val" value=<%=ctMinResult%>>
		

		<input type="hidden" id='leucocyte_esterate_max_date' name="leucocyte_esterate_max_date" value=<%=urinestMaxDate%>>
		<input type="hidden" id='leucocyte_esterate_min_date' name="leucocyte_esterate_min_date" value=<%=urinestMinDate%>>
		<input type="hidden" id='leucocyte_esterate_low' name="leucocyte_esterate_low" value=<%=urinestLow%>>
		<input type="hidden" id='leucocyte_esterate_high' name="leucocyte_esterate_high" value=<%=urinestHigh%>>
		<input type="hidden" id='leucocyte_esterate_max_val' name="leucocyte_esterate_max_val" value=<%=urinestMaxResult%>>
		<input type="hidden" id='leucocyte_esterate_min_val' name="leucocyte_esterate_min_val" value=<%=urinestMinResult%>>
		 

		<input type="hidden" id='leucocyte_nitrite_max_date' name="leucocyte_nitrite_max_date" value=<%=uriniMaxDate%>>
		<input type="hidden" id='leucocyte_nitrite_min_date' name="leucocyte_nitrite_min_date" value=<%=uriniMinDate%>>
		<input type="hidden" id='leucocyte_nitrite_low' name="leucocyte_nitrite_low" value=<%=uriniLow%>>
		<input type="hidden" id='leucocyte_nitrite_high' name="leucocyte_nitrite_high" value=<%=uriniHigh%>>
		<input type="hidden" id='leucocyte_nitrite_max_val' name="leucocyte_nitrite_max_val" value=<%=uriniMaxResult%>>
		<input type="hidden" id='leucocyte_nitrite_min_val' name="leucocyte_nitrite_min_val" value=<%=uriniMinResult%>>
		

		<input type="hidden" id='temp_max_date' name="temp_max_date" value=<%=tempMaxDate%>>
		<input type="hidden" id='temp_min_date' name="temp_min_date" value=<%=tempMinDate%>>
		<input type="hidden" id='temp_low' name="temp_low" value=<%=tempLow%>>
		<input type="hidden" id='temp_high' name="temp_high" value=<%=tempHigh%>>
		<input type="hidden" id='temp_max_val' name="temp_max_val" value=<%=tempMaxResult%>>
		<input type="hidden" id='temp_min_val' name="temp_min_val" value=<%=tempMinResult%>>
		

		<input type="hidden" id='hr_max_date' name="hr_max_date" value=<%=hRateMaxDate%>>
		<input type="hidden" id='hr_min_date' name="hr_min_date" value=<%=hRateMinDate%>>
		<input type="hidden" id='hr_low' name="hr_low" value=<%=hRateLow%>>
		<input type="hidden" id='hr_high' name="hr_high" value=<%=hRateHigh%>>
		<input type="hidden" id='hr_max_val' name="hr_max_val" value=<%=hRateMaxResult%>>
		<input type="hidden" id='hr_min_val' name="hr_min_val" value=<%=hRateMinResult%>>
		

		<input type="hidden" id='rr_max_date' name="rr_max_date" value=<%=rRateMaxDate%>>
		<input type="hidden" id='rr_min_date' name="rr_min_date" value=<%=rRateMinDate%>>
		<input type="hidden" id='rr_low' name="rr_low" value=<%=rRateLow%>>
		<input type="hidden" id='rr_high' name="rr_high" value=<%=rRateHigh%>>
		<input type="hidden" id='rr_max_val' name="rr_max_val" value=<%=rRateMaxResult%>>
		<input type="hidden" id='rr_min_val' name="rr_min_val" value=<%=rRateMinResult%>>
		

		<input type="hidden" id='lactate_max_date' name="lactate_max_date" value=<%=lactateMaxDate%>>
		<input type="hidden" id='lactate_min_date' name="lactate_min_date" value=<%=lactateMinDate%>>
		<input type="hidden" id='lactate_low' name="lactate_low" value=<%=lactateLow%>>
		<input type="hidden" id='lactate_high' name="lactate_high" value=<%=lactateHigh%>>
		<input type="hidden" id='lactate_max_val' name="lactate_max_val" value=<%=lactateMaxResult%>>
		<input type="hidden" id='lactate_min_val' name="lactate_min_val" value=<%=lactateMinResult%>>
		
		<input type="hidden" id='phosphorus_max_date' name="phosphorus_max_date" value=<%=phosphorusMaxDate%>>
		<input type="hidden" id='phosphorus_min_date' name="phosphorus_min_date" value=<%=phosphorusMinDate%>>
		<input type="hidden" id='phosphorus_low' name="phosphorus_low" value=<%=phosphorusLow%>>
		<input type="hidden" id='phosphorus_high' name="phosphorus_high" value=<%=phosphorusHigh%>>
		<input type="hidden" id='phosphorus_max_val' name="phosphorus_max_val" value=<%=phosphorusMaxResult%>>
		<input type="hidden" id='phosphorus_min_val' name="phosphorus_min_val" value=<%=phosphorusMinResult%>>
		

		 <input type="hidden" id='magnesium_max_date' name="magnesium_max_date" value=<%=magnesiumMaxDate%>>
		<input type="hidden" id='magnesium_min_date' name="magnesium_min_date" value=<%=magnesiumMinDate%>>
		<input type="hidden" id='magnesium_low' name="magnesium_low" value=<%=magnesiumLow%>>
		<input type="hidden" id='magnesium_high' name="magnesium_high" value=<%=magnesiumHigh%>>
		<input type="hidden" id='magnesium_max_val' name="magnesium_max_val" value=<%=magnesiumMaxResult%>>
		<input type="hidden" id='magnesium_min_val' name="magnesium_min_val" value=<%=magnesiumMinResult%>>
		
		
		<input type="hidden" id='cholesterol_max_date' name="cholesterol_max_date" value=<%=cholesterolMaxDate%>>
		<input type="hidden" id='cholesterol_min_date' name="cholesterol_min_date" value=<%=cholesterolMinDate%>>
		<input type="hidden" id='cholesterol_low' name="cholesterol_low" value=<%=cholesterolLow%>>
		<input type="hidden" id='cholesterol_high' name="cholesterol_high" value=<%=cholesterolHigh%>>
		<input type="hidden" id='cholesterol_max_val' name="cholesterol_max_val" value=<%=cholesterolMaxResult%>>
		<input type="hidden" id='cholesterol_min_val' name="cholesterol_min_val" value=<%=cholesterolMinResult%>>
		
		<input type="hidden" id='dehydration_creat_date' name="dehydration_creat_date" value=<%=dehydrationCreatDate%>>
		<input type="hidden" id='dehydration_bun_date' name="dehydration_bun_date" value=<%=dehydrationBunDate%>>
		<input type="hidden" id='creatinine_val' name="creatinine_val" value=<%=creatinineValue%>>
		<input type="hidden" id='bun_val' name="bun_val" value=<%=bunValue%>>
		
		
	<div id="top"
		style="position: absolute; top: 0px; height: 100px; font-family: verdana, arial, sans-serif;">
		<script type="text/javascript">
			var widthTop = screen.width ;
			var div = document.getElementById("top");
			div.style.width = widthTop + "px";
		</script>

		<div id="top_left" style="width: 200px; margin-top: 10px; margin-left: -300px;">
			<h2 align="left">ED checklist of Co-Morbidities</h2>
		</div>

		<div id="top_right" style="position:relative; margin-left: 400px; margin-top: 20px;">

			
			<a href="#lightbox1" rel="lightbox1" class="lbOn">
			<input type="image" title="HELP" id="comorb" name="Co-Morbidities" src="images/help.png"
				style="width: 36px; height: 36px; margin-left: 80px;"
				value="Co-Morbidities"> </a> 
				
				
		<!-- DEbugger @author Shaili Kapoor  -->

			<a href="#lightbox2" rel="lightbox2" class="lbOn">
			<input type="image" title="VALUE LIST" id="list" name="list" src="images/notebook.png"
				style="width: 36px; height: 36px; margin-left: 80px;"
				value="values"></a>
		 		

			 <input type="image" title="PDF" id='printer'
				name="printer" src="images/pdf_icon.png"
				style="width: 36px; height: 36px; margin-left: 80px;" value="printing"
				onClick="printPage()">
			
				
				
				<input type="image" title="commit" id='printer'
				name="printer" src="images/commit.png"
				style="width: 36px; height: 36px; margin-left: 80px;" value="commit"
				onClick="commitPage()">
			
				
				
				
				
			<!--	
			<input type="image" title="jump2" id="stubjump2"
				name="jump2" src="images/pdf_icon.png"
				style="width: 36px; height: 36px; margin-left: 80px;" value="print"
				onClick="window.location.href = 'http://www.mybrowserinfo.com'">
			-->
			<!--  pdf support bug workaround: if we don't have active pdf component, opening
			pdf page sometimes works wrong. We can't update server IE or adoble pdf, so I did this. -->
			<iframe src="blank.pdf" width="20" height="20" style="display:none">
			</iframe>
		</div>
	</div>

	<div id="bottom"
		style="position: absolute; top: 100px; height: 1400px;">

		<script type="text/javascript">
			var widthBottom = screen.width - 50;
			var div = document.getElementById("bottom");
			div.style.width = widthBottom + "px";
		</script>
	<!-- 
	I-frame consisting of the forwarddata.jsp
	
	 -->	
		<!--
		src="http://localhost:8080/CoMorbidities/forwardData.jsp" 
		src="http://uhmc-ed-admitd.uhmc.sunysb.edu:8080/CoMorbidities/forwardData.jsp"-->
		
		<iframe id="mainPageID" name="mainPage"
			src="forwardData.jsp"
			scrolling="auto" style="visibility: visible; position: absolute; height: 1400px; width: 85%; margin-left: -25px">
		</iframe>
		

	</div>

<!-- DEbugger @author Shaili Kapoor  -->


 	<!-- LightBox 2 stuff -->
 	 
	<div id="lightbox2" class="lightbox">

	<a href="#" class="lbAction" rel="deactivate" ><input
	type="image" src="images/close.png" name="close" id="close" style="float: right; width: 32px; height: 32px;"/> </a>
		
		<table border="1" style="width:800px;" cellpadding="10">
		<tr>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Sodium</strong></p>
			Max Date: <input id='sodium_max_date' name="sodium_max_date" value=<%=sodiumMaxDateConsidered%>><br/>
			Min Date: <input id='sodium_min_date' name="sodium_min_date" value=<%=sodiumMinDateConsidered%>><br/>
			Low: <input id='sodium_low' name="sodium_low" value=<%=sodiumLowConsidered%>><br/>
			High: <input id='sodium_high' name="sodium_high" value=<%=sodiumHighConsidered%>><br/>
			Max Result: <input id='sodium_max_val' name="sodium_max_val" value=<%=sodiumMaxResultConsidered%>><br/>
			Min Result: <input id='sodium_min_val' name="sodium_min_val" value=<%=sodiumMinResultConsidered%>><br/>
			</td>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Potassium</strong></p>
			Max Date: <input id='potassium_max_date' name="potassium_max_date" value=<%=potassiumMaxDateConsidered%>><br/>
			Min Date: <input id='potassium_min_date' name="potassium_min_date" value=<%=potassiumMinDateConsidered%>><br/>
			Low: <input id='potassium_low' name="potassium_low" value=<%=potassiumLowConsidered%>><br/>
			High: <input id='potassium_high' name="potassium_high" value=<%=potassiumHighConsidered%>><br/>
			Max Result: <input id='potassium_max_val' name="potassium_max_val" value=<%=potassiumMaxResultConsidered%>><br/>
			Min Result: <input id='potassium_min_val' name="potassium_min_val" value=<%=potassiumMinResultConsidered%>><br/>
			</td>		
		</tr>
		<tr>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Calcium</strong></p>
			Max Date : <input type="text" id='calcium_max_date' name="calcium_max_date" value=<%=calciumMaxDate%>><br/>
			Min Date : <input type="text" id='calcium_min_date' name="calcium_min_date" value=<%=calciumMinDate%>><br/>
			Low : <input type="text" id='calcium_low' name="calcium_low" value=<%=calciumLow%>><br/>
			High : <input  type="text" id='calcium_high' name="calcium_high" value=<%=calciumHigh%>><br/>
			Max Result : <input  type="text" id='calcium_max_val' name="calcium_max_val" value=<%=calciumMaxResult%>><br/>
			Min Result : <input  type="text" id='calcium_min_val' name="calcium_min_val" value=<%=calciumMinResult%>><br/>
			</td>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Glucose</strong></p>
			Max Date: <input  id='glucose_max_date' name="glucose_max_date" value=<%=glucMaxDateConsidered%>><br/>
			Min Date: <input  id='glucose_min_date' name="glucose_min_date" value=<%=glucMinDateConsidered%>><br/>
			Low: <input  id='glucose_low' name="glucose_low" value=<%=glucLowConsidered%>><br/>
			High: <input  id='glucose_high' name="glucose_high" value=<%=glucHighConsidered%>><br/>
			Max Result: <input  id='glucose_max_val' name="glucose_max_val" value=<%=glucMaxResultConsidered%>><br/>
			Min Result: <input  id='glucose_min_val' name="glucose_min_val" value=<%=glucMinResultConsidered%>><br/>
			</td>
 		</tr>
 		<tr>
	 		<td>
	 		<p style="text-align:center; margin-bottom:5px;"><strong>Phosphorus</strong></p>
	 		Max Date : <input type="text" id='phosphorus_max_date' name="phosphorus_max_date" value=<%=phosphorusMaxDate%>><br/>
			Min Date : <input type="text" id='phosphorus_min_date' name="phosphorus_min_date" value=<%=phosphorusMinDate%>><br/>
			Low : <input type="text" id='phosphorus_low' name="phosphorus_low" value=<%=phosphorusLow%>><br/>
			High : <input  type="text" id='phosphorus_high' name="phosphorus_high" value=<%=phosphorusHigh%>><br/>
			Max Result : <input  type="text" id='phosphorus_max_val' name="phosphorus_max_val" value=<%=phosphorusMaxResult%>><br/>
			Min Result : <input  type="text" id='phosphorus_min_val' name="phosphorus_min_val" value=<%=phosphorusMinResult%>><br/>
			</td>
	 		<td>
	 		<p style="text-align:center; margin-bottom:5px;"><strong>Magnesium</strong></p>
	 		Max Date : <input type="text" id='magnesium_max_date' name="magnesium_max_date" value=<%=magnesiumMaxDate%>><br/>
			Min Date : <input type="text" id='magnesium_min_date' name="magnesium_min_date" value=<%=magnesiumMinDate%>><br/>
			Low : <input type="text" id='magnesium_low' name="magnesium_low" value=<%=magnesiumLow%>><br/>
			High : <input  type="text" id='magnesium_high' name="magnesium_high" value=<%=magnesiumHigh%>><br/>
			Max Result : <input  type="text" id='magnesium_max_val' name="magnesium_max_val" value=<%=magnesiumMaxResult%>><br/>
			Min Result : <input  type="text" id='magnesium_min_val' name="magnesium_min_val" value=<%=magnesiumMinResult%>><br/>
	 		</td> 		
 		</tr>
 		<tr>
	 		<td>
	 		<p style="text-align:center; margin-bottom:5px;"><strong>Weight</strong></p>
			Max Date : <input type="text" id='weight_max_date' name="weight_max_date" value=<%=weightMaxDate%>><br/>
			Min Date : <input type="text" id='weight_min_date' name="weight_min_date" value=<%=weightMinDate%>><br/>
			Max Result : <input type="text" id='weight_max_val' name="weight_max_val" value=<%=weightMaxResult%>><br/>
			Min Result : <input type="text" id='weight_min_val' name="weight_min_val" value=<%=weightMinResult%>><br/>
			 </td>
			 <td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Height</strong></p>
			Max Date : <input type="text" id='height_max_date' name="height_max_date" value=<%=heightMaxDate%>><br/>
			Min Date : <input type="text" id='height_min_date' name="height_min_date" value=<%=heightMinDate%>><br/>
			Max Result : <input type="text" id='height_max_val' name="height_max_val" value=<%=heightMaxResult%>><br/>
			Min Result : <input type="text" id='height_min_val' name="height_min_val" value=<%=heightMinResult%>><br/>
			</td>
		</tr>
		<tr>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Diastolic BP</strong></p>
			Max Date : <input type="text" id='Diastolic_Blood_Pressure_max_date' name="Diastolic_Blood_Pressure_max_date" value=<%=diasBPMaxDate%>><br/>
			Min Date : <input type="text" id='Diastolic_Blood_Pressure_min_date' name="Diastolic_Blood_Pressure_min_date" value=<%=diasBPMinDate%>><br/>
			Low : <input type="text" id='Diastolic_Blood_Pressure_low' name="Diastolic_Blood_Pressure_low" value=<%=diasBPLow%>><br/>
			High : <input type="text" id='Diastolic_Blood_Pressure_high' name="Diastolic_Blood_Pressure_high" value=<%=diasBPHigh%>><br/>
			Max Result : <input type="text" id='Diastolic_Blood_Pressure_max_val' name="Diastolic_Blood_Pressure_max_val" value=<%=diasBPMaxResult%>><br/>
			Min Result : <input type="text" id='Diastolic_Blood_Pressure_min_val' name="Diastolic_Blood_Pressure_max_val" value=<%=diasBPMinResult%>><br/>
			 </td>
			 <td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Systolic BP</strong></p>
			Max Date : <input type="text" id='Systolic_Blood_Pressure_max_date' name="Systolic_Blood_Pressure_max_date" value=<%=sysBPMaxDate%>><br/>
			Min Date : <input type="text" id='Systolic_Blood_Pressure_min_date' name="Systolic_Blood_Pressure_min_date" value=<%=sysBPMinDate%>><br/>
			Low : <input type="text" id='Systolic_Blood_Pressure_low' name="Systolic_Blood_Pressure_low" value=<%=sysBPLow%>><br/>
			High : <input type="text" id='Systolic_Blood_Pressure_high' name="Systolic_Blood_Pressure_high" value=<%=sysBPHigh%>><br/>
			Max Result : <input type="text" id='Systolic_Blood_Pressure_max_val' name="Systolic_Blood_Pressure_max_val" value=<%=sysBPMaxResult%>><br/>
			Min Result : <input type="text" id='Systolic_Blood_Pressure_min_val' name="Systolic_Blood_Pressure_min_val" value=<%=sysBPMinResult%>><br/>
			</td>
		</tr>		
		<tr>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>PCO2</strong></p>
			Max Date : <input type="text" id='pco2_max_date' name="pco2_max_date" value=<%=pco2MaxDate%>><br/>
			Min Date : <input type="text" id='pco2_min_date' name="pco2_min_date" value=<%=pco2MinDate%>><br/>
			Low : <input type="text" id='pco2_low' name="pco2_low" value=<%=pco2Low%>><br/>
			High : <input  type="text" id='pco2_high' name="pco2_high" value=<%=pco2High%>><br/>
			Max Result : <input  type="text" id='pco2_max_val' name="pco2_max_val" value=<%=pco2MaxResult%>><br/>
			Min Result : <input  type="text" id='pco2_min_val' name="pco2_min_val" value=<%=pco2MinResult%>><br/>
			</td>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>O2SAT</strong></p>
			Max Date : <input type="text" id='o2sat_max_date' name="o2sat_max_date" value=<%=o2satMaxDate%>><br/>
			Min Date : <input type="text" id='o2sat_min_date' name="o2sat_min_date" value=<%=o2satMinDate%>><br/>
			Low : <input type="text" id='o2sat_low' name="o2sat_low" value=<%=o2satLow%>><br/>
			High : <input  type="text" id='o2sat_high' name="o2sat_high" value=<%=o2satHigh%>><br/>
			Max Result : <input  type="text" id='o2sat_max_val' name="o2sat_max_val" value=<%=o2satMaxResult%>><br/>
			Min Result : <input  type="text" id='o2sat_min_val' name="o2sat_min_val" value=<%=o2satMinResult%>><br/>
			</td>	
		</tr>
		<tr>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>BUN</strong></p>
			Max Date: <input id='bun_max_date' name="bun_max_date" value=<%=bunMaxDateConsidered%>><br/>
			Min Date: <input id='bun_min_date' name="bun_min_date" value=<%=bunMinDateConsidered%>><br/>
			Low: <input id='bun_low' name="bun_low" value=<%=bunLowConsidered%>><br/>
			High: <input id='bun_high' name="bun_high" value=<%=bunHighConsidered%>><br/>
			Max Result: <input id='bun_max_val' name="bun_max_val" value=<%=bunMaxResultConsidered%>><br/>
			Min Result: <input id='bun_min_val' name="bun_min_val" value=<%=bunMinResultConsidered%>><br/>	
			 </td>
			 <td>
	       <p style="text-align:center; margin-bottom:5px;"><strong>GFR</strong></p>
			 Max Date: <input id='gfr_max_date' name="gfr_max_date" value=<%=gfrMaxDate%>><br/>
			Min Date: <input id='gfr_min_date' name="gfr_min_date" value=<%=gfrMinDate%>><br/>
			
			Max Result: <input id='gfr_max_val' name="gfr_max_val" value=<%=gfrMaxResult%>><br/>
			Min Result: <input id='gfr_min_val' name="gfr_min_val" value=<%=gfrMinResult%>><br/> 
			</td>
		</tr>
		<tr>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Creatinine</strong></p>
			Max Date: <input id='creat_max_date' name="creat_max_date" value=<%=creatMaxDateConsidered%>><br/>
			Min Date: <input id='creat_min_date' name="creat_min_date" value=<%=creatMinDateConsidered%>><br/>
			Low: <input id='creat_low' name="creat_low" value=<%=creatLowConsidered%>><br/>
			High: <input id='creat_high' name="creat_high" value=<%=creatHighConsidered%>><br/>
			Max Result: <input id='creat_max_val' name="creat_max_val" value=<%=creatMaxResultConsidered%>><br/>
			Min Result: <input id='creat_min_val' name="creat_min_val" value=<%=creatMinResultConsidered%>><br/>
			 </td>
			 <td>
			 <p style="text-align:center; margin-bottom:5px;"><strong>Previous Creatinine</strong></p>
			Max Date: <input id='creat_prev_max_date' name="creat_prev_max_date" value=<%=prevCreatMaxDateConsidered%>><br/>
			Min Date: <input id='creat_prev_min_date' name="creat_prev_min_date" value=<%=prevCreatMinDateConsidered%>><br/>
			Low: <input id='creat_prev_low' name="creat_prev_low" value=<%=prevCreatLowConsidered%>><br/>
			High: <input id='creat_prev_high' name="creat_prev_high" value=<%=prevCreatHighConsidered%>><br/>
			Max Result: <input id='creat_prev_max_val' name="creat_prev_max_val" value=<%=prevCreatMaxResultConsidered%>><br/>
			Min Result: <input id='creat_prev_min_val' name="creat_prev_min_val" value=<%=prevCreatMinResultConsidered%>><br/>
			
			</td>
		</tr>
		<tr>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Hemoglobin</strong></p>
			Max Date: <input id='hb_max_date' name="hb_max_date" value=<%=hbMaxDate%>><br/>
			Min Date: <input id='hb_min_date' name="hb_min_date" value=<%=hbMinDate%>><br/>
			Low: <input id='hb_low' name="hb_low" value=<%=hbLow%>><br/>
			High: <input id='hb_high' name="hb_high" value=<%=hbHigh%>><br/>
			Max Result: <input id='hb_max_val' name="hb_max_val" value=<%=hbMaxResult%>><br/>
			Min Result: <input id='hb_min_val' name="hb_min_val" value=<%=hbMinResult%>><br/>
			 </td>
			 <td>
			 <p style="text-align:center; margin-bottom:5px;"><strong>Previous Hemoglobin</strong></p>
			Max Date: <input id='hb_prev_max_date' name="hb_prev_max_date" value=<%=hbPrevMaxDate%>><br/>
			Min Date: <input id='hb_prev_min_date' name="hb_prev_min_date" value=<%=hbPrevMinDate%>><br/>
			Low: <input id='hb_prev_low' name="hb_prev_low" value=<%=hbPrevLow%>><br/>
			High: <input id='hb_prev_high' name="hb_prev_high" value=<%=hbPrevHigh%>><br/>
			Max Result: <input id='hb_prev_max_val' name="hb_prev_max_val" value=<%=hbPrevMaxResult%>><br/>
			Min Result: <input id='hb_prev_min_val' name="hb_prev_min_val" value=<%=hbPrevMinResult%>><br/>
			</td>
		</tr>
		<tr>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Hematocrit</strong></p>
			Max Date: <input id='hc_max_date' name="hc_max_date" value=<%=hcMaxDate%>><br/>
			Min Date: <input id='hc_min_date' name="hc_min_date" value=<%=hcMinDate%>><br/>
			Low: <input id='hc_low' name="hc_low" value=<%=hcLow%>><br/>
			High: <input id='hc_high' name="hc_high" value=<%=hcHigh%>><br/>
			Max Result: <input id='hc_max_val' name="hc_max_val" value=<%=hcMaxResult%>><br/>
			Min Result: <input id='hc_min_val' name="hc_min_val" value=<%=hcMinResult%>><br/>
			 </td>
			 <td>
			 <p style="text-align:center; margin-bottom:5px;"><strong>Previous Hematocrit</strong></p>
			Max Date: <input id='hc_prev_max_date' name="hc_prev_max_date" value=<%=hcPrevMaxDate%>><br/>
			Min Date: <input id='hc_prev_min_date' name="hc_prev_min_date" value=<%=hcPrevMinDate%>><br/>
			Low: <input id='hc_prev_low' name="hc_prev_low" value=<%=hcPrevLow%>><br/>
			High: <input id='hc_prev_high' name="hc_prev_high" value=<%=hcPrevHigh%>><br/>
			Max Result: <input id='hc_prev_max_val' name="hc_prev_max_val" value=<%=hcPrevMaxResult%>><br/>
			Min Result: <input id='hc_prev_min_val' name="hc_prev_min_val" value=<%=hcPrevMinResult%>><br/>
			</td>
		</tr>
		<tr>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Wbc</strong></p>
			Max Date: <input  name="wbc_max_date" value=<%=wbcMaxDate%>><br/>
			Min Date: <input  name="wbc_min_date" value=<%=wbcMinDate%>><br/>
			Low: <input  name="wbc_low" value=<%=wbcLow%>><br/>
			High: <input  name="wbc_high" value=<%=wbcHigh%>><br/>
			Max Result: <input  name="wbc_max_val" value=<%=wbcMaxResult%>><br/>
			Min Result: <input  name="wbc_min_val" value=<%=wbcMinResult%>><br/>
			</td>
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>Uti WBC</strong></p>
			Max Date: <input  name="utiWbc_max_date" value=<%=utiWbcMaxDate%>><br/>
			Min Date: <input  name="utiWbc_min_date" value=<%=utiWbcMinDate%>><br/>
			Low: <input  name="utiWbc_low" value=<%=utiWbcLow%>><br/>
			High: <input  name="utiWbc_high" value=<%=utiWbcHigh%>><br/>
			Max Result: <input  name="utiWbc_max_val" value=<%=utiWbcMaxResult%>><br/>
			Min Result: <input  name="utiWbc_min_val" value=<%=utiWbcMinResult%>><br/>
			 </td>
		</tr>
		<tr>	
		<td>	
		<p style="text-align:center; margin-bottom:5px;"><strong>Cardiac Troponin</strong></p>
		Max date: <input id='cardiac_troponin_max_date' name="cardiac_troponin_max_date" value=<%=ctMaxDate%>><br/>
		Min Date: <input id='cardiac_troponin_min_date' name="cardiac_troponin_min_date" value=<%=ctMinDate%>><br/>
		Low: <input  name="cardiac_troponin_low" value=<%=ctLow%>><br/>
		High: <input  name="cardiac_troponin_high" value=<%=ctHigh%>><br/>
		Max Result: <input  name="cardiac_troponin_max_val" value=<%=ctMaxResult%>><br/>
		Min Result: <input  name="cardiac_troponin_min_val" value=<%=ctMinResult%>><br/>
		</td>
		<td>
		<p style="text-align:center; margin-bottom:5px;"><strong>Leukocyte Esterase</strong></p>
		Max Date: <input  id='leucocyte_esterate_max_date' name="leucocyte_esterate_max_date" value=<%=urinestMaxDate%>><br/>
		Min Date: <input  id='leucocyte_esterate_min_date' name="leucocyte_esterate_min_date" value=<%=urinestMinDate%>><br/>
		Low: <input  id='leucocyte_esterate_low' name="leucocyte_esterate_low" value=<%=urinestLow%>><br/>
		High: <input  id='leucocyte_esterate_high' name="leucocyte_esterate_high" value=<%=urinestHigh%>><br/>
		Max Result: <input  id='leucocyte_esterate_max_val' name="leucocyte_esterate_max_val" value=<%=urinestMaxResult%>><br/>
		Min Result: <input  id='leucocyte_esterate_min_val' name="leucocyte_esterate_min_val" value=<%=urinestMinResult%>><br/>
		 </td>
		 
		</tr>
		<tr>
	<td>
	<p style="text-align:center; margin-bottom:5px;"><strong>Temperature</strong></p>
		Max Date: <input  id='temp_max_date' name="temp_max_date" value=<%=tempMaxDate%>><br/>
		Min Date: <input  id='temp_min_date' name="temp_min_date" value=<%=tempMinDate%>><br/>
		Low: <input  id='temp_low' name="temp_low" value=<%=tempLow%>><br/>
		High: <input  id='temp_high' name="temp_high" value=<%=tempHigh%>><br/>
		Max Result: <input  id='temp_max_val' name="temp_max_val" value=<%=tempMaxResult%>><br/>
		Min Result: <input  id='temp_min_val' name="temp_min_val" value=<%=tempMinResult%>><br/>
		</td>
		<td> 
		<p style="text-align:center; margin-bottom:5px;"><strong>Heart Rate</strong></p>
		Max Date: <input  id='hr_max_date' name="hr_max_date" value=<%=hRateMaxDate%>><br/>
		Min Date: <input  id='hr_min_date' name="hr_min_date" value=<%=hRateMinDate%>><br/>
		Low: <input  id='hr_low' name="hr_low" value=<%=hRateLow%>><br/>
		High: <input  id='hr_high' name="hr_high" value=<%=hRateHigh%>><br/>
		Max Result: <input  id='hr_max_val' name="hr_max_val" value=<%=hRateMaxResult%>><br/>
		Min Result: <input  id='hr_min_val' name="hr_min_val" value=<%=hRateMinResult%>><br/>
		</td>
		</tr>
		<tr> 
		<td>
		<p style="text-align:center; margin-bottom:5px;"><strong>Resp Rate</strong></p>
		Max Date: <input   id='rr_max_date' name="rr_max_date" value=<%=rRateMaxDate%>><br/>
		Min Date: <input   id='rr_min_date' name="rr_min_date" value=<%=rRateMinDate%>><br/>
		Low: <input   id='rr_low' name="rr_low" value=<%=rRateLow%>><br/>
		High: <input   id='rr_high' name="rr_high" value=<%=rRateHigh%>><br/>
		Max Result: <input   id='rr_max_val' name="rr_max_val" value=<%=rRateMaxResult%>><br/>
		Min Result: <input   id='rr_min_val' name="rr_min_val" value=<%=rRateMinResult%>><br/>
		 </td>
		 <td>
		 <p style="text-align:center; margin-bottom:5px;"><strong>Lactate</strong></p>
		Max Date: <input   id='lactate_max_date' name="lactate_max_date" value=<%=lactateMaxDate%>><br/>
		Min Date: <input   id='lactate_min_date' name="lactate_min_date" value=<%=lactateMinDate%>><br/>
		Low: <input   id='lactate_low' name="lactate_low" value=<%=lactateLow%>><br/>
		High: <input   id='lactate_high' name="lactate_high" value=<%=lactateHigh%>><br/>
		Max Result: <input   id='lactate_max_val' name="lactate_max_val" value=<%=lactateMaxResult%>><br/>
		Min Result: <input   id='lactate_min_val' name="lactate_min_val" value=<%=lactateMinResult%>><br/>
		</td>		
		</tr>
		<tr>
		<td>
		<p style="text-align:center; margin-bottom:5px;"><strong>Lactic Acid</strong></p>
		Max Date: <input id='lactic_acid_max_date' name="lactic_acid_max_date" value=<%=lactic_acidMaxDateConsidered%>>
        Min Date: <input id='lactic_acid_min_date' name="lactic_acid_min_date" value=<%=lactic_acidMinDateConsidered%>>
        Max result: <input id='lactic_acid_max_val' name="lactic_acid_max_val" value=<%=lactic_acidMaxResultConsidered%>>
        Min Result: <input id='lactic_acid_min_val'name="lactic_acid_min_val" value=<%=lactic_acidMinResultConsidered%>>		
        Low: 	<input id='lactic_acid_low'name="lactic_acid_low" value=<%=lactic_acidLowConsidered%>>
        High: 	<input id='lactic_acid_high'name="lactic_acid_high" value=<%=lactic_acidHighConsidered%>>
		 </td>
		 <td>
		 <p style="text-align:center; margin-bottom:5px;"><strong>Cholesterol</strong></p>
		Max Date: <input   id='cholesterol_max_date' name="cholesterol_max_date" value=<%=cholesterolMaxDate%>><br/>
		Min Date: <input   id='cholesterol_min_date' name="cholesterol_min_date" value=<%=cholesterolMinDate%>><br/>
		Low: <input   id='cholesterol_low' name="cholesterol_low" value=<%=cholesterolLow%>><br/>
		High: <input   id='cholesterol_high' name="cholesterol_high" value=<%=cholesterolHigh%>><br/>
		Max Result: <input   id='cholesterol_max_val' name="cholesterol_max_val" value=<%=cholesterolMaxResult%>><br/>
		Min Result: <input   id='cholesterol_min_val' name="cholesterol_min_val" value=<%=cholesterolMinResult%>><br/>
		</td>		 
		</tr>
		<tr>
		<td>
		<p style="text-align:center; margin-bottom:5px;"><strong>Neutrophil</strong></p>
		Max Date: <input   id='neutrophil_max_date' name="neutrophil_max_date" value=<%=neutrophilMaxDate%>><br/>
		Min Date: <input   id='neutrophil_min_date' name="neutrophil_min_date" value=<%=neutrophilMinDate%>><br/>
		Low: <input   id='neutrophil_low' name="neutrophil_low" value=<%=neutrophilLow%>><br/>
		High: <input   id='neutrophil_high' name="neutrophil_high" value=<%=neutrophilHigh%>><br/>
		Max Result: <input   id='neutrophil_max_val' name="neutrophil_max_val" value=<%=neutrophilMaxResult%>><br/>
		Min Result: <input   id='neutrophil_min_val' name="neutrophil_min_val" value=<%=neutrophilMinResult%>><br/>
		</td>
		 <td>
		 <p style="text-align:center; margin-bottom:5px;"><strong>Leukocyte Nitrite</strong></p>
		Max Date: <input  id='leucocyte_nitrite_max_date' name="leucocyte_nitrite_max_date" value=<%=uriniMaxDate%>><br/>
		Min Date: <input  id='leucocyte_nitrite_min_date' name="leucocyte_nitrite_min_date" value=<%=uriniMinDate%>><br/>
		Low: <input  id='leucocyte_nitrite_low' name="leucocyte_nitrite_low" value=<%=uriniLow%>><br/>
		High: <input  id='leucocyte_nitrite_high' name="leucocyte_nitrite_high" value=<%=uriniHigh%>><br/>
		Max Result: <input  id='leucocyte_nitrite_max_val' name="leucocyte_nitrite_max_val" value=<%=uriniMaxResult%>><br/>
		Min Result: <input  id='leucocyte_nitrite_min_val' name="leucocyte_nitrite_min_val" value=<%=uriniMinResult%>><br/>
		</td>
		</tr>
		<tr>
		<td>
			<p style="text-align:center; margin-bottom:5px;"><strong>PO2</strong></p>
			Max Date : <input type="text" id='po2_max_date' name="po2_max_date" value=<%=po2MaxDate%>><br/>
			Min Date : <input type="text" id='po2_min_date' name="po2_min_date" value=<%=po2MinDate%>><br/>
			Low : <input type="text" id='po2_low' name="po2_low" value=<%=po2Low%>><br/>
			High : <input  type="text" id='po2_high' name="po2_high" value=<%=po2High%>><br/>
			Max Result : <input  type="text" id='po2_max_val' name="po2_max_val" value=<%=po2MaxResult%>><br/>
			Min Result : <input  type="text" id='po2_min_val' name="po2_min_val" value=<%=po2MinResult%>><br/>
			</td>	
			<td>
			<p style="text-align:center; margin-bottom:5px;"><strong><font color="white">End of Data</font></strong></p>
			</td>
		</tr>		
		</table>	
	</div>
	
	
	<!-- LightBox1 stuff -->
	<div id="lightbox1" class="lightbox">
	<script type="text/javascript">

			/***********************************************
			* Dynamic Ajax Content- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
			* This notice MUST stay intact for legal use
			* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
			***********************************************/
			
			var bustcachevar=1 ;//bust potential caching of external pages after initial request? (1=yes, 0=no)
			var loadedobjects="";
			var rootdomain="http://"+window.location.hostname;
			var bustcacheparameter="";
		
			function ajaxpage(url, containerid)
			{
				var page_request = false;
				if (window.XMLHttpRequest) // if Mozilla, Safari etc
					page_request = new XMLHttpRequest();
				else 
				if (window.ActiveXObject)
				{ // if IE
					try 
					{
						page_request = new ActiveXObject("Msxml2.XMLHTTP");
					} 
					catch (e)
					{	
						try
						{
							page_request = new ActiveXObject("Microsoft.XMLHTTP");
						}
						catch (e)
						{
							alert("Can't create page request");
							return false;
						}
					}
				}
				else
					return false;
				
				page_request.onreadystatechange=function(){ loadpage(page_request, containerid); };
				
				if (bustcachevar) //if bust caching of external page
					bustcacheparameter=(url.indexOf("?")!=-1)? "&"+new Date().getTime() : "?"+new Date().getTime();
				page_request.open('GET', url+bustcacheparameter, true);
				page_request.send(null);
			}
			
			function loadpage(page_request, containerid)
			{
				if (page_request.readyState == 4 && (page_request.status==200 || window.location.href.indexOf("http")==-1))
					document.getElementById(containerid).innerHTML=page_request.responseText;
			}
			
			function loadobjs()
			{
				if (!document.getElementById)
					return;
				for (var i=0; i<arguments.length; i++)
				{
					var file=arguments[i];
					var fileref="";
					if (loadedobjects.indexOf(file)==-1)
					{ //Check to see if this object has not already been added to page before proceeding
						if (file.indexOf(".js")!=-1)
						{ //If object is a js file
							fileref=document.createElement('script');
							fileref.setAttribute("type","text/javascript");
							fileref.setAttribute("src", file);
						}
						else if (file.indexOf(".css")!=-1)
						{ //If object is a css file
							fileref=document.createElement("link");
							fileref.setAttribute("rel", "stylesheet");
							fileref.setAttribute("type", "text/css");
							fileref.setAttribute("href", file);
						}
					}
					if (fileref!="")
					{
						document.getElementsByTagName("head").item(0).appendChild(fileref);
						loadedobjects+=file+" "; //Remember this object as being already added to page
					}
				}
			}
	</script>


		<a href="#" class="lbAction" rel="deactivate" >
		<input type="image" src="images/close.png" name="close" id="close" style="float: right; width: 32px; height: 32px;"/> </a>

		<div id="lightbox_left">
		<ul>
		<li style="margin-bottom: 20px;">
		<a id="displayText" href="javascript:toggle();">Comorbidities Rules</a>
			<ul id="toggleText" style="display: none"><br><br>
				<li><a href="javascript:ajaxpage('html/anemia.html', 'lightbox_right');">Anemia<br><br></a></li>
					
				<li><a href="javascript:ajaxpage('html/acuteKidney.html', 'lightbox_right');">Acute Kidney Injury<br><br></a></li>
				
				<li><a href="javascript:ajaxpage('html/cshock.html', 'lightbox_right');">Cardiogenic Shock<br><br></a></li>
				
				<li><a href="javascript:ajaxpage('html/chronicKidney.html', 'lightbox_right');">Chronic Kidney Disease<br><br></a></li>
				
				<li><a href="javascript:ajaxpage('html/diabetes.html', 'lightbox_right');">Diabetes &amp; Hyperglycemia<br><br></a></li>
				
				<li><a href="javascript:ajaxpage('html/dehydration.html', 'lightbox_right');">Dehydration<br><br></a></li>
				
				<li>Electrolyte Abnormality<br><br>
					<ul>
						<li><a href="javascript:ajaxpage('html/hypokalemia.html', 'lightbox_right');">Hypokalemia<br><br></a></li>
						<li><a href="javascript:ajaxpage('html/hyperkalemia.html', 'lightbox_right');">Hyperkalemia<br><br></a></li>
						<li><a href="javascript:ajaxpage('html/hyponatremia.html', 'lightbox_right');">Hyponatremia<br><br></a></li>
						<li><a href="javascript:ajaxpage('html/hypernatremia.html', 'lightbox_right');">Hypernatremia<br><br></a></li>
						<li><a href="javascript:ajaxpage('html/hypocalcemia.html', 'lightbox_right');">Hypocalcemia<br><br></a></li>
						<li><a href="javascript:ajaxpage('html/hypercalcemia.html', 'lightbox_right');">Hypercalcemia<br><br></a></li>
						<li><a href="javascript:ajaxpage('html/hypophosphatemia.html', 'lightbox_right');">HypoPhosphatemia<br><br></a></li>
						<li><a href="javascript:ajaxpage('html/hyperphosphatemia.html', 'lightbox_right');">HyperPhosphatemia<br><br></a></li>
						<li><a href="javascript:ajaxpage('html/hypomagnesemia.html', 'lightbox_right');">HypoMagnesemia<br><br></a></li>
						<li><a href="javascript:ajaxpage('html/hypermagnesemia.html', 'lightbox_right');">HyperMagnesemia<br><br></a></li>
					</ul>
				</li>
				<li><a href="javascript:ajaxpage('html/granulocytopenia.html', 'lightbox_right');">Granulocytopenia<br><br></a></li>
				<li><a href="javascript:ajaxpage('html/hyperCholesterolemia.html', 'lightbox_right');">HyperCholesterolemia<br><br></a></li>
				<li><a href="javascript:ajaxpage('html/hypoglycemia.html', 'lightbox_right');">Hypoglycemia<br><br></a></li>
				<li><a href="javascript:ajaxpage('html/hypoxia.html', 'lightbox_right');">Hypoxia<br><br></a></li>
				<li><a href="javascript:ajaxpage('html/lacticAcidosis.html', 'lightbox_right');">Lactic Acidosis<br><br></a></li>
				
				<li><a href="javascript:ajaxpage('html/hypertension.html', 'lightbox_right');">Hypertension<br><br></a></li>
				
				<li><a href="javascript:ajaxpage('html/malnutrition.html', 'lightbox_right');">Malnutrition<br><br></a></li>
				
				<li><a href="javascript:ajaxpage('html/mo.html', 'lightbox_right');">Morbid Obesity<br><br></a></li>
				
				<li><a href="javascript:ajaxpage('html/obsesity.html', 'lightbox_right');">Obesity<br><br></a></li>
				
				<li><a href="javascript:ajaxpage('html/acuteResp.html', 'lightbox_right');">Respiratory Failure<br><br></a></li>
				
				<li><a href="javascript:ajaxpage('html/shock.html', 'lightbox_right');">Shock</a><br><br></li>
				<li><a href="javascript:ajaxpage('html/sepsis.html', 'lightbox_right');">Sepsis</a><br><br></li>				
				<li><a href="javascript:ajaxpage('html/uti.html', 'lightbox_right');">UTI</a><br><br></li>
			
			</ul>
			</li>
			<li style="margin-bottom: 20px;">
			<a href="javascript:ajaxpage('html/HowToGuide.html', 'lightbox_right');">How To Guide</a>
			</li>
			</ul>
		</div>

		<div id="lightbox_right"></div>

	</div>

</body>
</html>