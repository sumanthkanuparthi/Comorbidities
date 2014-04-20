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

public class ElectrolyteAbnormality implements ComorbiditiesFunctor {
	
	private final String spacesLevelThree_;
	private final String spacesLevelTwo_;
	private final Font font_;
	private final Font fontSubHead_;
	private final Font subFont_;
	private final Font errorFont_;
		
	/*
	 * Constructor to initialize variables
	 */
	ElectrolyteAbnormality(Font font, Font fontSubHead, Font subFont, Font errorFont, String spacesLevelThree, String spacesLevelTwo)
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
		return "Electrolyte Abnormality";
	}
	
	/*
	 * This returns the ICD9  
	 */
	public String getICD9(String n){
		if(n.equalsIgnoreCase("Hypokalemia"))
			return (new String("(ICD9 CODE: "+"276.8)"));
		else if(n.equalsIgnoreCase("Hyperkalemia"))
			return (new String("(ICD9 CODE: "+"276.7)"));
		else if(n.equalsIgnoreCase("Hyponatremia"))
			return (new String("(ICD9 CODE: "+"276.1)"));
		else if(n.equalsIgnoreCase("Hypernatremia"))
			return (new String("(ICD9 CODE: "+"276.0)"));
		else if(n.equalsIgnoreCase("Hypocalcemia"))
			return (new String("(ICD9 CODE: "+"275.41)"));
		else if(n.equalsIgnoreCase("Hypercalcemia"))
			return (new String("(ICD9 CODE: "+"275.42)"));
		else if(n.equalsIgnoreCase("Hypophosphatemia"))
			return (new String("(ICD9 CODE: "+"275.3)"));
		else if(n.equalsIgnoreCase("Hyperphosphatemia"))
			return (new String("(ICD9 CODE: "+"275.3)"));
		else if(n.equalsIgnoreCase("Hypomagnesemia"))
			return (new String("(ICD9 CODE: "+"275.2)"));
		else if(n.equalsIgnoreCase("Hypermagnesemia"))
			return (new String("(ICD9 CODE: "+"275.2)"));
		else
			return (new String(" "));
	}
	
	public String getICD9Commit(String n){
		if(n.equalsIgnoreCase("Hypokalemia"))
			return (new String("276.8"));
		else if(n.equalsIgnoreCase("Hyperkalemia"))
			return (new String("276.7"));
		else if(n.equalsIgnoreCase("Hyponatremia"))
			return (new String("276.1"));
		else if(n.equalsIgnoreCase("Hypernatremia"))
			return (new String("276.0"));
		else if(n.equalsIgnoreCase("Hypocalcemia"))
			return (new String("275.41"));
		else if(n.equalsIgnoreCase("Hypercalcemia"))
			return (new String("275.42"));
		else if(n.equalsIgnoreCase("Hypophosphatemia"))
			return (new String("275.3"));
		else if(n.equalsIgnoreCase("Hyperphosphatemia"))
			return (new String("275.3"));
		else if(n.equalsIgnoreCase("Hypomagnesemia"))
			return (new String("275.2"));
		else if(n.equalsIgnoreCase("Hypermagnesemia"))
			return (new String("275.2"));
		else
			return (new String(" "));
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		String overallReturn="";
		String[] EaChkGrp;
		EaChkGrp =  request.getParameterValues("EaChkGrp");
		
		final String hypokalDate = Utils.getParameter(request, "hypokalDate");
		final String hypokalPot  = Utils.getParameter(request, "hypokalPot");
		
		final String hyperkalDate = Utils.getParameter(request, "hyperkalDate");
		final String hyperkalPot  = Utils.getParameter(request, "hyperkalPot");
		
		final String hyponatDate = Utils.getParameter(request, "hyponatDate");
		final String hyponatSod  = Utils.getParameter(request, "hyponatSod");
		
		final String hypernatDate = Utils.getParameter(request, "hypernatDate");
		final String hypernatSod  = Utils.getParameter(request, "hypernatSod");
		
		final String hypocalDate = Utils.getParameter(request, "hypocalDate");
		final String hypocalCal  = Utils.getParameter(request, "hypocalCal");
		
		final String hypercalDate = Utils.getParameter(request, "hypercalDate");
		final String hypercalCal  = Utils.getParameter(request, "hypercalCal");
		
		final String hypophosDate = Utils.getParameter(request, "hypophosDate");
		final String hypophosPhos = Utils.getParameter(request, "hypophosPhos");
		
		final String hyperphosDate = Utils.getParameter(request, "hyperphosDate");
		final String hyperphosPhos = Utils.getParameter(request, "hyperphosPhos");
		
		final String hypomagDate = Utils.getParameter(request, "hypomagDate");
		final String hypomagMag  = Utils.getParameter(request, "hypomagMag");
		
		final String hypermagDate = Utils.getParameter(request, "hypermagDate");
		final String hypermagMag  = Utils.getParameter(request, "hypermagMag");
		
		String mainGrp = getName();
		
		//flag =1 code starts 
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
			icdElement.appendChild(doc.createTextNode("null"));
			rootElement.appendChild(icdElement);

			Element dateElement = doc.createElement("date");
			dateElement.appendChild(doc.createTextNode(Date.substring(0,10)));
			rootElement.appendChild(dateElement);

			Element timeElement = doc.createElement("time");
			timeElement.appendChild(doc.createTextNode(Date.substring(0,10)));
			rootElement.appendChild(timeElement);

			if(EaChkGrp == null){
				XMLGenerator xg=new XMLGenerator();

				overallReturn=xg.generateXMLString(doc);

			}
			else{
				
				//rootElement.appendChild(subCat);
				for (int j = 0; j < EaChkGrp.length; j++){
					Element subCat = doc.createElement("subcategory");
					rootElement.appendChild(subCat);

					if(EaChkGrp[j].equalsIgnoreCase("Electrolyte Abnormality :Hypokalemia")) {

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Electrolyte Abnormality :Hypokalemia"));
						subCat.appendChild(subname);
						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Hypokalemia")));
						subCat.appendChild(icd91);

						//final String hypokalDate = Utils.getParameter(request, "hypokalDate");
						//final String hypokalPot  = Utils.getParameter(request, "hypokalPot");
							Element hypokalDateElement = doc.createElement("hypokaldate");
							hypokalDateElement.appendChild(doc.createTextNode(getICD9Commit(hypokalDate)));
							subCat.appendChild(hypokalDateElement);
							Element hypokalPotElement = doc.createElement("hypokalpot");
							hypokalPotElement.appendChild(doc.createTextNode(getICD9Commit(hypokalPot)));
							subCat.appendChild(hypokalPotElement);


						//writer.outLine(spacesLevelThree_ + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n",subFont_);

						
							

						}
						

					
					else if(EaChkGrp[j].equalsIgnoreCase("Electrolyte Abnormality :Hyperkalemia")) {


						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Electrolyte Abnormality :Hyperkalemia"));
						subCat.appendChild(subname);
						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Hyperkalemia")));
						subCat.appendChild(icd91);

						//final String hyperkalDate = Utils.getParameter(request, "hyperkalDate");
						//final String hyperkalPot  = Utils.getParameter(request, "hyperkalPot");
							Element hyperkalDateElement = doc.createElement("hyperkaldate");
							hyperkalDateElement.appendChild(doc.createTextNode(getICD9Commit(hyperkalDate)));
							subCat.appendChild(hyperkalDateElement);
							Element hyperkalPotElement = doc.createElement("hyperkalpot");
							hyperkalPotElement.appendChild(doc.createTextNode(getICD9Commit(hyperkalPot)));
							subCat.appendChild(hyperkalPotElement);


						
						//writer.outLine(spacesLevelThree_ + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n",subFont_);

						



					}
					else if(EaChkGrp[j].equalsIgnoreCase("Electrolyte Abnormality :Hyponatremia")){

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Electrolyte Abnormality :Hyponatremia"));
						subCat.appendChild(subname);

						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Hyponatremia")));
						subCat.appendChild(icd91);
						
						//final String hyponatDate = Utils.getParameter(request, "hyponatDate");
						//final String hyponatSod  = Utils.getParameter(request, "hyponatSod");
						
							Element hyponatDateElement = doc.createElement("hyponatdate");
							hyponatDateElement.appendChild(doc.createTextNode(getICD9Commit(hyponatDate)));
							subCat.appendChild(hyponatDateElement);
							Element hyponatSodElement = doc.createElement("hyponatsod");
							hyponatSodElement.appendChild(doc.createTextNode(getICD9Commit(hyponatSod)));
							subCat.appendChild(hyponatSodElement);


						
						

					}
					
					//4 
					
					else if(EaChkGrp[j].equalsIgnoreCase("Electrolyte Abnormality :Hypernatremia")){

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Electrolyte Abnormality :Hypernatremia"));
						subCat.appendChild(subname);

						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Hypernatremia")));
						subCat.appendChild(icd91);
						
						//final String hypernatDate = Utils.getParameter(request, "hypernatDate");
						//final String hypernatSod  = Utils.getParameter(request, "hypernatSod");
							Element hypernatDateElement = doc.createElement("hypernatdate");
							hypernatDateElement.appendChild(doc.createTextNode(hypernatDate));
							subCat.appendChild(hypernatDateElement);
							Element hypernatSodElement = doc.createElement("hypernatsod");
							hypernatSodElement.appendChild(doc.createTextNode(getICD9Commit(hypernatSod)));
							subCat.appendChild(hypernatSodElement);

					

					}
					//5
					
					else if(EaChkGrp[j].equalsIgnoreCase("Electrolyte Abnormality :Hypocalcemia")){

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Electrolyte Abnormality :Hypocalcemia"));
						subCat.appendChild(subname);

						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Hypocalcemia")));
						subCat.appendChild(icd91);
						//final String hypocalDate = Utils.getParameter(request, "hypocalDate");
						//final String hypocalCal  = Utils.getParameter(request, "hypocalCal");
						
							Element hypocalDateElement = doc.createElement("hypocaldate");
							hypocalDateElement.appendChild(doc.createTextNode(hypocalDate));
							subCat.appendChild(hypocalDateElement);
							Element hypocalCalElement = doc.createElement("hypocalcal");
							hypocalCalElement.appendChild(doc.createTextNode(getICD9Commit(hypocalCal)));
							subCat.appendChild(hypocalCalElement);

						

					}
					//6
					
					else if(EaChkGrp[j].equalsIgnoreCase("Electrolyte Abnormality :Hypercalcemia")){

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Electrolyte Abnormality :Hypercalcemia"));
						subCat.appendChild(subname);

						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Hypercalcemia")));
						subCat.appendChild(icd91);
						//final String hypercalDate = Utils.getParameter(request, "hypercalDate");
						//final String hypercalCal  = Utils.getParameter(request, "hypercalCal");
						
							Element hypercalDateElement = doc.createElement("hypercaldate");
							hypercalDateElement.appendChild(doc.createTextNode(hypercalDate));
							subCat.appendChild(hypercalDateElement);
							Element hypercalCalElement = doc.createElement("hypercalcal");
							hypercalCalElement.appendChild(doc.createTextNode(getICD9Commit(hypercalCal)));
							subCat.appendChild(hypercalCalElement);

						

					}
					//7
					
					else if(EaChkGrp[j].equalsIgnoreCase("Electrolyte Abnormality :Hypophosphatemia")){

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Electrolyte Abnormality :Hypophosphatemia"));
						subCat.appendChild(subname);

						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Hypophosphatemia")));
						subCat.appendChild(icd91);
						//final String hypophosDate = Utils.getParameter(request, "hypophosDate");
						//final String hypophosPhos = Utils.getParameter(request, "hypophosPhos");
						
						
						
						
						
						
							Element hypophosDateElement = doc.createElement("hypophosdate");
							hypophosDateElement.appendChild(doc.createTextNode(hypophosDate));
							subCat.appendChild(hypophosDateElement);
							Element hypophosPhosElement = doc.createElement("hypophosphos");
							hypophosPhosElement.appendChild(doc.createTextNode(getICD9Commit(hypophosPhos)));
							subCat.appendChild(hypophosPhosElement);

						

					}
					//8
					else if(EaChkGrp[j].equalsIgnoreCase("Electrolyte Abnormality :Hyperphosphatemia")){

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Electrolyte Abnormality :Hyperphosphatemia"));
						subCat.appendChild(subname);

						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Hyperphosphatemia")));
						subCat.appendChild(icd91);
						
						//final String hyperphosDate = Utils.getParameter(request, "hyperphosDate");
						//final String hyperphosPhos = Utils.getParameter(request, "hyperphosPhos");
						
							Element hyperphosDateElement = doc.createElement("hyperphosdate");
							hyperphosDateElement.appendChild(doc.createTextNode(hyperphosDate));
							subCat.appendChild(hyperphosDateElement);
							Element hyperphosPhosElement = doc.createElement("hyperphosphos");
							hyperphosPhosElement.appendChild(doc.createTextNode(getICD9Commit(hyperphosPhos)));
							subCat.appendChild(hyperphosPhosElement);

						

					}
					///9
					else if(EaChkGrp[j].equalsIgnoreCase("Electrolyte Abnormality :Hypomagnesemia")){

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Electrolyte Abnormality :Hypomagnesemia"));
						subCat.appendChild(subname);

						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Hypomagnesemia")));
						subCat.appendChild(icd91);
						
						//final String hypomagDate = Utils.getParameter(request, "hypomagDate");
						//final String hypomagMag  = Utils.getParameter(request, "hypomagMag");
							Element hypomagDateElement = doc.createElement("hypomagdate");
							hypomagDateElement.appendChild(doc.createTextNode(hypomagDate));
							subCat.appendChild(hypomagDateElement);
							Element hypomagMagElement = doc.createElement("hypomagmag");
							hypomagMagElement.appendChild(doc.createTextNode(getICD9Commit(hypomagMag)));
							subCat.appendChild(hypomagMagElement);

						

					}
					//10
					else if(EaChkGrp[j].equalsIgnoreCase("Electrolyte Abnormality :Hypermagnesemia")){

						Element subname = doc.createElement("subname");
						subname.appendChild(doc.createTextNode("Electrolyte Abnormality :Hypermagnesemia"));
						subCat.appendChild(subname);

						Element icd91 = doc.createElement("icd");
						icd91.appendChild(doc.createTextNode(getICD9Commit("Hypermagnesemia")));
						subCat.appendChild(icd91);
						
						//final String hypermagDate = Utils.getParameter(request, "hypermagDate");
						//final String hypermagMag  = Utils.getParameter(request, "hypermagMag");
						
							Element hypermagDateElement = doc.createElement("hypermagdate");
							hypermagDateElement.appendChild(doc.createTextNode(hypermagDate));
							subCat.appendChild(hypermagDateElement);
							Element hypermagMagElement = doc.createElement("hypermagmag");
							hypermagMagElement.appendChild(doc.createTextNode(getICD9Commit(hypermagMag)));
							subCat.appendChild(hypermagMagElement);

						

					}



				}
			}
			DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
			LSSerializer lsSerializer = domImplementation.createLSSerializer();
			overallReturn= lsSerializer.writeToString(doc);

		}


		
		
		
		// flag =1 code ends 
		
		
		if(flag==0)
		{
		writer.beginParagraph();
		writer.outLine("     \u2022  " + mainGrp + "\n",font_);
		writer.endParagraph();
		
		
		
		
		if(EaChkGrp == null){
			
			writer.beginParagraph();
			writer.outLine("     \u2022  Null values returned for Electrolyte Abnormality \n",errorFont_);
			writer.endParagraph();
			
		}
		else{
			
			for (int j = 0; j < EaChkGrp.length; j++){

				if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypokalemia")){

					
					/*hypokalDate = request.getParameter("hypokalDate");
					hypokalPot = request.getParameter("hypokalPot");*/
					
					
					writer.beginParagraph();					
					writer.outLine(spacesLevelTwo_ + "Hypokalemia" + "  " + getICD9("Hypokalemia") + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Potassium: " + hypokalPot + " " + hypokalDate + "\n"  
			   				,subFont_);					
					writer.endParagraph();
					
					
					
				}
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyperkalemia")){

					
					/*hyperkalDate = request.getParameter("hyperkalDate");
					hyperkalPot = request.getParameter("hyperkalPot");*/
					
					
					writer.beginParagraph();					
					writer.outLine(spacesLevelTwo_ + "Hyperkalemia" + "  " + getICD9("Hyperkalemia") +"\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Potassium: " + hyperkalPot + " " + hyperkalDate + "\n"
							,subFont_);
					writer.endParagraph();
					
					
				}
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyponatremia")){

					
					/*hyponatDate = request.getParameter("hyponatDate");
					hyponatSod = request.getParameter("hyponatSod");*/
					
					
					writer.beginParagraph();					
					writer.outLine(spacesLevelTwo_ + "Hyponatremia" + "  " + getICD9("Hyponatremia") + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Sodium: " + hyponatSod + " " + hyponatDate + "\n" 
							,subFont_);					
					writer.endParagraph();
					
				}
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypernatremia")){

					
					/*hypernatDate = request.getParameter("hypernatDate");
					hypernatSod = request.getParameter("hypernatSod");*/
					
					
					writer.beginParagraph();
					writer.outLine(spacesLevelTwo_ + "Hypernatremia" + "  " + getICD9("Hypernatremia") + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Sodium: " + hypernatSod + " " + hypernatDate + "\n"
							,subFont_);					
					writer.endParagraph();
					
				}
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypocalcemia")){

					
					/*hypocalDate = request.getParameter("hypocalDate");
					hypocalCal = request.getParameter("hypocalCal");*/
					
					
					writer.beginParagraph();
					writer.outLine(spacesLevelTwo_ + "Hypocalcemia" + "  " + getICD9("Hypocalcemia") + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Calcium: " + hypocalCal + " " + hypocalDate + "\n"  
							,subFont_);					
					writer.endParagraph();
					
					
				}
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypercalcemia")){

					
					/*hypercalDate = request.getParameter("hypercalDate");
					hypercalCal = request.getParameter("hypercalCal");*/
					
					
					writer.beginParagraph();					
					writer.outLine(spacesLevelTwo_ + "Hypercalcemia" + "  " + getICD9("Hypercalcemia") + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Calcium: " + hypercalCal + " " + hypercalDate + "\n" 
							,subFont_);					
					writer.endParagraph();
					
					
				}
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypophosphatemia")){

					
					/*hypophosDate = request.getParameter("hypophosDate");
					hypophosPhos = request.getParameter("hypophosPhos");*/
					
					
					writer.beginParagraph();
					writer.outLine(spacesLevelTwo_ + "Hypophosphatemia" + "  " + getICD9("Hypophosphatemia") + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Phosphorus: " + hypophosPhos + " " + hypophosDate + "\n"  
							,subFont_);					
					writer.endParagraph();
					
					
				}
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyperphosphatemia")){

					
					/*hyperphosDate = request.getParameter("hyperphosDate");
					hyperphosPhos = request.getParameter("hyperphosPhos");*/
					
					
					writer.beginParagraph();					
					writer.outLine(spacesLevelTwo_ + "Hyperphosphatemia" + "  " + getICD9("Hyperphosphatemia") + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Phosphorus: " + hyperphosPhos + " " + hyperphosDate + "\n"
							,subFont_);					
					writer.endParagraph();
					
					
					
				}
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypomagnesemia")){

					
					/*hypomagDate = request.getParameter("hypomagDate");
					hypomagMag = request.getParameter("hypomagMag");*/
					
					
					writer.beginParagraph();					
					writer.outLine(spacesLevelTwo_ + "Hypomagnesemia" + "  " + getICD9("Hypomagnesemia") + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Magnesium: " + hypomagMag + " " + hypomagDate + "\n"  
							,subFont_);					
					writer.endParagraph();
					
					
					
			}
				else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypermagnesemia")){

					
					/*hypermagDate = request.getParameter("hypermagDate");
					hypermagMag = request.getParameter("hypermagMag");*/
					
					
					writer.beginParagraph();
					writer.outLine(spacesLevelTwo_ + "Hypermagnesemia" + "  " + getICD9("Hypermagnesemia") + "\n",fontSubHead_);
					writer.outLine(spacesLevelThree_ + "Magnesium: " + hypermagMag + " " + hypermagDate + "\n"
							,subFont_);					
					writer.endParagraph();
					
					
					
				}
			}
			
		}
		}
		return overallReturn;
	}

}
