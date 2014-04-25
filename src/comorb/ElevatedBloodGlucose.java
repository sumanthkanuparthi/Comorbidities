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

public class ElevatedBloodGlucose implements ComorbiditiesFunctor{

	private final String spacesLevelThree_;
	private final Font font_;
	private final Font subFont_;
	private final Font errorFont_;
	
	/*
	 * Constructor to initialize variables
	 */
	ElevatedBloodGlucose(Font font, Font subFont, Font errorFont, String spacesLevelThree)
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
		return "ElevatedBloodGlucose";
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		
		String overallReturn="print";
		String[] EbgChkGrp = null;
		final String glucDate    = Utils.getParameter(request, "glucDate");
		final String glucResult  = Utils.getParameter(request, "glucResult");
		
		EbgChkGrp  = request.getParameterValues("EbgChkGrp");		
		/*glucDate   = request.getParameter("glucDate");
		glucResult = request.getParameter("glucResult");*/
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

			if(EbgChkGrp == null){
				//writer.outLine("     \u2022  Null values returned for Encephalopathy \n",errorFont_);
				XMLGenerator xg=new XMLGenerator();

				overallReturn=xg.generateXMLString(doc);
			}
			else{
				
				
				for (int j = 0; j < EbgChkGrp.length; j++){	
					Element subCat = doc.createElement("subcategory");
					rootElement.appendChild(subCat);
					Element subname = doc.createElement("subname");
					subname.appendChild(doc.createTextNode(EbgChkGrp[j]));
					Element glucResultElement = doc.createElement("glucresult");
					glucResultElement.appendChild(doc.createTextNode(glucResult));
					subCat.appendChild(glucResultElement);
					Element glucDateElement = doc.createElement("glucdate");
					glucDateElement.appendChild(doc.createTextNode(glucDate));
					subCat.appendChild(glucDateElement);
					//writer.currentLineInc();
					//writer.outLine("\n                    \u2022  " + encchkGrp[j] + "\n",fontSubHead_);
				}
			}
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
			LSSerializer lsSerializer = domImplementation.createLSSerializer();
			overallReturn= lsSerializer.writeToString(doc);	
			
			
		}
		
		if(flag==0){	
		if(EbgChkGrp == null){
			writer.beginParagraph();
			writer.outLine("     \u2022  Null values returned for ElevatedBloodGlucose \n",errorFont_);
			writer.endParagraph();
		}
		else{			
			for (int j = 0; j < EbgChkGrp.length; j++){
			
				writer.beginParagraph();
				writer.outLine("     \u2022  " + EbgChkGrp[j] + "\n",font_);
				writer.outLine(spacesLevelThree_ + "Glucose: " + glucResult + " " + glucDate + "\n" ,subFont_);
				writer.endParagraph();			
			}
		}
		}
		return overallReturn;
	}
	
}
