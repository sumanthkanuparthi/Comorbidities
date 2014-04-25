<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TestingInputs</title>
</head>
<body>

<!-- <form action="http://uhmc-ed-admitd.uhmc.sunysb.edu:8080/CoMorbidities/CoMorbMain.jsp">  -->
<form action="http://localhost:8080/CoMorbidities/CoMorbMain.jsp">

<!-- Changes made by Himanshu Jindal for mindate and maxdate changes -->
	<!--  
	Height <input type="text" name="height" value="2011-10-11_11:00:00"><br>
	Height_Val <input type="text" name="height_val"><br>
	-->
	Encounter ID <input type="text" name="encntr_id" id="encntr_id"><br>
	User ID <input type="text" name="user_id" id="user_id"><br>
	Height_Min_Val <input type="text" name="height_min_val"><br>
	Height_Min_Date <input type="text" name="height_min_date" value="2011-10-11_11:00:00"><br>
	Height_Max_Date <input type="text" name="height_max_date" value="2011-10-11_11:00:00"><br>
	Height_Max_Val <input type="text" name="height_max_val"><br>
	
	<!-- 
	Weight <input type="text" name="weight" value="2011-10-11_11:00:00"><br>
	Weight_Val <input type="text" name="weight_val"><br>
	 --> 
	Weight_Min_Date <input type="text" name="weight_min_date" value="2011-10-11_11:00:00"><br>
	Weight_Min_Val <input type="text" name="weight_min_val"><br>
	Weight_Max_Date <input type="text" name="weight_max_date" value="2011-10-11_11:00:00"><br>
	Weight_Max_Val <input type="text" name="weight_max_val"><br> 
	
	<!--
	Sodium <input type="text" name="sodium" value="2011-10-11_11:00:00"><br>
	Sodium_Low <input type="text" name="sodium_low"><br>
	Sodium_High <input type="text" name="sodium_high"><br>
	Sodium_Val <input type="text" name="sodium_val"><br>
	 -->
	Sodium_Max_Date <input type="text" name="sodium_max_date" value="2011-10-11_11:00:00"><br>
	Sodium_Min_Date <input type="text" name="sodium_min_date" value="2011-10-11_11:00:00"><br>
	Sodium_Low <input type="text" name="sodium_low"><br>
	Sodium_High <input type="text" name="sodium_high"><br>
	Sodium_Max_Val <input type="text" name="sodium_max_val"><br>
	Sodium_Min_Val <input type="text" name="sodium_min_val"><br>
	
	<!--
	WB Sodium <input type="text" name="wb_sodium" value="2011-10-11_11:00:00"><br>
	WB Sodium_Low <input type="text" name="wb_sodium_low"><br>
	WB Sodium_High <input type="text" name="wb_sodium_high"><br>
	WB Sodium_Val <input type="text" name="wb_sodium_val"><br>
	-->
	wb_sodium_Max_Date <input type="text" name="wb_sodium_max_date" value="2011-10-11_11:00:00"><br>
	wb_sodium_Min_Date <input type="text" name="wb_sodium_min_date" value="2011-10-11_11:00:00"><br>
	wb_sodium_Low <input type="text" name="wb_sodium_low"><br>
	wb_sodium_High <input type="text" name="wb_sodium_high"><br>
	wb_sodium_Max_Val <input type="text" name="wb_sodium_max_val"><br>
	wb_sodium_Min_Val <input type="text" name="wb_sodium_min_val"><br>
	
	
	potassium_Max_Date <input type="text" name="potassium_max_date" value="2011-10-11_11:00:00"><br>
	potassium_Min_Date <input type="text" name="potassium_min_date" value="2011-10-11_11:00:00"><br>
	potassium_Low <input type="text" name="potassium_low"><br>
	potassium_High <input type="text" name="potassium_high"><br>
	potassium_Max_Val <input type="text" name="potassium_max_val"><br>
	potassium_Min_Val <input type="text" name="potassium_min_val"><br>
	
	
	wb_potassium_Max_Date <input type="text" name="wb_potassium_max_date" value="2011-10-11_11:00:00"><br>
	wb_potassium_Min_Date <input type="text" name="wb_potassium_min_date" value="2011-10-11_11:00:00"><br>
	wb_potassium_Low <input type="text" name="wb_potassium_low"><br>
	wb_potassium_High <input type="text" name="wb_potassium_high"><br>
	wb_potassium_Max_Val <input type="text" name="wb_potassium_max_val"><br>
	wb_potassium_Min_Val <input type="text" name="wb_potassium_min_val"><br>
	
	<!-- 
	calcium <input type="text" name="calcium" value="2011-10-11_11:00:00"><br>
	calcium_Low <input type="text" name="calcium_low"><br>
	calcium_High <input type="text" name="calcium_high"><br>
	calcium_Val <input type="text" name="calcium_val"><br>
	 -->
	calcium_Max_Date <input type="text" name="calcium_max_date" value="2011-10-11_11:00:00"><br>
	calcium_Min_Date <input type="text" name="calcium_min_date" value="2011-10-11_11:00:00"><br>
	calcium_Low <input type="text" name="calcium_low"><br>
	calcium_High <input type="text" name="calcium_high"><br>
	calcium_Max_Val <input type="text" name="calcium_max_val"><br>
	calcium_Min_Val <input type="text" name="calcium_min_val"><br>
	 
	 <!--
	phosphorus <input type="text" name="phosphorus" value="2011-10-11_11:00:00"><br>
	phosphorus_Low <input type="text" name="phosphorus_low"><br>
	phosphorus_High <input type="text" name="phosphorus_high"><br>
	phosphorus_Val <input type="text" name="phosphorus_val"><br>
	-->
	phosphorus_Max_Date <input type="text" name="phosphorus_max_date" value="2011-10-11_11:00:00"><br>
	phosphorus_Min_Date <input type="text" name="phosphorus_min_date" value="2011-10-11_11:00:00"><br>
	phosphorus_Low <input type="text" name="phosphorus_low"><br>
	phosphorus_High <input type="text" name="phosphorus_high"><br>
	phosphorus_Max_Val <input type="text" name="phosphorus_max_val"><br>
	phosphorus_Min_Val <input type="text" name="phosphorus_min_val"><br>
	
	<!-- 
	magnesium <input type="text" name="magnesium" value="2011-10-11_11:00:00"><br>
	magnesium_Low <input type="text" name="magnesium_low"><br>
	magnesium_High <input type="text" name="magnesium_high"><br>
	magnesium_Val <input type="text" name="magnesium_val"><br>
	 -->
	magnesium_Max_Date <input type="text" name="magnesium_max_date" value="2011-10-11_11:00:00"><br>
	magnesium_Min_Date <input type="text" name="magnesium_min_date" value="2011-10-11_11:00:00"><br>
	magnesium_Low <input type="text" name="magnesium_low"><br>
	magnesium_High <input type="text" name="magnesium_high"><br>
	magnesium_Max_Val <input type="text" name="magnesium_max_val"><br>
	magnesium_Min_Val <input type="text" name="magnesium_min_val"><br>
	 
	 <!-- 
	glucose <input type="text" name="glucose" value="2011-10-11_11:00:00"><br>
	glucose_Low <input type="text" name="glucose_low"><br>
	glucose_High <input type="text" name="glucose_high"><br>
	glucose_Val <input type="text" name="glucose_val"><br>
	 -->
	glucose_Max_Date <input type="text" name="glucose_max_date" value="2011-10-11_11:00:00"><br>
	glucose_Min_Date <input type="text" name="glucose_min_date" value="2011-10-11_11:00:00"><br>
	glucose_Low <input type="text" name="glucose_low"><br>
	glucose_High <input type="text" name="glucose_high"><br>
	glucose_Max_Val <input type="text" name="glucose_max_val"><br>
	glucose_Min_Val <input type="text" name="glucose_min_val"><br>
	
	<!--
	WB glucose <input type="text" name="wb_glucose" value="2011-10-11_11:00:00"><br>
	WB glucose_Low <input type="text" name="wb_glucose_low"><br>
	WB glucose_High <input type="text" name="wb_glucose_high"><br>
	WB glucose_Val <input type="text" name="wb_glucose_val"><br>
	-->
	wb_glucose_Max_Date <input type="text" name="wb_glucose_max_date" value="2011-10-11_11:00:00"><br>
	wb_glucose_Min_Date <input type="text" name="wb_glucose_min_date" value="2011-10-11_11:00:00"><br>
	wb_glucose_Low <input type="text" name="wb_glucose_low"><br>
	wb_glucose_High <input type="text" name="wb_glucose_high"><br>
	wb_glucose_Max_Val <input type="text" name="wb_glucose_max_val"><br>
	wb_glucose_Min_Val <input type="text" name="wb_glucose_min_val"><br>
	
	<!-- 
	neutrophil <input type="text" name="neutrophil" value="2011-10-11_11:00:00"><br>
	neutrophil_Low <input type="text" name="neutrophil_low"><br>
	neutrophil_High <input type="text" name="neutrophil_high"><br>
	neutrophil_Val <input type="text" name="neutrophil_val"><br>
	 -->
	neutrophil_Max_Date <input type="text" name="neutrophil_max_date" value="2011-10-11_11:00:00"><br>
	neutrophil_Min_Date <input type="text" name="neutrophil_min_date" value="2011-10-11_11:00:00"><br>
	neutrophil_Low <input type="text" name="neutrophil_low"><br>
	neutrophil_High <input type="text" name="neutrophil_high"><br>
	neutrophil_Max_Val <input type="text" name="neutrophil_max_val"><br>
	neutrophil_Min_Val <input type="text" name="neutrophil_min_val"><br>
	
	<!-- 
	cholesterol <input type="text" name="cholesterol" value="2011-10-11_11:00:00"><br>
	cholesterol_Low <input type="text" name="cholesterol_low"><br>
	cholesterol_High <input type="text" name="cholesterol_high"><br>
	cholesterol_Val <input type="text" name="cholesterol_val"><br>
	 -->
	cholesterol_Max_Date <input type="text" name="cholesterol_max_date" value="2011-10-11_11:00:00"><br>
	cholesterol_Min_Date <input type="text" name="cholesterol_min_date" value="2011-10-11_11:00:00"><br>
	cholesterol_Low <input type="text" name="cholesterol_low"><br>
	cholesterol_High <input type="text" name="cholesterol_high"><br>
	cholesterol_Max_Val <input type="text" name="cholesterol_max_val"><br>
	cholesterol_Min_Val <input type="text" name="cholesterol_min_val"><br>
	<!-- 
	systolic blood pressure <input type="text" name="Systolic_Blood_Pressure" value="2011-10-11_11:00:00"><br>
	systolic blood pressure_low <input type="text" name="Systolic_Blood_Pressure_low"><br>
	systolic blood pressure_high <input type="text" name="Systolic_Blood_Pressure_high"><br>
	systolic blood pressure_val <input type="text" name="Systolic_Blood_Pressure_val"><br>
	 -->
	Systolic_Blood_Pressure_Max_Date <input type="text" name="Systolic_Blood_Pressure_max_date" value="2011-10-11_11:00:00"><br>
	Systolic_Blood_Pressure_Min_Date <input type="text" name="Systolic_Blood_Pressure_min_date" value="2011-10-11_11:00:00"><br>
	Systolic_Blood_Pressure_Low <input type="text" name="Systolic_Blood_Pressure_low"><br>
	Systolic_Blood_Pressure_High <input type="text" name="Systolic_Blood_Pressure_high"><br>
	Systolic_Blood_Pressure_Max_Val <input type="text" name="Systolic_Blood_Pressure_max_val"><br>
	Systolic_Blood_Pressure_Min_Val <input type="text" name="Systolic_Blood_Pressure_min_val"><br>
	
	<!-- 
	diastolic blood pressure <input type="text" name="Diastolic_Blood_Pressure" value="2011-10-11_11:00:00"><br>
	diastolic blood pressure_low <input type="text" name="Diastolic_Blood_Pressure_low"><br>
	diastolic blood pressure_high <input type="text" name="Diastolic_Blood_Pressure_high"><br>
	diastolic blood pressure_val <input type="text" name="Diastolic_Blood_Pressure_val"><br>
	 -->
	Diastolic_Blood_Pressure_Max_Date <input type="text" name="Diastolic_Blood_Pressure_max_date" value="2011-10-11_11:00:00"><br>
	Diastolic_Blood_Pressure_Min_Date <input type="text" name="Diastolic_Blood_Pressure_min_date" value="2011-10-11_11:00:00"><br>
	Diastolic_Blood_Pressure_Low <input type="text" name="Diastolic_Blood_Pressure_low"><br>
	Diastolic_Blood_Pressure_High <input type="text" name="Diastolic_Blood_Pressure_high"><br>
	Diastolic_Blood_Pressure_Max_Val <input type="text" name="Diastolic_Blood_Pressure_max_val"><br>
	Diastolic_Blood_Pressure_Min_Val <input type="text" name="Diastolic_Blood_Pressure_min_val"><br>
	
	<!--
	pco2 <input type="text" name="pco2" value="2011-10-11_11:00:00"><br>
	pco2_Low <input type="text" name="pco2_low"><br>
	pco2_High <input type="text" name="pco2_high"><br>
	pco2_Val <input type="text" name="pco2_val"><br>
	-->
	pco2_Max_Date <input type="text" name="pco2_max_date" value="2011-10-11_11:00:00"><br>
	pco2_Min_Date <input type="text" name="pco2_min_date" value="2011-10-11_11:00:00"><br>
	pco2_Low <input type="text" name="pco2_low"><br>
	pco2_High <input type="text" name="pco2_high"><br>
	pco2_Max_Val <input type="text" name="pco2_max_val"><br>
	pco2_Min_Val <input type="text" name="pco2_min_val"><br>
	
	<!--
	pco2_prev <input type="text" name="pco2_prev" value="2011-10-11_11:00:00"><br>
	pco2_prev_Low <input type="text" name="pco2_prev_low"><br>
	pco2_prev_High <input type="text" name="pco2_prev_high"><br>
	pco2_prev_Val <input type="text" name="pco2_prev_val"><br>
	-->
	pco2_prev_Max_Date <input type="text" name="pco2_prev_max_date" value="2011-10-11_11:00:00"><br>
	pco2_prev_Min_Date <input type="text" name="pco2_prev_min_date" value="2011-10-11_11:00:00"><br>
	pco2_prev_Low <input type="text" name="pco2_prev_low"><br>
	pco2_prev_High <input type="text" name="pco2_prev_high"><br>
	pco2_prev_Max_Val <input type="text" name="pco2_prev_max_val"><br>
	pco2_prev_Min_Val <input type="text" name="pco2_prev_min_val"><br>
	<!--
	etco2 <input type="text" name="etco2" value="2011-10-11_11:00:00"><br>
	etco2_Low <input type="text" name="etco2_low"><br>
	etco2_High <input type="text" name="etco2_high"><br>
	etco2_Val <input type="text" name="etco2_val"><br>
	
	etco2_prev <input type="text" name="etco2_prev" value="2011-10-11_11:00:00"><br>
	etco2_prev_Low <input type="text" name="etco2_prev_low"><br>
	etco2_prev_High <input type="text" name="etco2_prev_high"><br>
	etco2_prev_Val <input type="text" name="etco2_prev_val"><br>
	-->
	etco2_Max_Date <input type="text" name="etco2_max_date" value="2011-10-11_11:00:00"><br>
	etco2_Min_Date <input type="text" name="etco2_min_date" value="2011-10-11_11:00:00"><br>
	etco2_Low <input type="text" name="etco2_low"><br>
	etco2_High <input type="text" name="etco2_high"><br>
	etco2_Max_Val <input type="text" name="etco2_max_val"><br>
	etco2_Min_Val <input type="text" name="etco2_min_val"><br>
	
	etco2_prev_Max_Date <input type="text" name="etco2_prev_max_date" value="2011-10-11_11:00:00"><br>
	etco2_prev_Min_Date <input type="text" name="etco2_prev_min_date" value="2011-10-11_11:00:00"><br>
	etco2_prev_Low <input type="text" name="etco2_prev_low"><br>
	etco2_prev_High <input type="text" name="etco2_prev_high"><br>
	etco2_prev_Max_Val <input type="text" name="etco2_prev_max_val"><br>
	etco2_prev_Min_Val <input type="text" name="etco2_prev_min_val"><br>
	
	<!-- 
	po2 <input type="text" name="po2" value="2011-10-11_11:00:00"><br>
	po2_Low <input type="text" name="po2_low"><br>
	po2_High <input type="text" name="po2_high"><br>
	po2_Val <input type="text" name="po2_val"><br>
	 -->
	po2_Max_Date <input type="text" name="po2_max_date" value="2011-10-11_11:00:00"><br>
	po2_Min_Date <input type="text" name="po2_min_date" value="2011-10-11_11:00:00"><br>
	po2_Low <input type="text" name="po2_low"><br>
	po2_High <input type="text" name="po2_high"><br>
	po2_Max_Val <input type="text" name="po2_max_val"><br>
	po2_Min_Val <input type="text" name="po2_min_val"><br>
	
	<!-- 
	o2sat <input type="text" name="o2sat" value="2011-10-11_11:00:00"><br>
	o2sat_Low <input type="text" name="o2sat_low"><br>
	o2sat_High <input type="text" name="o2sat_high"><br>
	o2sat_Val <input type="text" name="o2sat_val"><br>
	 -->
	o2sat_Max_Date <input type="text" name="o2sat_max_date" value="2011-10-11_11:00:00"><br>
	o2sat_Min_Date <input type="text" name="o2sat_min_date" value="2011-10-11_11:00:00"><br>
	o2sat_Low <input type="text" name="o2sat_low"><br>
	o2sat_High <input type="text" name="o2sat_high"><br>
	o2sat_Max_Val <input type="text" name="o2sat_max_val"><br>
	o2sat_Min_Val <input type="text" name="o2sat_min_val"><br>
	
	Pulse_Oximetry_Max_Date <input type="text" name="oximetry_max_date" value="2011-10-11_11:00:00"><br>
	Pulse_Oximetry_Min_Date <input type="text" name="oximetry_min_date" value="2011-10-11_11:00:00"><br>
	Pulse_Oximetry_Low <input type="text" name="oximetry_low"><br>
	Pulse_Oximetry_High <input type="text" name="oximetry_high"><br>
	Pulse_Oximetry_Max_Val <input type="text" name="oximetry_max_val"><br>
	Pulse_Oximetry_Min_Val <input type="text" name="oximetry_min_val"><br>
	
	<!--
	bun <input type="text" name="bun" value="2011-10-11_11:00:00"><br>
	bun_Low <input type="text" name="bun_low"><br>
	bun_High <input type="text" name="bun_high"><br>
	bun_Val <input type="text" name="bun_val"><br>
	-->
	bun_Max_Date <input type="text" name="bun_max_date" value="2011-10-11_11:00:00"><br>
	bun_Min_Date <input type="text" name="bun_min_date" value="2011-10-11_11:00:00"><br>
	bun_Low <input type="text" name="bun_low"><br>
	bun_High <input type="text" name="bun_high"><br>
	bun_Max_Val <input type="text" name="bun_max_val"><br>
	bun_Min_Val <input type="text" name="bun_min_val"><br>
	<!--
	WB bun <input type="text" name="wb_bun" value="2011-10-11_11:00:00"><br>
	WB bun_Low <input type="text" name="wb_bun_low"><br>
	WB bun_High <input type="text" name="wb_bun_high"><br>
	WB bun_Val <input type="text" name="wb_bun_val"><br>
	-->
	wb_bun_Max_Date <input type="text" name="wb_bun_max_date" value="2011-10-11_11:00:00"><br>
	wb_bun_Min_Date <input type="text" name="wb_bun_min_date" value="2011-10-11_11:00:00"><br>
	wb_bun_Low <input type="text" name="wb_bun_low"><br>
	wb_bun_High <input type="text" name="wb_bun_high"><br>
	wb_bun_Max_Val <input type="text" name="wb_bun_max_val"><br>
	wb_bun_Min_Val <input type="text" name="wb_bun_min_val"><br>
	
	<!-- 
	creat <input type="text" name="creat" value="2011-10-11_11:00:00"><br>
	creat_Low <input type="text" name="creat_low"><br>
	creat_High <input type="text" name="creat_high"><br>
	creat_Val <input type="text" name="creat_val"><br>	
	
	creat_prev <input type="text" name="creat_prev" value="2011-10-11_11:00:00"><br>
	creat_prev_Low <input type="text" name="creat_prev_low"><br>
	creat_prev_High <input type="text" name="creat_prev_high"><br>
	creat_prev_Val <input type="text" name="creat_prev_val"><br>
	-->
	creat_Max_Date <input type="text" name="creat_max_date" value="2011-10-11_11:00:00"><br>
	creat_Min_Date <input type="text" name="creat_min_date" value="2011-10-11_11:00:00"><br>
	creat_Low <input type="text" name="creat_low" value="6"><br>
	creat_High <input type="text" name="creat_high" value="78"><br>
	creat_Max_Val <input type="text" name="creat_max_val" value="79"><br>
	creat_Min_Val <input type="text" name="creat_min_val" value="8"><br>
	
	creat_prev_Max_Date <input type="text" name="creat_prev_max_date" value="2011-10-11_11:00:00"><br>
	creat_prev_Min_Date <input type="text" name="creat_prev_min_date" value="2011-10-11_11:00:00"><br>
	creat_prev_Low <input type="text" name="creat_prev_low" value="22"><br>
	creat_prev_High <input type="text" name="creat_prev_high" value="33"><br>
	creat_prev_Max_Val <input type="text" name="creat_prev_max_val" value="44"><br>
	creat_prev_Min_Val <input type="text" name="creat_prev_min_val" value="55"><br>
	
	wb_creat_Max_Date <input type="text" name="wb_creat_max_date" value="2011-10-11_11:00:00"><br>
	wb_creat_Min_Date <input type="text" name="wb_creat_min_date" value="2011-10-11_11:00:00"><br>
	wb_creat_Low <input type="text" name="wb_creat_low"><br>
	wb_creat_High <input type="text" name="wb_creat_high"><br>
	wb_creat_Max_Val <input type="text" name="wb_creat_max_val"><br>
	wb_creat_Min_Val <input type="text" name="wb_creat_min_val"><br>
	
	wb_creat_prev_Max_Date <input type="text" name="wb_creat_prev_max_date" value="2011-10-11_11:00:00"><br>
	wb_creat_prev_Min_Date <input type="text" name="wb_creat_prev_min_date" value="2011-10-11_11:00:00"><br>
	wb_creat_prev_Low <input type="text" name="wb_creat_prev_low"><br>
	wb_creat_prev_High <input type="text" name="wb_creat_prev_high"><br>
	wb_creat_prev_Max_Val <input type="text" name="wb_creat_prev_max_val"><br>
	wb_creat_prev_Min_Val <input type="text" name="wb_creat_prev_min_val"><br>
	
	<!-- 
	gfr <input type="text" name="gfr" value="2011-10-11_11:00:00"><br>
	gfr_Low <input type="text" name="gfr_low"><br>
	gfr_High <input type="text" name="gfr_high"><br>
	gfr_Val <input type="text" name="gfr_val"><br>
	 -->
	gfr_Max_Date <input type="text" name="gfr_max_date" value="2011-10-11_11:00:00"><br>
	gfr_Min_Date <input type="text" name="gfr_min_date" value="2011-10-11_11:00:00"><br>
	
	gfr_Max_Val <input type="text" name="gfr_max_val"><br>
	gfr_Min_Val <input type="text" name="gfr_min_val"><br>
	
	<!-- 
	hb <input type="text" name="hb" value="2011-10-11_11:00:00"><br>
	hb_Low <input type="text" name="hb_low"><br>
	hb_High <input type="text" name="hb_high"><br>
	hb_Val <input type="text" name="hb_val"><br>	
	
	hb_prev <input type="text" name="hb_prev" value="2011-10-11_11:00:00"><br>
	hb_prev_Low <input type="text" name="hb_prev_low"><br>
	hb_prev_High <input type="text" name="hb_prev_high"><br>
	hb_prev_Val <input type="text" name="hb_prev_val"><br>
	 -->
	hb_Max_Date <input type="text" name="hb_max_date" value="2011-10-11_11:00:00"><br>
	hb_Min_Date <input type="text" name="hb_min_date" value="2011-10-11_11:00:00"><br>
	hb_Low <input type="text" name="hb_low"><br>
	hb_High <input type="text" name="hb_high"><br>
	hb_Max_Val <input type="text" name="hb_max_val"><br>
	hb_Min_Val <input type="text" name="hb_min_val"><br>
	
	hb_prev_Max_Date <input type="text" name="hb_prev_max_date" value="2011-10-11_11:00:00"><br>
	hb_prev_Min_Date <input type="text" name="hb_prev_min_date" value="2011-10-11_11:00:00"><br>
	hb_prev_Low <input type="text" name="hb_prev_low"><br>
	hb_prev_High <input type="text" name="hb_prev_high"><br>
	hb_prev_Max_Val <input type="text" name="hb_prev_max_val"><br>
	hb_prev_Min_Val <input type="text" name="hb_prev_min_val"><br>
	
	<!-- 
	hc <input type="text" name="hc" value="2011-10-11_11:00:00"><br>
	hc_Low <input type="text" name="hc_low"><br>
	hc_High <input type="text" name="hc_high"><br>
	hc_Val <input type="text" name="hc_val"><br>	
	
	hc_prev <input type="text" name="hc_prev" value="2011-10-11_11:00:00"><br>
	hc_prev_Low <input type="text" name="hc_prev_low"><br>
	hc_prev_High <input type="text" name="hc_prev_high"><br>
	hc_prev_Val <input type="text" name="hc_prev_val"><br>
	 -->
	hc_Max_Date <input type="text" name="hc_max_date" value="2011-10-11_11:00:00"><br>
	hc_Min_Date <input type="text" name="hc_min_date" value="2011-10-11_11:00:00"><br>
	hc_Low <input type="text" name="hc_low"><br>
	hc_High <input type="text" name="hc_high"><br>
	hc_Max_Val <input type="text" name="hc_max_val"><br>
	hc_Min_Val <input type="text" name="hc_min_val"><br>
	
	hc_prev_Max_Date <input type="text" name="hc_prev_max_date" value="2011-10-11_11:00:00"><br>
	hc_prev_Min_Date <input type="text" name="hc_prev_min_date" value="2011-10-11_11:00:00"><br>
	hc_prev_Low <input type="text" name="hc_prev_low"><br>
	hc_prev_High <input type="text" name="hc_prev_high"><br>
	hc_prev_Max_Val <input type="text" name="hc_prev_max_val"><br>
	hc_prev_Min_Val <input type="text" name="hc_prev_min_val"><br>
	
	<!--
	ct <input type="text" name="ct" value="2011-10-11_11:00:00"><br>
	ct_Low <input type="text" name="ct_low"><br>
	ct_High <input type="text" name="ct_high"><br>
	ct_Val <input type="text" name="ct_val"><br>
	-->
	ct_Max_Date <input type="text" name="ct_max_date" value="2011-10-11_11:00:00"><br>
	ct_Min_Date <input type="text" name="ct_min_date" value="2011-10-11_11:00:00"><br>
	ct_Low <input type="text" name="ct_low"><br>
	ct_High <input type="text" name="ct_high"><br>
	ct_Max_Val <input type="text" name="ct_max_val"><br>
	ct_Min_Val <input type="text" name="ct_min_val"><br>
	
	<!--
	wbc <input type="text" name="wbc" value="2011-10-11_11:00:00"><br>
	wbc_Low <input type="text" name="wbc_low"><br>
	wbc_High <input type="text" name="wbc_high"><br>
	wbc_Val <input type="text" name="wbc_val"><br>
	-->
	wbc_Max_Date <input type="text" name="wbc_max_date" value="2011-10-11_11:00:00"><br>
	wbc_Min_Date <input type="text" name="wbc_min_date" value="2011-10-11_11:00:00"><br>
	wbc_Low <input type="text" name="wbc_low"><br>
	wbc_High <input type="text" name="wbc_high"><br>
	wbc_Max_Val <input type="text" name="wbc_max_val"><br>
	wbc_Min_Val <input type="text" name="wbc_min_val"><br>
	
	<!-- 
	utiWbc <input type="text" name="utiWbc" value="2011-10-11_11:00:00"><br>
	utiWbc_Low <input type="text" name="utiWbc_low"><br>
	utiWbc_High <input type="text" name="utiWbc_high"><br>
	utiWbc_Val <input type="text" name="utiWbc_val"><br>
	 -->
	 utiWbc_Max_Date <input type="text" name="utiWbc_max_date" value="2011-10-11_11:00:00"><br>
	utiWbc_Min_Date <input type="text" name="utiWbc_min_date" value="2011-10-11_11:00:00"><br>
	utiWbc_Low <input type="text" name="utiWbc_low"><br>
	utiWbc_High <input type="text" name="utiWbc_high"><br>
	utiWbc_Max_Val <input type="text" name="utiWbc_max_val"><br>
	utiWbc_Min_Val <input type="text" name="utiWbc_min_val"><br>
	
	<!-- 
	leucocyte_nitrite <input type="text" name="leucocyte_nitrite" value="2011-10-11_11:00:00"><br>
	leucocyte_nitrite_Low <input type="text" name="leucocyte_nitrite_low"><br>
	leucocyte_nitrite_High <input type="text" name="leucocyte_nitrite_high"><br>
	leucocyte_nitrite_Val <input type="text" name="leucocyte_nitrite_val" id="leucocyte_nitrite_val"><br>
	 -->
	leucocyte_nitrite_Max_Date <input type="text" name="leucocyte_nitrite_max_date" value="2011-10-11_11:00:00"><br>
	leucocyte_nitrite_Min_Date <input type="text" name="leucocyte_nitrite_min_date" value="2011-10-11_11:00:00"><br>
	leucocyte_nitrite_Low <input type="text" name="leucocyte_nitrite_low"><br>
	leucocyte_nitrite_High <input type="text" name="leucocyte_nitrite_high"><br>
	leucocyte_nitrite_Max_Val <input type="text" name="leucocyte_nitrite_max_val"><br>
	leucocyte_nitrite_Min_Val <input type="text" name="leucocyte_nitrite_min_val"><br>
	
	<!--
	leucocyte_esterate <input type="text" name="leucocyte_esterate" value="2011-10-11_11:00:00"><br>
	leucocyte_esterate_Low <input type="text" name="leucocyte_esterate_low"><br>
	leucocyte_esterate_High <input type="text" name="leucocyte_esterate_high"><br>
	leucocyte_esterate_Val <input type="text" name="leucocyte_esterate_val" id="leucocyte_esterate_val"><br>
	-->
	leucocyte_esterate_Max_Date <input type="text" name="leucocyte_esterate_max_date" value="2011-10-11_11:00:00"><br>
	leucocyte_esterate_Min_Date <input type="text" name="leucocyte_esterate_min_date" value="2011-10-11_11:00:00"><br>
	leucocyte_esterate_Low <input type="text" name="leucocyte_esterate_low"><br>
	leucocyte_esterate_High <input type="text" name="leucocyte_esterate_high"><br>
	leucocyte_esterate_Max_Val <input type="text" name="leucocyte_esterate_max_val" id="leucocyte_esterate_max_val"><br>
	leucocyte_esterate_Min_Val <input type="text" name="leucocyte_esterate_min_val" id="leucocyte_esterate_min_val"><br>
	
	<!-- 
	hr <input type="text" name="hr" value="2011-10-11_11:00:00"><br>
	hr_Low <input type="text" name="hr_low"><br>
	hr_High <input type="text" name="hr_high"><br>
	hr_Val <input type="text" name="hr_val"><br>
	 -->
	hr_Max_Date <input type="text" name="hr_max_date" value="2011-10-11_11:00:00"><br>
	hr_Min_Date <input type="text" name="hr_min_date" value="2011-10-11_11:00:00"><br>
	hr_Low <input type="text" name="hr_low"><br>
	hr_High <input type="text" name="hr_high"><br>
	hr_Max_Val <input type="text" name="hr_max_val"><br>
	hr_Min_Val <input type="text" name="hr_min_val"><br>
	
	<!--
	rr <input type="text" name="rr" value="2011-10-11_11:00:00"><br>
	rr_Low <input type="text" name="rr_low"><br>
	rr_High <input type="text" name="rr_high"><br>
	rr_Val <input type="text" name="rr_val"><br>
	-->
	rr_Max_Date <input type="text" name="rr_max_date" value="2011-10-11_11:00:00"><br>
	rr_Min_Date <input type="text" name="rr_min_date" value="2011-10-11_11:00:00"><br>
	rr_Low <input type="text" name="rr_low"><br>
	rr_High <input type="text" name="rr_high"><br>
	rr_Max_Val <input type="text" name="rr_max_val"><br>
	rr_Min_Val <input type="text" name="rr_min_val"><br>
	
	<!--
	temp <input type="text" name="temp" value="2011-10-11_11:00:00"><br>
	temp_Low <input type="text" name="temp_low"><br>
	temp_High <input type="text" name="temp_high"><br>
	temp_Val <input type="text" name="temp_val"><br>
	-->
	temp_Max_Date <input type="text" name="temp_max_date" value="2011-10-11_11:00:00"><br>
	temp_Min_Date <input type="text" name="temp_min_date" value="2011-10-11_11:00:00"><br>
	temp_Low <input type="text" name="temp_low"><br>
	temp_High <input type="text" name="temp_high"><br>
	temp_Max_Val <input type="text" name="temp_max_val"><br>
	temp_Min_Val <input type="text" name="temp_min_val"><br>
	

	lactate_Max_Date <input type="text" name="lactate_max_date" value="2011-10-11_11:00:00"><br>
	lactate_Min_Date <input type="text" name="lactate_min_date" value="2011-10-11_11:00:00"><br>
	lactate_Low <input type="text" name="lactate_low"><br>
	lactate_High <input type="text" name="lactate_high"><br>
	lactate_Max_Val <input type="text" name="lactate_max_val"><br>
	lactate_Min_Val <input type="text" name="lactate_min_val"><br>
	
	
	lactic_acid_Max_Date <input type="text" name="lactic_acid_max_date" value="2011-10-11_11:00:00"><br>
	lactic_acid_Min_Date <input type="text" name="lactic_acid_min_date" value="2011-10-11_11:00:00"><br>
	lactic_acid_Max_Val <input type="text" name="lactic_acid_max_val"><br>
	lactic_acid_Min_Val <input type="text" name="lactic_acid_min_val"><br>	
	Lactic Acid Low:	<input type="text"  name="lactic_acid_low"><br> 
    Lactic Acid High:	<input type="text"  name="lactic_acid_high"><br>
	
	
	wb_lactic_acid_Max_Date <input type="text" name="wb_lactic_acid_max_date" value="2011-10-11_11:00:00"><br>
	wb_lactic_acid_Min_Date <input type="text" name="wb_lactic_acid_min_date" value="2011-10-11_11:00:00"><br>
	wb_lactic_acid_Max_Val <input type="text" name="wb_lactic_acid_max_val"><br>
	wb_lactic_acid_Min_Val <input type="text" name="wb_lactic_acid_min_val"><br>
	Lactic Acid, Whole Blood Low:	<input type="text"  name="wb_lactic_acid_low"><br> 
	Lactic Acid, Whole Blood High:	<input type="text"  name="wb_lactic_acid_high"><br>
	
	
	Dehydration Creatinine Date: <input type="text" id='dehydration_creat_date' name="dehydration_creat_date" value="2011-10-11_11:00:00"><br>
	Dehydration BUN Date: <input type="text" id='dehydration_bun_date' name="dehydration_bun_date" value="2011-10-11_11:00:00"><br>
    Dehydration Creatinine: <input type="text" id='dehydration_creat' name="dehydration_creat"><br>
    Dehydration BUN: <input type="text" id='dehydration_bun' name="dehydration_bun"><br>
	
	<input type="Submit">	
</form>
</body>
</html>