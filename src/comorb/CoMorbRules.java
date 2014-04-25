
package comorb;

import java.lang.String;

public class CoMorbRules {
	
	/**
	 * @param The values needed to evaluate the co-morbidity conditions 
	 * are passed into the functions in this class as strings. 
	 * They are converted into double to compute if they are not empty. 
	 * @author Abhishek Shukla, Shaili Kapoor, Kushal Shah
	 */
	//This variable is used a a flag when there are multiple AND conditions 
	public int count;

	public CoMorbRules() {

	}

	/*
	 * Return 0 if no Anemia
	 * Return 1 if Acute - in current encounter, values < normal values. but, previous are OK
	 * Return 2 if Acute with NOS, if current < normal. but, previous are not present
	 * Return 3 if Chronic if both current and previous are < normal
	 */
	public int anemia(String hb, String hc, String hbLow, String hcLow, String hbPrev, String hcPrev) {
		/* When hb or hc value is an empty string: return 0; */
		int ret_val = 0;
		
		boolean acute = false;
		boolean prev_avail = true;
		boolean chronic = false;
		
		/*
		 * We first check if curent conditions are anemic
		 * If yes, then we proceed, else, there is no point
		 */
		if(!(hb.isEmpty()) && !(hbLow.isEmpty()))
			if (Utils.isDouble(hb) && Utils.isDouble(hbLow)) {
				if(Double.parseDouble(hb) < Double.parseDouble(hbLow))
					acute = true;
			}

		if(!(hc.isEmpty()) && !(hcLow.isEmpty()))
			if (Utils.isDouble(hc) && Utils.isDouble(hcLow)) {
				if(Double.parseDouble(hc) < Double.parseDouble(hcLow))
					acute = true;
			}

		/*
		 * If both are empty, then previous info is not available 
		 * (if this comes with acute, then NOS)
		 */
		if(hbPrev.isEmpty() && hcPrev.isEmpty()) {
			prev_avail = false;
		}
		
		/*
		 * If acute is not true, we will not enter the if condition
		 */
		if(prev_avail == true && acute == true) {
			if(!(hbPrev.isEmpty()) && !(hbLow.isEmpty()))
				if (Utils.isDouble(hbPrev) && Utils.isDouble(hbLow)) {
					if(Double.parseDouble(hbPrev) < Double.parseDouble(hbLow))
						chronic = true;
				}
				else{
					//what to do here??
				}
			if(!(hcPrev.isEmpty()) && !(hcLow.isEmpty()))
				if (Utils.isDouble(hcPrev) && Utils.isDouble(hcLow)) {
					if(Double.parseDouble(hcPrev) < Double.parseDouble(hcLow))
						chronic = true;
				}

		}
		/* Only if previous values are available and they are not chronic, tbut, acute is true, then we say it is acute */
		if(acute == true && prev_avail == true && chronic == false) {
			ret_val = 1;
		}
		/* If previous values are unavailable and acute is true, we say it is anemic */
		else if( acute == true && prev_avail == false) {
			ret_val = 2;
		}
		/* If chronic is true, then we don't care about anything else, we say it is chronic */
		else if(chronic == true) {
			ret_val = 3;
		}
		return ret_val;
	}

	/*
	 * Acute Kidney Injury: if creatinine > 1.2
	 * 
	 * creatinine value = 366653 BUN = 366649 GFR = 49946269
	 * 1: acute
	 * 2: NOS
	 */
	public int acuteKidneyInjury(String creat, String prevCreat, String creatHigh) {
		if(creatHigh.isEmpty()){
			creatHigh = "1.2";
		}
		if(creat.isEmpty() && prevCreat.isEmpty()){
			// do nothing
		}
		else if(creat.isEmpty() != true && prevCreat.isEmpty() != true){
		
			if (Utils.isDouble(prevCreat) && Utils.isDouble(creat) && Utils.isDouble(creatHigh)){
			
				if((Double.parseDouble(prevCreat) == -99999 || Double.parseDouble(prevCreat) == 99999) && Double.parseDouble(creat) > Double.parseDouble(creatHigh)){
					return 1 ; //  1 is for NOS
				}
			
				else if (((Double.parseDouble(creat) > Double.parseDouble(creatHigh)) && Double.parseDouble(prevCreat) <= Double.parseDouble(creatHigh)) || ((Double.parseDouble(creat) > 1.5 * Double.parseDouble(prevCreat))&& Double.parseDouble(prevCreat)!=-99999)){
					return 2; // 2 is for acute
				}		
			
				else if (((Double.parseDouble(creat) > Double.parseDouble(creatHigh)) && Double.parseDouble(prevCreat) > Double.parseDouble(creatHigh))){
					return 3; //3 is for chronic
				}
			}
		}
		else if(creat.isEmpty() && prevCreat.isEmpty() != true){
			// do nothing
		}	
		
		return 0;
	}

