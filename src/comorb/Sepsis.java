package comorb;

import javax.servlet.http.HttpServletRequest;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import comorb.PrintInterface.ComorbiditiesFunctor;

public class Sepsis implements ComorbiditiesFunctor {
	
	private final String spacesLevelThree_;
	private final String spacesLevelTwo_;
	private final Font font_;
	private final Font fontSubHead_;
	private final Font subFont_;
	private final Font errorFont_;
		
	/*
	 * Constructor to initialize variables
	 */
	Sepsis(Font font, Font fontSubHead, Font subFont, String spacesLevelThree, String spacesLevelTwo,
			Font errorFont)
	{
		font_ = font;
		fontSubHead_ = fontSubHead;
		subFont_ = subFont;
		spacesLevelThree_ = spacesLevelThree;
		spacesLevelTwo_ = spacesLevelTwo;
		errorFont_ = errorFont;
	}
	
	/*
	 * This simply returns the name of the class/comorbidity
	 */
	@Override
	public String getName() {
		return "Sepsis";
	}
	
	public String getICD9(){
		return (new String("(ICD9 CODE: "+"995.91)"));
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		
		String temp="print";
		if(flag==0)
		{
		String mainGrp = getName();
		writer.beginParagraph();
		writer.outLine("     \u2022  " + mainGrp + "  " + getICD9() + "\n",font_);
		
		
		final String maxsepHr      = Utils.getParameter(request,"maxsepHr");
		final String minsepHr      = Utils.getParameter(request,"minsepHr");
		final String sepRr         = Utils.getParameter(request,"sepRr");
		final String sepMaxWbc     = Utils.getParameter(request,"maxsepWbc");
		final String sepMinWbc     = Utils.getParameter(request,"minsepWbc");
		final String sepSysBP      = Utils.getParameter(request,"sepSysBP");
		final String maxsepTem     = Utils.getParameter(request,"maxsepTem");
		final String minsepTem     = Utils.getParameter(request,"minsepTem");
		final String sepLac        = Utils.getParameter(request,"sepLac");
		final String maxsepHrDate  = Utils.getParameter(request,"maxsepHrDate");
		final String minsepHrDate  = Utils.getParameter(request,"minsepHrDate");
		final String sepRrDate     = Utils.getParameter(request,"sepRrDate");
		final String sepMaxWbcDate = Utils.getParameter(request,"maxsepWbcDate");
		final String sepMinWbcDate = Utils.getParameter(request,"minsepWbcDate");
		final String sepSysBPDate  = Utils.getParameter(request,"sepSysBPDate");
		final String maxsepTemDate = Utils.getParameter(request,"maxsepTemDate");
		final String minsepTemDate = Utils.getParameter(request,"minsepTemDate");
		final String sepLacDate    = Utils.getParameter(request,"sepLacDate");
		final String sepLacHigh    = Utils.getParameter(request,"sepLacHigh");		
		
		/*
		String sepDate       = "";
		String maxsepHr      = "";
		String minsepHr      = "";
		String sepRr         = "";
		String sepMaxWbc     = "";
		String sepMinWbc     = "";
		String sepSysBP      = "";
		String maxsepTem     = "";
		String minsepTem     = "";
		String sepLac        = ""; 
		String maxsepHrDate  = "";
		String minsepHrDate  = "";
		String sepRrDate     = "";
		String sepMaxWbcDate = "";
		String sepMinWbcDate = "";
		String sepSysBPDate  = "";
		String maxsepTemDate = ""; 
		String minsepTemDate = "";
		String sepLacDate    = "";
		String sepLacHigh    = "";
		
		maxsepHr      = request.getParameter("maxsepHr");
		minsepHr      = request.getParameter("minsepHr");
		sepRr         = request.getParameter("sepRr");
		sepMaxWbc     = request.getParameter("maxsepWbc");
		sepMinWbc     = request.getParameter("minsepWbc");
		sepSysBP      = request.getParameter("sepSysBP");
		maxsepTem     = request.getParameter("maxsepTem");
		minsepTem     = request.getParameter("minsepTem");
		sepLac        = request.getParameter("sepLac");
		maxsepHrDate  = request.getParameter("maxsepHrDate");
		minsepHrDate  = request.getParameter("minsepHrDate");
		sepRrDate     = request.getParameter("sepRrDate");
		sepMaxWbcDate = request.getParameter("maxsepWbcDate");
		sepMinWbcDate = request.getParameter("minsepWbcDate");
		sepSysBPDate  = request.getParameter("sepSysBPDate");
		maxsepTemDate = request.getParameter("maxsepTemDate");
		minsepTemDate = request.getParameter("minsepTemDate");
		sepLacDate    = request.getParameter("sepLacDate");
		sepLacHigh    = request.getParameter("sepLacHigh");		
		*/
		
		if(!maxsepHr.isEmpty()) {
			if (Utils.isDouble(maxsepHr)) {
				if (Double.parseDouble(maxsepHr) > 100.0)
					writer.outLine(spacesLevelThree_ + "Heart Rate (Maximum):  " + maxsepHr + 
					" "+ maxsepHrDate + "\n",subFont_);
			} else { 
				writer.outLine(spacesLevelThree_ + "Wrong Parameter: Heart Rate (Maximum):  " + maxsepHr + 
						" "+ maxsepHrDate + "\n",errorFont_);
			}
		}

		if(!minsepHr.isEmpty()) {
			if (Utils.isDouble(minsepHr)) {
				if (Double.parseDouble(minsepHr) < 40.0)
					writer.outLine(spacesLevelThree_ + "Heart Rate (Minimum):  " + minsepHr + 
					" "+ minsepHrDate + "\n",subFont_);
			} else { 
				writer.outLine(spacesLevelThree_ + "Wrong Parameter: Heart Rate (Minimum):  " + minsepHr + 
						" "+ minsepHrDate + "\n",errorFont_);
			}
		}

		if(!sepRr.isEmpty()) {
			if(Utils.isDouble(sepRr))
			{
				if(Double.parseDouble(sepRr) > 26.0)
					writer.outLine(spacesLevelThree_ + "Respiratory Rate:      " + sepRr + " "+
							sepRrDate + "\n",subFont_);
			}
			else
				writer.outLine(spacesLevelThree_ + "Wrong Parameter: Respiratory Rate:      " +
						sepRr + " "+ sepRrDate + "\n",errorFont_);
		}
		
		if(!sepMaxWbc.isEmpty()) {
			if (Utils.isDouble(sepMaxWbc)) {
				if (Double.parseDouble(sepMaxWbc) > 12.0)
					writer.outLine(spacesLevelThree_ + "WBC count (Maximum):   " + sepMaxWbc + 
							" "+ sepMaxWbcDate + "\n", subFont_);
			} else { 
				writer.outLine(spacesLevelThree_ + "Wrong: WBC count (Maximum):   " + sepMaxWbc + 
						" "+ sepMaxWbcDate + "\n", errorFont_);
			}
		}
		
		if (!sepMinWbc.isEmpty()) {
			if (Utils.isDouble(sepMinWbc)) {
				if (Double.parseDouble(sepMinWbc) < 4.0)
					writer.outLine(spacesLevelThree_ + "WBC count (Minimum):   " + sepMinWbc + 
							" "+ sepMinWbcDate + "\n", subFont_);
			} else {
				writer.outLine(spacesLevelThree_ + "Wrong: WBC count (Minimum):   " + sepMinWbc + 
						" "+ sepMinWbcDate + "\n", errorFont_);
			}
		}

		
		if(!sepSysBP.isEmpty()) {
			if (Utils.isDouble(sepSysBP)) {
				if (Double.parseDouble(sepSysBP) <= 90.0)
					writer.outLine(spacesLevelThree_ + "Systolic BP:           " + sepSysBP + 
							" "+ sepSysBPDate + "\n", subFont_);
			} else {
				writer.outLine(spacesLevelThree_ + "Wrong: Systolic BP:           " + sepSysBP + 
						" "+ sepSysBPDate + "\n", errorFont_);
			}
		}
		
		if(!maxsepTem.isEmpty()) {
			if (Utils.isDouble(maxsepTem)) {
				if (Double.parseDouble(maxsepTem) >= 38.88)
					writer.outLine(spacesLevelThree_ + "Temperature (Maximum): " + maxsepTem + 
							" "+ maxsepTemDate + "\n" ,subFont_);
			} else {
				writer.outLine(spacesLevelThree_ + "Wrong: Temperature (Maximum): " + maxsepTem + 
						" "+ maxsepTemDate + "\n" ,errorFont_);
			}
		}
		
		if(!minsepTem.isEmpty()) {
			if (Utils.isDouble(minsepTem)) {
				if (Double.parseDouble(minsepTem) < 36)
					writer.outLine(spacesLevelThree_ + "Temperature (Minimum): " + minsepTem + 
							" "+ minsepTemDate + "\n" ,subFont_);
			} else {
				writer.outLine(spacesLevelThree_ + "Wrong: Temperature (Minimum): " + minsepTem + 
						" "+ minsepTemDate + "\n" ,errorFont_);
			}
		}
		
		if(!sepLac.isEmpty()) {
			if (Utils.isDouble(sepLac) && Utils.isDouble(sepLacHigh)) {
				if (Double.parseDouble(sepLac) > Double.parseDouble(sepLacHigh))
					writer.outLine(spacesLevelThree_ + "Lactate:               " + sepLac + " "+ sepLacDate + "\n" ,subFont_);
			} else {
				writer.outLine(spacesLevelThree_ + "Wrong: Lactate:               " + sepLac + " "+ sepLacDate + "\n" , errorFont_);
			}
		} 
																														
		writer.endParagraph();
		}
		else
			temp=getICD9();
		return temp;
			
	}
}
