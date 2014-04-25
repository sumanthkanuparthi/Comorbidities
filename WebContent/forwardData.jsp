<%@page import="java.util.*"%>   
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Forward Data</title>

<script type="text/javascript">

function getValuesFromParent(){
	
//	alert("Start of gvfp");
	document.getElementById("encntr_id").value= window.parent.document.getElementById("encntr_id").value;
       document.getElementById("user_id").value= window.parent.document.getElementById("user_id").value;
	document.getElementById("sodium_max_date").value = window.parent.document.getElementById("sodium_max_date").value;
	document.getElementById("sodium_min_date").value = window.parent.document.getElementById("sodium_min_date").value;
	document.getElementById("sodium_high").value = window.parent.document.getElementById("sodium_high").value;
	document.getElementById("sodium_low").value = window.parent.document.getElementById("sodium_low").value;
	document.getElementById("sodium_max_val").value = window.parent.document.getElementById("sodium_max_val").value;
	document.getElementById("sodium_min_val").value = window.parent.document.getElementById("sodium_min_val").value;
	
// 	document.getElementById("potassium").value = window.parent.document.getElementById("potassium").value;
// 	document.getElementById("potassium_high").value = window.parent.document.getElementById("potassium_high").value;
// 	document.getElementById("potassium_low").value = window.parent.document.getElementById("potassium_low").value;
// 	document.getElementById("potassium_val").value = window.parent.document.getElementById("potassium_val").value;	
	document.getElementById("potassium_max_date").value = window.parent.document.getElementById("potassium_max_date").value;
	document.getElementById("potassium_min_date").value = window.parent.document.getElementById("potassium_min_date").value;
	document.getElementById("potassium_high").value = window.parent.document.getElementById("potassium_high").value;
	document.getElementById("potassium_low").value = window.parent.document.getElementById("potassium_low").value;
	document.getElementById("potassium_max_val").value = window.parent.document.getElementById("potassium_max_val").value;
	document.getElementById("potassium_min_val").value = window.parent.document.getElementById("potassium_min_val").value;
	
// 	document.getElementById("calcium").value = window.parent.document.getElementById("calcium").value;
// 	document.getElementById("calcium_high").value = window.parent.document.getElementById("calcium_high").value;
// 	document.getElementById("calcium_low").value = window.parent.document.getElementById("calcium_low").value;
// 	document.getElementById("calcium_val").value = window.parent.document.getElementById("calcium_val").value;
	document.getElementById("calcium_max_date").value = window.parent.document.getElementById("calcium_max_date").value;
	document.getElementById("calcium_min_date").value = window.parent.document.getElementById("calcium_min_date").value;
	
	document.getElementById("calcium_high").value = window.parent.document.getElementById("calcium_high").value;
	document.getElementById("calcium_low").value = window.parent.document.getElementById("calcium_low").value;
	document.getElementById("calcium_max_val").value = window.parent.document.getElementById("calcium_max_val").value;
	document.getElementById("calcium_min_val").value = window.parent.document.getElementById("calcium_min_val").value;
	
// 	document.getElementById("phosphorus").value = window.parent.document.getElementById("phosphorus").value;
// 	document.getElementById("phosphorus_high").value = window.parent.document.getElementById("phosphorus_high").value;
// 	document.getElementById("phosphorus_low").value = window.parent.document.getElementById("phosphorus_low").value;
// 	document.getElementById("phosphorus_val").value = window.parent.document.getElementById("phosphorus_val").value;
	document.getElementById("phosphorus_max_date").value = window.parent.document.getElementById("phosphorus_max_date").value;
	document.getElementById("phosphorus_min_date").value = window.parent.document.getElementById("phosphorus_min_date").value;
	document.getElementById("phosphorus_high").value = window.parent.document.getElementById("phosphorus_high").value;
	document.getElementById("phosphorus_low").value = window.parent.document.getElementById("phosphorus_low").value;
	document.getElementById("phosphorus_max_val").value = window.parent.document.getElementById("phosphorus_max_val").value;
	document.getElementById("phosphorus_min_val").value = window.parent.document.getElementById("phosphorus_min_val").value;
	
	
// 	document.getElementById("magnesium").value = window.parent.document.getElementById("magnesium").value;
// 	document.getElementById("magnesium_high").value = window.parent.document.getElementById("magnesium_high").value;
// 	document.getElementById("magnesium_low").value = window.parent.document.getElementById("magnesium_low").value;
// 	document.getElementById("magnesium_val").value = window.parent.document.getElementById("magnesium_val").value;
	document.getElementById("magnesium_max_date").value = window.parent.document.getElementById("magnesium_max_date").value;
	document.getElementById("magnesium_min_date").value = window.parent.document.getElementById("magnesium_min_date").value;
	document.getElementById("magnesium_high").value = window.parent.document.getElementById("magnesium_high").value;
	document.getElementById("magnesium_low").value = window.parent.document.getElementById("magnesium_low").value;
	document.getElementById("magnesium_max_val").value = window.parent.document.getElementById("magnesium_max_val").value;
	document.getElementById("magnesium_min_val").value = window.parent.document.getElementById("magnesium_min_val").value;
	
// 	document.getElementById("cholesterol").value = window.parent.document.getElementById("cholesterol").value;
// 	document.getElementById("cholesterol_high").value = window.parent.document.getElementById("cholesterol_high").value;
// 	document.getElementById("cholesterol_low").value = window.parent.document.getElementById("cholesterol_low").value;
// 	document.getElementById("cholesterol_val").value = window.parent.document.getElementById("cholesterol_val").value;	
	document.getElementById("cholesterol_max_date").value = window.parent.document.getElementById("cholesterol_max_date").value;
	document.getElementById("cholesterol_min_date").value = window.parent.document.getElementById("cholesterol_min_date").value;
	document.getElementById("cholesterol_high").value = window.parent.document.getElementById("cholesterol_high").value;
	document.getElementById("cholesterol_low").value = window.parent.document.getElementById("cholesterol_low").value;
	document.getElementById("cholesterol_max_val").value = window.parent.document.getElementById("cholesterol_max_val").value;
	document.getElementById("cholesterol_min_val").value = window.parent.document.getElementById("cholesterol_min_val").value;
	
// 	document.getElementById("glucose").value = window.parent.document.getElementById("glucose").value;
// 	document.getElementById("glucose_high").value = window.parent.document.getElementById("glucose_high").value;
// 	document.getElementById("glucose_low").value = window.parent.document.getElementById("glucose_low").value;
// 	document.getElementById("glucose_val").value = window.parent.document.getElementById("glucose_val").value;
 	document.getElementById("glucose_max_date").value = window.parent.document.getElementById("glucose_max_date").value;
	document.getElementById("glucose_min_date").value = window.parent.document.getElementById("glucose_min_date").value;
	document.getElementById("glucose_high").value = window.parent.document.getElementById("glucose_high").value;
	document.getElementById("glucose_low").value = window.parent.document.getElementById("glucose_low").value;
	document.getElementById("glucose_max_val").value = window.parent.document.getElementById("glucose_max_val").value;
	document.getElementById("glucose_min_val").value = window.parent.document.getElementById("glucose_min_val").value;
	
	
// 	document.getElementById("neutrophil").value = window.parent.document.getElementById("neutrophil").value;
// 	document.getElementById("neutrophil_high").value = window.parent.document.getElementById("neutrophil_high").value;
// 	document.getElementById("neutrophil_low").value = window.parent.document.getElementById("neutrophil_low").value;
// 	document.getElementById("neutrophil_val").value = window.parent.document.getElementById("neutrophil_val").value;
	document.getElementById("neutrophil_max_date").value = window.parent.document.getElementById("neutrophil_max_date").value;
	document.getElementById("neutrophil_min_date").value = window.parent.document.getElementById("neutrophil_min_date").value;
	document.getElementById("neutrophil_high").value = window.parent.document.getElementById("neutrophil_high").value;
	document.getElementById("neutrophil_low").value = window.parent.document.getElementById("neutrophil_low").value;
	document.getElementById("neutrophil_max_val").value = window.parent.document.getElementById("neutrophil_max_val").value;
	document.getElementById("neutrophil_min_val").value = window.parent.document.getElementById("neutrophil_min_val").value;
	
// 	document.getElementById("lactic_acid").value = window.parent.document.getElementById("lactic_acid").value;
// 	document.getElementById("lactic_acid_high").value = window.parent.document.getElementById("lactic_acid_high").value;
// 	document.getElementById("lactic_acid_low").value = window.parent.document.getElementById("lactic_acid_low").value;
// 	document.getElementById("lactic_acid_val").value = window.parent.document.getElementById("lactic_acid_val").value;
	document.getElementById("lactic_acid_max_date").value = window.parent.document.getElementById("lactic_acid_max_date").value;
	document.getElementById("lactic_acid_min_date").value = window.parent.document.getElementById("lactic_acid_min_date").value;
	document.getElementById("lactic_acid_max_val").value = window.parent.document.getElementById("lactic_acid_max_val").value;
	document.getElementById("lactic_acid_min_val").value = window.parent.document.getElementById("lactic_acid_min_val").value;
	document.getElementById("lactic_acid_low").value = window.parent.document.getElementById("lactic_acid_low").value;
	document.getElementById("lactic_acid_high").value = window.parent.document.getElementById("lactic_acid_high").value;
	
// 	document.getElementById("weight").value = window.parent.document.getElementById("weight").value;
// 	document.getElementById("weight_val").value = window.parent.document.getElementById("weight_val").value;
	document.getElementById("weight_max_date").value = window.parent.document.getElementById("weight_max_date").value;
	document.getElementById("weight_min_date").value = window.parent.document.getElementById("weight_min_date").value;
	document.getElementById("weight_max_val").value = window.parent.document.getElementById("weight_max_val").value;
	document.getElementById("weight_min_val").value = window.parent.document.getElementById("weight_min_val").value;
	
// 	document.getElementById("height").value = window.parent.document.getElementById("height").value;
// 	document.getElementById("height_val").value = window.parent.document.getElementById("height_val").value;
	document.getElementById("height_max_date").value = window.parent.document.getElementById("height_max_date").value;
	document.getElementById("height_min_date").value = window.parent.document.getElementById("height_min_date").value;
	document.getElementById("height_max_val").value = window.parent.document.getElementById("height_max_val").value;
	document.getElementById("height_min_val").value = window.parent.document.getElementById("height_min_val").value;
	
// 	document.getElementById("Diastolic_Blood_Pressure").value = window.parent.document.getElementById("Diastolic_Blood_Pressure").value;
// 	document.getElementById("Diastolic_Blood_Pressure_high").value = window.parent.document.getElementById("Diastolic_Blood_Pressure_high").value;
// 	document.getElementById("Diastolic_Blood_Pressure_low").value = window.parent.document.getElementById("Diastolic_Blood_Pressure_low").value;
// 	document.getElementById("Diastolic_Blood_Pressure_val").value = window.parent.document.getElementById("Diastolic_Blood_Pressure_val").value;
	document.getElementById("Diastolic_Blood_Pressure_max_date").value = window.parent.document.getElementById("Diastolic_Blood_Pressure_max_date").value;
	document.getElementById("Diastolic_Blood_Pressure_min_date").value = window.parent.document.getElementById("Diastolic_Blood_Pressure_min_date").value;
	document.getElementById("Diastolic_Blood_Pressure_high").value = window.parent.document.getElementById("Diastolic_Blood_Pressure_high").value;
	document.getElementById("Diastolic_Blood_Pressure_low").value = window.parent.document.getElementById("Diastolic_Blood_Pressure_low").value;
	document.getElementById("Diastolic_Blood_Pressure_max_val").value = window.parent.document.getElementById("Diastolic_Blood_Pressure_max_val").value;
	document.getElementById("Diastolic_Blood_Pressure_min_val").value = window.parent.document.getElementById("Diastolic_Blood_Pressure_min_val").value;
	
// 	document.getElementById("Systolic_Blood_Pressure").value = window.parent.document.getElementById("Systolic_Blood_Pressure").value;
// 	document.getElementById("Systolic_Blood_Pressure_high").value = window.parent.document.getElementById("Systolic_Blood_Pressure_high").value;
// 	document.getElementById("Systolic_Blood_Pressure_low").value = window.parent.document.getElementById("Systolic_Blood_Pressure_low").value;
// 	document.getElementById("Systolic_Blood_Pressure_val").value = window.parent.document.getElementById("Systolic_Blood_Pressure_val").value;
	document.getElementById("Systolic_Blood_Pressure_max_date").value = window.parent.document.getElementById("Systolic_Blood_Pressure_max_date").value;
	document.getElementById("Systolic_Blood_Pressure_min_date").value = window.parent.document.getElementById("Systolic_Blood_Pressure_min_date").value;
	document.getElementById("Systolic_Blood_Pressure_high").value = window.parent.document.getElementById("Systolic_Blood_Pressure_high").value;
	document.getElementById("Systolic_Blood_Pressure_low").value = window.parent.document.getElementById("Systolic_Blood_Pressure_low").value;
	document.getElementById("Systolic_Blood_Pressure_max_val").value = window.parent.document.getElementById("Systolic_Blood_Pressure_max_val").value;
	document.getElementById("Systolic_Blood_Pressure_min_val").value = window.parent.document.getElementById("Systolic_Blood_Pressure_min_val").value;
	
	
	
// 	document.getElementById("pco2").value = window.parent.document.getElementById("pco2").value;
// 	document.getElementById("pco2_high").value = window.parent.document.getElementById("pco2_high").value;
// 	document.getElementById("pco2_low").value = window.parent.document.getElementById("pco2_low").value;
// 	document.getElementById("pco2_val").value = window.parent.document.getElementById("pco2_val").value;
	document.getElementById("pco2_max_date").value = window.parent.document.getElementById("pco2_max_date").value;
	document.getElementById("pco2_min_date").value = window.parent.document.getElementById("pco2_min_date").value;
	document.getElementById("pco2_high").value = window.parent.document.getElementById("pco2_high").value;
	document.getElementById("pco2_low").value = window.parent.document.getElementById("pco2_low").value;
	document.getElementById("pco2_max_val").value = window.parent.document.getElementById("pco2_max_val").value;
	document.getElementById("pco2_min_val").value = window.parent.document.getElementById("pco2_min_val").value;
	
// 	document.getElementById("pco2_prev").value = window.parent.document.getElementById("pco2_prev").value;
// 	document.getElementById("pco2_prev_high").value = window.parent.document.getElementById("pco2_prev_high").value;
// 	document.getElementById("pco2_prev_low").value = window.parent.document.getElementById("pco2_prev_low").value;
// 	document.getElementById("pco2_prev_val").value = window.parent.document.getElementById("pco2_prev_val").value;
	document.getElementById("pco2_prev_max_date").value = window.parent.document.getElementById("pco2_prev_max_date").value;
	document.getElementById("pco2_prev_min_date").value = window.parent.document.getElementById("pco2_prev_min_date").value;
	document.getElementById("pco2_prev_high").value = window.parent.document.getElementById("pco2_prev_high").value;
	document.getElementById("pco2_prev_low").value = window.parent.document.getElementById("pco2_prev_low").value;
	document.getElementById("pco2_prev_max_val").value = window.parent.document.getElementById("pco2_prev_max_val").value;
	document.getElementById("pco2_prev_min_val").value = window.parent.document.getElementById("pco2_prev_min_val").value;
	
// 	document.getElementById("etco2").value = window.parent.document.getElementById("etco2").value;
// 	document.getElementById("etco2_high").value = window.parent.document.getElementById("etco2_high").value;
// 	document.getElementById("etco2_low").value = window.parent.document.getElementById("etco2_low").value;
// 	document.getElementById("etco2_val").value = window.parent.document.getElementById("etco2_val").value;
	
// 	document.getElementById("etco2_prev").value = window.parent.document.getElementById("etco2_prev").value;
// 	document.getElementById("etco2_prev_high").value = window.parent.document.getElementById("etco2_prev_high").value;
// 	document.getElementById("etco2_prev_low").value = window.parent.document.getElementById("etco2_prev_low").value;
// 	document.getElementById("etco2_prev_val").value = window.parent.document.getElementById("etco2_prev_val").value;
	
	document.getElementById("etco2_max_date").value = window.parent.document.getElementById("etco2_max_date").value;
	document.getElementById("etco2_min_date").value = window.parent.document.getElementById("etco2_min_date").value;
	document.getElementById("etco2_high").value = window.parent.document.getElementById("etco2_high").value;
	document.getElementById("etco2_low").value = window.parent.document.getElementById("etco2_low").value;
	document.getElementById("etco2_max_val").value = window.parent.document.getElementById("etco2_max_val").value;
	document.getElementById("etco2_min_val").value = window.parent.document.getElementById("etco2_min_val").value;
	
	document.getElementById("etco2_prev_max_date").value = window.parent.document.getElementById("etco2_prev_max_date").value;
	document.getElementById("etco2_prev_min_date").value = window.parent.document.getElementById("etco2_prev_min_date").value;
	document.getElementById("etco2_prev_high").value = window.parent.document.getElementById("etco2_prev_high").value;
	document.getElementById("etco2_prev_low").value = window.parent.document.getElementById("etco2_prev_low").value;
	document.getElementById("etco2_prev_max_val").value = window.parent.document.getElementById("etco2_prev_max_val").value;
	document.getElementById("etco2_prev_min_val").value = window.parent.document.getElementById("etco2_prev_min_val").value;
	
// 	document.getElementById("o2sat").value = window.parent.document.getElementById("o2sat").value;
// 	document.getElementById("o2sat_high").value = window.parent.document.getElementById("o2sat_high").value;
// 	document.getElementById("o2sat_low").value = window.parent.document.getElementById("o2sat_low").value;
// 	document.getElementById("o2sat_val").value = window.parent.document.getElementById("o2sat_val").value;
	document.getElementById("o2sat_max_date").value = window.parent.document.getElementById("o2sat_max_date").value;
	document.getElementById("o2sat_min_date").value = window.parent.document.getElementById("o2sat_min_date").value;
	document.getElementById("o2sat_high").value = window.parent.document.getElementById("o2sat_high").value;
	document.getElementById("o2sat_low").value = window.parent.document.getElementById("o2sat_low").value;
	document.getElementById("o2sat_max_val").value = window.parent.document.getElementById("o2sat_max_val").value;
	document.getElementById("o2sat_min_val").value = window.parent.document.getElementById("o2sat_min_val").value;
	 
	document.getElementById("oximetry_max_date").value = window.parent.document.getElementById("oximetry_max_date").value;
	document.getElementById("oximetry_min_date").value = window.parent.document.getElementById("oximetry_min_date").value;
	document.getElementById("oximetry_high").value = window.parent.document.getElementById("oximetry_high").value;
	document.getElementById("oximetry_low").value = window.parent.document.getElementById("oximetry_low").value;
	document.getElementById("oximetry_max_val").value = window.parent.document.getElementById("oximetry_max_val").value;
	document.getElementById("oximetry_min_val").value = window.parent.document.getElementById("oximetry_min_val").value; 
	

	document.getElementById("po2_max_date").value = window.parent.document.getElementById("po2_max_date").value;
	document.getElementById("po2_min_date").value = window.parent.document.getElementById("po2_min_date").value;
	document.getElementById("po2_high").value = window.parent.document.getElementById("po2_high").value;
	document.getElementById("po2_low").value = window.parent.document.getElementById("po2_low").value;
	document.getElementById("po2_max_val").value = window.parent.document.getElementById("po2_max_val").value;
	document.getElementById("po2_min_val").value = window.parent.document.getElementById("po2_min_val").value;
	

 	document.getElementById("bun_max_date").value = window.parent.document.getElementById("bun_max_date").value;
	document.getElementById("bun_min_date").value = window.parent.document.getElementById("bun_min_date").value;
	document.getElementById("bun_high").value = window.parent.document.getElementById("bun_high").value;
	document.getElementById("bun_low").value = window.parent.document.getElementById("bun_low").value;
	document.getElementById("bun_max_val").value = window.parent.document.getElementById("bun_max_val").value;
	document.getElementById("bun_min_val").value = window.parent.document.getElementById("bun_min_val").value;
	

	
	document.getElementById("creat_max_date").value = window.parent.document.getElementById("creat_max_date").value;
	document.getElementById("creat_min_date").value = window.parent.document.getElementById("creat_min_date").value;
	document.getElementById("creat_high").value = window.parent.document.getElementById("creat_high").value;
	document.getElementById("creat_low").value = window.parent.document.getElementById("creat_low").value;
	document.getElementById("creat_max_val").value = window.parent.document.getElementById("creat_max_val").value;
	document.getElementById("creat_min_val").value = window.parent.document.getElementById("creat_min_val").value;
	
	document.getElementById("creat_prev_max_date").value = window.parent.document.getElementById("creat_prev_max_date").value;
	document.getElementById("creat_prev_min_date").value = window.parent.document.getElementById("creat_prev_min_date").value;
	document.getElementById("creat_prev_high").value = window.parent.document.getElementById("creat_prev_high").value;
	document.getElementById("creat_prev_low").value = window.parent.document.getElementById("creat_prev_low").value;
	document.getElementById("creat_prev_max_val").value = window.parent.document.getElementById("creat_prev_max_val").value;
	document.getElementById("creat_prev_min_val").value = window.parent.document.getElementById("creat_prev_min_val").value;
	
	document.getElementById("gfr_max_date").value = window.parent.document.getElementById("gfr_max_date").value;
	document.getElementById("gfr_min_date").value = window.parent.document.getElementById("gfr_min_date").value;
	
	document.getElementById("gfr_max_val").value = window.parent.document.getElementById("gfr_max_val").value;
	document.getElementById("gfr_min_val").value = window.parent.document.getElementById("gfr_min_val").value; 
	

		
	document.getElementById("hb_max_date").value = window.parent.document.getElementById("hb_max_date").value;
	document.getElementById("hb_min_date").value = window.parent.document.getElementById("hb_min_date").value;
	document.getElementById("hb_high").value = window.parent.document.getElementById("hb_high").value;
	document.getElementById("hb_low").value = window.parent.document.getElementById("hb_low").value;
	document.getElementById("hb_max_val").value = window.parent.document.getElementById("hb_max_val").value;
	document.getElementById("hb_min_val").value = window.parent.document.getElementById("hb_min_val").value;
	
	document.getElementById("hb_prev_max_date").value = window.parent.document.getElementById("hb_prev_max_date").value;
	document.getElementById("hb_prev_min_date").value = window.parent.document.getElementById("hb_prev_min_date").value;
	document.getElementById("hb_prev_high").value = window.parent.document.getElementById("hb_prev_high").value;
	document.getElementById("hb_prev_low").value = window.parent.document.getElementById("hb_prev_low").value;
	document.getElementById("hb_prev_max_val").value = window.parent.document.getElementById("hb_prev_max_val").value;
	document.getElementById("hb_prev_min_val").value = window.parent.document.getElementById("hb_prev_min_val").value;
	

	 
	 document.getElementById("hc_max_date").value = window.parent.document.getElementById("hc_max_date").value;
	document.getElementById("hc_min_date").value = window.parent.document.getElementById("hc_min_date").value;
	document.getElementById("hc_high").value = window.parent.document.getElementById("hc_high").value;
	document.getElementById("hc_low").value = window.parent.document.getElementById("hc_low").value;
	document.getElementById("hc_max_val").value = window.parent.document.getElementById("hc_max_val").value;
	document.getElementById("hc_min_val").value = window.parent.document.getElementById("hc_min_val").value;
	
	document.getElementById("hc_prev_max_date").value = window.parent.document.getElementById("hc_prev_max_date").value;
	document.getElementById("hc_prev_min_date").value = window.parent.document.getElementById("hc_prev_min_date").value;
	document.getElementById("hc_prev_high").value = window.parent.document.getElementById("hc_prev_high").value;
	document.getElementById("hc_prev_low").value = window.parent.document.getElementById("hc_prev_low").value;
	document.getElementById("hc_prev_max_val").value = window.parent.document.getElementById("hc_prev_max_val").value;
	document.getElementById("hc_prev_min_val").value = window.parent.document.getElementById("hc_prev_min_val").value;
	

	document.getElementById("ct_max_date").value = window.parent.document.getElementById("ct_max_date").value;
	document.getElementById("ct_min_date").value = window.parent.document.getElementById("ct_min_date").value;
	document.getElementById("ct_high").value = window.parent.document.getElementById("ct_high").value;
	document.getElementById("ct_low").value = window.parent.document.getElementById("ct_low").value;
	document.getElementById("ct_max_val").value = window.parent.document.getElementById("ct_max_val").value;
	document.getElementById("ct_min_val").value = window.parent.document.getElementById("ct_min_val").value;
	

	document.getElementById("wbc_max_date").value = window.parent.document.getElementById("wbc_max_date").value;
	document.getElementById("wbc_min_date").value = window.parent.document.getElementById("wbc_min_date").value;
	document.getElementById("wbc_high").value = window.parent.document.getElementById("wbc_high").value;
	document.getElementById("wbc_low").value = window.parent.document.getElementById("wbc_low").value;
	document.getElementById("wbc_max_val").value = window.parent.document.getElementById("wbc_max_val").value;
	document.getElementById("wbc_min_val").value = window.parent.document.getElementById("wbc_min_val").value;
	

	document.getElementById("utiWbc_max_date").value = window.parent.document.getElementById("utiWbc_max_date").value;
	document.getElementById("utiWbc_min_date").value = window.parent.document.getElementById("utiWbc_min_date").value;
	document.getElementById("utiWbc_high").value = window.parent.document.getElementById("utiWbc_high").value;
	document.getElementById("utiWbc_low").value = window.parent.document.getElementById("utiWbc_low").value;
	document.getElementById("utiWbc_max_val").value = window.parent.document.getElementById("utiWbc_max_val").value;
	document.getElementById("utiWbc_min_val").value = window.parent.document.getElementById("utiWbc_min_val").value;
	
// 	document.getElementById("leucocyte_nitrite").value = window.parent.document.getElementById("leucocyte_nitrite").value;
// 	document.getElementById("leucocyte_nitrite_high").value = window.parent.document.getElementById("leucocyte_nitrite_high").value;
// 	document.getElementById("leucocyte_nitrite_low").value = window.parent.document.getElementById("leucocyte_nitrite_low").value;
// 	document.getElementById("leucocyte_nitrite_val").value = window.parent.document.getElementById("leucocyte_nitrite_val").value;
	document.getElementById("leucocyte_nitrite_max_date").value = window.parent.document.getElementById("leucocyte_nitrite_max_date").value;
	document.getElementById("leucocyte_nitrite_min_date").value = window.parent.document.getElementById("leucocyte_nitrite_min_date").value;
	document.getElementById("leucocyte_nitrite_high").value = window.parent.document.getElementById("leucocyte_nitrite_high").value;
	document.getElementById("leucocyte_nitrite_low").value = window.parent.document.getElementById("leucocyte_nitrite_low").value;
	document.getElementById("leucocyte_nitrite_max_val").value = window.parent.document.getElementById("leucocyte_nitrite_max_val").value;
	document.getElementById("leucocyte_nitrite_min_val").value = window.parent.document.getElementById("leucocyte_nitrite_min_val").value;
	
// 	document.getElementById("leucocyte_esterate").value = window.parent.document.getElementById("leucocyte_esterate").value;
// 	document.getElementById("leucocyte_esterate_high").value = window.parent.document.getElementById("leucocyte_esterate_high").value;
// 	document.getElementById("leucocyte_esterate_low").value = window.parent.document.getElementById("leucocyte_esterate_low").value;
// 	document.getElementById("leucocyte_esterate_val").value = window.parent.document.getElementById("leucocyte_esterate_val").value;
	 document.getElementById("leucocyte_esterate_max_date").value = window.parent.document.getElementById("leucocyte_esterate_max_date").value;
	document.getElementById("leucocyte_esterate_min_date").value = window.parent.document.getElementById("leucocyte_esterate_min_date").value;
	document.getElementById("leucocyte_esterate_high").value = window.parent.document.getElementById("leucocyte_esterate_high").value;
	document.getElementById("leucocyte_esterate_low").value = window.parent.document.getElementById("leucocyte_esterate_low").value;
	document.getElementById("leucocyte_esterate_max_val").value = window.parent.document.getElementById("leucocyte_esterate_max_val").value;
	document.getElementById("leucocyte_esterate_min_val").value = window.parent.document.getElementById("leucocyte_esterate_min_val").value;
	
// 	document.getElementById("temp").value = window.parent.document.getElementById("temp").value;
// 	document.getElementById("temp_high").value = window.parent.document.getElementById("temp_high").value;
// 	document.getElementById("temp_low").value = window.parent.document.getElementById("temp_low").value;
// 	document.getElementById("temp_val").value = window.parent.document.getElementById("temp_val").value;
	document.getElementById("temp_max_date").value = window.parent.document.getElementById("temp_max_date").value;
	document.getElementById("temp_min_date").value = window.parent.document.getElementById("temp_min_date").value;
	document.getElementById("temp_high").value = window.parent.document.getElementById("temp_high").value;
	document.getElementById("temp_low").value = window.parent.document.getElementById("temp_low").value;
	document.getElementById("temp_max_val").value = window.parent.document.getElementById("temp_max_val").value;
	document.getElementById("temp_min_val").value = window.parent.document.getElementById("temp_min_val").value;
	
// 	document.getElementById("hr").value = window.parent.document.getElementById("hr").value;
// 	document.getElementById("hr_high").value = window.parent.document.getElementById("hr_high").value;
// 	document.getElementById("hr_low").value = window.parent.document.getElementById("hr_low").value;
// 	document.getElementById("hr_val").value = window.parent.document.getElementById("hr_val").value;
	document.getElementById("hr_max_date").value = window.parent.document.getElementById("hr_max_date").value;
	document.getElementById("hr_min_date").value = window.parent.document.getElementById("hr_min_date").value;
	document.getElementById("hr_high").value = window.parent.document.getElementById("hr_high").value;
	document.getElementById("hr_low").value = window.parent.document.getElementById("hr_low").value;
	document.getElementById("hr_max_val").value = window.parent.document.getElementById("hr_max_val").value;
	document.getElementById("hr_min_val").value = window.parent.document.getElementById("hr_min_val").value;
// 	document.getElementById("rr").value = window.parent.document.getElementById("rr").value;
// 	document.getElementById("rr_high").value = window.parent.document.getElementById("rr_high").value;
// 	document.getElementById("rr_low").value = window.parent.document.getElementById("rr_low").value;
// 	document.getElementById("rr_val").value = window.parent.document.getElementById("rr_val").value;
	document.getElementById("rr_max_date").value = window.parent.document.getElementById("rr_max_date").value;
	document.getElementById("rr_min_date").value = window.parent.document.getElementById("rr_min_date").value;
	document.getElementById("rr_high").value = window.parent.document.getElementById("rr_high").value;
	document.getElementById("rr_low").value = window.parent.document.getElementById("rr_low").value;
	document.getElementById("rr_max_val").value = window.parent.document.getElementById("rr_max_val").value;
	document.getElementById("rr_min_val").value = window.parent.document.getElementById("rr_min_val").value;
	
// 	document.getElementById("lactate").value = window.parent.document.getElementById("lactate").value;
// 	document.getElementById("lactate_high").value = window.parent.document.getElementById("lactate_high").value;
// 	document.getElementById("lactate_low").value = window.parent.document.getElementById("lactate_low").value;
// 	document.getElementById("lactate_val").value = window.parent.document.getElementById("lactate_val").value;
	document.getElementById("lactate_max_date").value = window.parent.document.getElementById("lactate_max_date").value;
	document.getElementById("lactate_min_date").value = window.parent.document.getElementById("lactate_min_date").value;
	document.getElementById("lactate_high").value = window.parent.document.getElementById("lactate_high").value;
	document.getElementById("lactate_low").value = window.parent.document.getElementById("lactate_low").value;
	document.getElementById("lactate_max_val").value = window.parent.document.getElementById("lactate_max_val").value;
	document.getElementById("lactate_min_val").value = window.parent.document.getElementById("lactate_min_val").value;
	
	
	document.getElementById("dehydration_creat_date").value = window.parent.document.getElementById("dehydration_creat_date").value;
	document.getElementById("dehydration_bun_date").value = window.parent.document.getElementById("dehydration_bun_date").value;
	document.getElementById("creatinine_val").value = window.parent.document.getElementById("creatinine_val").value;
	document.getElementById("bun_val").value = window.parent.document.getElementById("bun_val").value;
	document.getElementById("print").value=window.parent.document.getElementById("printer").value;
	
	
		
	
	//alert("document going to be submitted");
//alert("gfvp end");	
document.form.submit();

}
</script>