	/*
	 * Chronic Kidney disease: if creatinine > 1.2 on two consecutive encounters
	 * and stages if gfr is present
	 * if only current is present(and is >1.2), previous is not there, return nos (1)
	 * if both are there show chronic (2)
	 * creatinine value = 366653 GFR = 49946269
	 */
	public int chronicKidneyDisease(String creat, String prevCreat, String creatHigh) {
		
		if (Utils.isDouble(creat) && Utils.isDouble(creatHigh) && Utils.isDouble(prevCreat)){
			if(creat.isEmpty() || creatHigh.isEmpty()) {
				return 0;
			}
			else if( prevCreat.isEmpty() && Double.parseDouble(creat) > Double.parseDouble(creatHigh)) {
				return 1; //return 1;
			}
			else if( (Double.parseDouble(creat) > Double.parseDouble(creatHigh)) && (Double.parseDouble(prevCreat) > Double.parseDouble(creatHigh))) {
				return 0; //return 2;
			}
		}
		return 0;

	}// end of chronic kidney disease

	/*
	 * Diabetes
	 * glucose level: 366648
	 */
	public int Diabetes(String gluc,String glucHigh) {
		
		/*When the glucose value is not available
		Return 0 as we cannot compute*/
		if (gluc.isEmpty()) {
			return 0;
		}
		/*if (glucHigh.isEmpty()) {
			glucHigh="150";
		}*/
		/*When value is grater than 150
		Return 1 indication diabetes*/
		if (Utils.isDouble(gluc)){
			if (Double.parseDouble(gluc) > 150){ //Double.parseDouble(glucHigh))  {
				return 1;
			}
		}
		/*When none of the above conditions match
		Return 0 indicating abscence of Diabetes*/
		return 0;
	}
	
	/*
	 * HypoGylecmia
	 * glucose level: 366648
	 */
	public int HypoGylecmia(String gluc,String glucLow){
		if (gluc.isEmpty()) {
			return 0;
		} 
		
		if (glucLow.isEmpty()){
			glucLow ="70";
		}
		
		/*When value is less than 70
		Return 1 indication Hyperglycemia*/
		if (Utils.isDouble(gluc) && Utils.isDouble(glucLow)){
			if (Double.parseDouble(gluc) < Double.parseDouble(glucLow))  {
				return 1;
			}
		}
		/*When none of the above conditions match
		Return 0 indicating absence of HypoGylecmia*/
		return 0;
	}
	
	// Electrolyte Abnormalities

	public boolean hypo(String low, String resVal) {
		/*When the value is not present
		Return false as we cannot compute*/
		if (resVal.isEmpty() != true  && low.isEmpty() != true) {
			if (Utils.isDouble(resVal) && Utils.isDouble(low)){
				if (Double.parseDouble(resVal) <  Double.parseDouble(low)) {
					return true;
				}
				else{
					return false;
				} 
			}
		} 
		/*When the value is present and the condition does not match
		Return false indicating absence*/
		return false;
	}

	public boolean hyper(String high, String resVal) {
		
		/*When the value is not present
		Return false as we cannot compute*/
		if (resVal.isEmpty() != true  && high.isEmpty() != true) {
			if (Utils.isDouble(resVal) && Utils.isDouble(high)){
				if ( Double.parseDouble(resVal) > Double.parseDouble(high)) {
					return true;
				}
				else{
					return false;
				}
			}
		} 
		/*When the value is present and the condition does not match
		Return false indicating absence*/
		return false;
	}

