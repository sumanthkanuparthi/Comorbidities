package comorb;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSSerializer;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import comorb.PrintInterface.ComorbiditiesFunctor;

public class Uti implements ComorbiditiesFunctor {

	private final String spacesLevelThree_;
	private final String spacesLevelTwo_;
	private final Font font_;
	private final Font fontSubHead_;
	private final Font subFont_;
	private final Font errorFont_;

	/*
	 * Constructor to initialize variables
	 */
	Uti(Font font, Font fontSubHead, Font subFont, Font errorFont, String spacesLevelThree, String spacesLevelTwo)
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
		return "Uti";
	}

	public String getICD9(){
		return (new String("(ICD9 CODE: "+"5990)"));
	}
	public String getICD9Commit(){
		return (new String("5990"));
	}

	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		String[] utichckgrp = null;
		String overallReturn="";
		final String utiDate      = Utils.getParameter(request, "utiDate");
		final String utiWbc       = Utils.getParameter(request, "utiWbc");
		final String utiUle       = Utils.getParameter(request, "utiUle");
		final String utiUln       = Utils.getParameter(request, "utiUln");
		final String utiUlndate   = Utils.getParameter(request, "utiUlndate");
		final String utiUledate   = Utils.getParameter(request, "utiUledate");

		utichckgrp = request.getParameterValues("catheterAssoc");

		/* ********************** new code  */
		if(flag==1){
			System.out.println("System check flow -------->>>>>>>>>> entering writeToDoc "+utichckgrp.length);
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

			/*if(utichckgrp == null){
				DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
			    LSSerializer lsSerializer = domImplementation.createLSSerializer();
			    overallReturn= lsSerializer.writeToString(doc);	
				
			}
			else{*/
				
				for (int j = 0; j < utichckgrp.length; j++){
					Element subCat = doc.createElement("subcategory");
					rootElement.appendChild(subCat);
					if(utichckgrp[j].equals("Catherter Associated")){
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Catherter Associated"));
						subCat.appendChild(subname);
						
					
						

					
					
				if(utiWbc.isEmpty()!=true){

					Element utiwbcElement = doc.createElement("utiwbc");
					utiwbcElement.appendChild(doc.createTextNode(utiWbc));
					subCat.appendChild(utiwbcElement);
					
					Element utidateElement = doc.createElement("utidate");
					utidateElement.appendChild(doc.createTextNode(utiDate.toString()));
					subCat.appendChild(utidateElement);
					
				}
				if(utiUle.isEmpty()!=true){
					//writer.outLine(spacesLevelThree_ + "Urinalysis, Leukocyte Esterase: " + utiUle + " " + utiUledate + "\n",subFont_);
					Element utiuleElement = doc.createElement("utiule");
					utiuleElement.appendChild(doc.createTextNode(utiUle));
					subCat.appendChild(utiuleElement);
					Element utiuledate = doc.createElement("utiuledate");
					utiuledate.appendChild(doc.createTextNode(utiUledate.toString()));
					subCat.appendChild(utiuledate);
					
				}
				if(utiUln.isEmpty()!=true){
					//writer.outLine(spacesLevelThree_ + "Urinalysis,  Nitrite:           " + utiUln + " " + utiUlndate +"\n",subFont_);
					Element utiuln = doc.createElement("utiuln");
					utiuln.appendChild(doc.createTextNode(utiUln));
					subCat.appendChild(utiuln);
					Element utiulndate = doc.createElement("utiulndate");
					utiulndate.appendChild(doc.createTextNode(utiUlndate.toString()));
					subCat.appendChild(utiulndate);
					
				}
				}
				}
				
			
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
		    LSSerializer lsSerializer = domImplementation.createLSSerializer();
		    overallReturn= lsSerializer.writeToString(doc); 
			/*File f=new File("C:\\Users\\iramakris\\Documents\\cc.txt");
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer;
			try {
				transformer = transformerFactory.newTransformer();
				DOMSource source = new DOMSource(doc);
				
				StreamResult result = new StreamResult(f);
				transformer.transform(source, result);
			} catch (TransformerException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			BufferedReader reader;
			String line="";
			String resultString="";
			try {
				 reader = new BufferedReader(new FileReader(f));
					while ((line = reader.readLine()) != null) {
						
							resultString=resultString+line;
						}
					 
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
			
			//XMLGenerator xg=new XMLGenerator();
			//totalReturn=xg.generateXMLString(doc);
			System.out.println("total return kya hai ?? "+resultString); */
			//totalReturn=resultString;	
		}

		/* *********************************/

		if(flag==0)
		{
			String mainGrp = getName();
			writer.beginParagraph();
			writer.outLine("     \u2022  " + mainGrp + "  " + getICD9() + "\n",font_);



			/* utiDate    = request.getParameter("utiDate");
		utiWbc     = request.getParameter("utiWbc");
		utiUle     = request.getParameter("utiUle");
		utiUledate = request.getParameter("utiUledate");
		utiUln     = request.getParameter("utiUln");
		utiUlndate = request.getParameter("utiUlndate");
			 */
			if(utichckgrp == null){
				writer.outLine("     \u2022  Null values returned for UTI \n",errorFont_);
			}
			else{
				if(utiWbc.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "WBC count:                      " + utiWbc + " " + utiDate + "\n",subFont_);
				}
				if(utiUle.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "Urinalysis, Leukocyte Esterase: " + utiUle + " " + utiUledate + "\n",subFont_);
				}
				if(utiUln.isEmpty()!=true){
					writer.outLine(spacesLevelThree_ + "Urinalysis,  Nitrite:           " + utiUln + " " + utiUlndate +"\n",subFont_);
				}
				for (int j = 0; j < utichckgrp.length; j++){
					if(utichckgrp[j].equals("Catherter Associated")){
						writer.outLine(spacesLevelTwo_ + "Catherter Associated" + "\n",fontSubHead_);
					}
				}
			}
			writer.endParagraph();
			overallReturn="print";
		}
		return overallReturn;	
	}

}