</head>
<body>

<!-- <form name="form" action="http://uhmc-ed-admitd.uhmc.sunysb.edu:8080/CoMorbidities/MpageServerInterface.jsp" method="POST"> -->
<!-- <form name="form" action="http://localhost:8080/CoMorbidities/MpageServerInterface.jsp" method="POST">  -->
<form name="form" action="MpageServerInterface.jsp" method="POST">
        <input type="hidden" id='encntr_id' name="encntr_id">
        <input type="hidden" id='user_id' name="user_id">
        <input type="hidden" id='sodium_max_date' name="sodium_max_date">
		<input type="hidden" id='sodium_min_date' name="sodium_min_date">
		<input type="hidden" id='sodium_low' name="sodium_low">
		<input type="hidden" id='sodium_high' name="sodium_high">
		<input type="hidden" id='sodium_max_val' name="sodium_max_val">
		<input type="hidden" id='sodium_min_val' name="sodium_min_val">
		
		<input type="hidden" id='potassium_max_date' name="potassium_max_date">
		<input type="hidden" id='potassium_min_date' name="potassium_min_date">
		<input type="hidden" id='potassium_low' name="potassium_low">
		<input type="hidden" id='potassium_high' name="potassium_high">
		<input type="hidden" id='potassium_max_val' name="potassium_max_val">
		<input type="hidden" id='potassium_min_val' name="potassium_min_val">
		
		<input type="hidden" id='calcium_max_date' name="calcium_max_date">
		<input type="hidden" id='calcium_min_date' name="calcium_min_date">
		<input type="hidden" id='calcium_low' name="calcium_low">
		<input type="hidden" id='calcium_high' name="calcium_high">
		<input type="hidden" id='calcium_max_val' name="calcium_max_val">
		<input type="hidden" id='calcium_min_val' name="calcium_min_val">
		
		<input type="hidden" id='glucose_max_date' name="glucose_max_date">
		<input type="hidden" id='glucose_min_date' name="glucose_min_date">
		<input type="hidden" id='glucose_low' name="glucose_low">
		<input type="hidden" id='glucose_high' name="glucose_high">
		<input type="hidden" id='glucose_max_val' name="glucose_max_val">
		<input type="hidden" id='glucose_min_val' name="glucose_min_val">
		
 		<input type="hidden" id='neutrophil_max_date' name="neutrophil_max_date">
		<input type="hidden" id='neutrophil_min_date' name="neutrophil_min_date">
		<input type="hidden" id='neutrophil_low' name="neutrophil_low">
		<input type="hidden" id='neutrophil_high' name="neutrophil_high">
		<input type="hidden" id='neutrophil_max_val' name="neutrophil_max_val">
		<input type="hidden" id='neutrophil_min_val' name="neutrophil_min_val">
		
		<input type="hidden" id='weight_max_date' name="weight_max_date">
		<input type="hidden" id='weight_min_date' name="weight_min_date">
		<input type="hidden" id='weight_max_val' name="weight_max_val">
		<input type="hidden" id='weight_min_val' name="weight_min_val">
		
		<input type="hidden" id='height_max_date' name="height_max_date">
		<input type="hidden" id='height_min_date' name="height_min_date">
		<input type="hidden" id='height_max_val' name="height_max_val">
		<input type="hidden" id='height_min_val' name="height_min_val">
		
		<input type="hidden" id='Diastolic_Blood_Pressure_max_date' name="Diastolic_Blood_Pressure_max_date">
		<input type="hidden" id='Diastolic_Blood_Pressure_min_date' name="Diastolic_Blood_Pressure_min_date">
		<input type="hidden" id='Diastolic_Blood_Pressure_low' name="Diastolic_Blood_Pressure_low">
		<input type="hidden" id='Diastolic_Blood_Pressure_high' name="Diastolic_Blood_Pressure_high">
		<input type="hidden" id='Diastolic_Blood_Pressure_max_val' name="Diastolic_Blood_Pressure_max_val">
		<input type="hidden" id='Diastolic_Blood_Pressure_min_val' name="Diastolic_Blood_Pressure_min_val">
		
		<input type="hidden" id='Systolic_Blood_Pressure_max_date' name="Systolic_Blood_Pressure_max_date">
		<input type="hidden" id='Systolic_Blood_Pressure_min_date' name="Systolic_Blood_Pressure_min_date">
		<input type="hidden" id='Systolic_Blood_Pressure_low' name="Systolic_Blood_Pressure_low">
		<input type="hidden" id='Systolic_Blood_Pressure_high' name="Systolic_Blood_Pressure_high">
		<input type="hidden" id='Systolic_Blood_Pressure_max_val' name="Systolic_Blood_Pressure_max_val">
		<input type="hidden" id='Systolic_Blood_Pressure_min_val' name="Systolic_Blood_Pressure_min_val">
		
		<input type="hidden" id='pco2_max_date' name="pco2_max_date">
		<input type="hidden" id='pco2_min_date' name="pco2_min_date">
		<input type="hidden" id='pco2_low' name="pco2_low">
		<input type="hidden" id='pco2_high' name="pco2_high">
		<input type="hidden" id='pco2_max_val' name="pco2_max_val">
		<input type="hidden" id='pco2_min_val' name="pco2_min_val">
		
		<input type="hidden" id='pco2_prev_max_date' name="pco2_prev_max_date">
		<input type="hidden" id='pco2_prev_min_date' name="pco2_prev_min_date">
		<input type="hidden" id='pco2_prev_low' name="pco2_prev_low">
		<input type="hidden" id='pco2_prev_high' name="pco2_prev_high">
		<input type="hidden" id='pco2_prev_max_val' name="pco2_prev_max_val">
		<input type="hidden" id='pco2_prev_min_val' name="pco2_prev_min_val">
		
		<input type="hidden" id='etco2_max_date' name="etco2_max_date">
		<input type="hidden" id='etco2_min_date' name="etco2_min_date">
		<input type="hidden" id='etco2_low' name="etco2_low">
		<input type="hidden" id='etco2_high' name="etco2_high">
		<input type="hidden" id='etco2_max_val' name="etco2_max_val">
		<input type="hidden" id='etco2_min_val' name="etco2_min_val">
		
		<input type="hidden" id='etco2_prev_max_date' name="etco2_prev_max_date">
		<input type="hidden" id='etco2_prev_min_date' name="etco2_prev_min_date">
		<input type="hidden" id='etco2_prev_low' name="etco2_prev_low">
		<input type="hidden" id='etco2_prev_high' name="etco2_prev_high">
		<input type="hidden" id='etco2_prev_max_val' name="etco2_prev_max_val">
		<input type="hidden" id='etco2_prev_min_val' name="etco2_prev_min_val">
		
		<input type="hidden" id='po2_max_date' name="po2_max_date">
		<input type="hidden" id='po2_min_date' name="po2_min_date">
		<input type="hidden" id='po2_low' name="po2_low">
		<input type="hidden" id='po2_high' name="po2_high">
		<input type="hidden" id='po2_max_val' name="po2_max_val">
		<input type="hidden" id='po2_min_val' name="po2_min_val">
		
		<input type="hidden" id='o2sat_max_date' name="o2sat_max_date">
		<input type="hidden" id='o2sat_min_date' name="o2sat_min_date">
		<input type="hidden" id='o2sat_low' name="o2sat_low">
		<input type="hidden" id='o2sat_high' name="o2sat_high">
		<input type="hidden" id='o2sat_max_val' name="o2sat_max_val">
		<input type="hidden" id='o2sat_min_val' name="o2sat_min_val">
		
		<input type="hidden" id='oximetry_max_date' name="oximetry_max_date">
		<input type="hidden" id='oximetry_min_date' name="oximetry_min_date">
		<input type="hidden" id='oximetry_low' name="oximetry_low">
		<input type="hidden" id='oximetry_high' name="oximetry_high">
		<input type="hidden" id='oximetry_max_val' name="oximetry_max_val">
		<input type="hidden" id='oximetry_min_val' name="oximetry_min_val">
		
		<input type="hidden" id='bun_max_date' name="bun_max_date">
		<input type="hidden" id='bun_min_date' name="bun_min_date">
		<input type="hidden" id='bun_low' name="bun_low">
		<input type="hidden" id='bun_high' name="bun_high">
		<input type="hidden" id='bun_max_val' name="bun_max_val">
		<input type="hidden" id='bun_min_val' name="bun_min_val">
		
		 <input type="hidden" id='gfr_max_date' name="gfr_max_date">
		<input type="hidden" id='gfr_min_date' name="gfr_min_date">
		
		<input type="hidden" id='gfr_max_val' name="gfr_max_val">
		<input type="hidden" id='gfr_min_val' name="gfr_min_val"> 
			
		<input type="hidden" id='creat_max_date' name="creat_max_date">
		<input type="hidden" id='creat_min_date' name="creat_min_date">
		<input type="hidden" id='creat_low' name="creat_low">
		<input type="hidden" id='creat_high' name="creat_high">
		<input type="hidden" id='creat_max_val' name="creat_max_val">
		<input type="hidden" id='creat_min_val' name="creat_min_val">
		
		<input type="hidden" id='creat_prev_max_date' name="creat_prev_max_date">
		<input type="hidden" id='creat_prev_min_date' name="creat_prev_min_date">
		<input type="hidden" id='creat_prev_low' name="creat_prev_low">
		<input type="hidden" id='creat_prev_high' name="creat_prev_high">
		<input type="hidden" id='creat_prev_max_val' name="creat_prev_max_val">
		<input type="hidden" id='creat_prev_min_val' name="creat_prev_min_val">			

		<input type="hidden" id='hb_max_date' name="hb_max_date">
		<input type="hidden" id='hb_min_date' name="hb_min_date">
		<input type="hidden" id='hb_low' name="hb_low">
		<input type="hidden" id='hb_high' name="hb_high">
		<input type="hidden" id='hb_max_val' name="hb_max_val">
		<input type="hidden" id='hb_min_val' name="hb_min_val">
		
		<input type="hidden" id='hb_prev_max_date' name="hb_prev_max_date">
		<input type="hidden" id='hb_prev_min_date' name="hb_prev_min_date">
		<input type="hidden" id='hb_prev_low' name="hb_prev_low">
		<input type="hidden" id='hb_prev_high' name="hb_prev_high">
		<input type="hidden" id='hb_prev_max_val' name="hb_prev_max_val">
		<input type="hidden" id='hb_prev_min_val' name="hb_prev_min_val">
		 
		<input type="hidden" id='hc_max_date' name="hc_max_date">
		<input type="hidden" id='hc_min_date' name="hc_min_date">
		<input type="hidden" id='hc_low' name="hc_low">
		<input type="hidden" id='hc_high' name="hc_high">
		<input type="hidden" id='hc_max_val' name="hc_max_val">
		<input type="hidden" id='hc_min_val' name="hc_min_val">
		
		<input type="hidden" id='hc_prev_max_date' name="hc_prev_max_date">
		<input type="hidden" id='hc_prev_min_date' name="hc_prev_min_date">
		<input type="hidden" id='hc_prev_low' name="hc_prev_low">
		<input type="hidden" id='hc_prev_high' name="hc_prev_high">
		<input type="hidden" id='hc_prev_max_val' name="hc_prev_max_val">
		<input type="hidden" id='hc_prev_min_val' name="hc_prev_min_val">
				
		<input type="hidden" id='ct_max_date' name="ct_max_date">
		<input type="hidden" id='ct_min_date' name="ct_min_date">
		<input type="hidden" id='ct_low' name="ct_low">
		<input type="hidden" id='ct_high' name="ct_high">
		<input type="hidden" id='ct_max_val' name="ct_max_val">
		<input type="hidden" id='ct_min_val' name="ct_min_val">
		
		<input type="hidden" id='wbc_max_date' name="wbc_max_date">
		<input type="hidden" id='wbc_min_date' name="wbc_min_date">
		<input type="hidden" id='wbc_low' name="wbc_low">
		<input type="hidden" id='wbc_high' name="wbc_high">
		<input type="hidden" id='wbc_max_val' name="wbc_max_val">
		<input type="hidden" id='wbc_min_val' name="wbc_min_val">	
		
		<input type="hidden" id='utiWbc_max_date' name="utiWbc_max_date">
		<input type="hidden" id='utiWbc_min_date' name="utiWbc_min_date">
		<input type="hidden" id='utiWbc_low' name="utiWbc_low">
		<input type="hidden" id='utiWbc_high' name="utiWbc_high">
		<input type="hidden" id='utiWbc_max_val' name="utiWbc_max_val">
		<input type="hidden" id='utiWbc_min_val' name="utiWbc_min_val">
		
		<input type="hidden" id='cardiac_troponin_max_date' name="cardiac_troponin_max_date">
		<input type="hidden" id='cardiac_troponin_min_date' name="cardiac_troponin_min_date">
		<input type="hidden" id='cardiac_troponin_low' name="cardiac_troponin_low">
		<input type="hidden" id='cardiac_troponin_high' name="cardiac_troponin_high">
		<input type="hidden" id='cardiac_troponin_max_val' name="cardiac_troponin_max_val">
		<input type="hidden" id='cardiac_troponin_min_val' name="cardiac_troponin_min_val">
			 
		 <input type="hidden" id='leucocyte_esterate_max_date' name="leucocyte_esterate_max_date">
		<input type="hidden" id='leucocyte_esterate_min_date' name="leucocyte_esterate_min_date">
		<input type="hidden" id='leucocyte_esterate_low' name="leucocyte_esterate_low">
		<input type="hidden" id='leucocyte_esterate_high' name="leucocyte_esterate_high">
		<input type="hidden" id='leucocyte_esterate_max_val' name="leucocyte_esterate_max_val">
		<input type="hidden" id='leucocyte_esterate_min_val' name="leucocyte_esterate_min_val">

		<input type="hidden" id='leucocyte_nitrite_max_date' name="leucocyte_nitrite_max_date">
		<input type="hidden" id='leucocyte_nitrite_min_date' name="leucocyte_nitrite_min_date">
		<input type="hidden" id='leucocyte_nitrite_low' name="leucocyte_nitrite_low">
		<input type="hidden" id='leucocyte_nitrite_high' name="leucocyte_nitrite_high">
		<input type="hidden" id='leucocyte_nitrite_max_val' name="leucocyte_nitrite_max_val">
		<input type="hidden" id='leucocyte_nitrite_min_val' name="leucocyte_nitrite_min_val">
		
		<input type="hidden" id='temp_max_date' name="temp_max_date">
		<input type="hidden" id='temp_min_date' name="temp_min_date">
		<input type="hidden" id='temp_low' name="temp_low">
		<input type="hidden" id='temp_high' name="temp_high">
		<input type="hidden" id='temp_max_val' name="temp_max_val">
		<input type="hidden" id='temp_min_val' name="temp_min_val">
		
		<input type="hidden" id='hr_max_date' name="hr_max_date">
		<input type="hidden" id='hr_min_date' name="hr_min_date">
		<input type="hidden" id='hr_low' name="hr_low">
		<input type="hidden" id='hr_high' name="hr_high">
		<input type="hidden" id='hr_max_val' name="hr_max_val">
		<input type="hidden" id='hr_min_val' name="hr_min_val">
		
		<input type="hidden" id='rr_max_date' name="rr_max_date">
		<input type="hidden" id='rr_min_date' name="rr_min_date">
		<input type="hidden" id='rr_low' name="rr_low">
		<input type="hidden" id='rr_high' name="rr_high">
		<input type="hidden" id='rr_max_val' name="rr_max_val">
		<input type="hidden" id='rr_min_val' name="rr_min_val">
		
		<input type="hidden" id='lactate_max_date' name="lactate_max_date">
		<input type="hidden" id='lactate_min_date' name="lactate_min_date">
		<input type="hidden" id='lactate_low' name="lactate_low">
		<input type="hidden" id='lactate_high' name="lactate_high">
		<input type="hidden" id='lactate_max_val' name="lactate_max_val">
		<input type="hidden" id='lactate_min_val' name="lactate_min_val">
		

		<input type="hidden" id='lactic_acid_max_date' name="lactic_acid_max_date">
		<input type="hidden" id='lactic_acid_min_date' name="lactic_acid_min_date">
		<input type="hidden" id='lactic_acid_max_val' name="lactic_acid_max_val">
		<input type="hidden" id='lactic_acid_min_val' name="lactic_acid_min_val">
		<input type="hidden" id='lactic_acid_low' name="lactic_acid_low">
		<input type="hidden" id='lactic_acid_high' name="lactic_acid_high">
				
		<input type="hidden" id='phosphorus_max_date' name="phosphorus_max_date">
		<input type="hidden" id='phosphorus_min_date' name="phosphorus_min_date">
		<input type="hidden" id='phosphorus_low' name="phosphorus_low">
		<input type="hidden" id='phosphorus_high' name="phosphorus_high">
		<input type="hidden" id='phosphorus_max_val' name="phosphorus_max_val">
		<input type="hidden" id='phosphorus_min_val' name="phosphorus_min_val">

		<input type="hidden" id='magnesium_max_date' name="magnesium_max_date">
		<input type="hidden" id='magnesium_min_date' name="magnesium_min_date">
		<input type="hidden" id='magnesium_low' name="magnesium_low">
		<input type="hidden" id='magnesium_high' name="magnesium_high">
		<input type="hidden" id='magnesium_max_val' name="magnesium_max_val">
		<input type="hidden" id='magnesium_min_val' name="magnesium_min_val">
		
		<input type="hidden" id='cholesterol_max_date' name="cholesterol_max_date">
		<input type="hidden" id='cholesterol_min_date' name="cholesterol_min_date">
		<input type="hidden" id='cholesterol_low' name="cholesterol_low">
		<input type="hidden" id='cholesterol_high' name="cholesterol_high">
		<input type="hidden" id='cholesterol_max_val' name="cholesterol_max_val">
		<input type="hidden" id='cholesterol_min_val' name="cholesterol_min_val">
		
		<input type="hidden" id='dehydration_creat_date' name="dehydration_creat_date">
		<input type="hidden" id='dehydration_bun_date' name="dehydration_bun_date">
		<input type="hidden" id='creatinine_val' name="creatinine_val">
		<input type="hidden" id='bun_val' name="bun_val">
		<input type="hidden" id='print' name="print">
		
<p><input type="submit" style="visibility: hidden;">
</p> 
<script type="text/javascript">
getValuesFromParent();
</script>
</form>
</body>
</html>