	/*
	 * Possible Malnutrition : BMI < 19
	 */
	public double malnutrition(String weight, String height) {
		/*When the value is not present
		Return false as we cannot compute*/
		if (weight.isEmpty() ||
			height.isEmpty()) {
				return 0;
		} 
		/*When the value is present, calculate BMI value and
		  Return appropriate value*/
		else {
			double bmi = 0.0, ht1 = 0.0;
			
			if (Utils.isDouble(height) && Utils.isDouble(weight)){
				// Formula to calculate BMI in kg/m^2
				ht1 =  Double.parseDouble(height) / 100.0;
				ht1 = Math.pow(ht1, 2);
				if(ht1 != 0.0) ; // addded byy priya:test;
				bmi = Double.parseDouble(weight) / ht1; 
			
				/*Return the BMI value indicating presence*/
				if (bmi < 19.0) {
				  double ret_bmi = 0.0;
				  ret_bmi = bmi*100;
				  ret_bmi = Math.round(ret_bmi);
				  ret_bmi = ret_bmi/100;
				  return ret_bmi;
				}
				/*Return 0 indicating absence*/
				else{
				  return 0;
				}
			}
			else{
				//do something
			}
			return 0;
		}
	}

	
	
	/*
	 * Obesity This method calculates the BMI in order to determine the
	 * whether the patient has obesity or not. Weight is in Kilograms -
	 * event_Cd = 9888909 Height is in centimeters, event_cd = 9888910
	 */	
	
	public double obesity(String weight, String height) {
		/*When the value is not present
		Return false as we cannot compute*/
		if (weight.isEmpty() || 
			height.isEmpty()) {
				return 0;
		} 
		/*When the value is present, calculate BMI value and
		  Return appropriate value*/
		else {
			double bmi = 0.0, ht1 = 0.0;
			
			if (Utils.isDouble(height) && Utils.isDouble(weight)){
				// Formula to calculate BMI in kg/m^2
				ht1 = Double.parseDouble(height) / 100.0;
				ht1 = Math.pow(ht1, 2);
				if(ht1 != 0) // added by priya
				bmi = Double.parseDouble(weight) / ht1; 
			
				/*Return the BMI value indicating presence*/
				if (bmi > 30.0 && bmi < 40.0) {
				  double ret_bmi = 0.0;
				  ret_bmi = bmi*100;
				  ret_bmi = Math.round(ret_bmi);
				  ret_bmi = ret_bmi/100;
				  return ret_bmi;
				}
				/*Return 0 indicating absence*/
				else{
				  return 0;
				}
			}
			else{
				//do something
			}
			return 0;
		}
	}


	


	/*
	 * Morbid Obesity This method calculates the BMI in order to determine the
	 * whether the patient has morbid obesity or not. Weight is in Kilograms -
	 * event_Cd = 9888909 Height is in centimeters, event_cd = 9888910
	 */
	public double morbidObesity(String weight, String height) {
		/*When the value is not present
		Return false as we cannot compute*/
		if (weight.isEmpty() || 
			height.isEmpty()) {
				return 0;
		} 
		/*When the value is present, calculate BMI value and
		  Return appropriate value*/
		else {
			double bmi = 0.0, ht1 = 0.0;
			
			if (Utils.isDouble(height) && Utils.isDouble(weight)){
				// Formula to calculate BMI in kg/m^2
				ht1 = Double.parseDouble(height) / 100.0;
				ht1 = Math.pow(ht1, 2);
				if(ht1 != 0) // added by priya
				bmi = Double.parseDouble(weight) / ht1; 
			
				/*Return the BMI value indicating presence*/
				if (bmi > 40.0) {
				  double ret_bmi = 0.0;
				  ret_bmi = bmi*100;
				  ret_bmi = Math.round(ret_bmi);
				  ret_bmi = ret_bmi/100;
				  return ret_bmi;
				}
				/*Return 0 indicating absence*/
				else{
				  return 0;
				}
			}
			else{
				//do something
			}
			
			return 0;
			
		}
	}

