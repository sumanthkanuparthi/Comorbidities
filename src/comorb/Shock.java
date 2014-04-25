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

public class Shock implements ComorbiditiesFunctor {
	
	private final String spacesLevelThree_;
	private final String spacesLevelTwo_;
	private final Font font_;
	private final Font fontSubHead_;
	private final Font subFont_;
	private final Font errorFont_;
		
	/*
	 * Constructor to initialize variables
	 */
	Shock(Font font, Font fontSubHead, Font subFont, Font errorFont, String spacesLevelThree, String spacesLevelTwo)
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
		return "Shock";
	}
	
	public String getICD9(String n){
		if(n.equalsIgnoreCase("Septic"))
			return (new String("(ICD9 CODE: "+"785.52)"));
		else if(n.equalsIgnoreCase("Hypovolemic"))
			return (new String("(ICD9 CODE: "+"785.59)"));
		else if(n.equalsIgnoreCase("NOS"))
			return (new String("(ICD9 CODE: "+"785.50)"));
		else
			return (new String(" "));
	}
	
	public String getICD9Commit(String n){
		if(n.equalsIgnoreCase("Septic"))
			return (new String("785.52"));
		else if(n.equalsIgnoreCase("Hypovolemic"))
			return (new String("785.59"));
		else if(n.equalsIgnoreCase("NOS"))
			return (new String("785.50"));
		else
			return (new String(" "));
	}
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		
		String overallReturn="";
		String mainGrp = getName();
		String[] shockChkGrp = null;
		final String shockDate     =  Utils.getParameter(request, "shockDate");
		final String shockBP       =  Utils.getParameter(request, "shockBp");
		
		shockChkGrp = request.getParameterValues("shockChkGrp");
		
		// flag =1 code starts 
		if(flag==1){
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
			icdElement.appendChild(doc.createTextNode(""));
			rootElement.appendChild(icdElement);

			Element dateElement = doc.createElement("date");
			dateElement.appendChild(doc.createTextNode(Date.substring(0,10)));
			rootElement.appendChild(dateElement);

			Element timeElement = doc.createElement("time");
			timeElement.appendChild(doc.createTextNode(Date.substring(0,10)));
			rootElement.appendChild(timeElement);

			if(shockChkGrp == null){
				XMLGenerator xg=new XMLGenerator();

				overallReturn=xg.generateXMLString(doc);

			}
			else{
				
				//rootElement.appendChild(subCat);
				for (int j = 0; j < shockChkGrp.length; j++){
					Element subCat = doc.createElement("subcategory");
					rootElement.appendChild(subCat);

					if(shockChkGrp[j].equalsIgnoreCase("Shock:Septic")) {

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Shock:Septic"));
						subCat.appendChild(subname);
						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Septic")));
						subCat.appendChild(icd91);

						
							Element shockBPElement = doc.createElement("shockbp");
							shockBPElement.appendChild(doc.createTextNode(getICD9Commit(shockBP)));
							subCat.appendChild(shockBPElement);
							Element shockDateElement = doc.createElement("shockdate");
							shockDateElement.appendChild(doc.createTextNode(getICD9Commit(shockDate)));
							subCat.appendChild(shockDateElement);


						
						
						//	writer.outLine(spacesLevelThree_ + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n",subFont_);


					}
					else if(shockChkGrp[j].equalsIgnoreCase("Shock:Obstructive")) {


						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Shock:Obstructive"));
						subCat.appendChild(subname);
						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(""));
						subCat.appendChild(icd91);

						Element shockBPElement = doc.createElement("shockbp");
						shockBPElement.appendChild(doc.createTextNode(getICD9Commit(shockBP)));
						subCat.appendChild(shockBPElement);
						Element shockDateElement = doc.createElement("shockdate");
						shockDateElement.appendChild(doc.createTextNode(getICD9Commit(shockDate)));
						subCat.appendChild(shockDateElement);


					}
					else if(shockChkGrp[j].equalsIgnoreCase("Shock:NOS")){

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Shock:NOS"));
						subCat.appendChild(subname);

						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("NOS")));
						subCat.appendChild(icd91);
						
						Element shockBPElement = doc.createElement("shockbp");
						shockBPElement.appendChild(doc.createTextNode(getICD9Commit(shockBP)));
						subCat.appendChild(shockBPElement);
						Element shockDateElement = doc.createElement("shockdate");
						shockDateElement.appendChild(doc.createTextNode(getICD9Commit(shockDate)));
						subCat.appendChild(shockDateElement);
					}
					
					else if(shockChkGrp[j].equalsIgnoreCase("Shock:Hypovolemic")){

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Shock:Hypovolemic"));
						subCat.appendChild(subname);

						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Hypovolemic")));
						subCat.appendChild(icd91);
						
						Element shockBPElement = doc.createElement("shockbp");
						shockBPElement.appendChild(doc.createTextNode(getICD9Commit(shockBP)));
						subCat.appendChild(shockBPElement);
						Element shockDateElement = doc.createElement("shockdate");
						shockDateElement.appendChild(doc.createTextNode(getICD9Commit(shockDate)));
						subCat.appendChild(shockDateElement);
					}



				}
			}
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
			LSSerializer lsSerializer = domImplementation.createLSSerializer();
			overallReturn= lsSerializer.writeToString(doc);

		}


		
		
		// flag =1 code ends
		
		
		
		if(flag==0)
		{
		writer.beginParagraph();
		writer.outLine("     \u2022  " + mainGrp + "\n",font_);
		writer.endParagraph();
		//temp="print";
		
		
		
		
		
	/*	shockDate   = request.getParameter("shockDate");
		shockBP     = request.getParameter("shockBp");
*/
		if(shockChkGrp == null){
			
			writer.beginParagraph();
			writer.outLine("     \u2022  Null values returned for Shock \n",errorFont_);
			writer.endParagraph();
			
		}
		else{		
			for (int j = 0; j < shockChkGrp.length; j++){
				
				if(shockChkGrp[j].equals("Shock:Septic")){
					
					
					writer.beginParagraph();
					writer.outLine(spacesLevelTwo_ + "Septic" + "  " + getICD9("Septic") + "\n" ,fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n"  
							,subFont_);					
					writer.endParagraph();
					}
					
					
				
				else if(shockChkGrp[j].equals("Shock:Hypovolemic")){
					
					writer.beginParagraph();
					writer.outLine(spacesLevelTwo_ + "Hypovolemic" + "  " + getICD9("Hypovolemic") + "\n" ,fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n"  
							,subFont_);					
					writer.endParagraph();
					
					
					
				}
				else if(shockChkGrp[j].equals("Shock:Obstructive")){
					
					writer.beginParagraph();
					writer.outLine(spacesLevelTwo_ + "Obstructive" + "\n" ,fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n"  
							,subFont_);					
					writer.endParagraph();
					}
					
					
				
				else if(shockChkGrp[j].equals("Shock:NOS")){
					
					
					
					writer.beginParagraph();
					writer.outLine(spacesLevelTwo_ + "NOS" + "  " + getICD9("NOS") + "\n" ,fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n"  
							,subFont_);					
					writer.endParagraph();
					}
					
									
			}
		}
	}
		return overallReturn;
	}
}
