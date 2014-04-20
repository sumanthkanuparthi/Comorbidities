package comorb;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSSerializer;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import comorb.PrintInterface.ComorbiditiesFunctor;

public class CardiogenicShock implements ComorbiditiesFunctor {
	
	private final String spacesLevelThree_;
	private final String spacesLevelTwo_;
	private final Font font_;
	private final Font fontSubHead_;
	private final Font subFont_;
	private final Font errorFont_;
		
	/*
	 * Constructor to initialize variables
	 */
	CardiogenicShock(Font font, Font fontSubHead, Font subFont, Font errorFont, String spacesLevelThree, String spacesLevelTwo)
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
		return "Cardiogenic Shock";
	}
	
	/*
	 * This returns the ICD9  
	 */
	public String getICD9(){
			return (new String("(ICD9 CODE: "+"785.51)"));
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		
		String overallReturn="";
		String temp="print";
		
		
		String[] cshockChkGrp = null;
		final String cshockDate     = Utils.getParameter(request, "cShockDate");
		final String cshockBP       = Utils.getParameter(request, "cShockBP");
		final String cDateShockTrop = Utils.getParameter(request, "cDateShockTrop");
		final String cShockTrop     = Utils.getParameter(request, "cShockTrop");
		
		cshockChkGrp   = request.getParameterValues("cshockChkGrp");
		/*cshockDate     = request.getParameter("cShockDate");
		cshockBP       = request.getParameter("cShockBP");
		cDateShockTrop = request.getParameter("cDateShockTrop");
		cShockTrop     = request.getParameter("cShockTrop");*/
		if(flag==1)
		{
			DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy h:mm a");
			Date date = new Date();
			String Date = dateFormat.format(date);
			Document doc = null;
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder;
			try {
				docBuilder = docFactory.newDocumentBuilder();
				 doc = docBuilder.newDocument();
			} catch (ParserConfigurationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			

			Element rootElement = doc.createElement("comorbidity");
			doc.appendChild(rootElement);
			Element nameElement = doc.createElement("name");
			nameElement.appendChild(doc.createTextNode(getName()));
			rootElement.appendChild(nameElement);

			Element icdElement = doc.createElement("icd");
			icdElement.appendChild(doc.createTextNode(getICD9()));
			rootElement.appendChild(icdElement);

			Element dateElement = doc.createElement("date");
			dateElement.appendChild(doc.createTextNode(Date.substring(0,10)));
			rootElement.appendChild(dateElement);

			Element timeElement = doc.createElement("time");
			timeElement.appendChild(doc.createTextNode(Date.substring(0,10)));
			rootElement.appendChild(timeElement);

			if(cshockChkGrp == null){
				XMLGenerator xg=new XMLGenerator();
				
				overallReturn=xg.generateXMLString(doc);

			}
			else{
				
				//rootElement.appendChild(subCat);
				for (int j = 0; j < cshockChkGrp.length; j++){
					Element subCat = doc.createElement("subcategory");
					rootElement.appendChild(subCat);
					
					if(cshockChkGrp[j].equalsIgnoreCase("Cardiogenic Shock:Cardiogenic Shock")) {
						
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Cardiogenic Shock:Cardiogenic Shock"));
						subCat.appendChild(subname);
						Element creat1 = doc.createElement("cshockBP");
						creat1.appendChild(doc.createTextNode(cshockBP));
						subCat.appendChild(creat1);
						Element creatDate = doc.createElement("cshockDate");
						creatDate.appendChild(doc.createTextNode(cshockDate.toString()));
						subCat.appendChild(creatDate);
						
						Element prevCreat1 = doc.createElement("cShockTrop");
					    prevCreat1.appendChild(doc.createTextNode(cShockTrop));
					    subCat.appendChild(prevCreat1);
					    
					    Element prevCreatDate1 = doc.createElement("cDateShockTrop");
						prevCreatDate1.appendChild(doc.createTextNode(cDateShockTrop.toString()));
						subCat.appendChild(prevCreatDate1);
						
				      }
					else if(cshockChkGrp[j].equalsIgnoreCase("Cardiogenic Shock:Septic")) {
						
						
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Cardiogenic Shock:Septic"));
						subCat.appendChild(subname);
						
						Element creat = doc.createElement("cshockDate");
						creat.appendChild(doc.createTextNode(cshockDate));
						subCat.appendChild(creat);
						
						
						Element creatDate = doc.createElement("cshockBP");
						creatDate.appendChild(doc.createTextNode(cshockBP.toString()));
						subCat.appendChild(creatDate);
						


					}
					else if(cshockChkGrp[j].equalsIgnoreCase("Cardiogenic Shock:Hypovolemic")){
						
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Cardiogenic Shock:Hypovolemic"));
						subCat.appendChild(subname);
						
						
							Element creat = doc.createElement("cshockDate");
							creat.appendChild(doc.createTextNode(cshockDate));
							subCat.appendChild(creat);
							
						
							Element prevCreat = doc.createElement("cshockBP");
							prevCreat.appendChild(doc.createTextNode(cshockBP.toString()));
							subCat.appendChild(prevCreat);
							
							
						}
					
					
	            else if(cshockChkGrp[j].equalsIgnoreCase("Cardiogenic Shock:Obstructive")){
						
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Cardiogenic Shock:Obstructive"));
						subCat.appendChild(subname);
						
						
							Element creat = doc.createElement("cshockDate");
							creat.appendChild(doc.createTextNode(cshockDate));
							subCat.appendChild(creat);
							
						
							Element prevCreat = doc.createElement("cshockBP");
							prevCreat.appendChild(doc.createTextNode(cshockBP.toString()));
							subCat.appendChild(prevCreat);
							
				}
					
					
					
	            else if(cshockChkGrp[j].equalsIgnoreCase("Cardiogenic Shock:NOS")){
						
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Cardiogenic Shock:NOS"));
						subCat.appendChild(subname);
						
						
							Element creat = doc.createElement("cshockDate");
							creat.appendChild(doc.createTextNode(cshockDate));
							subCat.appendChild(creat);
							
						
							Element prevCreat = doc.createElement("cshockBP");
							prevCreat.appendChild(doc.createTextNode(cshockBP.toString()));
							subCat.appendChild(prevCreat);
							
				  }
					
                }
		    }

			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
		    LSSerializer lsSerializer = domImplementation.createLSSerializer();
		    overallReturn= lsSerializer.writeToString(doc);
		}
		
		if(flag==0)
		{
			
			String mainGrp = getName();
			writer.beginParagraph();
			writer.outLine("     \u2022  " + mainGrp + "  " + getICD9() + "\n",font_);
			writer.endParagraph();
		
		if(cshockChkGrp == null){
		
			writer.beginParagraph();
			writer.outLine("     \u2022  Null values returned for Cardiogenic Shock \n",errorFont_);
			writer.endParagraph();
		}
		else{
			
			for (int j = 0; j < cshockChkGrp.length; j++){
				
				if(cshockChkGrp[j].equals("Cardiogenic Shock:Cardiogenic Shock")){
					
					writer.beginParagraph();
					writer.outLine(spacesLevelTwo_ + "Cardiogenic Shock" + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Systolic Blood Pressure: " + cshockBP + " " + cshockDate +  "\n",subFont_);
					writer.outLine(spacesLevelThree_ + "Cardiac Troponin Date:   " + cShockTrop + " " + cDateShockTrop +  "\n",subFont_);					
					writer.endParagraph();
					
				}
				else if(cshockChkGrp[j].equals("Cardiogenic Shock:Septic")){

					
					writer.beginParagraph();
					writer.outLine("          " + "Shock : Septic" + "\n",fontSubHead_);
					writer.outLine("                  Systolic BP Date: " + cshockDate +
							"        Systolic Blood Pressure: " + cshockBP + "\n"  ,subFont_);					
					writer.endParagraph();
					
				}
				else if(cshockChkGrp[j].equals("Cardiogenic Shock:Hypovolemic")){
					
					writer.beginParagraph();
					writer.outLine("          " + "Shock : Hypovolemic" + "\n",fontSubHead_);
					writer.outLine("                  Systolic BP Date: " + cshockDate +
							"        Systolic Blood Pressure: " + cshockBP + "\n"  ,subFont_);
					writer.endParagraph();
					
				}
				else if(cshockChkGrp[j].equals("Cardiogenic Shock:Obstructive")){

					writer.beginParagraph();
					writer.outLine("          " + "Shock : Obstructive" + "\n",fontSubHead_);
					writer.outLine("                  Systolic BP Date: " + cshockDate +
							"        Systolic Blood Pressure: " + cshockBP + "\n"  ,subFont_);					
					writer.endParagraph();
					
				}
				else if(cshockChkGrp[j].equals("Cardiogenic Shock:NOS")){
					
					writer.beginParagraph();					
					writer.outLine("          " + "Shock : NOS" + "\n",fontSubHead_);
					writer.outLine("                  Systolic BP Date: " + cshockDate +
							"        Systolic Blood Pressure: " + cshockBP + "\n"  ,subFont_);					
					writer.endParagraph();
					
				}	
			  }
		   }
		overallReturn="print";
	   }
	return overallReturn;
	}
}