	/*
	 * Malignant Hypertension: blood pressure (diastolic) >= 90 OR if blood
	 * pressure (systolic) >= 140 DBP =48326685 SBP = 48326665
	 */
	public int hypertension(String sys, String dia) {
		/* Check fi sys */
		if (sys.isEmpty() != true) {
			
        		if (Utils.isDouble(sys)) {
						if (Double.parseDouble(sys) > 140) {
							return 1;
						}
				}
			
		} 
		/* Check for dia */
		else if (dia.isEmpty() != true) {
		        	if(Utils.isDouble(dia)) {
						if ( Double.parseDouble(dia) > 90) {
							System.out.println("I am in second else if");
							return 1;
						}
					}
		} 
		
		/* Else Return 0 when above conditions do not match 
		indicating absence*/
		return 0;

	}
	
	/*
	 * Granulocytopenia : if Neutrophils < 2.4
	 * 
	 * Neutrophils # auto : 366575
	 */
	public int granulocytopenia(String Minneutrophil, String neutrophilLow){
		/*When the value is not present
		Return false as we cannot compute*/
		if (Minneutrophil.isEmpty()) {
			
		}
		else if (Minneutrophil.isEmpty() != true ) {
		    if(Utils.isDouble(Minneutrophil) && Utils.isDouble(neutrophilLow)) {
		        if(Double.parseDouble(Minneutrophil) < Double.parseDouble(neutrophilLow)) {
			        return 1;
			    }
			}
		}
		/*else if(Maxneutrophil.isEmpty() != true && Double.parseDouble(Maxneutrophil) > Double.parseDouble(neutrophilHigh))
		{
			return 1;
		}*/
		/*When none of the above conditions match
		Return 0 indicating absence of Granulocytopenia*/
		return 0;
	}


	/*
	 * If NOS: 1
	 * If Acute: 10
	 * If Chronic: 100
	 * If AconChronic: 1000
	 */
	public int respFailure(String pco2, String etco2, String prevPCo2,
			String prevEtco2, String pO2, String o2sat) {
		
		boolean respFailChronic, respFailAcute, respFailAcOnChr, respFailNOS; 
		int ret_val = 0;
		respFailChronic = chronicRespFailure(pco2, etco2, prevPCo2, prevEtco2);   // 5,2,0
		System.out.println("respFailValChronic: "  + respFailChronic);
		
		respFailAcute = acuteRespFailure(pO2, o2sat);	// 3,0 
		System.out.println("respFailValAcute: "  + respFailAcute);
		
		respFailAcOnChr = respFailAcute && respFailChronic;   // 5,3,1,0
		System.out.println("respFailValAC: " + respFailAcOnChr);
		
		if(respFailAcute == true || respFailChronic == true || respFailAcOnChr == true)
			respFailNOS = prevPCo2.isEmpty() || prevEtco2.isEmpty();
		else
			respFailNOS = false;
		if(respFailNOS)
			ret_val = 1; //ret_val + 1;
		if(respFailAcute){
			ret_val = 2; //ret_val + 10;
			System.out.println("ACUTE: "+ret_val);
		}
		if(respFailChronic){
			ret_val = 3; //ret_val + 100;
		System.out.println("CHRONIC: "+ret_val);
		}
		if(respFailAcOnChr){
			ret_val = 4; //ret_val + 1000;
			System.out.println("CAUTEONCHRONIC:"+ret_val);
		}
		
		return ret_val;

	}


	/*
	 * Chronic Respiratory Failure - High (PCO2 or ETCO2) > 45 and High (PCO2 or
	 * ETCO2) > 45 on previous encounter pCO2 = 48920141 ETCO2 = 160586074
	 * 
	 */

	boolean chronicRespFailure(String pco2, String etco2, String prevPCo2,
			String prevEtco2) {
		boolean current = false, previous = false;
		
		if(!pco2.isEmpty()) {
		    if(Utils.isDouble(pco2)) {
    			if(Double.parseDouble(pco2) > 45.0) {
	    			current = true;
		    	}
            }
		}
		
		if(current != true && !etco2.isEmpty()) {
		    if(Utils.isDouble(etco2)) {
			    if(Double.parseDouble(etco2) > 45.0) {
				    current = true;
    			}
            }
        }
		
		if(!prevPCo2.isEmpty()) {
		    if(Utils.isDouble(prevPCo2) ){
			    if(Double.parseDouble(prevPCo2) > 45.0) {
				    previous = true;
    			}
            }
		}
		
		if(previous != true && !prevEtco2.isEmpty()) {
		    if(Utils.isDouble(prevEtco2)) {
			    if(Double.parseDouble(prevEtco2) > 45.0) {
    				    previous = true;
                }
			}
		}
		
		if(current == true && previous == true) {
			return true;
		}
		
		return false;
	}

