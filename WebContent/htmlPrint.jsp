<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Print</title>

<style type="text/css">

.mainborder{
width:1200px;
height:1200px;
border:5px solid black; 
margin-left: 100px; 
margin-top: 50px; 
scroll: auto;
border:hidden;
}

.main{
text-align:left; 
font-family: arial; 
font-size:25px;
font-weight: bold;
white-space:nowrap;
}

.sub{
text-align:left; 
font-family: arial; 
font-size:20px;
font-weight: normal;
}

.dt{
font-family: arial; 
font-size:20px;
font-weight: normal;
float: left;
}

td
{
border:hidden;
height: 100px;
text-align:center;
vertical-align:center;
width:33%
}

table tr:last-child td:last-child
{
vertical-align:bottom;
padding:15px;
font-family: arial; 
font-size:40px;
font-weight: bold;
}


</style>


</head>
<body>

<% 
String []mainGrp;

mainGrp = request.getParameterValues("mainGrp");
%>

<table height="100px" width="86%" style="margin-left:100px;">
   <tr>
    <td><img src="barcode.bmp" alt="barcode"></td>
   </tr>
  <tr>
    <td style="text-align:left;">CO-MORBIDITIES</td>
  </tr>
</table>

<div id="border" class="mainborder">

<%
if(mainGrp == null)
{
	out.print("No Co-Morbidities found");	
}
else
{
%>
<ul>
<%
	for (int i = 0; i < mainGrp.length; i++){
		
		if(mainGrp[i].equals("Anemia :")){%>
		<%
			String[] anemiaChkGrp = request.getParameterValues("anemiaChkGrp");
			String chHgloDate,chHglo,preChHglo,chHcrit,preChHcrit,chHcritDate,preChHgloDate,preChHcritDate,norHBLow,norHCLow,result;
			
			chHgloDate = request.getParameter("AnHgloDate");
			chHglo = request.getParameter("AnHglo");
			preChHgloDate = request.getParameter("preAnHgloDate");
			preChHglo = request.getParameter("preAnHglo");
            chHcritDate = request.getParameter("AnHcritDate");
			chHcrit = request.getParameter("AnHcrit");
			preChHcritDate = request.getParameter("preAnHcritDate");
			preChHcrit = request.getParameter("preAnHcrit");
			norHCLow = request.getParameter("normalHCLow");
			norHBLow = request.getParameter("normalHBLow");
			result = request.getParameter("result");

			for (int j = 0; j < anemiaChkGrp.length; j++){
				if(anemiaChkGrp[j].equals("Acute blood loss")){
		%>
					<li><div id="main" class="main">Anemia: Acute</div><br> 
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<%//if(result.isEmpty() != true && result.equalsIgnoreCase("1"))
					{
						if(chHglo.isEmpty() != true){
						out.print("Hemoglobin: " + "   " + chHglo + "   " + chHgloDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}	
					%> 
					<%if(preChHglo.isEmpty() != true){
						out.print("Previous Hemoglobin: " + "   " + preChHglo + "   " + preChHgloDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}
					%>
					<%if(chHcrit.isEmpty() != true){
						out.print("Hematocrit: " + "   " + chHcrit + "   " + chHcritDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}
					%> 
					<%if(preChHcrit.isEmpty() != true){
						out.print("Previous Hematocrit: " + "   " + preChHcrit + "   " + preChHcritDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}
					}
					%> 
					
					</div>
					
		<%
				} //Acute anemia check ends here
				else if(anemiaChkGrp[j].equals("Anemia: Chronic Disease")){
		%>
					<li><div id="main" class="main">Anemia: Chronic</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<%//if(result.isEmpty() != true && result.equalsIgnoreCase("3"))
					{
						if(chHglo.isEmpty() != true){
						out.print("Hemoglobin: " + "   " + chHglo + "   " + chHgloDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}	
					%> 
					<%if(preChHglo.isEmpty() != true){
						out.print("Previous Hemoglobin: " + "   " + preChHglo + "   " + preChHgloDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}
					%> 
					<%if(chHcrit.isEmpty() != true){
						out.print("Hematocrit: " + "   " + chHcrit + "   " + chHcritDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}
					%> 
					<%if(preChHcrit.isEmpty() != true){
						out.print("Previous Hematocrit: " + "   " + preChHcrit + "   " + preChHcritDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}
					}
					%>
					</div>
		<%								
				} //Chronic anemia check ends here
				else if(anemiaChkGrp[j].equals("Anemia: NOS")){
		%>
					<li><div id="main" class="main">Anemia: NOS</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<%//if(result.isEmpty() != true && result.equalsIgnoreCase("2"))
					{
						if(chHglo.isEmpty() != true){
						out.print("Hemoglobin: " + "   " + chHglo + "   " + chHgloDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}	
					%>
					<%if(preChHglo.isEmpty() != true){
						out.print("Previous Hemoglobin: " + "   " + preChHglo + "   " + preChHgloDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}
					%> 
					<%if(chHcrit.isEmpty() != true){
						out.print("Hematocrit: " + "   " + chHcrit + "   " + chHcritDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}
					%>
					<%if(preChHcrit.isEmpty() != true){
						out.print("Previous Hematocrit: " + "   " + preChHcrit + "   " + preChHcritDate);
						out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					}
					}
					%> 					
					</div>
		
		<%			
				} //NOS anemia check ends here
				else if(anemiaChkGrp[j].equals("Anemia: Blood Loss")){
					%>
								<li><div id="main" class="main">Due to Blood Loss</div><br>
								<div id="sub" class="sub">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<%
								out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
								%> 					
								</div>
					
					<%			
				} //Due to Blood Loss for anemia check ends here
			} //for loop of anemia ends here
		%>
		<%
			} // if condition check for anemia ends here
			
			else if(mainGrp[i].equals("Acute Kidney Injury")){
				String[] renFailChkGrp = request.getParameterValues("akiChkGrp");
				String CreatDate, Creat, PrevCreat, PrevCreatDate;
				CreatDate = request.getParameter("CreatDate");
				Creat = request.getParameter("Creat");
				PrevCreat = request.getParameter("CreatPrev"); 
				PrevCreatDate = request.getParameter("CreatPrevDate");
				for (int j = 0; j < renFailChkGrp.length; j++){
					if(renFailChkGrp[j].equalsIgnoreCase("Acute Kidney Injury :Acute")) {
			%>
						<li><div id="main" class="main">Kidney Injury: Acute</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			/*String rfaDate,rfaCreat, rfaPrevCreat, rfaPrevCreatDate;
			rfaDate = request.getParameter("AcrfaCreatDate");
			rfaCreat = request.getParameter("AcrfaCreat");
			rfaPrevCreat = request.getParameter("AcrfaCreatPrev"); 
			rfaPrevCreatDate = request.getParameter("AcrfaCreatPrevDate");*/
			if(CreatDate!=null && Creat!=null && PrevCreat!=null && PrevCreatDate!=null){
				if(PrevCreat.equalsIgnoreCase("-99999.0")!=true && PrevCreat.equalsIgnoreCase("99999.0")!=true){
					out.print("Creatinine: " + Creat + " " + CreatDate + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
					+ "Previous Creatinine: " + PrevCreat + " " + PrevCreatDate);
				}
				else{
					out.print("Creatinine: " + Creat + " " + CreatDate + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				}
			}//if condition ends here
			%>
			<br><br>
			</div>
			<br><br>
			<%
					}//if condition for acute kidney injury ends here
					else if(renFailChkGrp[j].equalsIgnoreCase("Acute Kidney Injury :NOS")) {
						/*String rfaDate,rfaCreat;
						rfaDate = request.getParameter("ChrfaCreatDate");
						rfaCreat = request.getParameter("ChrfaCreat");*/
			%>
						<li><div id="main" class="main">Kidney Injury: NOS</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
			<%
						if(Creat!=null){
							out.print("Creatinine: " + Creat + " " + CreatDate);
						}
			%>
			<br><br>
			</div>
			<br><br>
			<%
					}//if condition for NOS kidney injury ends here
					else if(renFailChkGrp[j].equalsIgnoreCase("Chronic Kidney Disease :Chronic")){
						
						/*String rfaDate,rfaCreat, rfaPrevCreat, rfaPrevCreatDate;
						rfaDate = request.getParameter("rfcCreatDate");
						rfaCreat = request.getParameter("rfcCreat");
						rfaPrevCreat = request.getParameter("rfcCreatPrev"); 
						rfaPrevCreatDate = request.getParameter("rfcCreatPrevDate");*/
			%>
						<li><div id="main" class="main">Kidney Injury: Chronic</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
			<%
				if(CreatDate!=null && Creat!=null && PrevCreat!=null && PrevCreatDate!=null){
					if(PrevCreat.equalsIgnoreCase("-99999.0")!=true && PrevCreat.equalsIgnoreCase("99999.0")!=true){
							out.print("Creatinine: " + Creat + " " + CreatDate+ "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
									+ "Previous Creatinine: " + PrevCreat + " " + PrevCreatDate);
					}
					else{
						out.print("Creatinine: " + Creat + " " + CreatDate+ "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					}
						}//if condition ends here
			%>
			<br><br>
			</div>
			<br><br>
						
			<%
					}//if condition for chronic kidney injury ends here
				}//for loop ends here
			}//if condition for kidney injury ends here 
			
		else if(mainGrp[i].equals("ElevatedBloodGlucose")){
			
			String[] EbgChkGrp;
			EbgChkGrp =  request.getParameterValues("EbgChkGrp");
			
			String glucDate,glucResult = "";
			glucDate = request.getParameter("glucDate");
			glucResult = request.getParameter("glucResult");
			
			for (int j = 0; j < EbgChkGrp.length; j++){
				if (EbgChkGrp[j].equals("Hyperglycemia")){
		%>
					<li><div id="main" class="main">Hyperglycemia</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
		<%
					out.print("Glucose: " + "   " + glucResult + "   " + glucDate);
		%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
		<%
				}//if condition check for hyperglycemia ends here
				else if (EbgChkGrp[j].equals("Diabetes")){
		%>
					<li><div id="main" class="main">Diabetes</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
		<%
					out.print("Glucose: " + "   " + glucResult + "   " + glucDate);
		%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
		<%

				}// if condition for diabetes ends here
			}// for loop for Elevated Blood Glucose ends here
		}// if condition check for Elevated Blood Glucose ends here
		else if(mainGrp[i].equals("Hypoglycemia")){

			String glucDate,glucResult = "";
			glucDate = request.getParameter("hypoglucDate");
			glucResult = request.getParameter("hypoglucResult");
	%>
			<li><div id="main" class="main">Hypoglycemia</div><br>
			<div id="sub" class="sub">
			&nbsp;&nbsp;&nbsp;&nbsp;
	<%
			out.print("Glucose: " + "   " + glucResult + "   " + glucDate);
	%>
		<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
	<%
		}// if condition for hypoglycemia ends here
		else if(mainGrp[i].equals("Hypoxia")){

			String oximetryDate,oximetryResult = "";
			oximetryDate = request.getParameter("oximetryDate");
			oximetryResult = request.getParameter("oximetryResult");
	%>
			<li><div id="main" class="main">Hypoxia</div><br>
			<div id="sub" class="sub">
			&nbsp;&nbsp;&nbsp;&nbsp;
	<%
			out.print("Pulse Oximetry: " + "   " + oximetryResult + "   " + oximetryDate);
	%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
	<%
		}// if condition check for hypoxia ends here
		else if(mainGrp[i].equals("Granulocytopenia")){

			String minneutrophilDate,minneutrophilResult = "";
			minneutrophilDate = request.getParameter("neutrophilMinDate");
			minneutrophilResult = request.getParameter("neutrophilMinResult");
	%>
			<li><div id="main" class="main">Granulocytopenia</div><br>
			<div id="sub" class="sub">
			&nbsp;&nbsp;&nbsp;&nbsp;
	<%
			out.print("Neutrophil (Minimum): " + "  " + minneutrophilResult + "   " + minneutrophilDate);
	%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
	<%
		}// if condition for granulocytopenia ends here
		else if(mainGrp[i].equals("LacticAcidosis")){

			String lacticAcidDate,lacticAcidResult = "";
			lacticAcidDate = request.getParameter("lacticAcidDate");
			lacticAcidResult = request.getParameter("lacticAcidResult");
	%>
			<li><div id="main" class="main">Lactic Acidosis</div><br>
			<div id="sub" class="sub">
			&nbsp;&nbsp;&nbsp;&nbsp;
	<%
			out.print("Lactic Acid: " + "   " + lacticAcidResult + "   " + lacticAcidDate);
	%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
	<%
		}// if condition for lactic acidosis ends here
		else if(mainGrp[i].equals("Electrolyte Abnormality")){

			String[] EaChkGrp;
			EaChkGrp =  request.getParameterValues("EaChkGrp");
			for (int j = 0; j < EaChkGrp.length; j++){

				if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypokalemia")){
					String hypokalDate,hypokalPot = "";
					hypokalDate = request.getParameter("hypokalDate");
					hypokalPot = request.getParameter("hypokalPot");
			%>
					<li><div id="main" class="main">Hypokalemia</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Potassium: " + "   " +  hypokalPot + "   " + hypokalDate);
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%					
				}//if condition for hypokalemia ends here
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyperkalemia")){

					String hyperkalDate,hyperkalPot = "";
					hyperkalDate = request.getParameter("hyperkalDate");
					hyperkalPot = request.getParameter("hyperkalPot");
			%>
					<li><div id="main" class="main">Hyperkalemia</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Potassium: " + "   " +  hyperkalPot + "   " + hyperkalDate);
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%
				}//if condition for hyperkalemia ends here
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyponatremia")){

					String hyponatDate,hyponatSod = "";
					hyponatDate = request.getParameter("hyponatDate");
					hyponatSod = request.getParameter("hyponatSod");
			%>
					<li><div id="main" class="main">Hyponatremia</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Sodium: " + "   " +  hyponatSod + "   " + hyponatDate);
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%
				}//if condition for Hyponatremia ends here
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypernatremia")){

					String hypernatDate,hypernatSod = "";
					hypernatDate = request.getParameter("hypernatDate");
					hypernatSod = request.getParameter("hypernatSod");
			%>
					<li><div id="main" class="main">Hypernatremia</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Sodium: " + "   " +  hypernatSod + "   " + hypernatDate);
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%
				}//if condition for Hypernatremia ends here
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypocalcemia")){

					String hypocalDate,hypocalCal = "";
					hypocalDate = request.getParameter("hypocalDate");
					hypocalCal = request.getParameter("hypocalCal");
			%>
					<li><div id="main" class="main">Hypocalcemia</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Calcium: " + "   " +  hypocalCal + "   " + hypocalDate);
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%
				}//if condition for Hypocalcemia ends here
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypercalcemia")){

					String hypercalDate,hypercalCal = "";
					hypercalDate = request.getParameter("hypercalDate");
					hypercalCal = request.getParameter("hypercalCal");
			%>
					<li><div id="main" class="main">Hypercalcemia</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Calcium: " + "   " +  hypercalCal + "   " + hypercalDate);
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%
				}//if condition for Hypercalcemia ends here
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypophosphatemia")){

					String hypophosDate,hypophosPhos = "";
					hypophosDate = request.getParameter("hypophosDate");
					hypophosPhos = request.getParameter("hypophosPhos");
			%>
					<li><div id="main" class="main">Hypophosphatemia</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Phosphorous: " + "   " +  hypophosPhos + "   " + hypophosDate);
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%
				}//if condition for Hypophosphatemia ends here
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyperphosphatemia")){

					String hyperphosDate,hyperphosPhos = "";
					hyperphosDate = request.getParameter("hyperphosDate");
					hyperphosPhos = request.getParameter("hyperphosPhos");
			%>
					<li><div id="main" class="main">Hyperphosphatemia</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Phosphorous: " + "   " +  hyperphosPhos + "   " + hyperphosDate);
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%
				}//if condition for Hyperphosphatemia ends here
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypomagnesemia")){

					String hypomagDate,hypomagMag = "";
					hypomagDate = request.getParameter("hypomagDate");
					hypomagMag = request.getParameter("hypomagMag");
			%>
					<li><div id="main" class="main">Hypomagnesemia</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Magnesium: " + "   " +  hypomagMag + "   " + hypomagDate);
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%
				}//if condition for Hypomagnesemia ends here
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypermagnesemia")){

					String hypermagDate,hypermagMag = "";
					hypermagDate = request.getParameter("hypermagDate");
					hypermagMag = request.getParameter("hypermagMag");
			%>
					<li><div id="main" class="main">Hypermagnesemia</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Magnesium: " + "   " +  hypermagMag + "   " + hypermagDate);
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%
				}//if condition for Hypermagnesemia ends here
			}// for loop for electrolyte abnormality ends here
		}// if condition for electrolyte abnormality ends here
		else if(mainGrp[i].equals("HyperCholesterolemia")){

			String cholesterolDate,cholesterolResult = "";
			cholesterolDate = request.getParameter("cholesterolDate");
			cholesterolResult = request.getParameter("cholesterolResult");
	%>
			<li><div id="main" class="main">HyperCholesterolemia</div><br>
			<div id="sub" class="sub">
			&nbsp;&nbsp;&nbsp;&nbsp;
	<%
			out.print("Cholesterol: " + "   " +  cholesterolResult + "   " + cholesterolDate);
	%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
	<%
		}//if condition for HyperCholesterolemia ends here
		else if(mainGrp[i].equals("Dehydration")){

			String creatDate,creatResult,bunDate,bunResult,hydration  = "";
			creatDate = request.getParameter("hydracreatDate");
			creatResult = request.getParameter("hydracreatinine");
			bunDate = request.getParameter("hydrabunDate");
			bunResult = request.getParameter("hydrabunResult");
			hydration = request.getParameter("hydration");
	%>
			<li><div id="main" class="main">Dehydration</div><br>
			<div id="sub" class="sub">
			&nbsp;&nbsp;&nbsp;&nbsp;
	<%
			out.print("Creatinine: " + "   " + creatResult + "   " + creatDate + "<br><br>");
			out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "BUN: " + "   " + bunResult + "   " + bunDate + "<br><br>");
			out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "BUN/Creatinine: " + hydration);
	%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
	<%
		}//if condition for Dehydration ends here
		else if(mainGrp[i].equals("Malnutrition")){

			String malHeightDate,malHeight,malWeight,malBmi,malWeightDate;
			malHeightDate = request.getParameter("malHeightDate");
			malWeightDate = request.getParameter("malWeightDate");
			malHeight = request.getParameter("malHeight");
			malWeight = request.getParameter("malWeight");
			malBmi = request.getParameter("malBmi");
	%>
			<li><div id="main" class="main">Malnutrition</div><br>
			<div id="sub" class="sub">
			&nbsp;&nbsp;&nbsp;&nbsp;
	<%
			out.print("Height: " + malHeight + " " + malHeightDate + "<br><br>");
			out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "Weight: " + malWeight + " " + malWeightDate + "<br><br>");
			out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "BMI: " + malBmi);
	%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
	<%
		}//if condition for Malnutrition ends here
		else if(mainGrp[i].equals("Obesity")){

			String obHeightDate, obHeight, obWeight, obBmi, obWeightDate = "";
			
			obHeightDate = request.getParameter("obHeightDate");
			obHeight = request.getParameter("obHeight");
			obWeight = request.getParameter("obWeight");
			obBmi = request.getParameter("obBmi");
			obWeightDate = request.getParameter("obWeightDate");
	%>
			<li><div id="main" class="main">Obesity</div><br>
			<div id="sub" class="sub">
			&nbsp;&nbsp;&nbsp;&nbsp;
	<%
			out.print("Height: " + obHeight + " " + obHeightDate + "<br><br>");
			out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "Weight: " + obWeight + " " + obWeightDate + "<br><br>");
			out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "BMI: " + obBmi);
	%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
	<%
		}//if condition for obesity ends here
		else if(mainGrp[i].equals("Morbid Obesity")){

			String mobHeightDate, mobHeight, mobWeight, mobBmi, mobWeightDate = "";
			
			mobHeightDate = request.getParameter("mobHeightDate");
			mobHeight = request.getParameter("mobHeight");
			mobWeight = request.getParameter("mobWeight");
			mobBmi = request.getParameter("mobBmi");
			mobWeightDate = request.getParameter("mobWeightDate");
	%>
			<li><div id="main" class="main">Morbid Obesity</div><br>
			<div id="sub" class="sub">
			&nbsp;&nbsp;&nbsp;&nbsp;
	<%
			out.print("Height: " + mobHeight + " " + mobHeightDate + "<br><br>");
			out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "Weight: " + mobWeight + " " + mobWeightDate + "<br><br>");
			out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "BMI: " + mobBmi);
	%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
	<%
		}//if condition for Morbid Obesity ends here
		else if(mainGrp[i].equals("Hypertension")){

			String htnDate,htnDatesys,htnBpDia,htnBpSys = "";
			htnDate = request.getParameter("htnDate");
			htnDatesys = request.getParameter("htnDateSys");
			htnBpDia = request.getParameter("htnBpDia");
			htnBpSys = request.getParameter("htnBpSys");
		
			String[] hyperChkGrp;
			hyperChkGrp =  request.getParameterValues("htChkGrp");

			for (int j = 0; j < hyperChkGrp.length; j++){

				if(hyperChkGrp[j].equals("Hypertension: Elevated BP")){
			%>
					<li><div id="main" class="main">Elevated Blood Pressure</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Blood Pressure(systolic): " + htnBpSys + " " + htnDatesys + "<br><br>");
					out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "Blood Pressure(diastolic): " + htnBpDia + " " + htnDate + "<br><br>");
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%
				}// if condition for elevated BP ends here
				if(hyperChkGrp[j].equals("Hypertension: Hypertension")){
			%>
					<li><div id="main" class="main">Hypertension</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print("Blood Pressure(systolic): " + htnBpSys + " " + htnDatesys + "<br><br>");
					out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "Blood Pressure(diastolic): " + htnBpDia + " " + htnDate + "<br><br>");
			%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
			<%
				}// if condition for Hypertension ends here
			}// for loop ends here
		}// if condition for hypertension ends here
		
		else if(mainGrp[i].equals("Shock")){

			String[] shockChkGrp = null;
			shockChkGrp =  request.getParameterValues("shockChkGrp");

			if(shockChkGrp != null) {
				String shockDate,shockBP = "";
				shockDate = request.getParameter("shockDate");
				shockBP = request.getParameter("shockBp");

				for (int j = 0; j < shockChkGrp.length; j++){
					if(shockChkGrp[j].equals("Shock:Septic")){
				%>
						<li><div id="main" class="main"> Shock: Septic</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
				<%
						out.print("Systolic Blood Pressure: " + shockBP + " " + shockDate);
				%>
						<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
				<%	
					}//if condition for septic shock ends here
					else if(shockChkGrp[j].equals("Shock:Hypovolemic")){
				%>
						<li><div id="main" class="main">Shock: Hypovolemic</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
				<%
						out.print("Systolic Blood Pressure: " + shockBP + " " + shockDate);
				%>
						<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
				<%		
					}//if condition for Hypovolemic shock ends here
					else if(shockChkGrp[j].equals("Shock:Obstructive")){
				%>
						<li><div id="main" class="main">Shock: Obstructive</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
				<%
						out.print("Systolic Blood Pressure: " + shockBP + " " + shockDate);
				%>
						<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
				<%
					}//if condition for Obstructive shock ends here
					else if(shockChkGrp[j].equals("Shock:NOS")){
				%>
						<li><div id="main" class="main">Shock:NOS</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
				<%
						out.print("Systolic Blood Pressure: " + shockBP + " " + shockDate);
				%>
						<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
				<%
					}//if condition for NOS shock ends here
				}// for loop for shock ends here
			}//if check for the null condition ends here
		}//if condition for the shock ends here
		else if(mainGrp[i].equals("Cardiogenic Shock")){

			String[] cshockChkGrp = null;
			cshockChkGrp =  request.getParameterValues("cshockChkGrp");
			if(cshockChkGrp != null) {
				String cshockDate,cshockBP, cDateShockTrop, cShockTrop = "";
				cshockDate = request.getParameter("cShockDate");
				cshockBP = request.getParameter("cShockBP");
				cDateShockTrop = request.getParameter("cDateShockTrop");
				cShockTrop = request.getParameter("cShockTrop");
				
				for (int j = 0; j < cshockChkGrp.length; j++){
					if(cshockChkGrp[j].equals("Cardiogenic Shock:Cardiogenic Shock")){
				%>
						<li><div id="main" class="main">Cardiogenic Shock</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
				<%
						out.print("Systolic Blood Pressure: " + cshockBP + " " + cshockDate +  "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
								   "Cardiac Troponin Date: " + cShockTrop + " " + cDateShockTrop);
				%>
						<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
				<%						
					}//if condition for cardiogenic shock ends here
					else if(cshockChkGrp[j].equals("Cardiogenic Shock:Septic")){
				%>
						<li><div id="main" class="main">Cardiogenic Shock : Septic</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
				<%
						out.print("Systolic Blood Pressure: " + cshockBP + " " + cshockDate);
				%>
						<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
				<%	
					}//if condition for septic shock ends here
					else if(cshockChkGrp[j].equals("Cardiogenic Shock:Hypovolemic")){
				%>
						<li><div id="main" class="main">Cardiogenic Shock : Hypovolemic</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
				<%
						out.print("Systolic Blood Pressure: " + cshockBP + " " + cshockDate);
				%>
						<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
				<%
					}//if condition for Hypovolemic shock ends here
					else if(cshockChkGrp[j].equals("Cardiogenic Shock:Obstructive")){
				%>
						<li><div id="main" class="main">Cardiogenic Shock : Obstructive</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
				<%
						out.print("Systolic Blood Pressure: " + cshockBP + " " + cshockDate);
				%>
						<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
				<%
					}//if condition for Obstructive ends here 
					else if(cshockChkGrp[j].equals("Cardiogenic Shock:NOS")){
				%>
						<li><div id="main" class="main">Cardiogenic Shock : NOS</div><br>
						<div id="sub" class="sub">
						&nbsp;&nbsp;&nbsp;&nbsp;
				<%
						out.print("Systolic Blood Pressure: " + cshockBP + " " + cshockDate);
				%>
						<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
				<%
					}//if condition for NOS ends here 
				}// for loop for cardiogenic shock ends here
			}//if condition for null check ends here
		}//if condition for cardiogenic shock ends here
		else if(mainGrp[i].equals("Uti")){
			
			String[] utichckgrp;
			utichckgrp =  request.getParameterValues("catheterAssoc");

			String utiDate,utiWbc,utiUle,utiUln,utiUlndate,utiUledate = "";
	
			utiDate = request.getParameter("utiDate");
			utiWbc = request.getParameter("utiWbc");
			utiUle = request.getParameter("utiUle");
			utiUledate = request.getParameter("utiUledate");
			utiUln = request.getParameter("utiUln");
			utiUlndate = request.getParameter("utiUlndate");
			%>
				<li><div id="main" class="main">UTI</div><br>
				<div id="sub" class="sub">
				&nbsp;&nbsp;&nbsp;&nbsp;
			<%
				if(utiWbc.isEmpty()!= true){
				out.print("WBC count: " + utiWbc + " " + utiDate);
				}
				if(utiUle.isEmpty()!= true){
			%>
				<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			<%
				
				out.print("Urinalysis, Leukocyte Esterase: " + utiUle + " " + utiUledate );
				}
				if(utiUln.isEmpty()!= true){
			%>
				<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			<%
				
				out.print("Urinalysis,  Nitrite: " + utiUln + " " + utiUlndate);
				}
			%>
				<br><br>
				</div>
			<% for (int j = 0; j < utichckgrp.length; j++){
				if(utichckgrp[j].equals("Catherter Associated")){
			%>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<%
					out.print("Catherter Associated");
					out.print("<br><br>&nbsp;&nbsp;&nbsp;&nbsp;");
					%> 					
					</div>
				<%}
			}
		}//if condition for UTI ends here
		else if(mainGrp[i].equals("Respiratory Failure :")){

			String[] respFailChkGrp;
			respFailChkGrp =  request.getParameterValues("respFailChkGrp");
			
			for (int j = 0; j < respFailChkGrp.length; j++){

				if(respFailChkGrp[j].equals("Respiratory Failure :Acute")){
					String respPo2Date,respPo,respO2satDate, respO2sat = "";
					respPo2Date = request.getParameter("respPo2Date");
					respPo = request.getParameter("respPo");
					respO2satDate = request.getParameter("respO2satDate");
					respO2sat = request.getParameter("respO2sat");
				%>
					<li><div id="main" class="main">Acute Respiratory Failure</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
				<%
					out.print("PO2: " + respPo + " " + respPo2Date + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "Pulse Oximetry: " + respO2sat + " " + respO2satDate);
				%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				<%					
				}//if condition for acute respiratory failure ends here
				else if(respFailChkGrp[j].equals("Respiratory Failure :Chronic")){

					String respPco2Date = request.getParameter("respPco2Date");
					String respPco2 = request.getParameter("respPco2");
					String respEtco2Date = request.getParameter("respEtco2Date");
					String respEtco2 = request.getParameter("respEtco2");
					String respPrevPco2Date = request.getParameter("respPrevPco2Date");
					String respPrevPco2 = request.getParameter("respPrevPco2");
					String respPrevEtco2Date = request.getParameter("respPrevEtco2Date");
					String respPrevEtco2 = request.getParameter("respPrevEtco2");
				%>
					<li><div id="main" class="main">Chronic Respiratory Failure</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
				<%
					out.print("PCO2: " + respPco2 + " " + respPco2Date + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" 
								+ "Previous PCO2: " + respPrevPco2 + " " + respPrevPco2Date + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
								+ "EtcO2: " + respEtco2 + " " + respEtco2Date + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
								+ "Previous EtcO2: " + respPrevEtco2 + " " + respPrevEtco2Date);
				%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				<%	
				}//if condition for chronic respiratory failure ends here
				else if(respFailChkGrp[j].equals("Respiratory Failure :Acute on Chronic")){

					String respPco2Date = request.getParameter("respPco2Date");
					String respPco2 = request.getParameter("respPco2");
					String respEtco2Date = request.getParameter("respEtco2Date");
					String respEtco2 = request.getParameter("respEtco2");
					String respPrevPco2Date = request.getParameter("respPrevPco2Date");
					String respPrevPco2 = request.getParameter("respPrevPco2");
					String respPrevEtco2Date = request.getParameter("respPrevEtco2Date");
					String respPrevEtco2 = request.getParameter("respPrevEtco2");
					String respPo2Date,respPo,respO2satDate, respO2sat = "";
					
					respPo2Date = request.getParameter("respPo2Date");
					respPo = request.getParameter("respPo");
					respO2satDate = request.getParameter("respO2satDate");
					respO2sat = request.getParameter("respO2sat");
				%>
					<li><div id="main" class="main">Respiratory Failure :Acute on Chronic</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
				<%
					out.print("PO2: " + respPo + " " + respPo2Date + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" 
								+ "Pulse Oximetry: " + respO2sat + " " + respO2satDate + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
								+ "PCO2: " + respPco2 + " " + respPco2Date + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
								+ "Previous PCO2: " + respPrevPco2 + " " + respPrevPco2Date + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
								+ "EtcO2: " + respEtco2 + " " + respEtco2Date + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
								+ "Previous EtcO2: " + respPrevEtco2 + " " + respPrevEtco2Date);
				%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				<%	
				}//if condition for acute on chronic respiratory failure ends here
				else if(respFailChkGrp[j].equals("Respiratory Failure :NOS")){

					String respPo2Date,respPo,respO2satDate, respO2sat = "";

					respPo2Date = request.getParameter("respPo2Date");
					respPo = request.getParameter("respPo");
					respO2satDate = request.getParameter("respO2satDate");
					respO2sat = request.getParameter("respO2sat");
				%>
					<li><div id="main" class="main">Respiratory Failure :NOS</div><br>
					<div id="sub" class="sub">
					&nbsp;&nbsp;&nbsp;&nbsp;
				<%
					out.print("PO2: " + respPo + " " + respPo2Date + "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" 
								+ "Pulse Oximetry: " + respO2sat + " " + respO2satDate);
				%>
					<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				<%	
				}//if condition for NOS respiratory failure ends here
			}// for loop for respiratory failure ends here
		}//if condition for respiratory failure ends here
		else if(mainGrp[i].equals("Sepsis")){

			String sepDate,maxsepHr,minsepHr,sepRr,sepMaxWbc,sepMinWbc,sepSysBP,maxsepTem, minsepTem,sepLac, 
			maxsepHrDate, minsepHrDate, sepRrDate,sepMaxWbcDate,sepMinWbcDate,sepSysBPDate,maxsepTemDate, 
			minsepTemDate,sepLacDate,sepLacHigh = "";
			
			maxsepHr = request.getParameter("maxsepHr");
			minsepHr = request.getParameter("minsepHr");
			sepRr = request.getParameter("sepRr");
			sepMaxWbc = request.getParameter("maxsepWbc");
			sepMinWbc = request.getParameter("minsepWbc");
			sepSysBP = request.getParameter("sepSysBP");
			maxsepTem = request.getParameter("maxsepTem");
			minsepTem = request.getParameter("minsepTem");
			sepLac = request.getParameter("sepLac");
			maxsepHrDate = request.getParameter("maxsepHrDate");
			minsepHrDate = request.getParameter("minsepHrDate");
			sepRrDate = request.getParameter("sepRrDate");
			sepMaxWbcDate = request.getParameter("maxsepWbcDate");
			sepMinWbcDate = request.getParameter("minsepWbcDate");
			sepSysBPDate = request.getParameter("sepSysBPDate");
			maxsepTemDate = request.getParameter("maxsepTemDate");
			minsepTemDate = request.getParameter("minsepTemDate");
			sepLacDate = request.getParameter("sepLacDate");
			sepLacHigh = request.getParameter("sepLacHigh");
			
			%>
			<li><div id="main" class="main">Sepsis</div><br>
			<div id="sub" class="sub">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<%
		
			if(maxsepHr.isEmpty() != true && Double.parseDouble(maxsepHr) > 100.0){
				out.print("Heart Rate (Maximum): " + maxsepHr + " "+ maxsepHrDate);
			}
			
			%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			
			if( minsepHr.isEmpty() != true && Double.parseDouble(minsepHr) < 40.0){
				out.print("Heart Rate (Minimum): " + minsepHr + " "+ minsepHrDate);
			}
			
			%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			
			if(sepRr.isEmpty() != true && Double.parseDouble(sepRr) > 26.0){
				out.print("Respiratory Rate: " + sepRr + " "+ sepRrDate);
			}
			
			%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			
			if(sepMaxWbc.isEmpty() != true && Double.parseDouble(sepMaxWbc) > 12000.0){
				out.print("WBC count (Maximum): " + sepMaxWbc + " "+ sepMaxWbcDate);
			}
			
			%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			
			if(sepMinWbc.isEmpty() != true && Double.parseDouble(sepMinWbc) < 4000.0){
				out.print("WBC count (Minimum): " + sepMinWbc + " "+ sepMinWbcDate);
			}
			
			%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			
			if(sepSysBP.isEmpty() != true && Double.parseDouble(sepSysBP) <= 90.0){
				out.print("Systolic BP: " + sepSysBP + " "+ sepSysBPDate);
			}
			
			%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			
			if(maxsepTem.isEmpty() != true && Double.parseDouble(maxsepTem) >= 38.88){
				out.print("Temperature (Maximum): " + maxsepTem + " "+ maxsepTemDate);
			}
			
			%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			
			if(minsepTem.isEmpty() != true &&  Double.parseDouble(minsepTem) < 36){
				out.print("Temperature (Minimum): " + minsepTem + " "+ minsepTemDate);
			}
			
			%>
			<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			
			if( sepLac.isEmpty() != true && Double.parseDouble(sepLac) > Double.parseDouble(sepLacHigh)){
				out.print("Lactate: " + sepLac + " "+ sepLacDate);
			}
			
			%>
			<br><br>
			</div>
			<%
		}//if condition for sepsis ends here
		else if(mainGrp[i].equals("Acute Pulmonary Edema")){
		%>
			<li><div id="main" class="main">Acute Pulmonary Edema</div><br><br>
		<%	
		}// if condition for acute pulmonary edema
		else if(mainGrp[i].equals("Anoxic Brain Injury")){
		%>
			<li><div id="main" class="main">Anoxic Brain Injury</div><br><br>
		<%
		}//if condition for Anoxic Brain Injury ends here
		else if(mainGrp[i].equals("Coma")){
		%>
			<li><div id="main" class="main">Coma</div><br><br>
		<%
		}//if condition for Anoxic Brain Injury ends here
		else if(mainGrp[i].equals("Decubitis Ulcer")){

			String[] duChkgrp;
			String ipDuSite = request.getParameter("ipDuSite");
			duChkgrp = request.getParameterValues("duChkgrp");
			if(duChkgrp != null){
		%>
			<li><div id="main" class="main">Decubitis Ulcer</div><br>
			<div id="sub" class="sub">
		<%
				for (int j = 0; j < duChkgrp.length; j++){
		%>
			&nbsp;&nbsp;&nbsp;&nbsp;
		<%
					out.print(duChkgrp[j]);
		%>
			<br><br>
		<%
				}//for loop ends here
			}//if condition for null check ends here
			if (ipDuSite.isEmpty()!= true){
		%>
				&nbsp;&nbsp;&nbsp;&nbsp;
		<%
				out.print("Site: " + ipDuSite);
		%>
			<br><br>
		<%
			}//if condition for ipDuSite ends here
			%>
			</div>
			<%
		}//if condition for decubities ulcer ends here
		else if(mainGrp[i].equals("Delirium")){

			String[] delichkgrp;
			delichkgrp = request.getParameterValues("delichkgrp");
			if(delichkgrp != null){
			%>
				<li><div id="main" class="main">Delirium</div><br>
				<div id="sub" class="sub">
			<%
				for (int j = 0; j < delichkgrp.length; j++){
			%>
				&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print(delichkgrp[j]);
			%>
				<br><br>
			<%
				}//for loop ends here
			}//if condition for the null check ends here
			%> 
			</div>
			<%
		}//if condition for delirium ends here
		else if(mainGrp[i].equals("Encephalopathy")){
		%>
			<li><div id="main" class="main">Encephalopathy</div><br><br>
		<%	
		}//if condition for encephalopathy ends here
		else if(mainGrp[i].equals("Pleural Effusion")){
		%>
			<li><div id="main" class="main">Pleural Effusion</div><br><br>
		<%	
		}//if condition for Pleural Effusion ends here
		else if(mainGrp[i].equals("Pneumonia")){

			String[] pneuchkgrp;
			
			pneuchkgrp = request.getParameterValues("pneuchkgrp");
			if(pneuchkgrp != null){
			%>
				<li><div id="main" class="main">Pneumonia</div><br>
				<div id="sub" class="sub">
			<%
				for (int j = 0; j < pneuchkgrp.length; j++){
			%>
				&nbsp;&nbsp;&nbsp;&nbsp;
			<%
					out.print(pneuchkgrp[j]);
			%>
				<br><br>
			<%
				}//for loop ends here
			}//if condition for null check ends here
			%> 
			</div>
			<%
		}//if condition for pneumonia ends here
		else if(mainGrp[i].equals("PSVT")){
		%>
			<li><div id="main" class="main">PSVT</div><br><br>
		<%	
		}//if condition for PSVT ends here
		else if(mainGrp[i].equals("Seizure")){
		%>
			<li><div id="main" class="main">Seizure</div><br><br>
		<%	
		}//if condition for Seizure ends here
		else if(mainGrp[i].equals("SepsisOther")){
			String SepsisOtherComments = "";
			SepsisOtherComments = request.getParameter("sepsisOtherComments");
		%>
			<li><div id="main" class="main">
		<%
			out.print("Reasons for Sepsis: " + SepsisOtherComments);
		%>
			</div><br><br>
		<%	
		}//if condition for SepsisOther ends here
		else if(mainGrp[i].equals("comments")){
			String comments = "";
			comments = request.getParameter("comments");
			
			if(comments.isEmpty() != true || comments != null){
			%>
				<li><div id="main" class="main">Other Comorbidities:</div><br><br>
				<div id="sub" class="sub">&nbsp;&nbsp;&nbsp;&nbsp;
			<%
				out.print(comments);
			}//if condition for null check ends here
			%>
			</div>
			<%
			
		}//if condition for comments ends here

		
	}// for loop for the comorbidities end here
}// else condition for the comorbidities end here
%>
</ul>


<%

DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy h:mm a");
Date date = new Date();
String Date = dateFormat.format(date);

%>
<br><br>
<div id="main" class="main">Physician Name: ______________________________________  ID#: _________________________</div>
<br><br>
<div id="main" class="main">Physician Signature: _________________________________  Date:<%=" "+Date.substring(0,10)+" "%>Time:<%=" "+Date.substring(11)+" "%></div>

</div>

<br><br><br><br><br><br><br><br><br><br><br>

</body>
</html>