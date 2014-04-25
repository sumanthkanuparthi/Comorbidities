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

public class Anemia implements ComorbiditiesFunctor{

	private final String spacesLevelThree_;
	private final String spacesLevelTwo_;
	private final Font font_;
	private final Font fontSubHead_;
	private final Font subFont_;
	private final Font errorFont_;

	/*
	 * Constructor to initialize variables
	 */
	Anemia(Font font, Font fontSubHead, Font subFont, Font errorFont, String spacesLevelThree, String spacesLevelTwo)
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
		return "Anemia";
	}

	/*
	 * This returns the ICD9  
	 */
	public String getICD9(String n){
		if(n.equalsIgnoreCase("Acute blood loss"))
			return (new String("(ICD9 CODE: "+"285.1)"));
		else if(n.equalsIgnoreCase("Anemia: Chronic Disease"))
			return (new String("(ICD9 CODE: "+"280.0)"));
		else if(n.equalsIgnoreCase("Anemia: NOS"))
			return (new String("(ICD9 CODE: "+"285.9)"));
		else
			return (new String(" "));
	}

	public String getICD9Commit(String n){
		if(n.equalsIgnoreCase("Acute blood loss"))
			return (new String("285.1"));
		else if(n.equalsIgnoreCase("Anemia: Chronic Disease"))
			return (new String("280.0"));
		else if(n.equalsIgnoreCase("Anemia: NOS"))
			return (new String("285.9"));
		else
			return (new String(" "));
	}

	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		String overallReturn="";
		String mainGrp = getName();
		String temp="";
		String[] anemiaChkGrp = null;
		final String chHgloDate     = Utils.getParameter(request, "AnHgloDate");
		final String chHglo         = Utils.getParameter(request, "AnHglo");
		final String preChHglo      = Utils.getParameter(request, "preAnHglo"); 
		final String chHcrit        = Utils.getParameter(request, "AnHcrit");
		final String preChHcrit     = Utils.getParameter(request, "preAnHcrit");
		final String chHcritDate    = Utils.getParameter(request, "AnHcritDate"); 
		final String preChHgloDate  = Utils.getParameter(request, "preAnHgloDate");
		final String preChHcritDate = Utils.getParameter(request, "preAnHcritDate");
		final String norHBLow       = Utils.getParameter(request, "normalHBLow");
		final String norHCLow       = Utils.getParameter(request, "normalHCLow");
		final String result         = Utils.getParameter(request, "result");

		anemiaChkGrp   = request.getParameterValues("anemiaChkGrp");

		// for flag =1 when commit to cerner is selected 
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

			if(anemiaChkGrp == null){
				XMLGenerator xg=new XMLGenerator();

				overallReturn=xg.generateXMLString(doc);

			}
			else{
				//Element subCat = doc.createElement("subcategory");
				//rootElement.appendChild(subCat);
				//rootElement.appendChild(subCat);
				for (int j = 0; j < anemiaChkGrp.length; j++){
					Element subCat = doc.createElement("subcategory");
					rootElement.appendChild(subCat);

					if(anemiaChkGrp[j].equalsIgnoreCase("Acute blood loss")) {

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Acute blood loss"));
						subCat.appendChild(subname);
						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Acute blood loss")));
						subCat.appendChild(icd91);

						if(!chHglo.isEmpty()){
							Element chHgloElement = doc.createElement("chhglo");
							chHgloElement.appendChild(doc.createTextNode(chHglo));
							subCat.appendChild(chHgloElement);
							Element chHgloDateElement = doc.createElement("chhglodate");
							chHgloDateElement.appendChild(doc.createTextNode(chHgloDate));
							subCat.appendChild(chHgloDateElement);


						}
						//writer.outLine(spacesLevelThree_ + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n",subFont_);

						if(preChHglo.isEmpty() != true){
							Element preChHgloElement = doc.createElement("prechhglo");
							preChHgloElement.appendChild(doc.createTextNode(preChHglo));
							subCat.appendChild(preChHgloElement);
							Element preChHgloDateElement = doc.createElement("prechhglodate");

							//preChHgloDateElement.appendChild(doc.createTextNode(chHgloDate));

							preChHgloDateElement.appendChild(doc.createTextNode(preChHgloDate));

							subCat.appendChild(preChHgloDateElement);

						}
						//writer.outLine(spacesLevelThree_ + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n",subFont_);

						if(chHcrit.isEmpty() != true){
							Element chHcritElement = doc.createElement("chhcrit");
							chHcritElement.appendChild(doc.createTextNode(chHcrit));
							subCat.appendChild(chHcritElement);
							Element chHcritDateElement = doc.createElement("chhcritdate");

//							chHcritDateElement.appendChild(doc.createTextNode(chHgloDate));

							chHcritDateElement.appendChild(doc.createTextNode(chHcritDate));

							subCat.appendChild(chHcritDateElement);

						}
						//writer.outLine(spacesLevelThree_ + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n",subFont_);

						if(preChHcrit.isEmpty() != true){
							Element preChHcritElement = doc.createElement("prechhcrit");
							preChHcritElement.appendChild(doc.createTextNode(preChHcrit));
							subCat.appendChild(preChHcritElement);
							Element preChHcritDateElement = doc.createElement("prechhcritdate");
							preChHcritDateElement.appendChild(doc.createTextNode(preChHcritDate));
							subCat.appendChild(preChHcritDateElement);

						}
						//	writer.outLine(spacesLevelThree_ + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n",subFont_);


					}
					else if(anemiaChkGrp[j].equalsIgnoreCase("Anemia: Chronic Disease")) {


						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Anemia: Chronic Disease"));
						subCat.appendChild(subname);
						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Anemia: Chronic Disease")));
						subCat.appendChild(icd91);

						if(!chHglo.isEmpty()){
							Element chHgloElement = doc.createElement("chhglo");
							chHgloElement.appendChild(doc.createTextNode(chHglo));
							subCat.appendChild(chHgloElement);
							Element chHgloDateElement = doc.createElement("chhglodate");
							chHgloDateElement.appendChild(doc.createTextNode(chHgloDate));
							subCat.appendChild(chHgloDateElement);


						}
						//writer.outLine(spacesLevelThree_ + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n",subFont_);

						if(preChHglo.isEmpty() != true){
							Element preChHgloElement = doc.createElement("prechhglo");
							preChHgloElement.appendChild(doc.createTextNode(preChHglo));
							subCat.appendChild(preChHgloElement);
							Element preChHgloDateElement = doc.createElement("prechhglodate");

						//	preChHgloDateElement.appendChild(doc.createTextNode(chHgloDate));

							preChHgloDateElement.appendChild(doc.createTextNode(preChHgloDate));

							subCat.appendChild(preChHgloDateElement);

						}
						//writer.outLine(spacesLevelThree_ + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n",subFont_);

						if(chHcrit.isEmpty() != true){
							Element chHcritElement = doc.createElement("chhcrit");
							chHcritElement.appendChild(doc.createTextNode(chHcrit));
							subCat.appendChild(chHcritElement);
							Element chHcritDateElement = doc.createElement("chhcritdate");

//							chHcritDateElement.appendChild(doc.createTextNode(chHgloDate));

							chHcritDateElement.appendChild(doc.createTextNode(chHcritDate));

							subCat.appendChild(chHcritDateElement);

						}
						//writer.outLine(spacesLevelThree_ + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n",subFont_);

						if(preChHcrit.isEmpty() != true){
							Element preChHcritElement = doc.createElement("prechhcrit");
							preChHcritElement.appendChild(doc.createTextNode(preChHcrit));
							subCat.appendChild(preChHcritElement);
							Element preChHcritDateElement = doc.createElement("prechhcritdate");
							preChHcritDateElement.appendChild(doc.createTextNode(preChHcritDate));
							subCat.appendChild(preChHcritDateElement);

						}



					}
					else if(anemiaChkGrp[j].equalsIgnoreCase("Anemia: NOS")){

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Anemia: NOS"));
						subCat.appendChild(subname);

						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Anemia: Chronic Disease")));
						subCat.appendChild(icd91);
						if(!chHglo.isEmpty()){
							Element chHgloElement = doc.createElement("chhglo");
							chHgloElement.appendChild(doc.createTextNode(chHglo));
							subCat.appendChild(chHgloElement);
							Element chHgloDateElement = doc.createElement("chhglodate");
							chHgloDateElement.appendChild(doc.createTextNode(chHgloDate));
							subCat.appendChild(chHgloDateElement);


						}
						if(chHcrit.isEmpty() != true){
							Element chHcritElement = doc.createElement("chhcrit");
							chHcritElement.appendChild(doc.createTextNode(chHcrit));
							subCat.appendChild(chHcritElement);
							Element chHcritDateElement = doc.createElement("chhcritdate");

	//						chHcritDateElement.appendChild(doc.createTextNode(chHgloDate));

							chHcritDateElement.appendChild(doc.createTextNode(chHcritDate));

							subCat.appendChild(chHcritDateElement);

						}

					}



				}
			}
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
			LSSerializer lsSerializer = domImplementation.createLSSerializer();
			overallReturn= lsSerializer.writeToString(doc);

		}



		/// code ends






		if(flag==0)
		{
			writer.beginParagraph();									
			writer.outLine("     \u2022  " + mainGrp + "\n",font_);																	
			writer.endParagraph();



			/*chHgloDate     = request.getParameter("AnHgloDate");
		chHglo         = request.getParameter("AnHglo");
		preChHgloDate  = request.getParameter("preAnHgloDate");
		preChHglo      = request.getParameter("preAnHglo");
		chHcritDate    = request.getParameter("AnHcritDate");
		chHcrit        = request.getParameter("AnHcrit");
		preChHcritDate = request.getParameter("preAnHcritDate");
		preChHcrit     = request.getParameter("preAnHcrit");		
		norHCLow       = request.getParameter("normalHCLow");
		norHBLow       = request.getParameter("normalHBLow");		
		result         = request.getParameter("result");*/

			if(anemiaChkGrp == null){

				writer.beginParagraph();
				writer.outLine("     \u2022  Null values returned for Anemia \n",errorFont_);
				writer.endParagraph();
				temp="print";

			}
			else{

				for (int j = 0; j < anemiaChkGrp.length; j++){

					if(anemiaChkGrp[j].equals("Acute blood loss")){	


						temp="print";
						writer.beginParagraph();
						writer.outLine(spacesLevelTwo_ + "Acute" + "  " + getICD9("Acute blood loss") + "\n", fontSubHead_);

						if(!chHglo.isEmpty())
							writer.outLine(spacesLevelThree_ + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n",subFont_);

						if(preChHglo.isEmpty() != true)
							writer.outLine(spacesLevelThree_ + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n",subFont_);

						if(chHcrit.isEmpty() != true)
							writer.outLine(spacesLevelThree_ + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n",subFont_);

						if(preChHcrit.isEmpty() != true)
							writer.outLine(spacesLevelThree_ + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n",subFont_);

						writer.endParagraph();
					}




					else if(anemiaChkGrp[j].equals("Anemia: Chronic Disease")){


						writer.beginParagraph();
						writer.outLine(spacesLevelTwo_ + "Chronic" + "  " + getICD9("Anemia: Chronic Disease") +"\n",fontSubHead_);

						if(chHglo.isEmpty() != true)
							writer.outLine(spacesLevelThree_ + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n",subFont_);

						if(preChHglo.isEmpty() != true)
							writer.outLine(spacesLevelThree_ + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n\n",subFont_);

						if(chHcrit.isEmpty() != true)
							writer.outLine(spacesLevelThree_ + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n",subFont_);

						if(preChHcrit.isEmpty() != true /*&& (Double.parseDouble(preChHcrit) < Double.parseDouble(norHCLow))*/)
							writer.outLine(spacesLevelThree_ + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n",subFont_);

						writer.endParagraph();
					}



					else if(anemiaChkGrp[j].equals("Anemia: NOS")){


						writer.beginParagraph();
						writer.outLine(spacesLevelTwo_ + "Not otherwise specified" + "  " + getICD9("Anemia: NOS") + "\n",fontSubHead_);

						if(chHglo.isEmpty() != true)
							writer.outLine(spacesLevelThree_ + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n",subFont_);

						if(chHcrit.isEmpty() != true)
							writer.outLine(spacesLevelThree_ + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n",subFont_);

						writer.endParagraph();
					}

					else if(anemiaChkGrp[j].equals("Anemia: Blood Loss")){


						writer.beginParagraph();
						writer.outLine(spacesLevelTwo_ + "Due to Blood Loss" + "\n",fontSubHead_);
						writer.endParagraph();
					}
				}
			}

			overallReturn="";	
		}
		return overallReturn;
	}
}
