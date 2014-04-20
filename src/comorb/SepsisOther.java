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

public class SepsisOther implements ComorbiditiesFunctor {
	private final String spacesLevelThree_;
	private final Font font_;
	private final Font subFont_;
	private final Font errorFont_;
	private final Font fontSubHead_;
	
	/*
	 * Constructor to initialize variables
	 */
	SepsisOther(Font font, Font subFont, Font errorFont, String spacesLevelThree,Font fontSubHead)
	{
		font_ = font;
		subFont_ = subFont;
		spacesLevelThree_ = spacesLevelThree;
		errorFont_ = errorFont;
		fontSubHead_=fontSubHead;
	}
	
	/*
	 * This simply returns the name of the class/comorbidity
	 */
	@Override
	public String getName() {
		return "SepsisOther";
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		
		String overallReturn="print";
		writer.beginParagraph();			
		writer.outLine("     \u2022  " + "Sepsis for reasons listed below" + "\n",font_);
		
		String SepsisOtherComments = null;
		SepsisOtherComments = request.getParameter("sepsisOtherComments");
		
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

			if(SepsisOtherComments == null){
				//writer.outLine("     \u2022  Null values returned for Encephalopathy \n",errorFont_);
				XMLGenerator xg=new XMLGenerator();

				overallReturn=xg.generateXMLString(doc);
			}
			else{
				Element subCat = doc.createElement("subcategory");
				rootElement.appendChild(subCat);
				
					
					Element subname = doc.createElement("subname");
					subname.appendChild(doc.createTextNode(SepsisOtherComments));
					//writer.currentLineInc();
					//writer.outLine("\n                    \u2022  " + encchkGrp[j] + "\n",fontSubHead_);
				
			}
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
			LSSerializer lsSerializer = domImplementation.createLSSerializer();
			overallReturn= lsSerializer.writeToString(doc);	
			
			
		}
		if(flag==0){
		if(SepsisOtherComments == null){
			writer.outLine("     \u2022  Null values returned for Other Comments of Sepsis \n",errorFont_);
		}
		else{
			writer.outLine("                               Reasons: " + SepsisOtherComments + "\n" ,fontSubHead_);
			writer.currentLineInc();
			writer.currentLineInc();
		}
		writer.endParagraph();
		}
	return overallReturn;
	}

}
