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

public class AcuteKidneyInjury implements ComorbiditiesFunctor {

	private final String spacesLevelThree_;
	private final String spacesLevelTwo_;
	private final Font font_;
	private final Font fontSubHead_;
	private final Font subFont_;
	private final Font errorFont_;


	/*
	 * Constructor to initialize variables
	 */
	AcuteKidneyInjury(Font font, Font fontSubHead, Font subFont, Font errorFont, String spacesLevelThree, String spacesLevelTwo)
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
		return "Acute Kidney Injury";
	}

	/*
	 * This returns the ICD9  
	 */
	public String getICD9(){
		return (new String("(ICD9 CODE: "+"584.9)"));
	}

	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		String overallReturn="";
		String[] renFailChkGrp = null;
		final String CreatDate       = Utils.getParameter(request, "CreatDate");
		final String Creat           = Utils.getParameter(request, "Creat");
		final String PrevCreat       = Utils.getParameter(request, "CreatPrev");
		final String PrevCreatDate   = Utils.getParameter(request, "CreatPrevDate");
		

		renFailChkGrp = request.getParameterValues("akiChkGrp");

		/* ******* new code *******/

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

			if(renFailChkGrp == null){
				XMLGenerator xg=new XMLGenerator();
				
				overallReturn=xg.generateXMLString(doc);

			}
			else{
				//Element subCat = doc.createElement("subcategory");
				//rootElement.appendChild(subCat);
				//rootElement.appendChild(subCat);
				for (int j = 0; j < renFailChkGrp.length; j++){
					Element subCat = doc.createElement("subcategory");
					rootElement.appendChild(subCat);
					
					if(renFailChkGrp[j].equalsIgnoreCase("Acute Kidney Injury :Acute")) {
						
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Acute Kidney Injury :Acute"));
						subCat.appendChild(subname);
						Element creat1 = doc.createElement("creat");
						creat1.appendChild(doc.createTextNode(Creat));
						subCat.appendChild(creat1);
						Element creatDate = doc.createElement("creatdate");
						creatDate.appendChild(doc.createTextNode(CreatDate.toString()));
						subCat.appendChild(creatDate);
						
						if(PrevCreat.equalsIgnoreCase("-99999.0")!=true && PrevCreat.equalsIgnoreCase("99999.0")!=true){
							
							
						
							
							Element prevCreat1 = doc.createElement("prevcreat");
							prevCreat1.appendChild(doc.createTextNode(PrevCreat));
							subCat.appendChild(prevCreat1);
						
							
							
						
							
							Element prevCreatDate1 = doc.createElement("prevcreatdate");
							prevCreatDate1.appendChild(doc.createTextNode(PrevCreatDate.toString()));
							subCat.appendChild(prevCreatDate1);
						


						
						
						}


					}
					else if(renFailChkGrp[j].equalsIgnoreCase("Acute Kidney Injury :NOS")) {
						
						
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Acute Kidney Injury :NOS"));
						subCat.appendChild(subname);
						
						Element creat = doc.createElement("creat");
						creat.appendChild(doc.createTextNode(Creat));
						subCat.appendChild(creat);
						
						
						Element creatDate = doc.createElement("creatdate");
						creatDate.appendChild(doc.createTextNode(CreatDate.toString()));
						subCat.appendChild(creatDate);
						


					}
					else if(renFailChkGrp[j].equalsIgnoreCase("Chronic Kidney Disease :Chronic")){
						
						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Acute Kidney Injury :Chronic"));
						subCat.appendChild(subname);
						if(PrevCreat.equalsIgnoreCase("-99999.0")!=true && PrevCreat.equalsIgnoreCase("99999.0")!=true){
						
							Element creat = doc.createElement("creat");
							creat.appendChild(doc.createTextNode(Creat));
							subCat.appendChild(creat);
							
						
							Element prevCreat = doc.createElement("prevcreat");
							prevCreat.appendChild(doc.createTextNode(PrevCreat.toString()));
							subCat.appendChild(prevCreat);
							
						
							Element creatDate = doc.createElement("creatdate");
							creatDate.appendChild(doc.createTextNode(CreatDate.toString()));
							subCat.appendChild(creatDate);
						
						
							Element prevCreatDate = doc.createElement("prevcreatdate");
							prevCreatDate.appendChild(doc.createTextNode(PrevCreatDate.toString()));
							subCat.appendChild(prevCreatDate);
							


						}
						else{
							if(Creat!=null){
							Element creat = doc.createElement("creat");
							creat.appendChild(doc.createTextNode(Creat));
							subCat.appendChild(creat);
							}
							if(CreatDate.toString()!=null){
							Element creatDate = doc.createElement("creatdate");
							creatDate.appendChild(doc.createTextNode(CreatDate.toString()));
							subCat.appendChild(creatDate);
							}
						}



					}
				}

			}
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
		    LSSerializer lsSerializer = domImplementation.createLSSerializer();
		    overallReturn= lsSerializer.writeToString(doc);
			
		}
		/* ************************** */ 
		if(flag==0)
		{
			String mainGrp = getName();
			writer.beginParagraph();
			writer.outLine("     \u2022  " + mainGrp + "  " +  getICD9() + "\n",font_);
			writer.endParagraph();


			/*String[] renFailChkGrp = null;
			final String CreatDate       = Utils.getParameter(request, "CreatDate");
			final String Creat           = Utils.getParameter(request, "Creat");
			final String PrevCreat       = Utils.getParameter(request, "PrevCreat");
			final String PrevCreatDate   = Utils.getParameter(request, "PrevCreatDate"); 

			renFailChkGrp = request.getParameterValues("akiChkGrp");  */
			//CreatDate     = request.getParameter("CreatDate");
			//Creat         = request.getParameter("Creat");
			//PrevCreat     = request.getParameter("CreatPrev"); 
			//PrevCreatDate = request.getParameter("CreatPrevDate");

			if(renFailChkGrp == null){
				writer.beginParagraph();
				writer.outLine("     \u2022  Null values returned for Acute Kidney Injury \n",errorFont_);
				writer.endParagraph();
			}
			else{

				for (int j = 0; j < renFailChkGrp.length; j++){
					if(renFailChkGrp[j].equalsIgnoreCase("Acute Kidney Injury :Acute")) {

						writer.beginParagraph();
						writer.outLine(spacesLevelTwo_ + "Acute" + "\n",fontSubHead_);
						if(PrevCreat.equalsIgnoreCase("-99999.0")!=true && PrevCreat.equalsIgnoreCase("99999.0")!=true){
							writer.outLine(spacesLevelThree_ + "Creatinine:          " + Creat + " " + CreatDate + "\n",subFont_);
							writer.outLine(spacesLevelThree_ + "Previous Creatinine: " + PrevCreat + " " + PrevCreatDate + "\n",subFont_);
						System.out.println("ye kya hai ---------->>>>>>> "+PrevCreat);
						}
						else{
							writer.outLine(spacesLevelThree_ + "Creatinine:          " + Creat + " " + CreatDate + "\n" ,subFont_);
						}
						writer.endParagraph();
					}
					else if(renFailChkGrp[j].equalsIgnoreCase("Acute Kidney Injury :NOS")) {								

						writer.beginParagraph();
						writer.outLine(spacesLevelTwo_ + "Not Otherwise Specified" + "\n",fontSubHead_);
						writer.outLine(spacesLevelThree_ + "Creatinine:          " + Creat + " " + CreatDate + "\n", subFont_);
						writer.endParagraph();

					}
					else if(renFailChkGrp[j].equalsIgnoreCase("Chronic Kidney Disease :Chronic")){

						writer.beginParagraph();
						writer.outLine(spacesLevelTwo_ + "Chronic" + "\n",fontSubHead_);
						if(PrevCreat.equalsIgnoreCase("-99999.0")!=true && PrevCreat.equalsIgnoreCase("99999.0")!=true){

							writer.outLine(spacesLevelThree_ + "Creatinine:          " + Creat + " " + CreatDate + "\n",subFont_);
							writer.outLine(spacesLevelThree_ + "Previous Creatinine: " + PrevCreat + " " + PrevCreatDate + "\n",subFont_);
						}
						else{
							writer.outLine(spacesLevelThree_ + "Creatinine:          " + Creat + " " + CreatDate + "\n" ,subFont_);
						}
						writer.endParagraph();	
					}
				}
			}
			overallReturn="print";
		}


		return overallReturn;	
	}
	
}