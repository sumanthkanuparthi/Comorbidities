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

public class Hypertension implements ComorbiditiesFunctor {
	
	private final String spacesLevelThree_;
	private final Font font_;
	private final Font subFont_;
	private final Font errorFont_;
		
	/*
	 * Constructor to initialize variables
	 */
	Hypertension(Font font, Font subFont, Font errorFont, String spacesLevelThree)
	{
		font_ = font;
		subFont_ = subFont;
		spacesLevelThree_ = spacesLevelThree;
		errorFont_ = errorFont;
	}
	
	/*
	 * This simply returns the name of the class/comorbidity
	 */
	@Override
	public String getName() {
		return "Hypertension";
	}
	
	public String getICD9(){
		return (new String("(ICD9 CODE: "+"401.9)"));
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		
		String temp="print";
		String overallReturn="";
		String mainGrp = getName();
		
		String[] hyperChkGrp = null;
		final String htnDate       = Utils.getParameter(request, "htnDate");
		final String htnDatesys    = Utils.getParameter(request, "htnDateSys");
		final String htnBpDia      = Utils.getParameter(request, "htnBpDia");
		final String htnBpSys      = Utils.getParameter(request, "htnBpSys");
		
		hyperChkGrp = request.getParameterValues("htChkGrp");
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
			icdElement.appendChild(doc.createTextNode(getICD9()));
			rootElement.appendChild(icdElement);

			Element dateElement = doc.createElement("date");
			dateElement.appendChild(doc.createTextNode(Date.substring(0,10)));
			rootElement.appendChild(dateElement);

			Element timeElement = doc.createElement("time");
			timeElement.appendChild(doc.createTextNode(Date.substring(0,10)));
			rootElement.appendChild(timeElement);

			if(hyperChkGrp == null){
				XMLGenerator xg=new XMLGenerator();
				
				overallReturn=xg.generateXMLString(doc);

			}
			else{
				
				//rootElement.appendChild(subCat);
				for (int j = 0; j < hyperChkGrp.length; j++){
					Element subCat = doc.createElement("subcategory");
					rootElement.appendChild(subCat);
					
					if(hyperChkGrp[j].equalsIgnoreCase("Hypertension: Elevated BP")) {
						
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Hypertension: Elevated BP"));
						subCat.appendChild(subname);
						
						
						Element htnDateElement = doc.createElement("htndate");
						htnDateElement.appendChild(doc.createTextNode(htnDate));
						subCat.appendChild(htnDateElement);
						
						
						Element htnDateSysElement = doc.createElement("htndatesys");
						htnDateSysElement.appendChild(doc.createTextNode(htnDatesys));
						subCat.appendChild(htnDateSysElement);
						Element htnBpDiaElement = doc.createElement("htnbpdia");
						htnBpDiaElement.appendChild(doc.createTextNode(htnBpDia));
						subCat.appendChild(htnBpDiaElement);
							
							Element htnBpSysElement = doc.createElement("htnbpsys");
							htnBpSysElement.appendChild(doc.createTextNode(htnBpSys));
							subCat.appendChild(htnBpSysElement);
					
					}
						
						
					if(hyperChkGrp[j].equalsIgnoreCase("Hypertension: Hypertension")) {
						
						
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Hypertension: Hypertension"));
						subCat.appendChild(subname);
						
						Element htnDateElement = doc.createElement("htndate");
						htnDateElement.appendChild(doc.createTextNode(htnDate));
						subCat.appendChild(htnDateElement);
						
						
						Element htnDateSysElement = doc.createElement("htndatesys");
						htnDateSysElement.appendChild(doc.createTextNode(htnDatesys));
						subCat.appendChild(htnDateSysElement);
						Element htnBpDiaElement = doc.createElement("htnbpdia");
						htnBpDiaElement.appendChild(doc.createTextNode(htnBpDia));
						subCat.appendChild(htnBpDiaElement);
							
							Element htnBpSysElement = doc.createElement("htnbpsys");
							htnBpSysElement.appendChild(doc.createTextNode(htnBpSys));
							subCat.appendChild(htnBpSysElement);
					
					}
				}	
						
			

			}
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
		    LSSerializer lsSerializer = domImplementation.createLSSerializer();
		    overallReturn= lsSerializer.writeToString(doc);
			
		}
		if(flag==0)
		{
		
		/*htnDate     = request.getParameter("htnDate");
		htnDatesys  = request.getParameter("htnDateSys");
		htnBpDia    = request.getParameter("htnBpDia");
		htnBpSys    = request.getParameter("htnBpSys");*/
		
		if(hyperChkGrp == null){
			writer.beginParagraph();
			writer.outLine("     \u2022  " + mainGrp + "  " + getICD9() +  "\n",font_);
			writer.outLine("     \u2022  Null values returned for Hypertension \n",errorFont_);
			writer.endParagraph();
		}
		else{
			
			for (int j = 0; j < hyperChkGrp.length; j++){

				if(hyperChkGrp[j].equals("Hypertension: Elevated BP")){
					
					writer.beginParagraph();
					
					writer.outLine("     \u2022  " + "Elevated Blood Pressure" + "\n", font_);
					writer.outLine(spacesLevelThree_ + "Blood Pressure(systolic):  " + htnBpSys + " " + htnDatesys + "\n",subFont_);
					writer.outLine(spacesLevelThree_ + "Blood Pressure(diastolic): " + htnBpDia + " " + htnDate + "\n",subFont_);
					
					writer.endParagraph();
					
				}
				if(hyperChkGrp[j].equals("Hypertension: Hypertension")){
					
					
					writer.beginParagraph();

					writer.outLine("     \u2022  " + "Hypertension" + "\n", font_);
					writer.outLine(spacesLevelThree_ + "Blood Pressure(systolic):  " + htnBpSys + " " + htnDatesys + "\n",subFont_);
					writer.outLine(spacesLevelThree_ + "Blood Pressure(diastolic): " + htnBpDia + " " + htnDate + "\n",subFont_);

					writer.endParagraph();
					
				}
			}
			
		}
		overallReturn="print";
	}
		
		return overallReturn;
	}
}
