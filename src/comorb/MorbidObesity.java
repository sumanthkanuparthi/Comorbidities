package comorb;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSSerializer;

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

public class MorbidObesity implements ComorbiditiesFunctor {
	
	private final String spacesLevelThree_;
	private final Font font_;
	private final Font subFont_;
	
	/*
	 * Constructor to initialize variables
	 */
	MorbidObesity(Font font, Font subFont, String spacesLevelThree)
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
		return "Morbid Obesity";
	}
	
	public String getICD9(){
		return (new String("(ICD9 CODE: "+"278.01)"));
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		
		
		String overallReturn="";
		String mainGrp = getName();
		final String mobHeightDate = Utils.getParameter(request,"mobHeightDate");
		final String mobHeight     = Utils.getParameter(request,"mobHeight");
		final String mobWeight     = Utils.getParameter(request,"mobWeight");
		final String mobBmi        = Utils.getParameter(request,"mobBmi");
		final String mobWeightDate = Utils.getParameter(request,"mobWeightDate");
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
			
			
			
			Element mobHeightDateElement = doc.createElement("mobheightdate");
			mobHeightDateElement.appendChild(doc.createTextNode(mobHeightDate));
			rootElement.appendChild(mobHeightDateElement);
			
			Element mobHeightElement = doc.createElement("mobheight");
			mobHeightElement.appendChild(doc.createTextNode(mobHeight));
			rootElement.appendChild(mobHeightElement);
			
			Element mobWeightElement = doc.createElement("mobweight");
			mobWeightElement.appendChild(doc.createTextNode(mobWeight));
			rootElement.appendChild(mobWeightElement);
			
			Element mobBmiElement = doc.createElement("mobbmi");
			mobBmiElement.appendChild(doc.createTextNode(mobBmi));
			rootElement.appendChild(mobBmiElement);
			
			Element mobWeightDateElement = doc.createElement("mobweightdate");
			mobWeightDateElement.appendChild(doc.createTextNode(mobWeightDate));
			rootElement.appendChild(mobWeightDateElement);

			
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
		    LSSerializer lsSerializer = domImplementation.createLSSerializer();
		    overallReturn= lsSerializer.writeToString(doc); 
			//XMLGenerator xg=new XMLGenerator();
			
		}//overallReturn=xg.generateXMLString(doc);
		if(flag==0)
		{
		
		
	
	/*	
		String mobHeightDate = null;
		String mobHeight     = null;
		String mobWeight     = null;
		String mobBmi        = null;
		String mobWeightDate = null;
		
		mobHeightDate = request.getParameter("mobHeightDate");
		mobHeight     = request.getParameter("mobHeight");
		mobWeight     = request.getParameter("mobWeight");
		mobBmi        = request.getParameter("mobBmi");
		mobWeightDate = request.getParameter("mobWeightDate");
		*/
		
		writer.beginParagraph();

		writer.outLine("     \u2022  " + mainGrp + "  " + getICD9() + "\n",font_);
		writer.outLine(spacesLevelThree_ + "Height: " + mobHeight + " " + mobHeightDate + "\n",subFont_);
		writer.outLine(spacesLevelThree_ + "Weight: " + mobWeight + " " + mobWeightDate + "\n",subFont_);
		writer.outLine(spacesLevelThree_ + "BMI:    " + mobBmi  + "\n",subFont_);
								
		writer.endParagraph();
		overallReturn="print";
		}
		
		return overallReturn;
	}

}

