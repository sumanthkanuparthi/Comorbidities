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

import com.itextpdf.text.Chunk;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import comorb.PrintInterface.ComorbiditiesFunctor;

public class Delirium implements ComorbiditiesFunctor {
	private final Font font_;
	private final Font fontSubHead_;
	private final Font errorFont_;
	
	/*
	 * Constructor to initialize variables
	 */
	Delirium(Font font, Font fontSubHead, Font errorFont)
	{
		font_ = font;
		fontSubHead_ = fontSubHead;
		errorFont_ = errorFont;
	}
	
	/*
	 * This simply returns the name of the class/comorbidity
	 */
	@Override
	public String getName() {
		return "Delirium";
	}
	
	/*
	 * This returns the ICD9  
	 */
	public String getICD9(){
			return (new String("(ICD9 CODE: "+"780.09)"));
	}
	
	public String getICD9Commit(){
		return (new String("780.09"));
}

	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		String overallReturn="print";
		String[] delichkgrp = null;		
		delichkgrp = request.getParameterValues("delichkgrp");
		System.out.println("Checkbox length"+delichkgrp.length);
		
		
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
			icdElement.appendChild(doc.createTextNode(getICD9Commit()));
			rootElement.appendChild(icdElement);

			Element dateElement = doc.createElement("date");
			dateElement.appendChild(doc.createTextNode(Date.substring(0,10)));
			rootElement.appendChild(dateElement);

			Element timeElement = doc.createElement("time");
			timeElement.appendChild(doc.createTextNode(Date.substring(0,10)));
			rootElement.appendChild(timeElement);

			if(delichkgrp == null){
				//writer.outLine("     \u2022  Null values returned for Encephalopathy \n",errorFont_);
				XMLGenerator xg=new XMLGenerator();

				overallReturn=xg.generateXMLString(doc);
			}
			else{
				
				
				for (int j = 0; j < delichkgrp.length; j++){
					Element subCat = doc.createElement("subcategory");
					rootElement.appendChild(subCat);
					System.out.println("Checkbox length"+delichkgrp[j]);
					Element subname = doc.createElement("subname");
					subname.appendChild(doc.createTextNode(delichkgrp[j]));
					subCat.appendChild(subname);
					//writer.currentLineInc();
					//writer.outLine("\n                    \u2022  " + encchkGrp[j] + "\n",fontSubHead_);
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
		
		
		
		
		if(delichkgrp == null){
			writer.outLine("     \u2022  Null values returned for Delirium \n",errorFont_);
		}
		else{
			for (int j = 0; j < delichkgrp.length; j++){				
				writer.currentLineInc();
				writer.outLine("                    \u2022  " + delichkgrp[j] + "\n",fontSubHead_);
			}
		}
		//writer.outLine("\n\n", font_);
		writer.endParagraph();
	}
		
		return overallReturn;
		}

}
