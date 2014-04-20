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

public class Granulocytopenia implements ComorbiditiesFunctor {
	
	private final String spacesLevelThree_;
	private final Font font_;
	private final Font subFont_;
	
	/*
	 * Constructor to initialize variables
	 */
	Granulocytopenia(Font font, Font subFont, String spacesLevelThree)
	{
		font_ = font;
		subFont_ = subFont;
		spacesLevelThree_ = spacesLevelThree;
	}
	
	/*
	 * This simply returns the name of the class/comorbidity
	 */
	@Override
	public String getName() {
		return "Granulocytopenia";
	}
	
	public String getICD9(){
		return (new String("(ICD9 CODE: "+"288.00)"));
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		String temp="print";
		String overallReturn="";
		final String minneutrophilDate    = Utils.getParameter(request, "neutrophilMinDate");
		final String minneutrophilResult  = Utils.getParameter(request, "neutrophilMinResult");
		
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
			
			
			
			Element hydracreatDateElement = doc.createElement("minneutrophilDate ");
			hydracreatDateElement.appendChild(doc.createTextNode(minneutrophilDate ));
			rootElement.appendChild(hydracreatDateElement);
			
			Element hydracreatinineElement = doc.createElement("minneutrophilResult");
			hydracreatinineElement.appendChild(doc.createTextNode(minneutrophilResult));
			rootElement.appendChild(hydracreatinineElement);
			
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
		    LSSerializer lsSerializer = domImplementation.createLSSerializer();
		    overallReturn= lsSerializer.writeToString(doc); 
			//XMLGenerator xg=new XMLGenerator();
			
		}//overallReturn=xg.generateXMLString(doc);
		
		
		if(flag==0)
		{
		
		String mainGrp = getName();
		
		
		/*minneutrophilDate   = request.getParameter("neutrophilMinDate");
		minneutrophilResult = request.getParameter("neutrophilMinResult");*/
			
		writer.beginParagraph();			
		writer.outLine("     \u2022  " + mainGrp + "  " + getICD9() + "\n",font_);
		writer.outLine(spacesLevelThree_ + "Neutrophil (Minimum): " + minneutrophilResult + " " + 
					minneutrophilDate + "\n",subFont_);			
		writer.endParagraph();
		overallReturn="print";
		
	}
		return overallReturn;
	}

}