	/*
	 * Acute - if PO2 <= 60 or O2 Sat levels <= 90 PO2 = 48920149 O2 sat =
	 * 135041537
	 */
	boolean acuteRespFailure(String pO2, String o2sat) {
		
		if(pO2.isEmpty() != true){
		    if(Utils.isDouble(pO2) ){
			    if(Double.parseDouble(pO2) <= 60)
				    return true;
            }
		}
		
		if(o2sat.isEmpty() != true){
		    if(Utils.isDouble(o2sat)) {
			    if(Double.parseDouble(o2sat) <=90){
				    return true;
                }
			}
		}
		return false;
	}
	
	
	/*
	 * Shock: Systolic Blood Pressure < 90
	 * 
	 * systolic blood pressure = 48326665 cardiac troponin = 366686
	 */
	public int shock(String sys, String ct, String ctHigh) {
		
		/*This variable is used as a flag in this function*/
		count = 0;
		/*When sys value is not avalable
		Return 0 indicating that we cannot compute*/
		if(sys.isEmpty()){
			return 0;
		}
		/*When sys value is present*/
		else {
			/*Evaluating condition for sys to see if shock is present*/
		    if(Utils.isDouble(sys)) {
			    if (Double.parseDouble(sys) < 90.0) {
				    count = 1; //Shock present
                }
			}
		/*If shock is present, we want to know if
		its cardiogenic or not*/
			if (count == 1) {
				/*When CT value is available and condition holds good
				Return 1 indicating cardiogenic shock*/
				if(ct.isEmpty() != true && ctHigh.isEmpty()!= true){
		            if(Utils.isDouble(ct) && Utils.isDouble(ctHigh) ){
    					if ( Double.parseDouble(ct) > Double.parseDouble(ctHigh)) {
	    					return 1; 
                        }
					} 
				}
				/*When CT is null but first condition holds true
				Return 2 indication normal Shock*/
				return 2;
			}
		}
		/*When none of the conditions are true
		Return 0 indicating absence*/
		return 0;
	}

