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

public class Obesity implements ComorbiditiesFunctor {
	
	private final String spacesLevelThree_;
	private final Font font_;
	private final Font subFont_;
	
	/*
	 * Constructor to initialize variables
	 */
	Obesity(Font font, Font subFont, String spacesLevelThree)
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
		return "Obesity";
	}
	
	public String getICD9(){
		return (new String("(ICD9 CODE: "+"278.00)"));
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		
		//String temp="print";
		String overallReturn="";
		String mainGrp = getName();
		//final String maxsepHr      = Utils.getParameter(request,"maxsepHr");
		final String obHeightDate = Utils.getParameter(request,"obHeightDate");
		final String obHeight     = Utils.getParameter(request,"obHeight");
		final String obWeight     = Utils.getParameter(request,"obWeight");
		final String obBmi        = Utils.getParameter(request,"obBmi");
		final String obWeightDate = Utils.getParameter(request,"obWeightDate");
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
			
			
			
			Element obHeightDateElement = doc.createElement("obheightdate");
			obHeightDateElement.appendChild(doc.createTextNode(obHeightDate));
			rootElement.appendChild(obHeightDateElement);
			
			Element obHeightElement = doc.createElement("obheight");
			obHeightElement.appendChild(doc.createTextNode(obHeight));
			rootElement.appendChild(obHeightElement);
			
			Element obWeightElement = doc.createElement("obweight");
			obWeightElement.appendChild(doc.createTextNode(obWeight));
			rootElement.appendChild(obWeightElement);
			
			Element obBmiElement = doc.createElement("obbmi");
			obBmiElement.appendChild(doc.createTextNode(obBmi));
			rootElement.appendChild(obBmiElement);
			
			Element obWeightDateElement = doc.createElement("obweightdate");
			obWeightDateElement.appendChild(doc.createTextNode(obWeightDate));
			rootElement.appendChild(obWeightDateElement);

			
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
		    LSSerializer lsSerializer = domImplementation.createLSSerializer();
		    overallReturn= lsSerializer.writeToString(doc); 
			//XMLGenerator xg=new XMLGenerator();
			
		}//overallReturn=xg.generateXMLString(doc);
		if(flag==0)
		{
		
		
		/* 
		 String obHeightDate = null;
		String obHeight     = null;
		String obWeight     = null;
		String obBmi        = null;
		String obWeightDate = null;
		
		obHeightDate = request.getParameter("obHeightDate");
		obHeight     = request.getParameter("obHeight");
		obWeight     = request.getParameter("obWeight");
		obBmi        = request.getParameter("obBmi");
		obWeightDate = request.getParameter("obWeightDate");
		
		*/
		writer.beginParagraph();
		writer.outLine("     \u2022  " + mainGrp + "  " + getICD9() + "\n",font_);
		writer.outLine(spacesLevelThree_ + "Height: " + obHeight + " " + obHeightDate + "\n",subFont_);
		writer.outLine(spacesLevelThree_ + "Weight: " + obWeight + " " + obWeightDate + "\n",subFont_);
		writer.outLine(spacesLevelThree_ + "BMI:    " + obBmi  + "\n",subFont_);		
		writer.endParagraph();
	overallReturn="print";	
	}
		
		return overallReturn;
	}
}
