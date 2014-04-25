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

public class ChronicKidneyDisease implements ComorbiditiesFunctor {
	
	private final String spacesLevelThree_;
	private final String spacesLevelTwo_;
	private final Font font_;
	private final Font fontSubHead_;
	private final Font subFont_;
	private final Font errorFont_;
		
	/*
	 * Constructor to initialize variables
	 */
	ChronicKidneyDisease(Font font, Font fontSubHead, Font subFont, Font errorFont, String spacesLevelThree, String spacesLevelTwo)
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
		return "Chronic Kidney Disease";
	}
	
	/*
	 * This returns the ICD9  
	 */
	public String getICD9(){
			return (new String("(ICD9 CODE: "+"585.9)"));
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		String overallReturn="";
		String mainGrp = getName();
		String temp="print";
		
		
		String[] renFailChkGrp  = null;
		final String rfcPrevCreatDate = Utils.getParameter(request, "rfcprevDate");
		final String rfcPrevCreat     = Utils.getParameter(request, "rfcprevCreat");
		final String rfcDate          = Utils.getParameter(request, "rfcDate");
		final String rfcCreat         = Utils.getParameter(request, "rfcCreat");
		final String rfcMaxGfr        = Utils.getParameter(request, "rfcMaxGfr");
		final String rfcMaxGfrDate    = Utils.getParameter(request, "rfcMaxGfrDate");
		final String rfcMinGfr        = Utils.getParameter(request, "rfcMinGfr");
		final String rfcMinGfrDate    = Utils.getParameter(request, "rfcMinGfrDate");
		
		renFailChkGrp =  request.getParameterValues("ckdChkGrp");
		/*rfcDate = request.getParameter("rfcDate");
		rfcCreat = request.getParameter("rfcCreat");
		rfcPrevCreatDate = request.getParameter("rfcprevDate");
		rfcPrevCreat = request.getParameter("rfcprevCreat");
		rfcMaxGfr = request.getParameter("rfcMaxGfr");
		rfcMaxGfrDate = request.getParameter("rfcMaxGfrDate");
		rfcMinGfr = request.getParameter("rfcMinGfr");
		rfcMinGfrDate = request.getParameter("rfcMinGfrDate");*/
		
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

			if(renFailChkGrp == null){
				XMLGenerator xg=new XMLGenerator();
				
				overallReturn=xg.generateXMLString(doc);

			}
			else{
				
				//rootElement.appendChild(subCat);
				for (int j = 0; j < renFailChkGrp.length; j++){
					Element subCat = doc.createElement("subcategory");
					rootElement.appendChild(subCat);
					
					if(renFailChkGrp[j].equalsIgnoreCase("Chronic Kidney Disease :NOS")) {
					
		
							
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Chronic Kidney Disease :NOS"));
						subCat.appendChild(subname);
						
						Element rfcCreat1 = doc.createElement("rfcCreat");
						rfcCreat1.appendChild(doc.createTextNode(rfcCreat));
						subCat.appendChild(rfcCreat1);
						Element rfcDate1 = doc.createElement("rfcDate");
						rfcDate1.appendChild(doc.createTextNode(rfcDate.toString()));
						subCat.appendChild(rfcDate1);
						
						
						Element rfcMaxGfr1 = doc.createElement("rfcMaxGfr");
						rfcMaxGfr1.appendChild(doc.createTextNode(rfcMaxGfr));
						subCat.appendChild(rfcMaxGfr1);
						Element rfcMaxGfrDate1 = doc.createElement("rfcMaxGfrDate");
						rfcMaxGfrDate1.appendChild(doc.createTextNode(rfcMaxGfrDate.toString()));
						subCat.appendChild(rfcMaxGfrDate1);
						
							
							
						
							
							Element rfcMinGfr1 = doc.createElement("rfcMinGfr");
							rfcMinGfr1.appendChild(doc.createTextNode(rfcMinGfr));
							subCat.appendChild(rfcMinGfr1);
						
							
							
						
							
							Element rfcMinGfrDate1 = doc.createElement("rfcMinGfrDate");
							rfcMinGfrDate1.appendChild(doc.createTextNode(rfcMinGfrDate.toString()));
							subCat.appendChild(rfcMinGfrDate1);
						


						
						
						


					}
					if(renFailChkGrp[j].equalsIgnoreCase("Chronic Kidney Disease :Chronic")) {
						
						
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Chronic Kidney Disease :Chronic"));
						subCat.appendChild(subname);
						
						Element rfcCreat1 = doc.createElement("rfcCreat");
						rfcCreat1.appendChild(doc.createTextNode(rfcCreat));
						subCat.appendChild(rfcCreat1);
						Element rfcDate1 = doc.createElement("rfcDate");
						rfcDate1.appendChild(doc.createTextNode(rfcDate.toString()));
						subCat.appendChild(rfcDate1);

						
						Element rfcPrevCreat1 = doc.createElement("rfcPrevCreat");
						rfcPrevCreat1.appendChild(doc.createTextNode(rfcPrevCreat));
						subCat.appendChild(rfcPrevCreat1);
						Element rfcPrevCreatDate1 = doc.createElement("rfcPrevCreatDate");
						rfcPrevCreatDate1.appendChild(doc.createTextNode(rfcDate.toString()));
						subCat.appendChild(rfcPrevCreatDate1);
						
						
						Element rfcMaxGfr1 = doc.createElement("rfcMaxGfr");
						rfcMaxGfr1.appendChild(doc.createTextNode(rfcMaxGfr));
						subCat.appendChild(rfcMaxGfr1);
						Element rfcMaxGfrDate1 = doc.createElement("rfcMaxGfrDate");
						rfcMaxGfrDate1.appendChild(doc.createTextNode(rfcMaxGfrDate.toString()));
						subCat.appendChild(rfcMaxGfrDate1);
						
							
							
						
							
							Element rfcMinGfr1 = doc.createElement("rfcMinGfr");
							rfcMinGfr1.appendChild(doc.createTextNode(rfcMinGfr));
							subCat.appendChild(rfcMinGfr1);
						
							
							
						
							
							Element rfcMinGfrDate1 = doc.createElement("rfcMinGfrDate");
							rfcMinGfrDate1.appendChild(doc.createTextNode(rfcMinGfrDate.toString()));
							subCat.appendChild(rfcMinGfrDate1);
				}
              }
			}
			
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
		    LSSerializer lsSerializer = domImplementation.createLSSerializer();
		    overallReturn= lsSerializer.writeToString(doc);
			
		}
		/* ************************** */ 
		
		
		if(flag==0)
		{
		writer.beginParagraph();
		writer.outLine("     \u2022  " + mainGrp + "  " + getICD9() + "\n",font_);
		writer.endParagraph();
		
		
		if(renFailChkGrp == null){
			writer.beginParagraph();
			writer.outLine("     \u2022  Null values returned for Chronic Kidney Disease \n",errorFont_);
			writer.endParagraph();
		}
		else{
			for (int j = 0; j < renFailChkGrp.length; j++){
				if(renFailChkGrp[j].equals("Chronic Kidney Disease :NOS")){
					writer.beginParagraph();
					writer.outLine(spacesLevelTwo_ + "Not Otherwise Specified" + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Creatinine: " + rfcCreat + " " + rfcDate + "\n",subFont_);
					writer.outLine(spacesLevelThree_ + "Max GFR: " + rfcMaxGfr + " " + rfcMaxGfrDate + "\n",subFont_);
					writer.outLine(spacesLevelThree_ + "Min GFR: " + rfcMinGfr + " " + rfcMinGfrDate + "\n",subFont_);
					writer.endParagraph();			
				}
				if(renFailChkGrp[j].equals("Chronic Kidney Disease :Chronic")){
					writer.beginParagraph();
					writer.outLine(spacesLevelTwo_ + "Chronic" + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Creatinine: " + rfcCreat + " " + rfcDate + "\n", subFont_);
					writer.outLine(spacesLevelThree_ + "Previous Creatinine: " + rfcPrevCreat + " " + rfcPrevCreatDate + "\n", subFont_);
					writer.outLine(spacesLevelThree_ + "Max GFR: " + rfcMaxGfr + " " + rfcMaxGfrDate + "\n", subFont_);
					writer.outLine(spacesLevelThree_ + "Min GFR: " + rfcMinGfr + " " + rfcMinGfrDate + "\n", subFont_);
					writer.endParagraph();
				}
			}
		}
		overallReturn="print";
		}
		return overallReturn;
	}
}
