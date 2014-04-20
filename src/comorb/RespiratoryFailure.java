package comorb;

import javax.servlet.http.HttpServletRequest;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;

import comorb.PrintInterface.ComorbiditiesFunctor;

public class RespiratoryFailure implements ComorbiditiesFunctor {
	
	private final String spacesLevelThree_;
	private final String spacesLevelTwo_;
	private final Font font_;
	private final Font fontSubHead_;
	private final Font subFont_;
	private final Font errorFont_;
		
	/*
	 * Constructor to initialize variables
	 */
	RespiratoryFailure(Font font, Font fontSubHead, Font subFont, Font errorFont, String spacesLevelThree, String spacesLevelTwo)
	{
		errorFont_ = errorFont;
		font_ = font;
		fontSubHead_ = fontSubHead;
		subFont_ = subFont;
		spacesLevelThree_ = spacesLevelThree;
		spacesLevelTwo_ = spacesLevelTwo;
	}
	
	/*
	 * This simply returns the name of the class/comorbidity
	 */
	@Override
	public String getName() {
		return "Respiratory Failure";
	}
	
	public String getICD9(String n){
		if(n.equalsIgnoreCase("Acute on Chronic"))
			return (new String("(ICD9 CODE: "+"518.84)"));
		else if(n.equalsIgnoreCase("Acute"))
			return (new String("(ICD9 CODE: "+"518.81)"));
		else if(n.equalsIgnoreCase("Chronic"))
			return (new String("(ICD9 CODE: "+"518.83)"));
		else
			return (new String(" "));
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		
		String temp="";
		String mainGrp = getName();
		if(flag==0)
		{
		
		writer.beginParagraph();
		writer.outLine("     \u2022  " + mainGrp + "\n",font_);
		writer.endParagraph();
		}
		String[] respFailChkGrp = null;
		respFailChkGrp =  request.getParameterValues("respFailChkGrp");
		
		if(respFailChkGrp == null) {
			if(flag==0)
			{
			writer.beginParagraph();
			writer.outLine("     \u2022  Null values returned for Respiratory Failure \n", errorFont_);
			writer.endParagraph();
		}
		}
		else{
			for (int j = 0; j < respFailChkGrp.length; j++){

			if(respFailChkGrp[j].equals("Respiratory Failure :Acute")){

				//final String maxsepHr      = Utils.getParameter(request,"maxsepHr");
				final String respPo2Date   = Utils.getParameter(request,"respPo2Date");
				final String respPo        = Utils.getParameter(request,"respPo");
				final String respO2satDate = Utils.getParameter(request,"respO2satDate");
				final String respO2sat     = Utils.getParameter(request,"respO2sat");
				
				
				/*String respPo2Date,respPo,respO2satDate, respO2sat = "";
				
				respPo2Date   = request.getParameter("respPo2Date");
				respPo        = request.getParameter("respPo");
				respO2satDate = request.getParameter("respO2satDate");
				respO2sat     = request.getParameter("respO2sat");
				 */			
				if(flag==0)
				{
					
				temp="print";
				writer.beginParagraph();

				writer.outLine(spacesLevelTwo_ + "Acute" + "  " + getICD9("Acute") + "\n",fontSubHead_);
				if(respPo.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "PO2:            " + respPo + " " + respPo2Date + "\n",subFont_);
				}
				if(respO2sat.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "Pulse Oximetry: " + respO2sat + " " + respO2satDate + "\n",subFont_);
				}
				
				writer.endParagraph();
				}
				else
					temp=temp+","+getICD9("Acute");
				
			}
			else if(respFailChkGrp[j].equals("Respiratory Failure :Chronic")){

				if(flag==0)
				{
				final String respPco2Date      = Utils.getParameter(request,"respPco2Date");
				final String respPco2          = Utils.getParameter(request,"respPco2");
				final String respEtco2Date     = Utils.getParameter(request,"respEtco2Date");
				final String respEtco2         = Utils.getParameter(request,"respEtco2");
				final String respPrevPco2Date  = Utils.getParameter(request,"respPrevPco2Date");
				final String respPrevPco2      = Utils.getParameter(request,"respPrevPco2");
				final String respPrevEtco2Date = Utils.getParameter(request,"respPrevEtco2Date");
				final String respPrevEtco2     = Utils.getParameter(request,"respPrevEtco2");
				
				
				/*String respPco2Date,respPco2,respEtco2Date, respEtco2, respPrevPco2Date = "";
				String respPrevPco2, respPrevEtco2Date, respPrevEtco2 = "";
				
				//final String maxsepHr      = Utils.getParameter(request,"maxsepHr");
				
				respPco2Date      = request.getParameter("respPco2Date");
				respPco2          = request.getParameter("respPco2");
				respEtco2Date     = request.getParameter("respEtco2Date");
				respEtco2         = request.getParameter("respEtco2");
				respPrevPco2Date  = request.getParameter("respPrevPco2Date");
				respPrevPco2      = request.getParameter("respPrevPco2");
				respPrevEtco2Date = request.getParameter("respPrevEtco2Date");
				respPrevEtco2     = request.getParameter("respPrevEtco2");
				*/

				
				writer.beginParagraph();
				
				writer.outLine("          " + "Chronic" + "  " + getICD9("Chronic") + "\n",fontSubHead_);
				
				if(respPco2.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "PCO2:           " + respPco2 + " " + respPco2Date + "\n",subFont_);
				}
				if(respPrevPco2.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "Previous PCO2:  " + respPrevPco2 + " " + respPrevPco2Date + "\n",subFont_);
				}
				if(respEtco2.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "EtcO2:          " + respEtco2 + " " + respEtco2Date + "\n",subFont_);
				}
				if(respPrevEtco2.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "Previous EtcO2: " + respPrevEtco2 + " " + respPrevEtco2Date + "\n",subFont_);
				}

				writer.endParagraph();
				}
				else
					temp=temp+","+getICD9("Chronic") ;
				
		}
			else if(respFailChkGrp[j].equals("Respiratory Failure :Acute on Chronic")) {
				if(flag==0)
				{
				
				final String respPco2Date = Utils.getParameter(request,"respPco2Date");
				final String respPco2 = Utils.getParameter(request,"respPco2");
				final String respEtco2Date = Utils.getParameter(request,"respEtco2Date");
				final String respEtco2 = Utils.getParameter(request,"respEtco2");
				final String respPrevPco2Date = Utils.getParameter(request,"respPrevPco2Date");
				final String respPrevPco2 = Utils.getParameter(request,"respPrevPco2");
				final String respPrevEtco2Date = Utils.getParameter(request,"respPrevEtco2Date");
				final String respPrevEtco2 = Utils.getParameter(request,"respPrevEtco2");
				
				final String respPo2Date   = Utils.getParameter(request,"respPo2Date");
				final String respPo        = Utils.getParameter(request,"respPo");
				final String respO2satDate = Utils.getParameter(request,"respO2satDate");
				final String respO2sat     = Utils.getParameter(request,"respO2sat");

				/*
				String respPco2Date, respPco2, respEtco2Date, respEtco2, respPrevPco2Date = ""; 
				String respPrevPco2, respPrevEtco2Date, respPrevEtco2= "";
				String respPo2Date,respPo,respO2satDate, respO2sat = "";
				
				respPco2Date = request.getParameter("respPco2Date");
				respPco2 = request.getParameter("respPco2");
				respEtco2Date = request.getParameter("respEtco2Date");
				respEtco2 = request.getParameter("respEtco2");
				respPrevPco2Date = request.getParameter("respPrevPco2Date");
				respPrevPco2 = request.getParameter("respPrevPco2");
				respPrevEtco2Date = request.getParameter("respPrevEtco2Date");
				respPrevEtco2 = request.getParameter("respPrevEtco2");
				
				respPo2Date   = request.getParameter("respPo2Date");
				respPo        = request.getParameter("respPo");
				respO2satDate = request.getParameter("respO2satDate");
				respO2sat     = request.getParameter("respO2sat");
				*/

				
				writer.beginParagraph();
				writer.outLine("          " + "Acute on Chronic" + "  " + getICD9("Acute on Chronic") + "\n",fontSubHead_);
				
				if(respPo.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "PO2:                " + respPo + " " + respPo2Date + "\n",subFont_);
				}
				if(respO2sat.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "Pulse Oximetry: " + respO2sat + " " + respO2satDate + "\n",subFont_);
				}
				if(respPco2.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "PCO2:           " + respPco2 + " " + respPco2Date + "\n",subFont_);
				}
				if(respPrevPco2.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "Previous PCO2:  " + respPrevPco2 + " " + respPrevPco2Date + "\n",subFont_);
				}
				if(respEtco2.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "EtcO2:          " + respEtco2 + " " + respEtco2Date + "\n",subFont_);
				}
				if(respPrevEtco2.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "Previous EtcO2: " + respPrevEtco2 + " " + respPrevEtco2Date + "\n",subFont_);
				}

				writer.endParagraph();
				}
				else
					temp=temp+","+getICD9("Chronic") ;
			}
		}
	}
		return temp;
}
	

}