	/*
	 * Sepsis: On current encounter, 2 or more of the following 1) Temperature
	 * >= 38.88) Temperature < 36.  HR < 40 or > 100 4) RR >= 26 5) Serum
	 * WBC(> 12,000 or < 4000 or > 10% bands on differential) 6) Systolic BP <=
	 * 90 7) Positive blood culture 8) Urine output last 8 hours <= 240cc 9)
	 * Lactate value > normal
	 * 
	 * HR = 48326879
	 */
	public int sepsis(String maxhRate, String minhRate, String rRate, String maxwbc, String minwbc, String sysBP,
			String maxtem, String mintem, String lactate, String lactate_high) {

		count = 0;
		boolean newminimumhrate = false , newmaximumhrate = false , newminimumwbc = false , newmaximumwbc = false , newminimumtemp = false , newmaximumtemp = false, newlactate, newmaximumlactate = false;
		
		if(minhRate.isEmpty() && maxhRate.isEmpty()){
			
		}
		/*
		 * Check for Heart Rate<40 >100
		 */
		else if (minhRate.isEmpty() != true) {
		    if(Utils.isDouble(minhRate)) {
                if(Double.parseDouble(minhRate) < 40.0 ){
		            newminimumhrate = true;
                }
            }
		}
		else if ((maxhRate.isEmpty() != true)) { 
		    if(Utils.isDouble(maxhRate)) { 
                if(Double.parseDouble(maxhRate) > 100.0) {
        			newmaximumhrate = true;
                }
            }
		}
		
		if(newminimumhrate == true || newmaximumhrate == true){
			count = count + 1;
		}
		
		
		/*
		 * Check for RR>=26
		 */
		if(rRate.isEmpty() != true){
		    if(Utils.isDouble(rRate)) {
			    if (Double.parseDouble(rRate) > 26.0) {
				    count = count + 1;
    				System.out.println("Sepsis R Rate");
                }
			}
		}
		
		
		if(minwbc.isEmpty() && maxwbc.isEmpty()){
			
		}
		/*
		 * Check for Heart Rate<40 >100
		 */
		else if ((minwbc.isEmpty()) != true ) {
		    if(Utils.isDouble(minwbc) ){
                if (Double.parseDouble(minwbc) < 4.0){
    			newminimumwbc = true;
                }
	    	}
        }
		else if ((maxwbc.isEmpty()) != true && Utils.isDouble(maxwbc) && (Double.parseDouble(maxwbc) > 12.0)) {
		    
			newmaximumwbc = true;
		}
		
		
		if(newminimumwbc == true || newmaximumwbc == true){
			count = count + 1;
		}
		
		
		/*
		 * Check for WBC > 10k or < 40K
		 */		
/*		if(maxwbc.isEmpty() != true ) {
			if (Double.parseDouble(maxwbc) > 12000.0) {
				count = count + 1;
				System.out.println("Sepsis WBC");
			}
		}
		 if(minwbc.isEmpty() != true ) {
				if (Double.parseDouble(minwbc) < 4000.0) {
					count = count + 1;
					System.out.println("Sepsis WBC");
				}
			}*/

		 /*
		  * Check for SysBp<=90
		  */
		
		 if(sysBP.isEmpty() != true ){
			if (Utils.isDouble(sysBP) && Double.parseDouble(sysBP) <= 90) {
				count = count + 1;
				System.out.println("Sepsis SysBP");
			}
		}
		
		 /*
		  * Check for temperature <96.8 >=102
		  */
			if(maxtem.isEmpty() && mintem.isEmpty()){
				
			}
			/*
			 * Check for Heart Rate<40 >100
			 */
			else if (maxtem.isEmpty()!= true){
				if(Utils.isDouble(maxtem) && Double.parseDouble(maxtem) >= 38.88){
					newmaximumtemp = true;
				}				
			}
			else if (mintem.isEmpty()!= true){
				if(Utils.isDouble(mintem) && Double.parseDouble(mintem) < 36){
					newminimumtemp = true;
				}				
			}
			
			
			if(newmaximumtemp == true || newminimumtemp == true){
				count = count + 1;
			}
		
		/* if(maxtem.isEmpty()!= true || mintem.isEmpty()!= true){
			double maxtemperature = (Double.parseDouble(maxtem) * 9/5) + 32;
			double mintemperature = (Double.parseDouble(mintem) * 9/5) + 32;
			if (mintemperature < 96.8 || maxtemperature >= 102.0) {
				System.out.println("Sepsis Temp");
				count = count + 1;
			}
		}*/
		 
		 
		 
		/*
		 * Check for lactate value > normal
		 */
		if((lactate.isEmpty() != true) && (lactate_high.isEmpty() != true)){
			if (Utils.isDouble(lactate) && Utils.isDouble(lactate_high) && Double.parseDouble(lactate) > Double.parseDouble(lactate_high)) {
				count = count + 1;
				System.out.println("Sepsis Lactate");
			}
		}
		System.out.println("Sepsis Count="+count);
		
		if (count >= 2) {
			System.out.println("Sepsis Returning 1");
			return 1;
		}
		else
		{
			System.out.println("Returning 0");
			return 0;
		}
	}

