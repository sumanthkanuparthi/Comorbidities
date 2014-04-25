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

public class Malnutrition implements ComorbiditiesFunctor {
	
	private final String spacesLevelThree_;
	private final Font font_;
	private final Font subFont_;
	
	/*
	 * Constructor to initialize variables
	 */
	Malnutrition(Font font, Font subFont, String spacesLevelThree)
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
		return "Malnutrition";
	}
	
	public String getICD9(){
		return (new String("(ICD9 CODE: "+"263.9)"));
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		
		
		String overallReturn="";
		String temp="print";
		
		final String malHeightDate = Utils.getParameter(request , "malHeightDate");
		final String malWeightDate = Utils.getParameter(request , "malWeightDate");
		final String malHeight     = Utils.getParameter(request , "malHeight");
		final String malWeight     = Utils.getParameter(request , "malWeight");
		final String malBmi        = Utils.getParameter(request , "malBmi");
		
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
			
			
			
			Element malHeightDate1 = doc.createElement("malHeightDate");
			malHeightDate1.appendChild(doc.createTextNode(malHeightDate));
			rootElement.appendChild(malHeightDate1);
			
			Element malWeightDate1 = doc.createElement("malWeightDate");
			malWeightDate1.appendChild(doc.createTextNode(malWeightDate));
			rootElement.appendChild(malWeightDate1);
			
			
			Element malHeight1 = doc.createElement("malHeight");
			malHeight1.appendChild(doc.createTextNode(malHeight));
			rootElement.appendChild(malHeight1);
			
			Element malWeight1 = doc.createElement("malWeight");
			malWeight1.appendChild(doc.createTextNode(malWeight));
			rootElement.appendChild(malWeight1);
			
			Element malBmi1 = doc.createElement("malBmi");
			malBmi1.appendChild(doc.createTextNode(malBmi));
			rootElement.appendChild(malBmi1);
			
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
		    LSSerializer lsSerializer = domImplementation.createLSSerializer();
		    overallReturn= lsSerializer.writeToString(doc); 
			//XMLGenerator xg=new XMLGenerator();
			
		}
		if(flag==0)
		{
		String mainGrp = getName();
	

		
		
		/*
		String malHeightDate = null;
		String malHeight     = null;
		String malWeight     = null;
		String malBmi        = null; 
		String malWeightDate = null;
		
		malHeightDate = request.getParameter("malHeightDate");
		malWeightDate = request.getParameter("malWeightDate");
		malHeight     = request.getParameter("malHeight");
		malWeight     = request.getParameter("malWeight");
		malBmi        = request.getParameter("malBmi");
		*/
		
		writer.beginParagraph();
		writer.outLine("     \u2022  " + mainGrp + "  " + getICD9() + "\n",font_);
		writer.outLine(spacesLevelThree_ + "Height: " + malHeight + " " + malHeightDate + "\n",subFont_);
		writer.outLine(spacesLevelThree_ + "Weight: " + malWeight + " " + malWeightDate + "\n",subFont_);
		writer.outLine(spacesLevelThree_ + "BMI:    " + malBmi  + "\n",subFont_);
		writer.endParagraph();
		overallReturn="print";
		
	}
		return overallReturn;
	}
	
	
	
	

}