	/*
	 * if WBC Count > 5 AND/OR Urinalysis, Leukocyte Esterase ! =NEGATIVE AND/OR
	 * Urinalysis, Nitrites != NEGATIVE WBC event_cd is 366703 event_cd 366743
	 * is Urinalysis, Leukocyte Esterase event_cd 366742 is Urinalysis, Nitrite
	 */
	public int UTI(String wbc, String urinni, String urinest) {
		/*This variable is used as a flag in this function*/
		count = 0;
		int wbccount = 0;
		/*When whc is not null evaluate the condition*/
		if(wbc.isEmpty()!= true){
			/*Evaluating the condition*/
			if (Utils.isDouble(wbc) && Double.parseDouble(wbc) > 5.0) {
				 wbccount = wbccount + 1; //Flag that this condition is satisfied
			}
		}
		/*When Urinalysis, Leukocyte Nitrite is not null evaluate the condition*/
		if(urinni.isEmpty() != true){
			System.out.println(urinni);
			/*Evaluating the condition*/
			/*if (urinni.equalsIgnoreCase("NEGATIVE")) {				
			}
			else{
				count = count + 1; // Indicating that this condition is satisfied
			}*/
			if(urinni.equalsIgnoreCase("POSITIVE")|| urinni.equalsIgnoreCase("LARGE") || urinni.equalsIgnoreCase("MOD") || 
					urinni.equalsIgnoreCase("SMALL") || urinni.equalsIgnoreCase("TRACE")){
				count = count + 1;
			}
			else{
				//do nothing
			}
		}
		/*When Urinalysis, Leukocyte Esterate is not null evaluate the condition*/
		if(urinest.isEmpty()!= true){
			System.out.println(urinest);
			/*Evaluating the condition*/
			/*if (urinest.equalsIgnoreCase("NEGATIVE")) {
				
			}
			else{
				count = count + 1; // Indicating that this condition is satisfied
			}*/
			if(urinest.equalsIgnoreCase("POSITIVE")|| urinest.equalsIgnoreCase("LARGE") || urinest.equalsIgnoreCase("MOD") || 
					urinest.equalsIgnoreCase("SMALL") || urinest.equalsIgnoreCase("TRACE")){
				count = count + 1;
			}
			else{
				//do nothing
			}
		}
		/*When any one of the above conditions is true
		Return 1 indicating UTI*/
		 if ((count >= 1) && (wbccount==1)) {
			return 1;
		}
		return 0;
	}
	
	/*
	 * Lactic acidosis : Lactic Acid > 2.2
	 * Lactic acid : event_id = 366692
	 */
	public int lacticAcidosis(String lacticAcid, String LacticAcidHigh){
		/*When the value is not present
		Return false as we cannot compute*/
		if (lacticAcid.isEmpty() || LacticAcidHigh.isEmpty()) {
			return 0;
		}
		/*When value is greater than High value (2.2)
		Return 1 indication Lactic acidosis*/
		else if (Utils.isDouble(lacticAcid) && Utils.isDouble(LacticAcidHigh) && Double.parseDouble(lacticAcid) > Double.parseDouble(LacticAcidHigh))  {
				return 1;
		}
		/*When none of the above conditions match
		Return 0 indicating absence of Lactic acidosis*/
		return 0;
	}
	
	/* Dehydration : (BUN/creatinine) > 20
	 * creatinine value = 366653 BUN = 366649 
	 */
	public double dehydration(String creat, String bun){
		/*When the value is not present
		Return false as we cannot compute*/
		if (creat.isEmpty() || bun.isEmpty()) {
            return 0;
        }
        else {
            double creatinine =0.0, hydration = 0.0;
            if(Utils.isDouble(creat) )
                creatinine = Double.parseDouble(creat);
            if(Utils.isDouble(bun) && creatinine!=0.0)
                hydration = Double.parseDouble(bun)/creatinine ;
            
            /*Return the hydration value indicating presence*/
            if(hydration > 20){
                double round_hydration = hydration*100;
                round_hydration = Math.round(round_hydration);
                hydration = round_hydration/100;
                return hydration;
            }
            /*Return 0 indicating absence*/
            else{
                return 0;
            }
        }
	}
	
	/*
	 * HyperCholestrolemia: Total Cholesterol > 200
	 */
	public double HyperCholestrolemia(String chol){
		/*When the value is not present
		Return false as we cannot compute*/
		if (chol.isEmpty()) {
			return 0;
		}
		else if(Utils.isDouble(chol)&& Double.parseDouble(chol) > 200){
			return 1;
		}
		
		return 0;		
	}
	
	/*
	 * Hypoxia - when pulse oximetry < 90
	 */
	public boolean hypoxia(String low, String resVal) {
		/*When the value is not present
		Return false as we cannot compute*/
		if (resVal.isEmpty() != true  && low.isEmpty() != true) {
			if (Utils.isDouble(resVal) && Double.parseDouble(resVal) <  90){ //Double.parseDouble(low)) {
				return true;
			}
			else{
				return false;
			} 
		} 
		/*When the value is present and the condition does not match
		Return false indicating absence*/
		return false;
	}
	
	
}
