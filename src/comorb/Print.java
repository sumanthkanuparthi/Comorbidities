/*package comorb;

import java.io.IOException;
import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.itextpdf.text.Image;
import com.itextpdf.text.*;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;


public class Print extends HttpServlet {
	private static final long serialVersionUID = 1L;



	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		Document document = new Document();


		try {
			String[] mainGrp;
			String toPrint = "";
			response.setContentType("application/pdf");    			
			PdfWriter.getInstance(document, response.getOutputStream());
			String relativeWebPath = "barcode.bmp";
			String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
			Image To_be_Added = Image.getInstance(absoluteDiskPath);    			
			To_be_Added.setAlignment(Image.MIDDLE);
			To_be_Added.setBorder(Image.BOX);
			To_be_Added.scalePercent(50);

			document.open();
			document.add(To_be_Added);    	        
			document.add(new Paragraph("\n"));


			Paragraph paragraph = new Paragraph();
			Font font = FontFactory.getFont("Times-Roman",18, Font.BOLD);
			Font fontSubHead = FontFactory.getFont("Courier",12, Font.BOLD);
			Font subFont = FontFactory.getFont("Courier" ,10);

			paragraph = new Paragraph("  CO-MORBIDITIES",font);
			document.add(paragraph);

			document.add(new Paragraph("\n"));

			PdfPTable table = new PdfPTable(1);
			PdfPCell cell = new PdfPCell();

			paragraph = new Paragraph("\n");
			cell = new PdfPCell(paragraph);
			cell.setBorderWidthBottom(0);
			table.addCell(cell);

			font = FontFactory.getFont("Times-Roman",14, Font.BOLD);
			mainGrp = request.getParameterValues("mainGrp");
			
			String spacesLevelTwo = "          ";
			String spacesLevelThree = "                    ";

			if(mainGrp == null)
			{
				toPrint = "Error";
				document.add(new Paragraph("     " + toPrint,font));
			}
			else
			{ 
				for (int i = 0; i < mainGrp.length; i++) 
				{
					if(mainGrp[i].equals("Anemia :")){

						String[] anemiaChkGrp;
						anemiaChkGrp =  request.getParameterValues("anemiaChkGrp");

						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						String chHgloDate,chHglo,preChHglo,chHcrit,preChHcrit,chHcritDate,preChHgloDate,preChHcritDate,norHBLow,norHCLow;
						String result;

						chHgloDate = request.getParameter("AnHgloDate");
						chHglo = request.getParameter("AnHglo");

						preChHgloDate = request.getParameter("preAnHgloDate");
						preChHglo = request.getParameter("preAnHglo");

						chHcritDate = request.getParameter("AnHcritDate");
						chHcrit = request.getParameter("AnHcrit");

						preChHcritDate = request.getParameter("preAnHcritDate");
						preChHcrit = request.getParameter("preAnHcrit");
						
						norHCLow = request.getParameter("normalHCLow");
						norHBLow = request.getParameter("normalHBLow");
						
						result = request.getParameter("result");
						
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);

						for (int j = 0; j < anemiaChkGrp.length; j++){

							if(anemiaChkGrp[j].equals("Acute blood loss")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Acute" + "\n\n",fontSubHead));
								
								//if(result.isEmpty() != true && result.equalsIgnoreCase("1"))
								{
									if(chHglo.isEmpty() != true && (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow)))
									{

										paragraph.add(new Chunk(spacesLevelThree + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n\n",subFont));

									}
									
									if(preChHglo.isEmpty() != true && (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow)))
									{
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n\n",subFont));
									}
									
									if(chHcrit.isEmpty() != true && (Double.parseDouble(chHcrit) < Double.parseDouble(norHCLow)))
									{

										paragraph.add(new Chunk(spacesLevelThree + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n\n",subFont));

									}
									
									if(preChHcrit.isEmpty() != true && (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow)))
									{
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n\n",subFont));
									}
								}
								
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(anemiaChkGrp[j].equals("Anemia: Chronic Disease")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Chronic" + "\n\n",fontSubHead));

								//if(result.isEmpty() != true && result.equalsIgnoreCase("3"))
								{	
									if(chHglo.isEmpty() != true && (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow)) && 
											preChHglo.isEmpty() != true && (Double.parseDouble(preChHglo) < Double.parseDouble(norHBLow)))
									{
										paragraph.add(new Chunk(spacesLevelThree + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n\n",subFont));
										//paragraph.add(new Chunk(spacesLevelThree + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n\n",subFont));
									}
									
									if(preChHglo.isEmpty() != true && (Double.parseDouble(preChHglo) < Double.parseDouble(norHBLow)))
									{
										//paragraph.add(new Chunk(spacesLevelThree + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n\n",subFont));
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n\n",subFont));
									}
									
									if(chHcrit.isEmpty() != true && (Double.parseDouble(chHcrit) < Double.parseDouble(norHCLow)) &&
											preChHcrit.isEmpty() != true && (Double.parseDouble(preChHcrit) < Double.parseDouble(norHCLow)))
									{
										paragraph.add(new Chunk(spacesLevelThree + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n\n",subFont));
										//paragraph.add(new Chunk(spacesLevelThree + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n\n",subFont));
									}
									if(preChHcrit.isEmpty() != true && (Double.parseDouble(preChHcrit) < Double.parseDouble(norHCLow)))
									{
										//paragraph.add(new Chunk(spacesLevelThree + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n\n",subFont));
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n\n",subFont));
									}
								}
								
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							} 
							else if(anemiaChkGrp[j].equals("Anemia: NOS")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Not otherwise specified" + "\n\n",fontSubHead));

								//if(result.isEmpty() != true && result.equalsIgnoreCase("2"))
								{
									if(chHglo.isEmpty() != true && (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow)) && preChHglo.isEmpty() == true)
									{
										paragraph.add(new Chunk(spacesLevelThree + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n\n",subFont));
									}
									
									if(preChHglo.isEmpty() != true && (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow)))
									{
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n\n",subFont));
									}
									
									if(chHcrit.isEmpty() != true && (Double.parseDouble(chHcrit) < Double.parseDouble(norHCLow)))
									{
										paragraph.add(new Chunk(spacesLevelThree + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n\n",subFont));
									}
									
									if(preChHcrit.isEmpty() != true && (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow)))
									{
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n\n",subFont));
									}
								}
								
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(anemiaChkGrp[j].equals("Anemia: Blood Loss")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Due to Blood Loss" + "\n\n",fontSubHead));
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
						}
					}

					else if(mainGrp[i].equals("Acute Kidney Injury")){

						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						String[] renFailChkGrp = request.getParameterValues("akiChkGrp");
						String CreatDate, Creat, PrevCreat, PrevCreatDate;
						CreatDate = request.getParameter("CreatDate");
						Creat = request.getParameter("Creat");
						PrevCreat = request.getParameter("CreatPrev"); 
						PrevCreatDate = request.getParameter("CreatPrevDate");
						
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
						
						for (int j = 0; j < renFailChkGrp.length; j++){
							if(renFailChkGrp[j].equalsIgnoreCase("Acute Kidney Injury :Acute")) {
								
								String rfaDate,rfaCreat, rfaPrevCreat, rfaPrevCreatDate;
								rfaDate = request.getParameter("AcrfaCreatDate");
								rfaCreat = request.getParameter("AcrfaCreat");
								rfaPrevCreat = request.getParameter("AcrfaCreatPrev"); 
								rfaPrevCreatDate = request.getParameter("AcrfaCreatPrevDate");
								
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Acute" + "\n\n",fontSubHead));
								
								if(CreatDate!=null && Creat!=null && PrevCreat!=null && PrevCreatDate!=null){
								
									if(PrevCreat.equalsIgnoreCase("-99999.0")!=true && PrevCreat.equalsIgnoreCase("99999.0")!=true){
									
										paragraph.add(new Chunk(spacesLevelThree + "Creatinine:          " + Creat + " " + CreatDate + "\n\n" +
													        	spacesLevelThree + "Previous Creatinine: " + PrevCreat + " " + PrevCreatDate + "\n\n"
													        	,subFont));
									}
									else{
										paragraph.add(new Chunk(spacesLevelThree + "Creatinine:          " + Creat + " " + CreatDate + "\n\n" ,subFont));
									}
								}
								
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(renFailChkGrp[j].equalsIgnoreCase("Acute Kidney Injury :NOS")) {
								String rfaDate,rfaCreat;
								rfaDate = request.getParameter("ChrfaCreatDate");
								rfaCreat = request.getParameter("ChrfaCreat");
								
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Not Otherwise Specified" + "\n\n",fontSubHead));
								
								if(CreatDate!=null && Creat!=null){
								
								paragraph.add(new Chunk(spacesLevelThree + "Creatinine: " + Creat + " " + CreatDate + "\n\n"
														, subFont));
								}
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(renFailChkGrp[j].equalsIgnoreCase("Chronic Kidney Disease :Chronic")){
								
								String rfaDate,rfaCreat, rfaPrevCreat, rfaPrevCreatDate;
								rfaDate = request.getParameter("rfcCreatDate");
								rfaCreat = request.getParameter("rfcCreat");
								rfaPrevCreat = request.getParameter("rfcCreatPrev"); 
								rfaPrevCreatDate = request.getParameter("rfcCreatPrevDate");
								
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Chronic" + "\n\n",fontSubHead));
								
								if(CreatDate!=null && Creat!=null && PrevCreat!=null && PrevCreatDate!=null){
									
									if(PrevCreat.equalsIgnoreCase("-99999.0")!=true && PrevCreat.equalsIgnoreCase("99999.0")!=true){
								
										paragraph.add(new Chunk(spacesLevelThree + "Creatinine:          " + Creat + " " + CreatDate + "\n\n" +
														        spacesLevelThree + "Previous Creatinine: " + PrevCreat + " " + PrevCreatDate + "\n\n"
														        ,subFont));
									}
									else{
										paragraph.add(new Chunk(spacesLevelThree + "Creatinine:          " + Creat + " " + CreatDate + "\n\n" ,subFont));
									}
								}
								
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
						}
					}

					else if(mainGrp[i].equals("Chronic Kidney Disease")){

						String[] renFailChkGrp;
						renFailChkGrp =  request.getParameterValues("ckdChkGrp");

						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
						for (int j = 0; j < renFailChkGrp.length; j++){

							String rfcPrevCreatDate, rfcPrevCreat, rfcDate,rfcCreat,rfcMaxGfr,rfcMaxGfrDate,rfcMinGfr,rfcMinGfrDate;							
							rfcDate = request.getParameter("rfcDate");
							rfcCreat = request.getParameter("rfcCreat");
							rfcPrevCreatDate = request.getParameter("rfcprevDate");
							rfcPrevCreat = request.getParameter("rfcprevCreat");
							rfcMaxGfr = request.getParameter("rfcMaxGfr");
							rfcMaxGfrDate = request.getParameter("rfcMaxGfrDate");
							rfcMinGfr = request.getParameter("rfcMinGfr");
							rfcMinGfrDate = request.getParameter("rfcMinGfrDate");
							
							if(renFailChkGrp[j].equals("Chronic Kidney Disease :NOS")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Not Otherwise Specified" + "\n\n",fontSubHead));
								paragraph.add(new Chunk(spacesLevelThree + "Creatinine: " + rfcCreat + " " + rfcDate + "\n\n" + 
														spacesLevelThree + "Max GFR: " + rfcMaxGfr + " " + rfcMaxGfrDate + "\n\n" +
														spacesLevelThree + "Min GFR: " + rfcMinGfr + " " + rfcMinGfrDate + "\n\n"
														,subFont));

								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							if(renFailChkGrp[j].equals("Chronic Kidney Disease :Chronic")){
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Chronic" + "\n\n",fontSubHead));
								paragraph.add(new Chunk(spacesLevelThree + "Creatinine: " + rfcCreat + " " + rfcDate + "\n\n" +
														spacesLevelThree + "Previous Creatinine: " + rfcPrevCreat + " " + rfcPrevCreatDate + "\n\n" +
														spacesLevelThree + "Max GFR: " + rfcMaxGfr + " " + rfcMaxGfrDate + "\n\n" +
														spacesLevelThree + "Min GFR: " + rfcMinGfr + " " + rfcMinGfrDate + "\n\n"
														, subFont));

								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
						}
					}
					else if(mainGrp[i].equals("ElevatedBloodGlucose")){
						
						String[] EbgChkGrp;
						EbgChkGrp =  request.getParameterValues("EbgChkGrp");
						
						String glucDate,glucResult = "";
						glucDate = request.getParameter("glucDate");
						glucResult = request.getParameter("glucResult");
						
						for (int j = 0; j < EbgChkGrp.length; j++){
							paragraph = new Paragraph();
							paragraph.add(new Chunk("     \u2022  " + EbgChkGrp[j] + "\n\n",font));
							
							paragraph.add(new Chunk(spacesLevelThree + "Glucose: " + glucResult + " " + glucDate + "\n\n" ,
													subFont));
							
							cell = new PdfPCell(paragraph);
							cell.setBorderWidthBottom(0);
							cell.setBorderWidthTop(0);
							table.addCell(cell);
						}
					}
					else if(mainGrp[i].equals("Hypoglycemia")){

						String glucDate,glucResult = "";
						glucDate = request.getParameter("hypoglucDate");
						glucResult = request.getParameter("hypoglucResult");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));

						paragraph.add(new Chunk(spacesLevelThree + "Glucose: " + glucResult + " " + glucDate + "\n\n" 
								 				,subFont));
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("Hypoxia")){

						String oximetryDate,oximetryResult = "";
						oximetryDate = request.getParameter("oximetryDate");
						oximetryResult = request.getParameter("oximetryResult");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));

						paragraph.add(new Chunk(spacesLevelThree + "Pulse Oximetry: " + oximetryResult + " " + oximetryDate + "\n\n" 
								 				,subFont));
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("Granulocytopenia")){

						String minneutrophilDate,minneutrophilResult = "";
						minneutrophilDate = request.getParameter("neutrophilMinDate");
						minneutrophilResult = request.getParameter("neutrophilMinResult");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));

						paragraph.add(new Chunk(spacesLevelThree + "Neutrophil (Minimum): " + minneutrophilResult + " " + 
												minneutrophilDate + "\n\n" 
												,subFont));
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("LacticAcidosis")){

						String lacticAcidDate,lacticAcidResult = "";
						lacticAcidDate = request.getParameter("lacticAcidDate");
						lacticAcidResult = request.getParameter("lacticAcidResult");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));

						paragraph.add(new Chunk(spacesLevelThree + "Lactic Acid: " + lacticAcidResult + " " + lacticAcidDate + "\n\n" 
												,subFont));
						
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("Electrolyte Abnormality")){

						String[] EaChkGrp;
						EaChkGrp =  request.getParameterValues("EaChkGrp");
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));

						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
						
						for (int j = 0; j < EaChkGrp.length; j++){

							if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypokalemia")){

								String hypokalDate,hypokalPot = "";
								hypokalDate = request.getParameter("hypokalDate");
								hypokalPot = request.getParameter("hypokalPot");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypokalemia" + "\n\n",fontSubHead));

								paragraph.add(new Chunk(spacesLevelThree + "Potassium: " + hypokalPot + " " + hypokalDate + "\n\n"  
										   				,subFont));
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);

							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyperkalemia")){

								String hyperkalDate,hyperkalPot = "";
								hyperkalDate = request.getParameter("hyperkalDate");
								hyperkalPot = request.getParameter("hyperkalPot");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hyperkalemia" + "\n\n",fontSubHead));

								paragraph.add(new Chunk(spacesLevelThree + "Potassium: " + hyperkalPot + " " + hyperkalDate + "\n\n"
														,subFont));
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyponatremia")){

								String hyponatDate,hyponatSod = "";
								hyponatDate = request.getParameter("hyponatDate");
								hyponatSod = request.getParameter("hyponatSod");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hyponatremia" + "\n\n",fontSubHead));

								paragraph.add(new Chunk(spacesLevelThree + "Sodium: " + hyponatSod + " " + hyponatDate + "\n\n" 
														,subFont));
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypernatremia")){

								String hypernatDate,hypernatSod = "";
								hypernatDate = request.getParameter("hypernatDate");
								hypernatSod = request.getParameter("hypernatSod");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypernatremia" + "\n\n",fontSubHead));

								paragraph.add(new Chunk(spacesLevelThree + "Sodium: " + hypernatSod + " " + hypernatDate + "\n\n"
														,subFont));
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypocalcemia")){

								String hypocalDate,hypocalCal = "";
								hypocalDate = request.getParameter("hypocalDate");
								hypocalCal = request.getParameter("hypocalCal");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypocalcemia" + "\n\n",fontSubHead));

								paragraph.add(new Chunk(spacesLevelThree + "Calcium: " + hypocalCal + " " + hypocalDate + "\n\n"  
														,subFont));
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypercalcemia")){

								String hypercalDate,hypercalCal = "";
								hypercalDate = request.getParameter("hypercalDate");
								hypercalCal = request.getParameter("hypercalCal");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypercalcemia" + "\n\n",fontSubHead));

								paragraph.add(new Chunk(spacesLevelThree + "Calcium: " + hypercalCal + " " + hypercalDate + "\n\n" 
														,subFont));
								
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypophosphatemia")){

								String hypophosDate,hypophosPhos = "";
								hypophosDate = request.getParameter("hypophosDate");
								hypophosPhos = request.getParameter("hypophosPhos");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypophosphatemia" + "\n\n",fontSubHead));

								paragraph.add(new Chunk(spacesLevelThree + "Phosphorus: " + hypophosPhos + " " + hypophosDate + "\n\n"  
														,subFont));
								
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyperphosphatemia")){

								String hyperphosDate,hyperphosPhos = "";
								hyperphosDate = request.getParameter("hyperphosDate");
								hyperphosPhos = request.getParameter("hyperphosPhos");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hyperphosphatemia" + "\n\n",fontSubHead));

								paragraph.add(new Chunk(spacesLevelThree + "Phosphorus: " + hyperphosPhos + " " + hyperphosDate + "\n\n"
														,subFont));
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypomagnesemia")){

								String hypomagDate,hypomagMag = "";
								hypomagDate = request.getParameter("hypomagDate");
								hypomagMag = request.getParameter("hypomagMag");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypomagnesemia" + "\n\n",fontSubHead));

								paragraph.add(new Chunk(spacesLevelThree + "Magnesium: " + hypomagMag + " " + hypomagDate + "\n\n"  
														,subFont));
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypermagnesemia")){

								String hypermagDate,hypermagMag = "";
								hypermagDate = request.getParameter("hypermagDate");
								hypermagMag = request.getParameter("hypermagMag");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypermagnesemia" + "\n\n",fontSubHead));

								paragraph.add(new Chunk(spacesLevelThree + "Magnesium: " + hypermagMag + " " + hypermagDate + "\n\n"
														,subFont));
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
						}
					}
					else if(mainGrp[i].equals("HyperCholesterolemia")){

						String cholesterolDate,cholesterolResult = "";
						cholesterolDate = request.getParameter("cholesterolDate");
						cholesterolResult = request.getParameter("cholesterolResult");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));

						paragraph.add(new Chunk(spacesLevelThree + "Cholesterol: " + cholesterolResult + " " + cholesterolDate + "\n\n" 
												,subFont));
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);							
					}
					else if(mainGrp[i].equals("Dehydration")){

						String creatDate,creatResult,bunDate,bunResult,hydration  = "";
						creatDate = request.getParameter("hydracreatDate");
						creatResult = request.getParameter("hydracreatinine");
						bunDate = request.getParameter("hydrabunDate");
						bunResult = request.getParameter("hydrabunResult");
						hydration = request.getParameter("hydration");
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						paragraph.add(new Chunk("                    Date: " + creatDate +
								"        Creatinine: " + creatResult + "\n\n" ,subFont));
						paragraph.add(new Chunk("                    Date: " + bunDate +
								"        BUN: " + bunResult + "\n\n" ,subFont));
						paragraph.add(new Chunk("                    BUN/Creatinine: " + hydration + "\n\n" ,subFont));
						paragraph.add(new Chunk(spacesLevelThree + "Creatinine:     " + creatResult + " " + creatDate + "\n\n" +
								                spacesLevelThree + "BUN:            " + bunResult + " " + bunDate + "\n\n" +
								                spacesLevelThree + "BUN/Creatinine: " + hydration  + "\n\n" ,subFont));
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("Malnutrition")){

						String malHeightDate,malHeight,malWeight,malBmi,malWeightDate;
						malHeightDate = request.getParameter("malHeightDate");
						malWeightDate = request.getParameter("malWeightDate");
						malHeight = request.getParameter("malHeight");
						malWeight = request.getParameter("malWeight");
						malBmi = request.getParameter("malBmi");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));

						paragraph.add(new Chunk(spacesLevelThree + "Height: " + malHeight + " " + malHeightDate + "\n\n" +
												spacesLevelThree + "Weight: " + malWeight + " " + malWeightDate + "\n\n" +
												spacesLevelThree + "BMI:    " + malBmi  + "\n\n"  
												,subFont));
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("Obesity")){

						String obHeightDate, obHeight, obWeight, obBmi, obWeightDate = "";
						
						obHeightDate = request.getParameter("obHeightDate");
						obHeight = request.getParameter("obHeight");
						obWeight = request.getParameter("obWeight");
						obBmi = request.getParameter("obBmi");
						obWeightDate = request.getParameter("obWeightDate");
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));

						paragraph.add(new Chunk(spacesLevelThree + "Height: " + obHeight + " " + obHeightDate + "\n\n" +
												spacesLevelThree + "Weight: " + obWeight + " " + obWeightDate + "\n\n" +
												spacesLevelThree + "BMI:    " + obBmi  + "\n\n"
												,subFont));
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("Morbid Obesity")){

						String mobHeightDate, mobHeight, mobWeight, mobBmi, mobWeightDate = "";
						
						mobHeightDate = request.getParameter("mobHeightDate");
						mobHeight = request.getParameter("mobHeight");
						mobWeight = request.getParameter("mobWeight");
						mobBmi = request.getParameter("mobBmi");
						mobWeightDate = request.getParameter("mobWeightDate");
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));

						paragraph.add(new Chunk(spacesLevelThree + "Height: " + mobHeight + " " + mobHeightDate + "\n\n" +
												spacesLevelThree + "Weight: " + mobWeight + " " + mobWeightDate + "\n\n" +
												spacesLevelThree + "BMI:    " + mobBmi  + "\n\n"
												,subFont));
						
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("Hypertension")){

						String htnDate,htnDatesys,htnBpDia,htnBpSys = "";
						htnDate = request.getParameter("htnDate");
						htnDatesys = request.getParameter("htnDateSys");
						htnBpDia = request.getParameter("htnBpDia");
						htnBpSys = request.getParameter("htnBpSys");
					
						String[] hyperChkGrp;
						hyperChkGrp =  request.getParameterValues("htChkGrp");


						for (int j = 0; j < hyperChkGrp.length; j++){

							if(hyperChkGrp[j].equals("Hypertension: Elevated BP")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk("     \u2022  " + "Elevated Blood Pressure" + "\n\n", font));
								paragraph.add(new Chunk(spacesLevelThree + "Blood Pressure(systolic):  " + htnBpSys + " " + htnDatesys + "\n\n" +
														spacesLevelThree + "Blood Pressure(diastolic): " + htnBpDia + " " + htnDate + "\n\n"
														,subFont));
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							if(hyperChkGrp[j].equals("Hypertension: Hypertension")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk("     \u2022  " + "Hypertension" + "\n\n", font));
								paragraph.add(new Chunk(spacesLevelThree + "Blood Pressure(systolic):  " + htnBpSys + " " + htnDatesys + "\n\n" +
														spacesLevelThree + "Blood Pressure(diastolic): " + htnBpDia + " " + htnDate + "\n\n"
														,subFont));
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
						}
					}
					else if(mainGrp[i].equals("Shock")){

						String[] shockChkGrp = null;
						shockChkGrp =  request.getParameterValues("shockChkGrp");

						if(shockChkGrp != null) {
							paragraph = new Paragraph();
							paragraph.add(new Chunk("     \u2022  " + "Shock" + "\n\n",font));
							String shockDate,shockBP = "";

							cell = new PdfPCell(paragraph);
							cell.setBorderWidthBottom(0);
							cell.setBorderWidthTop(0);
							table.addCell(cell);
							
							shockDate = request.getParameter("shockDate");
							shockBP = request.getParameter("shockBp");

							for (int j = 0; j < shockChkGrp.length; j++){
								if(shockChkGrp[j].equals("Shock:Septic")){

									shockDate = request.getParameter("shockDate");
									shockBP = request.getParameter("shockBp");
									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "Septic" + "\n\n" ,fontSubHead));

									paragraph.add(new Chunk(spacesLevelThree + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n\n"  
															,subFont));
									cell = new PdfPCell(paragraph);
									cell.setBorderWidthBottom(0);
									cell.setBorderWidthTop(0);
									table.addCell(cell);
								}
								else if(shockChkGrp[j].equals("Shock:Hypovolemic")){

									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "Hypovolemic" + "\n\n" ,fontSubHead));
									paragraph.add(new Chunk(spacesLevelThree + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n\n"  
															,subFont));
									cell = new PdfPCell(paragraph);
									cell.setBorderWidthBottom(0);
									cell.setBorderWidthTop(0);
									table.addCell(cell);
								}
								else if(shockChkGrp[j].equals("Shock:Obstructive")){

									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "Obstructive" + "\n\n" ,fontSubHead));
									paragraph.add(new Chunk(spacesLevelThree + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n\n"  
															,subFont));
									cell = new PdfPCell(paragraph);
									cell.setBorderWidthBottom(0);
									cell.setBorderWidthTop(0);
									table.addCell(cell);
								}
								else if(shockChkGrp[j].equals("Shock:NOS")){


									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "NOS" + "\n\n" ,fontSubHead));
									paragraph.add(new Chunk(spacesLevelThree + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n\n"  
															,subFont));
									cell = new PdfPCell(paragraph);
									cell.setBorderWidthBottom(0);
									cell.setBorderWidthTop(0);
									table.addCell(cell);
								}					
							}
						}
					}
					else if(mainGrp[i].equals("Cardiogenic Shock")){

						String[] cshockChkGrp = null;
						cshockChkGrp =  request.getParameterValues("cshockChkGrp");
						if(cshockChkGrp != null) {

							paragraph = new Paragraph();
							paragraph.add(new Chunk("     \u2022  " + "Cardiogenic Shock" + "\n\n",font));
							String cshockDate,cshockBP, cDateShockTrop, cShockTrop = "";
							cshockDate = request.getParameter("cShockDate");
							cshockBP = request.getParameter("cShockBP");
							cDateShockTrop = request.getParameter("cDateShockTrop");
							cShockTrop = request.getParameter("cShockTrop");

							cell = new PdfPCell(paragraph);
							cell.setBorderWidthBottom(0);
							cell.setBorderWidthTop(0);
							table.addCell(cell);
							
							for (int j = 0; j < cshockChkGrp.length; j++){
								if(cshockChkGrp[j].equals("Cardiogenic Shock:Cardiogenic Shock")){


									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "Cardiogenic Shock" + "\n\n",fontSubHead));

									paragraph.add(new Chunk(spacesLevelThree + "Systolic Blood Pressure: " + cshockBP + " " + cshockDate +  "\n\n" +
															spacesLevelThree + "Cardiac Troponin Date:   " + cShockTrop + " " + cDateShockTrop +  "\n\n"
															,subFont));

									cell = new PdfPCell(paragraph);
									cell.setBorderWidthBottom(0);
									cell.setBorderWidthTop(0);
									table.addCell(cell);
								}
								else if(cshockChkGrp[j].equals("Cardiogenic Shock:Septic")){

									paragraph = new Paragraph();
									paragraph.add(new Chunk("          " + "Shock : Septic" + "\n\n",fontSubHead));

									paragraph.add(new Chunk("                  Systolic BP Date: " + cshockDate +
											"        Systolic Blood Pressure: " + cshockBP + "\n\n"  ,subFont));

									cell = new PdfPCell(paragraph);
									cell.setBorderWidthBottom(0);
									cell.setBorderWidthTop(0);
									table.addCell(cell);
								}
								else if(cshockChkGrp[j].equals("Cardiogenic Shock:Hypovolemic")){


									paragraph = new Paragraph();
									paragraph.add(new Chunk("          " + "Shock : Hypovolemic" + "\n\n",fontSubHead));

									paragraph.add(new Chunk("                  Systolic BP Date: " + cshockDate +
											"        Systolic Blood Pressure: " + cshockBP + "\n\n"  ,subFont));

									cell = new PdfPCell(paragraph);
									cell.setBorderWidthBottom(0);
									cell.setBorderWidthTop(0);
									table.addCell(cell);
								}
								else if(cshockChkGrp[j].equals("Cardiogenic Shock:Obstructive")){


									paragraph = new Paragraph();
									paragraph.add(new Chunk("          " + "Shock : Obstructive" + "\n\n",fontSubHead));

									paragraph.add(new Chunk("                  Systolic BP Date: " + cshockDate +
											"        Systolic Blood Pressure: " + cshockBP + "\n\n"  ,subFont));

									cell = new PdfPCell(paragraph);
									cell.setBorderWidthBottom(0);
									cell.setBorderWidthTop(0);
									table.addCell(cell);
								}
								else if(cshockChkGrp[j].equals("Cardiogenic Shock:NOS")){

									paragraph = new Paragraph();
									paragraph.add(new Chunk("          " + "Shock : NOS" + "\n\n",fontSubHead));

									paragraph.add(new Chunk("                  Systolic BP Date: " + cshockDate +
											"        Systolic Blood Pressure: " + cshockBP + "\n\n"  ,subFont));

									cell = new PdfPCell(paragraph);
									cell.setBorderWidthBottom(0);
									cell.setBorderWidthTop(0);
									table.addCell(cell);
								}	

							}
						}
					}
					else if(mainGrp[i].equals("Uti")){

						String[] utichckgrp;
						utichckgrp =  request.getParameterValues("catheterAssoc");
						
						String utiDate,utiWbc,utiUle,utiUln,utiUlndate,utiUledate = "";
						paragraph = new Paragraph();
						utiDate = request.getParameter("utiDate");
						utiWbc = request.getParameter("utiWbc");
						utiUle = request.getParameter("utiUle");
						utiUledate = request.getParameter("utiUledate");
						utiUln = request.getParameter("utiUln");
						utiUlndate = request.getParameter("utiUlndate");
						
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						if(utiWbc.isEmpty()!=true){
						paragraph.add(new Chunk(spacesLevelThree + "WBC count:                      " + utiWbc + " " + utiDate + "\n\n",subFont));
						}
						if(utiUle.isEmpty()!=true){
							paragraph.add(new Chunk(spacesLevelThree + "Urinalysis, Leukocyte Esterase: " + utiUle + " " + utiUledate + "\n\n",subFont));
						}
						if(utiUln.isEmpty()!=true){
							paragraph.add(new Chunk(spacesLevelThree + "Urinalysis,  Nitrite:           " + utiUln + " " + utiUlndate +"\n\n",subFont));
						}

						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
						
						if(utichckgrp != null){
							System.out.println("UTI CHECKGROUPLENTH:" + utichckgrp.length);
							for (int j = 0; j < utichckgrp.length; j++){
								if(utichckgrp[j].equals("Catherter Associated")){

									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "Catherter Associated" + "\n\n",fontSubHead));
									cell = new PdfPCell(paragraph);
									cell.setBorderWidthBottom(0);
									cell.setBorderWidthTop(0);
									table.addCell(cell);
								}
							}
						}
						else{
							System.out.println("Catherter not selected");
						}
					}
					else if(mainGrp[i].equals("Respiratory Failure :")){

						String[] respFailChkGrp;
						respFailChkGrp =  request.getParameterValues("respFailChkGrp");

						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));

						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
						
						for (int j = 0; j < respFailChkGrp.length; j++){

							if(respFailChkGrp[j].equals("Respiratory Failure :Acute")){

								String respPo2Date,respPo,respO2satDate, respO2sat = "";
								paragraph = new Paragraph();
								respPo2Date = request.getParameter("respPo2Date");
								respPo = request.getParameter("respPo");
								respO2satDate = request.getParameter("respO2satDate");
								respO2sat = request.getParameter("respO2sat");
								
								paragraph.add(new Chunk(spacesLevelTwo + "Acute" + "\n\n",fontSubHead));
								if(respPo.isEmpty()!=true){
								paragraph.add(new Chunk(spacesLevelThree + "PO2:            " + respPo + " " + respPo2Date + "\n\n",subFont));
								}
								if(respO2sat.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Pulse Oximetry: " + respO2sat + " " + respO2satDate + "\n\n",subFont));
								}
								
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);

							}
							else if(respFailChkGrp[j].equals("Respiratory Failure :Chronic")){

								paragraph = new Paragraph();

								String respPco2Date = request.getParameter("respPco2Date");
								String respPco2 = request.getParameter("respPco2");
								String respEtco2Date = request.getParameter("respEtco2Date");
								String respEtco2 = request.getParameter("respEtco2");
								String respPrevPco2Date = request.getParameter("respPrevPco2Date");
								String respPrevPco2 = request.getParameter("respPrevPco2");
								String respPrevEtco2Date = request.getParameter("respPrevEtco2Date");
								String respPrevEtco2 = request.getParameter("respPrevEtco2");

								paragraph.add(new Chunk("          " + "Chronic" + "\n\n",fontSubHead));
								
								if(respPco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "PCO2:           " + respPco2 + " " + respPco2Date + "\n\n",subFont));
								}
								if(respPrevPco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Previous PCO2:  " + respPrevPco2 + " " + respPrevPco2Date + "\n\n",subFont));
								}
								if(respEtco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "EtcO2:          " + respEtco2 + " " + respEtco2Date + "\n\n",subFont));
								}
								if(respPrevEtco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Previous EtcO2: " + respPrevEtco2 + " " + respPrevEtco2Date + "\n\n",subFont));
								}

								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(respFailChkGrp[j].equals("Respiratory Failure :Acute on Chronic")){

								String respPco2Date = request.getParameter("respPco2Date");
								String respPco2 = request.getParameter("respPco2");
								String respEtco2Date = request.getParameter("respEtco2Date");
								String respEtco2 = request.getParameter("respEtco2");
								String respPrevPco2Date = request.getParameter("respPrevPco2Date");
								String respPrevPco2 = request.getParameter("respPrevPco2");
								String respPrevEtco2Date = request.getParameter("respPrevEtco2Date");
								String respPrevEtco2 = request.getParameter("respPrevEtco2");
								String respPo2Date,respPo,respO2satDate, respO2sat = "";
								paragraph = new Paragraph();
								respPo2Date = request.getParameter("respPo2Date");
								respPo = request.getParameter("respPo");
								respO2satDate = request.getParameter("respO2satDate");
								respO2sat = request.getParameter("respO2sat");

								paragraph.add(new Chunk("          " + "Acute on Chronic" + "\n\n",fontSubHead));
								
								
								if(respPo.isEmpty()!=true){
								paragraph.add(new Chunk(spacesLevelThree + "PO2:                " + respPo + " " + respPo2Date + "\n\n",subFont));
								}
								if(respO2sat.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Pulse Oximetry: " + respO2sat + " " + respO2satDate + "\n\n",subFont));
								}
								if(respPco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "PCO2:           " + respPco2 + " " + respPco2Date + "\n\n",subFont));
								}
								if(respPrevPco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Previous PCO2:  " + respPrevPco2 + " " + respPrevPco2Date + "\n\n",subFont));
								}
								if(respEtco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "EtcO2:          " + respEtco2 + " " + respEtco2Date + "\n\n",subFont));
								}
								if(respPrevEtco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Previous EtcO2: " + respPrevEtco2 + " " + respPrevEtco2Date + "\n\n",subFont));
								}

								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}
							else if(respFailChkGrp[j].equals("Respiratory Failure :NOS")){

								String respPo2Date,respPo,respO2satDate, respO2sat = "";
								
								paragraph = new Paragraph();
								respPo2Date = request.getParameter("respPo2Date");
								respPo = request.getParameter("respPo");
								respO2satDate = request.getParameter("respO2satDate");
								respO2sat = request.getParameter("respO2sat");
								
								paragraph.add(new Chunk(spacesLevelTwo + "Not Otherwise Specified" + "\n\n",fontSubHead));
								if(respPo.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "PO2:            " + respPo + " " + respPo2Date + "\n\n",subFont));
								}
								if(respO2sat.isEmpty()!=true){
										paragraph.add(new Chunk(spacesLevelThree + "Pulse Oximetry: " + respO2sat + " " + respO2satDate + "\n\n",subFont));
								}
								
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}

						}
					}
					else if(mainGrp[i].equals("Sepsis")){

						String sepDate,maxsepHr,minsepHr,sepRr,sepMaxWbc,sepMinWbc,sepSysBP,maxsepTem, minsepTem,sepLac, 
						maxsepHrDate, minsepHrDate, sepRrDate,sepMaxWbcDate,sepMinWbcDate,sepSysBPDate,maxsepTemDate, 
						minsepTemDate,sepLacDate,sepLacHigh = "";
						
						paragraph = new Paragraph();
						
						maxsepHr = request.getParameter("maxsepHr");
						minsepHr = request.getParameter("minsepHr");
						sepRr = request.getParameter("sepRr");
						sepMaxWbc = request.getParameter("maxsepWbc");
						sepMinWbc = request.getParameter("minsepWbc");
						sepSysBP = request.getParameter("sepSysBP");
						maxsepTem = request.getParameter("maxsepTem");
						minsepTem = request.getParameter("minsepTem");
						sepLac = request.getParameter("sepLac");
						maxsepHrDate = request.getParameter("maxsepHrDate");
						minsepHrDate = request.getParameter("minsepHrDate");
						sepRrDate = request.getParameter("sepRrDate");
						sepMaxWbcDate = request.getParameter("maxsepWbcDate");
						sepMinWbcDate = request.getParameter("minsepWbcDate");
						sepSysBPDate = request.getParameter("sepSysBPDate");
						maxsepTemDate = request.getParameter("maxsepTemDate");
						minsepTemDate = request.getParameter("minsepTemDate");
						sepLacDate = request.getParameter("sepLacDate");
						sepLacHigh = request.getParameter("sepLacHigh");

						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						
						if(maxsepHr.isEmpty() != true && Double.parseDouble(maxsepHr) > 100.0){
							paragraph.add(new Chunk(spacesLevelThree + "Heart Rate (Maximum):  " + maxsepHr + 
													" "+ maxsepHrDate + "\n\n",subFont));
						}
						if( minsepHr.isEmpty() != true && Double.parseDouble(minsepHr) < 40.0){
							paragraph.add(new Chunk(spacesLevelThree + "Heart Rate (Minimum):  " + minsepHr + 
													" "+ minsepHrDate+ "\n\n",subFont));
						}
						if(sepRr.isEmpty() != true && Double.parseDouble(sepRr) > 26.0){
							paragraph.add(new Chunk(spacesLevelThree + "Respiratory Rate:      " + sepRr + " "+ sepRrDate + "\n\n",subFont));
						}
						if(sepMaxWbc.isEmpty() != true && Double.parseDouble(sepMaxWbc) > 12000.0){
							paragraph.add(new Chunk(spacesLevelThree + "WBC count (Maximum):   " + sepMaxWbc + 
													" "+ sepMaxWbcDate + "\n\n", subFont));
						}
						if(sepMinWbc.isEmpty() != true && Double.parseDouble(sepMinWbc) < 4000.0){
							paragraph.add(new Chunk(spacesLevelThree + "WBC count (Minimum):   " + sepMinWbc + 
													" "+ sepMinWbcDate + "\n\n", subFont));
						}
						if(sepSysBP.isEmpty() != true && Double.parseDouble(sepSysBP) <= 90.0){
							paragraph.add(new Chunk(spacesLevelThree + "Systolic BP:           " + sepSysBP + 
													" "+ sepSysBPDate + "\n\n", subFont));
						}
						if(maxsepTem.isEmpty() != true && Double.parseDouble(maxsepTem) >= 38.88){
							paragraph.add(new Chunk(spacesLevelThree + "Temperature (Maximum): " + maxsepTem + 
													" "+ maxsepTemDate + "\n\n" ,subFont));
						}
						if(minsepTem.isEmpty() != true &&  Double.parseDouble(minsepTem) < 36){
							paragraph.add(new Chunk(spacesLevelThree + "Temperature (Minimum): " + minsepTem + 
													" "+ minsepTemDate + "\n\n" ,subFont));
						}
						if( sepLac.isEmpty() != true && Double.parseDouble(sepLac) > Double.parseDouble(sepLacHigh)){
							paragraph.add(new Chunk(spacesLevelThree + "Lactate:               " + sepLac + " "+ sepLacDate + "\n\n" ,subFont));
						} 
																																		
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("Acute Pulmonary Edema")){

						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));

						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);

					}

					else if(mainGrp[i].equals("Anoxic Brain Injury")){

						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));


						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);

					}						
					else if(mainGrp[i].equals("Coma")){

						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));

						String comaDate,comaValue1,comaValue2 = "";


						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);

					}

					else if(mainGrp[i].equals("Decubitis Ulcer")){

						String[] duChkgrp;
						String ipDuSite = "";
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n",font));
						duChkgrp = request.getParameterValues("duChkgrp");
						if(duChkgrp == null){

						}
						else{
							for (int j = 0; j < duChkgrp.length; j++){
								paragraph.add(new Chunk("\n                    \u2022  " + duChkgrp[j] + "\n",fontSubHead));
							}
						}
						paragraph.add(new Chunk("\n"));

						if((request.getParameter("ipDuSite")) != ""){
							ipDuSite = request.getParameter("ipDuSite"); 
							paragraph.add(new Chunk("                    Site: " + ipDuSite + "\n\n",fontSubHead));
						}
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}

					else if(mainGrp[i].equals("Delirium")){

						String[] delichkgrp;
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n",font));
						delichkgrp = request.getParameterValues("delichkgrp");
						if(delichkgrp == null){

						}
						else{
							for (int j = 0; j < delichkgrp.length; j++){
								paragraph.add(new Chunk("\n                    \u2022  " + delichkgrp[j] + "\n",fontSubHead));
							}
						}
						paragraph.add(new Chunk("\n\n"));
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}						
					else if(mainGrp[i].equals("Encephalopathy")){

						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));


						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);

					}
					else if(mainGrp[i].equals("Pleural Effusion")){

						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));


						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}

					else if(mainGrp[i].equals("Pneumonia")){

						String[] pneuchkgrp;
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));
						pneuchkgrp = request.getParameterValues("pneuchkgrp");
						if(pneuchkgrp == null){

						}
						else{
							for (int j = 0; j < pneuchkgrp.length; j++){
								paragraph.add(new Chunk("\n                    \u2022  " + pneuchkgrp[j] + "\n",fontSubHead));
							}
						}


						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}

					else if(mainGrp[i].equals("PSVT")){

						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));


						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("Seizure")){

						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));


						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("SepsisOther")){

						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + "Sepsis for reasons listed below" + "\n\n",font));
						
						String SepsisOtherComments = "";
						SepsisOtherComments = request.getParameter("sepsisOtherComments");
						paragraph.add(new Chunk(spacesLevelThree + "Reasons: " + SepsisOtherComments + "\n\n" ,subFont));
						
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("SepsisOther")){

						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + "Sepsis for reasons listed below" + "\n\n",font));
						
						String SepsisOtherComments = "";
						SepsisOtherComments = request.getParameter("sepsisOtherComments");
						paragraph.add(new Chunk(spacesLevelThree + "Reasons: " + SepsisOtherComments + "\n\n" ,subFont));
						
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);
						table.addCell(cell);
					}
					else if(mainGrp[i].equals("comments")){
						String comments = "";
						comments = request.getParameter("commentsid");
						//String newcomments = comments.replace("/\n\r?/g", ",");
						String newcomments = comments.replace(",", "\n\r                   ");
						
						if(comments.isEmpty() != true || comments != null){
							paragraph = new Paragraph();
							paragraph.add(new Chunk("\n     \u2022  " + "Other Comorbidities: " + "\n\n",font));
							
							paragraph.add(new Chunk(spacesLevelThree + newcomments + "\n\n" ,subFont));
							
							cell = new PdfPCell(paragraph);
							cell.setBorderWidthBottom(0);
							cell.setBorderWidthTop(0);
							table.addCell(cell);
						}
					}
				}
			}
										
			paragraph = new Paragraph("\n");
			cell = new PdfPCell(paragraph);
			cell.setBorderWidthBottom(0);
			cell.setBorderWidthTop(0);
			table.addCell(cell);

			DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy h:mm a");
			Date date = new Date();
			String Date = dateFormat.format(date);

			font = FontFactory.getFont("Times-Roman",14, Font.BOLD);

			paragraph = new Paragraph();
			paragraph.add(new Chunk("Physician Name:  _________________________"+ "  " + "ID #:  _________________________" + 
					"\n\n" +
					"Physician Signature:   _______________________" + "  ",font));

			paragraph.add(new Chunk("Date: ",font));
			paragraph.add(new Chunk(Date.substring(0,10) + "  ",FontFactory.getFont("Times-Roman",14)));
			paragraph.add(new Chunk("Time: ",font));
			paragraph.add(new Chunk(Date.substring(11) + "\n\n",FontFactory.getFont("Times-Roman",14)));

			cell = new PdfPCell(paragraph);
			cell.setPaddingLeft(10);
			cell.setBorderWidthBottom(0);
			cell.setBorderWidthTop(0);
			table.addCell(cell);


			paragraph = new Paragraph("\n");
			cell = new PdfPCell(paragraph);
			cell.setBorderWidthTop(0);
			table.addCell(cell);

			table.setWidthPercentage(100);
			document.add(table);


			document.close();


		}
		catch (DocumentException e) {
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);

	}

}
*/



package comorb;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/*import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
*/
import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.*;
import com.lowagie.text.exceptions.InvalidPdfException;

public class Print extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final long maxLinesInPage = 20;
	public long setPageTemplate(long currentLine, Document document, Image To_be_Added){
		 
		if(currentLine >= maxLinesInPage){
			System.out.println(currentLine);
			Font font = FontFactory.getFont("Times-Roman",14, Font.BOLD);
			try {
				PdfPTable table = new PdfPTable(1);
				PdfPCell cell = new PdfPCell();

				Paragraph paragraph = new Paragraph("\n");
				cell = new PdfPCell(paragraph);
				cell.setBorderWidthBottom(0);
				cell.setBorderWidthRight(0);
				cell.setBorderWidthLeft(0);
				table.addCell(cell);
				table.setWidthPercentage(100);
				document.add(table);

				document.newPage();
				document.add(To_be_Added);
				document.add(new Paragraph("\n"));
				
				paragraph = new Paragraph("  CO-MORBIDITIES",font);
				document.add(paragraph);

				document.add(new Paragraph("\n"));
				document.add(table);
				
            	currentLine = 0;
			} catch (DocumentException e) {
				
				e.printStackTrace();
			}
			
		}
		else{
			
		}
		return currentLine;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Document document = new Document();
		long currentLine = 0;
		try {
			String[] mainGrp;
			String[] timer;
			String toPrint = "";
			response.setContentType("application/pdf");    			
			PdfWriter.getInstance(document, response.getOutputStream());
			Font font = FontFactory.getFont("Times-Roman",14, Font.BOLD);
			Font fontSubHead = FontFactory.getFont("Courier",10, Font.BOLD);
			Font subFont = FontFactory.getFont("Courier" ,8);


			document.open();
			
			String relativeWebPath = "barcode.bmp";
			String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
			
			Image To_be_Added = Image.getInstance(absoluteDiskPath);    			
			To_be_Added.setAlignment(Image.MIDDLE);
			To_be_Added.setBorder(Image.BOX);
			To_be_Added.scalePercent(50);
			timer = request.getParameterValues("clock");

			Paragraph paragraph1 = new Paragraph("  " + timer[0],subFont);
			//Font font = FontFactory.getFont("Times-Roman",14, Font.BOLD);
			//Font fontSubHead = FontFactory.getFont("Courier",10, Font.BOLD);
			//Font subFont = FontFactory.getFont("Courier" ,8);
            document.add(paragraph1);
			
			document.add(To_be_Added);    	        
			document.add(new Paragraph("\n"));


			Paragraph paragraph = new Paragraph();
			
			paragraph = new Paragraph("  CO-MORBIDITIES",font);
			//paragraph.add(new Chunk("                                            " + timer[0])); //+ "\n\n",subFont));
			document.add(paragraph);


			document.add(new Paragraph("\n"));

			PdfPTable table = new PdfPTable(1);
			PdfPCell cell = new PdfPCell();

			paragraph = new Paragraph("\n");
			cell = new PdfPCell(paragraph);
			cell.setBorderWidthBottom(0);
			cell.setBorderWidthRight(0);
			cell.setBorderWidthLeft(0);
			table.addCell(cell);
			table.setWidthPercentage(100);
			document.add(table);
			
			font = FontFactory.getFont("Times-Roman",14, Font.BOLD);
			mainGrp = request.getParameterValues("mainGrp");
			
			String spacesLevelTwo = "          ";
			String spacesLevelThree = "                    ";

			if(mainGrp == null)
			{
				toPrint = "Error";
				document.add(new Paragraph("     " + toPrint,font));
			}
			else
			{ 
				for (int i = 0; i < mainGrp.length; i++) 
				{
					if(mainGrp[i].equals("Anemia :")){

						String[] anemiaChkGrp;
						anemiaChkGrp =  request.getParameterValues("anemiaChkGrp");

						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
						String chHgloDate,chHglo,preChHglo,chHcrit,preChHcrit,chHcritDate,preChHgloDate,preChHcritDate,norHBLow,norHCLow;
						String result;

						chHgloDate = request.getParameter("AnHgloDate");
						chHglo = request.getParameter("AnHglo");

						preChHgloDate = request.getParameter("preAnHgloDate");
						preChHglo = request.getParameter("preAnHglo");

						chHcritDate = request.getParameter("AnHcritDate");
						chHcrit = request.getParameter("AnHcrit");

						preChHcritDate = request.getParameter("preAnHcritDate");
						preChHcrit = request.getParameter("preAnHcrit");
						
						norHCLow = request.getParameter("normalHCLow");
						norHBLow = request.getParameter("normalHBLow");
						
						result = request.getParameter("result");
						
						for (int j = 0; j < anemiaChkGrp.length; j++){

							if(anemiaChkGrp[j].equals("Acute blood loss")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Acute" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								//if(result.isEmpty() != true && result.equalsIgnoreCase("1"))
								{
									if(chHglo.isEmpty() != true /*&& (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow))*/)
									{

										paragraph.add(new Chunk(spacesLevelThree + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n\n",subFont));
										currentLine = currentLine + 1;
									}
									
									if(preChHglo.isEmpty() != true /*&& (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow))*/)
									{
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n\n",subFont));
										currentLine = currentLine + 1;
									}
									
									if(chHcrit.isEmpty() != true /*&& (Double.parseDouble(chHcrit) < Double.parseDouble(norHCLow))*/)
									{

										paragraph.add(new Chunk(spacesLevelThree + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n\n",subFont));
										currentLine = currentLine + 1;

									}
									
									if(preChHcrit.isEmpty() != true /*&& (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow))*/)
									{
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n\n",subFont));
										currentLine = currentLine + 1;
									}
								}
								
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(anemiaChkGrp[j].equals("Anemia: Chronic Disease")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Chronic" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;

								//if(result.isEmpty() != true && result.equalsIgnoreCase("3"))
								{	
									if(chHglo.isEmpty() != true /*&& (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow)) && */
											/*preChHglo.isEmpty() != true*/ /*&& (Double.parseDouble(preChHglo) < Double.parseDouble(norHBLow))*/)
									{
										paragraph.add(new Chunk(spacesLevelThree + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n\n",subFont));
										currentLine = currentLine + 1;
										//paragraph.add(new Chunk(spacesLevelThree + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n\n",subFont));
									}
									
									if(preChHglo.isEmpty() != true /*&& (Double.parseDouble(preChHglo) < Double.parseDouble(norHBLow))*/)
									{
										//paragraph.add(new Chunk(spacesLevelThree + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n\n",subFont));
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n\n",subFont));
										currentLine = currentLine + 1;
									}
									
									if(chHcrit.isEmpty() != true /*&& (Double.parseDouble(chHcrit) < Double.parseDouble(norHCLow)) &&*/
											/*preChHcrit.isEmpty() != true*/ /*&& (Double.parseDouble(preChHcrit) < Double.parseDouble(norHCLow))*/)
									{
										paragraph.add(new Chunk(spacesLevelThree + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n\n",subFont));
										currentLine = currentLine + 1;
										//paragraph.add(new Chunk(spacesLevelThree + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n\n",subFont));
									}
									if(preChHcrit.isEmpty() != true /*&& (Double.parseDouble(preChHcrit) < Double.parseDouble(norHCLow))*/)
									{
										//paragraph.add(new Chunk(spacesLevelThree + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n\n",subFont));
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n\n",subFont));
										currentLine = currentLine + 1;
									}
								}
								
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							} 
							else if(anemiaChkGrp[j].equals("Anemia: NOS")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Not otherwise specified" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;

								//if(result.isEmpty() != true && result.equalsIgnoreCase("2"))
								{
									if(chHglo.isEmpty() != true /*&& (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow)) && preChHglo.isEmpty() == true*/)
									{
										paragraph.add(new Chunk(spacesLevelThree + "Hemoglobin:          " + chHglo + " " + chHgloDate + "\n\n",subFont));
										currentLine = currentLine + 1;
									}
									
									/*if(preChHglo.isEmpty() != true && (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow)))
									{
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hemoglobin: " + preChHglo + " " + preChHgloDate + "\n\n",subFont));
									}*/
									
									if(chHcrit.isEmpty() != true /*&& (Double.parseDouble(chHcrit) < Double.parseDouble(norHCLow))*/)
									{
										paragraph.add(new Chunk(spacesLevelThree + "Hematocrit:          " + chHcrit + " " + chHcritDate + "\n\n",subFont));
										currentLine = currentLine + 1;
									}
									
									/*if(preChHcrit.isEmpty() != true && (Double.parseDouble(chHglo) < Double.parseDouble(norHBLow)))
									{
										paragraph.add(new Chunk(spacesLevelThree + "Previous Hematocrit: " + preChHcrit + " " + preChHcritDate + "\n\n",subFont));
									}*/
								}
								
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(anemiaChkGrp[j].equals("Anemia: Blood Loss")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Due to Blood Loss" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
						}
					}

					else if(mainGrp[i].equals("Acute Kidney Injury")){

						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
						
						String[] renFailChkGrp = request.getParameterValues("akiChkGrp");
						String CreatDate, Creat, PrevCreat, PrevCreatDate;
						CreatDate = request.getParameter("CreatDate");
						Creat = request.getParameter("Creat");
						PrevCreat = request.getParameter("CreatPrev"); 
						PrevCreatDate = request.getParameter("CreatPrevDate");
						
						for (int j = 0; j < renFailChkGrp.length; j++){
							if(renFailChkGrp[j].equalsIgnoreCase("Acute Kidney Injury :Acute")) {
								
								/*String rfaDate,rfaCreat, rfaPrevCreat, rfaPrevCreatDate;
								rfaDate = request.getParameter("AcrfaCreatDate");
								rfaCreat = request.getParameter("AcrfaCreat");
								rfaPrevCreat = request.getParameter("AcrfaCreatPrev"); 
								rfaPrevCreatDate = request.getParameter("AcrfaCreatPrevDate");*/
								
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Acute" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								
								if(CreatDate!=null && Creat!=null && PrevCreat!=null && PrevCreatDate!=null){
								
									if(PrevCreat.equalsIgnoreCase("-99999.0")!=true && PrevCreat.equalsIgnoreCase("99999.0")!=true){
									
										paragraph.add(new Chunk(spacesLevelThree + "Creatinine:          " + Creat + " " + CreatDate + "\n\n",subFont));
										paragraph.add(new Chunk(spacesLevelThree + "Previous Creatinine: " + PrevCreat + " " + PrevCreatDate + "\n\n",subFont));													      
										currentLine = currentLine + 2;
									}
									else{
										paragraph.add(new Chunk(spacesLevelThree + "Creatinine:          " + Creat + " " + CreatDate + "\n\n" ,subFont));
										currentLine = currentLine + 1;
									}
								}
								
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(renFailChkGrp[j].equalsIgnoreCase("Acute Kidney Injury :NOS")) {
								/*String rfaDate,rfaCreat;
								rfaDate = request.getParameter("ChrfaCreatDate");
								rfaCreat = request.getParameter("ChrfaCreat");*/
								
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Not Otherwise Specified" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								if(CreatDate!=null && Creat!=null){
								
									paragraph.add(new Chunk(spacesLevelThree + "Creatinine: " + Creat + " " + CreatDate + "\n\n"
														, subFont));
									currentLine = currentLine + 1;
								}
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(renFailChkGrp[j].equalsIgnoreCase("Chronic Kidney Disease :Chronic")){
								
								/*String rfaDate,rfaCreat, rfaPrevCreat, rfaPrevCreatDate;
								rfaDate = request.getParameter("rfcCreatDate");
								rfaCreat = request.getParameter("rfcCreat");
								rfaPrevCreat = request.getParameter("rfcCreatPrev"); 
								rfaPrevCreatDate = request.getParameter("rfcCreatPrevDate");*/
								
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Chronic" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								
								if(CreatDate!=null && Creat!=null && PrevCreat!=null && PrevCreatDate!=null){
									
									if(PrevCreat.equalsIgnoreCase("-99999.0")!=true && PrevCreat.equalsIgnoreCase("99999.0")!=true){
								
										paragraph.add(new Chunk(spacesLevelThree + "Creatinine:          " + Creat + " " + CreatDate + "\n\n",subFont));
										paragraph.add(new Chunk(spacesLevelThree + "Previous Creatinine: " + PrevCreat + " " + PrevCreatDate + "\n\n",subFont));
										currentLine = currentLine + 2;
									}
									else{
										paragraph.add(new Chunk(spacesLevelThree + "Creatinine:          " + Creat + " " + CreatDate + "\n\n" ,subFont));
										currentLine = currentLine + 1;
									}
								}
								
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
						}
					}

					else if(mainGrp[i].equals("Chronic Kidney Disease")){

						String[] renFailChkGrp;
						renFailChkGrp =  request.getParameterValues("ckdChkGrp");

						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
						
						for (int j = 0; j < renFailChkGrp.length; j++){

							String rfcPrevCreatDate, rfcPrevCreat, rfcDate,rfcCreat,rfcMaxGfr,rfcMaxGfrDate,rfcMinGfr,rfcMinGfrDate;							
							rfcDate = request.getParameter("rfcDate");
							rfcCreat = request.getParameter("rfcCreat");
							rfcPrevCreatDate = request.getParameter("rfcprevDate");
							rfcPrevCreat = request.getParameter("rfcprevCreat");
							rfcMaxGfr = request.getParameter("rfcMaxGfr");
							rfcMaxGfrDate = request.getParameter("rfcMaxGfrDate");
							rfcMinGfr = request.getParameter("rfcMinGfr");
							rfcMinGfrDate = request.getParameter("rfcMinGfrDate");
							
							if(renFailChkGrp[j].equals("Chronic Kidney Disease :NOS")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Not Otherwise Specified" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Creatinine: " + rfcCreat + " " + rfcDate + "\n\n",subFont));
								paragraph.add(new Chunk(spacesLevelThree + "Max GFR: " + rfcMaxGfr + " " + rfcMaxGfrDate + "\n\n",subFont));
								paragraph.add(new Chunk(spacesLevelThree + "Min GFR: " + rfcMinGfr + " " + rfcMinGfrDate + "\n\n",subFont));
								currentLine = currentLine + 3;

								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							if(renFailChkGrp[j].equals("Chronic Kidney Disease :Chronic")){
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Chronic" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Creatinine: " + rfcCreat + " " + rfcDate + "\n\n", subFont));
								paragraph.add(new Chunk(spacesLevelThree + "Previous Creatinine: " + rfcPrevCreat + " " + rfcPrevCreatDate + "\n\n", subFont));
								paragraph.add(new Chunk(spacesLevelThree + "Max GFR: " + rfcMaxGfr + " " + rfcMaxGfrDate + "\n\n", subFont));
								paragraph.add(new Chunk(spacesLevelThree + "Min GFR: " + rfcMinGfr + " " + rfcMinGfrDate + "\n\n", subFont));
								currentLine = currentLine + 4;
								
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
						}
					}
					else if(mainGrp[i].equals("ElevatedBloodGlucose")){
						
						String[] EbgChkGrp;
						EbgChkGrp =  request.getParameterValues("EbgChkGrp");
						
						String glucDate,glucResult = "";
						glucDate = request.getParameter("glucDate");
						glucResult = request.getParameter("glucResult");
						
						for (int j = 0; j < EbgChkGrp.length; j++){
							paragraph = new Paragraph();
							paragraph.add(new Chunk("     \u2022  " + EbgChkGrp[j] + "\n\n",font));
							currentLine = currentLine + 1;
							paragraph.add(new Chunk(spacesLevelThree + "Glucose: " + glucResult + " " + glucDate + "\n\n" ,
													subFont));
							currentLine = currentLine + 1;
							
							currentLine = setPageTemplate(currentLine, document, To_be_Added);
							document.add(paragraph);
						}
					}
					else if(mainGrp[i].equals("Hypoglycemia")){

						String glucDate,glucResult = "";
						glucDate = request.getParameter("hypoglucDate");
						//glucResult = request.getParameter("hypoglucResult");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						paragraph.add(new Chunk(spacesLevelThree + "Glucose: " + glucResult + " " + glucDate + "\n\n" 
								 				,subFont));
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("Hypoxia")){

						String oximetryDate,oximetryResult = "";
						oximetryDate = request.getParameter("oximetryDate");
						oximetryResult = request.getParameter("oximetryResult");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						
						paragraph.add(new Chunk(spacesLevelThree + "Pulse Oximetry: " + oximetryResult + " " + oximetryDate + "\n\n" 
								 				,subFont));
						currentLine = currentLine + 1;
						
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("Granulocytopenia")){

						String minneutrophilDate,minneutrophilResult = "";
						minneutrophilDate = request.getParameter("neutrophilMinDate");
						minneutrophilResult = request.getParameter("neutrophilMinResult");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						paragraph.add(new Chunk(spacesLevelThree + "Neutrophil (Minimum): " + minneutrophilResult + " " + 
												minneutrophilDate + "\n\n" 
												,subFont));
						currentLine = currentLine + 1;
						
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("LacticAcidosis")){

						String lacticAcidDate,lacticAcidResult = "";
						lacticAcidDate = request.getParameter("lacticAcidDate");
						lacticAcidResult = request.getParameter("lacticAcidResult");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						paragraph.add(new Chunk(spacesLevelThree + "Lactic Acid: " + lacticAcidResult + " " + lacticAcidDate + "\n\n" 
												,subFont));
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("Electrolyte Abnormality")){

						String[] EaChkGrp;
						EaChkGrp =  request.getParameterValues("EaChkGrp");
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
						
						for (int j = 0; j < EaChkGrp.length; j++){

							if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypokalemia")){

								String hypokalDate,hypokalPot = "";
								hypokalDate = request.getParameter("hypokalDate");
								hypokalPot = request.getParameter("hypokalPot");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypokalemia" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Potassium: " + hypokalPot + " " + hypokalDate + "\n\n"  
										   				,subFont));
								currentLine = currentLine + 1;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyperkalemia")){

								String hyperkalDate,hyperkalPot = "";
								hyperkalDate = request.getParameter("hyperkalDate");
								hyperkalPot = request.getParameter("hyperkalPot");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hyperkalemia" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;

								paragraph.add(new Chunk(spacesLevelThree + "Potassium: " + hyperkalPot + " " + hyperkalDate + "\n\n"
														,subFont));
								currentLine = currentLine + 1;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyponatremia")){

								String hyponatDate,hyponatSod = "";
								hyponatDate = request.getParameter("hyponatDate");
								hyponatSod = request.getParameter("hyponatSod");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hyponatremia" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Sodium: " + hyponatSod + " " + hyponatDate + "\n\n" 
														,subFont));
								currentLine = currentLine + 1;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypernatremia")){

								String hypernatDate,hypernatSod = "";
								hypernatDate = request.getParameter("hypernatDate");
								hypernatSod = request.getParameter("hypernatSod");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypernatremia" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Sodium: " + hypernatSod + " " + hypernatDate + "\n\n"
														,subFont));
								currentLine = currentLine + 1;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypocalcemia")){

								String hypocalDate,hypocalCal = "";
								hypocalDate = request.getParameter("hypocalDate");
								hypocalCal = request.getParameter("hypocalCal");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypocalcemia" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Calcium: " + hypocalCal + " " + hypocalDate + "\n\n"  
														,subFont));
								currentLine = currentLine + 1;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypercalcemia")){

								String hypercalDate,hypercalCal = "";
								hypercalDate = request.getParameter("hypercalDate");
								hypercalCal = request.getParameter("hypercalCal");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypercalcemia" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Calcium: " + hypercalCal + " " + hypercalDate + "\n\n" 
														,subFont));
								currentLine = currentLine + 1;
								
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypophosphatemia")){

								String hypophosDate,hypophosPhos = "";
								hypophosDate = request.getParameter("hypophosDate");
								hypophosPhos = request.getParameter("hypophosPhos");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypophosphatemia" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Phosphorus: " + hypophosPhos + " " + hypophosDate + "\n\n"  
														,subFont));
								currentLine = currentLine + 1;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hyperphosphatemia")){

								String hyperphosDate,hyperphosPhos = "";
								hyperphosDate = request.getParameter("hyperphosDate");
								hyperphosPhos = request.getParameter("hyperphosPhos");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hyperphosphatemia" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Phosphorus: " + hyperphosPhos + " " + hyperphosDate + "\n\n"
														,subFont));
								currentLine = currentLine + 1;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypomagnesemia")){

								String hypomagDate,hypomagMag = "";
								hypomagDate = request.getParameter("hypomagDate");
								hypomagMag = request.getParameter("hypomagMag");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypomagnesemia" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Magnesium: " + hypomagMag + " " + hypomagDate + "\n\n"  
														,subFont));
								currentLine = currentLine + 1;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(EaChkGrp[j].equals("Electrolyte Abnormality :Hypermagnesemia")){

								String hypermagDate,hypermagMag = "";
								hypermagDate = request.getParameter("hypermagDate");
								hypermagMag = request.getParameter("hypermagMag");
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Hypermagnesemia" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Magnesium: " + hypermagMag + " " + hypermagDate + "\n\n"
														,subFont));
								currentLine = currentLine + 1;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
						}
					}
					else if(mainGrp[i].equals("HyperCholesterolemia")){

						String cholesterolDate,cholesterolResult = "";
						cholesterolDate = request.getParameter("cholesterolDate");
						cholesterolResult = request.getParameter("cholesterolResult");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						paragraph.add(new Chunk(spacesLevelThree + "Cholesterol: " + cholesterolResult + " " + cholesterolDate + "\n\n" 
												,subFont));
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);					
					}
					else if(mainGrp[i].equals("Dehydration")){

						String creatDate,creatResult,bunDate,bunResult,hydration  = "";
						creatDate = request.getParameter("hydracreatDate");
						creatResult = request.getParameter("hydracreatinine");
						bunDate = request.getParameter("hydrabunDate");
						bunResult = request.getParameter("hydrabunResult");
						hydration = request.getParameter("hydration");
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						/*paragraph.add(new Chunk("                    Date: " + creatDate +
								"        Creatinine: " + creatResult + "\n\n" ,subFont));
						paragraph.add(new Chunk("                    Date: " + bunDate +
								"        BUN: " + bunResult + "\n\n" ,subFont));
						paragraph.add(new Chunk("                    BUN/Creatinine: " + hydration + "\n\n" ,subFont));*/
						paragraph.add(new Chunk(spacesLevelThree + "Creatinine:     " + creatResult + " " + creatDate + "\n\n",subFont));
						paragraph.add(new Chunk(spacesLevelThree + "BUN:            " + bunResult + " " + bunDate + "\n\n",subFont));
						paragraph.add(new Chunk(spacesLevelThree + "BUN/Creatinine: " + hydration  + "\n\n" ,subFont));
						currentLine = currentLine + 3;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("Malnutrition")){

						String malHeightDate,malHeight,malWeight,malBmi,malWeightDate;
						malHeightDate = request.getParameter("malHeightDate");
						malWeightDate = request.getParameter("malWeightDate");
						malHeight = request.getParameter("malHeight");
						malWeight = request.getParameter("malWeight");
						malBmi = request.getParameter("malBmi");
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						paragraph.add(new Chunk(spacesLevelThree + "Height: " + malHeight + " " + malHeightDate + "\n\n",subFont));
						paragraph.add(new Chunk(spacesLevelThree + "Weight: " + malWeight + " " + malWeightDate + "\n\n",subFont));
						paragraph.add(new Chunk(spacesLevelThree + "BMI:    " + malBmi  + "\n\n",subFont));  
												
						currentLine = currentLine + 3;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("Obesity")){

						String obHeightDate, obHeight, obWeight, obBmi, obWeightDate = "";
						
						obHeightDate = request.getParameter("obHeightDate");
						obHeight = request.getParameter("obHeight");
						obWeight = request.getParameter("obWeight");
						obBmi = request.getParameter("obBmi");
						obWeightDate = request.getParameter("obWeightDate");
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						paragraph.add(new Chunk(spacesLevelThree + "Height: " + obHeight + " " + obHeightDate + "\n\n",subFont));
						paragraph.add(new Chunk(spacesLevelThree + "Weight: " + obWeight + " " + obWeightDate + "\n\n",subFont));
						paragraph.add(new Chunk(spacesLevelThree + "BMI:    " + obBmi  + "\n\n",subFont));  
												
						currentLine = currentLine + 3;						
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("Morbid Obesity")){

						String mobHeightDate, mobHeight, mobWeight, mobBmi, mobWeightDate = "";
						
						mobHeightDate = request.getParameter("mobHeightDate");
						mobHeight = request.getParameter("mobHeight");
						mobWeight = request.getParameter("mobWeight");
						mobBmi = request.getParameter("mobBmi");
						mobWeightDate = request.getParameter("mobWeightDate");
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						paragraph.add(new Chunk(spacesLevelThree + "Height: " + mobHeight + " " + mobHeightDate + "\n\n",subFont));
						paragraph.add(new Chunk(spacesLevelThree + "Weight: " + mobWeight + " " + mobWeightDate + "\n\n",subFont));
						paragraph.add(new Chunk(spacesLevelThree + "BMI:    " + mobBmi  + "\n\n",subFont));  
												
						currentLine = currentLine + 3;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("Hypertension")){

						String htnDate,htnDatesys,htnBpDia,htnBpSys = "";
						htnDate = request.getParameter("htnDate");
						htnDatesys = request.getParameter("htnDateSys");
						htnBpDia = request.getParameter("htnBpDia");
						htnBpSys = request.getParameter("htnBpSys");
					
						String[] hyperChkGrp;
						hyperChkGrp =  request.getParameterValues("htChkGrp");


						for (int j = 0; j < hyperChkGrp.length; j++){

							if(hyperChkGrp[j].equals("Hypertension: Elevated BP")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk("     \u2022  " + "Elevated Blood Pressure" + "\n\n", font));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Blood Pressure(systolic):  " + htnBpSys + " " + htnDatesys + "\n\n",subFont));
								paragraph.add(new Chunk(spacesLevelThree + "Blood Pressure(diastolic): " + htnBpDia + " " + htnDate + "\n\n",subFont));
														
								currentLine = currentLine + 2;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							if(hyperChkGrp[j].equals("Hypertension: Hypertension")){

								paragraph = new Paragraph();
								paragraph.add(new Chunk("     \u2022  " + "Hypertension" + "\n\n", font));
								currentLine = currentLine + 1;
								paragraph.add(new Chunk(spacesLevelThree + "Blood Pressure(systolic):  " + htnBpSys + " " + htnDatesys + "\n\n",subFont));
								paragraph.add(new Chunk(spacesLevelThree + "Blood Pressure(diastolic): " + htnBpDia + " " + htnDate + "\n\n",subFont));
														
								currentLine = currentLine + 2;
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
						}
					}
					else if(mainGrp[i].equals("Shock")){

						String[] shockChkGrp = null;
						shockChkGrp =  request.getParameterValues("shockChkGrp");

						if(shockChkGrp != null) {
							paragraph = new Paragraph();
							paragraph.add(new Chunk("     \u2022  " + "Shock" + "\n\n",font));
							currentLine = currentLine + 1;
							currentLine = setPageTemplate(currentLine, document, To_be_Added);
							document.add(paragraph);
							String shockDate,shockBP = "";
							
							shockDate = request.getParameter("shockDate");
							shockBP = request.getParameter("shockBp");

							for (int j = 0; j < shockChkGrp.length; j++){
								if(shockChkGrp[j].equals("Shock:Septic")){

									shockDate = request.getParameter("shockDate");
									shockBP = request.getParameter("shockBp");
									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "Septic" + "\n\n" ,fontSubHead));
									currentLine = currentLine + 1;
									paragraph.add(new Chunk(spacesLevelThree + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n\n"  
															,subFont));
									currentLine = currentLine + 1;
									currentLine = setPageTemplate(currentLine, document, To_be_Added);
									document.add(paragraph);
								}
								else if(shockChkGrp[j].equals("Shock:Hypovolemic")){
									
									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "Hypovolemic" + "\n\n" ,fontSubHead));
									currentLine = currentLine + 1;
									paragraph.add(new Chunk(spacesLevelThree + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n\n"  
															,subFont));
									currentLine = currentLine + 1;
									currentLine = setPageTemplate(currentLine, document, To_be_Added);
									document.add(paragraph);
								}
								else if(shockChkGrp[j].equals("Shock:Obstructive")){
									
									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "Obstructive" + "\n\n" ,fontSubHead));
									currentLine = currentLine + 1;
									paragraph.add(new Chunk(spacesLevelThree + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n\n"  
															,subFont));
									currentLine = currentLine + 1;
									currentLine = setPageTemplate(currentLine, document, To_be_Added);
									document.add(paragraph);
								}
								else if(shockChkGrp[j].equals("Shock:NOS")){
									
									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "NOS" + "\n\n" ,fontSubHead));
									currentLine = currentLine + 1;
									paragraph.add(new Chunk(spacesLevelThree + "Systolic Blood Pressure: " + shockBP + " " + shockDate + "\n\n"  
															,subFont));
									currentLine = currentLine + 1;
									currentLine = currentLine + 1;
									currentLine = setPageTemplate(currentLine, document, To_be_Added);
									document.add(paragraph);
								}					
							}
						}
					}
					else if(mainGrp[i].equals("Cardiogenic Shock")){

						String[] cshockChkGrp = null;
						cshockChkGrp =  request.getParameterValues("cshockChkGrp");
						if(cshockChkGrp != null) {

							paragraph = new Paragraph();
							paragraph.add(new Chunk("     \u2022  " + "Cardiogenic Shock" + "\n\n",font));
							currentLine = currentLine + 1;
							currentLine = setPageTemplate(currentLine, document, To_be_Added);
							document.add(paragraph);
							String cshockDate,cshockBP, cDateShockTrop, cShockTrop = "";
							cshockDate = request.getParameter("cShockDate");
							cshockBP = request.getParameter("cShockBP");
							cDateShockTrop = request.getParameter("cDateShockTrop");
							cShockTrop = request.getParameter("cShockTrop");

							//currentLine = setPageTemplate(currentLine, document, To_be_Added);
							//document.add(paragraph);
							
							for (int j = 0; j < cshockChkGrp.length; j++){
								if(cshockChkGrp[j].equals("Cardiogenic Shock:Cardiogenic Shock")){


									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "Cardiogenic Shock" + "\n\n",fontSubHead));
									currentLine = currentLine + 1;
									paragraph.add(new Chunk(spacesLevelThree + "Systolic Blood Pressure: " + cshockBP + " " + cshockDate +  "\n\n",subFont));
									paragraph.add(new Chunk(spacesLevelThree + "Cardiac Troponin Date:   " + cShockTrop + " " + cDateShockTrop +  "\n\n",subFont));
															
									currentLine = currentLine + 2;
									currentLine = setPageTemplate(currentLine, document, To_be_Added);
									document.add(paragraph);
								}
								else if(cshockChkGrp[j].equals("Cardiogenic Shock:Septic")){

									paragraph = new Paragraph();
									paragraph.add(new Chunk("          " + "Shock : Septic" + "\n\n",fontSubHead));
									currentLine = currentLine + 1;
									paragraph.add(new Chunk("                  Systolic BP Date: " + cshockDate +
											"        Systolic Blood Pressure: " + cshockBP + "\n\n"  ,subFont));
									currentLine = currentLine + 1;
									currentLine = setPageTemplate(currentLine, document, To_be_Added);
									document.add(paragraph);
								}
								else if(cshockChkGrp[j].equals("Cardiogenic Shock:Hypovolemic")){


									paragraph = new Paragraph();
									paragraph.add(new Chunk("          " + "Shock : Hypovolemic" + "\n\n",fontSubHead));
									currentLine = currentLine + 1;
									paragraph.add(new Chunk("                  Systolic BP Date: " + cshockDate +
											"        Systolic Blood Pressure: " + cshockBP + "\n\n"  ,subFont));
									currentLine = currentLine + 1;
									currentLine = setPageTemplate(currentLine, document, To_be_Added);
									document.add(paragraph);
								}
								else if(cshockChkGrp[j].equals("Cardiogenic Shock:Obstructive")){


									paragraph = new Paragraph();
									paragraph.add(new Chunk("          " + "Shock : Obstructive" + "\n\n",fontSubHead));
									currentLine = currentLine + 1;
									paragraph.add(new Chunk("                  Systolic BP Date: " + cshockDate +
											"        Systolic Blood Pressure: " + cshockBP + "\n\n"  ,subFont));
									currentLine = currentLine + 1;
									currentLine = setPageTemplate(currentLine, document, To_be_Added);
									document.add(paragraph);
								}
								else if(cshockChkGrp[j].equals("Cardiogenic Shock:NOS")){

									paragraph = new Paragraph();
									paragraph.add(new Chunk("          " + "Shock : NOS" + "\n\n",fontSubHead));
									currentLine = currentLine + 1;
									paragraph.add(new Chunk("                  Systolic BP Date: " + cshockDate +
											"        Systolic Blood Pressure: " + cshockBP + "\n\n"  ,subFont));
									currentLine = currentLine + 1;
									currentLine = setPageTemplate(currentLine, document, To_be_Added);
									document.add(paragraph);
								}	

							}
						}
					}
					else if(mainGrp[i].equals("Uti")){

						String[] utichckgrp;
						utichckgrp =  request.getParameterValues("catheterAssoc");
						
						String utiDate,utiWbc,utiUle,utiUln,utiUlndate,utiUledate = "";
						paragraph = new Paragraph();
						utiDate = request.getParameter("utiDate");
						utiWbc = request.getParameter("utiWbc");
						utiUle = request.getParameter("utiUle");
						utiUledate = request.getParameter("utiUledate");
						utiUln = request.getParameter("utiUln");
						utiUlndate = request.getParameter("utiUlndate");
						
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						if(utiWbc.isEmpty()!=true){
						paragraph.add(new Chunk(spacesLevelThree + "WBC count:                      " + utiWbc + " " + utiDate + "\n\n",subFont));
						currentLine = currentLine + 1;
						}
						if(utiUle.isEmpty()!=true){
							paragraph.add(new Chunk(spacesLevelThree + "Urinalysis, Leukocyte Esterase: " + utiUle + " " + utiUledate + "\n\n",subFont));
							currentLine = currentLine + 1;
						}
						if(utiUln.isEmpty()!=true){
							paragraph.add(new Chunk(spacesLevelThree + "Urinalysis,  Nitrite:           " + utiUln + " " + utiUlndate +"\n\n",subFont));
							currentLine = currentLine + 1;
						}

						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
						
						if(utichckgrp != null){
							System.out.println("UTI CHECKGROUPLENTH:" + utichckgrp.length);
							for (int j = 0; j < utichckgrp.length; j++){
								if(utichckgrp[j].equals("Catherter Associated")){

									paragraph = new Paragraph();
									paragraph.add(new Chunk(spacesLevelTwo + "Catherter Associated" + "\n\n",fontSubHead));
									currentLine = currentLine + 1;
									currentLine = setPageTemplate(currentLine, document, To_be_Added);
									document.add(paragraph);
								}
							}
						}
						else{
							System.out.println("Catherter not selected");
						}
					}
					else if(mainGrp[i].equals("Respiratory Failure :")){

						String[] respFailChkGrp;
						respFailChkGrp =  request.getParameterValues("respFailChkGrp");

						paragraph = new Paragraph();
						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
						
						for (int j = 0; j < respFailChkGrp.length; j++){

							if(respFailChkGrp[j].equals("Respiratory Failure :Acute")){

								String respPo2Date,respPo,respO2satDate, respO2sat = "";
								
								respPo2Date = request.getParameter("respPo2Date");
								respPo = request.getParameter("respPo");
								respO2satDate = request.getParameter("respO2satDate");
								respO2sat = request.getParameter("respO2sat");
								
								paragraph = new Paragraph();
								paragraph.add(new Chunk(spacesLevelTwo + "Acute" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								if(respPo.isEmpty()!=true){
								paragraph.add(new Chunk(spacesLevelThree + "PO2:            " + respPo + " " + respPo2Date + "\n\n",subFont));
								currentLine = currentLine + 1;
								}
								if(respO2sat.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Pulse Oximetry: " + respO2sat + " " + respO2satDate + "\n\n",subFont));
									currentLine = currentLine + 1;
								}
								
								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);

							}
							else if(respFailChkGrp[j].equals("Respiratory Failure :Chronic")){

								String respPco2Date = request.getParameter("respPco2Date");
								String respPco2 = request.getParameter("respPco2");
								String respEtco2Date = request.getParameter("respEtco2Date");
								String respEtco2 = request.getParameter("respEtco2");
								String respPrevPco2Date = request.getParameter("respPrevPco2Date");
								String respPrevPco2 = request.getParameter("respPrevPco2");
								String respPrevEtco2Date = request.getParameter("respPrevEtco2Date");
								String respPrevEtco2 = request.getParameter("respPrevEtco2");
								
								paragraph = new Paragraph();
								paragraph.add(new Chunk("          " + "Chronic" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								if(respPco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "PCO2:           " + respPco2 + " " + respPco2Date + "\n\n",subFont));
									currentLine = currentLine + 1;
								}
								if(respPrevPco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Previous PCO2:  " + respPrevPco2 + " " + respPrevPco2Date + "\n\n",subFont));
									currentLine = currentLine + 1;
								}
								if(respEtco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "EtcO2:          " + respEtco2 + " " + respEtco2Date + "\n\n",subFont));
									currentLine = currentLine + 1;
								}
								if(respPrevEtco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Previous EtcO2: " + respPrevEtco2 + " " + respPrevEtco2Date + "\n\n",subFont));
									currentLine = currentLine + 1;
								}

								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							else if(respFailChkGrp[j].equals("Respiratory Failure :Acute on Chronic")){

								String respPco2Date = request.getParameter("respPco2Date");
								String respPco2 = request.getParameter("respPco2");
								String respEtco2Date = request.getParameter("respEtco2Date");
								String respEtco2 = request.getParameter("respEtco2");
								String respPrevPco2Date = request.getParameter("respPrevPco2Date");
								String respPrevPco2 = request.getParameter("respPrevPco2");
								String respPrevEtco2Date = request.getParameter("respPrevEtco2Date");
								String respPrevEtco2 = request.getParameter("respPrevEtco2");
								String respPo2Date,respPo,respO2satDate, respO2sat = "";
								paragraph = new Paragraph();
								respPo2Date = request.getParameter("respPo2Date");
								respPo = request.getParameter("respPo");
								respO2satDate = request.getParameter("respO2satDate");
								respO2sat = request.getParameter("respO2sat");
								
								paragraph = new Paragraph();
								paragraph.add(new Chunk("          " + "Acute on Chronic" + "\n\n",fontSubHead));
								currentLine = currentLine + 1;
								
								if(respPo.isEmpty()!=true){
								paragraph.add(new Chunk(spacesLevelThree + "PO2:                " + respPo + " " + respPo2Date + "\n\n",subFont));
								currentLine = currentLine + 1;
								}
								if(respO2sat.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Pulse Oximetry: " + respO2sat + " " + respO2satDate + "\n\n",subFont));
									currentLine = currentLine + 1;
								}
								if(respPco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "PCO2:           " + respPco2 + " " + respPco2Date + "\n\n",subFont));
									currentLine = currentLine + 1;
								}
								if(respPrevPco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Previous PCO2:  " + respPrevPco2 + " " + respPrevPco2Date + "\n\n",subFont));
									currentLine = currentLine + 1;
								}
								if(respEtco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "EtcO2:          " + respEtco2 + " " + respEtco2Date + "\n\n",subFont));
									currentLine = currentLine + 1;
								}
								if(respPrevEtco2.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "Previous EtcO2: " + respPrevEtco2 + " " + respPrevEtco2Date + "\n\n",subFont));
									currentLine = currentLine + 1;
								}

								currentLine = setPageTemplate(currentLine, document, To_be_Added);
								document.add(paragraph);
							}
							/*else if(respFailChkGrp[j].equals("Respiratory Failure :NOS")){

								String respPo2Date,respPo,respO2satDate, respO2sat = "";
								
								paragraph = new Paragraph();
								respPo2Date = request.getParameter("respPo2Date");
								respPo = request.getParameter("respPo");
								respO2satDate = request.getParameter("respO2satDate");
								respO2sat = request.getParameter("respO2sat");
								
								paragraph.add(new Chunk(spacesLevelTwo + "Not Otherwise Specified" + "\n\n",fontSubHead));
								if(respPo.isEmpty()!=true){
									paragraph.add(new Chunk(spacesLevelThree + "PO2:            " + respPo + " " + respPo2Date + "\n\n",subFont));
								}
								if(respO2sat.isEmpty()!=true){
										paragraph.add(new Chunk(spacesLevelThree + "Pulse Oximetry: " + respO2sat + " " + respO2satDate + "\n\n",subFont));
								}
								
								cell = new PdfPCell(paragraph);
								cell.setBorderWidthBottom(0);
								cell.setBorderWidthTop(0);
								table.addCell(cell);
							}*/

						}
					}
					else if(mainGrp[i].equals("Sepsis")){

						String sepDate,maxsepHr,minsepHr,sepRr,sepMaxWbc,sepMinWbc,sepSysBP,maxsepTem, minsepTem,sepLac, 
						maxsepHrDate, minsepHrDate, sepRrDate,sepMaxWbcDate,sepMinWbcDate,sepSysBPDate,maxsepTemDate, 
						minsepTemDate,sepLacDate,sepLacHigh = "";
						
						paragraph = new Paragraph();
						
						maxsepHr = request.getParameter("maxsepHr");
						minsepHr = request.getParameter("minsepHr");
						sepRr = request.getParameter("sepRr");
						sepMaxWbc = request.getParameter("maxsepWbc");
						sepMinWbc = request.getParameter("minsepWbc");
						sepSysBP = request.getParameter("sepSysBP");
						maxsepTem = request.getParameter("maxsepTem");
						minsepTem = request.getParameter("minsepTem");
						sepLac = request.getParameter("sepLac");
						maxsepHrDate = request.getParameter("maxsepHrDate");
						minsepHrDate = request.getParameter("minsepHrDate");
						sepRrDate = request.getParameter("sepRrDate");
						sepMaxWbcDate = request.getParameter("maxsepWbcDate");
						sepMinWbcDate = request.getParameter("minsepWbcDate");
						sepSysBPDate = request.getParameter("sepSysBPDate");
						maxsepTemDate = request.getParameter("maxsepTemDate");
						minsepTemDate = request.getParameter("minsepTemDate");
						sepLacDate = request.getParameter("sepLacDate");
						sepLacHigh = request.getParameter("sepLacHigh");

						paragraph.add(new Chunk("     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						if(maxsepHr.isEmpty() != true && Double.parseDouble(maxsepHr) > 100.0){
							paragraph.add(new Chunk(spacesLevelThree + "Heart Rate (Maximum):  " + maxsepHr + 
													" "+ maxsepHrDate + "\n\n",subFont));
							currentLine = currentLine + 1;
						}
						if( minsepHr.isEmpty() != true && Double.parseDouble(minsepHr) < 40.0){
							paragraph.add(new Chunk(spacesLevelThree + "Heart Rate (Minimum):  " + minsepHr + 
													" "+ minsepHrDate+ "\n\n",subFont));
							currentLine = currentLine + 1;
						}
						if(sepRr.isEmpty() != true && Double.parseDouble(sepRr) > 26.0){
							paragraph.add(new Chunk(spacesLevelThree + "Respiratory Rate:      " + sepRr + " "+ sepRrDate + "\n\n",subFont));
							currentLine = currentLine + 1;
						}
						if(sepMaxWbc.isEmpty() != true && Double.parseDouble(sepMaxWbc) > 12.0){
							paragraph.add(new Chunk(spacesLevelThree + "WBC count (Maximum):   " + sepMaxWbc + 
													" "+ sepMaxWbcDate + "\n\n", subFont));
							currentLine = currentLine + 1;
						}
						if(sepMinWbc.isEmpty() != true && Double.parseDouble(sepMinWbc) < 4.0){
							paragraph.add(new Chunk(spacesLevelThree + "WBC count (Minimum):   " + sepMinWbc + 
													" "+ sepMinWbcDate + "\n\n", subFont));
							currentLine = currentLine + 1;
						}
						if(sepSysBP.isEmpty() != true && Double.parseDouble(sepSysBP) <= 90.0){
							paragraph.add(new Chunk(spacesLevelThree + "Systolic BP:           " + sepSysBP + 
													" "+ sepSysBPDate + "\n\n", subFont));
							currentLine = currentLine + 1;
						}
						if(maxsepTem.isEmpty() != true && Double.parseDouble(maxsepTem) >= 38.88){
							paragraph.add(new Chunk(spacesLevelThree + "Temperature (Maximum): " + maxsepTem + 
													" "+ maxsepTemDate + "\n\n" ,subFont));
							currentLine = currentLine + 1;
						}
						if(minsepTem.isEmpty() != true &&  Double.parseDouble(minsepTem) < 36){
							paragraph.add(new Chunk(spacesLevelThree + "Temperature (Minimum): " + minsepTem + 
													" "+ minsepTemDate + "\n\n" ,subFont));
							currentLine = currentLine + 1;
						}
						if( sepLac.isEmpty() != true && Double.parseDouble(sepLac) > Double.parseDouble(sepLacHigh)){
							paragraph.add(new Chunk(spacesLevelThree + "Lactate:               " + sepLac + " "+ sepLacDate + "\n\n" ,subFont));
							currentLine = currentLine + 1;
						} 
																																		
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("Acute Pulmonary Edema")){
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
				
					}

					else if(mainGrp[i].equals("Anoxic Brain Injury")){
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
						
					}						
					else if(mainGrp[i].equals("Coma")){
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));
						String comaDate,comaValue1,comaValue2 = "";
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}

					else if(mainGrp[i].equals("Decubitis Ulcer")){
						
						String[] duChkgrp;
						String ipDuSite = "";
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n",font));
						currentLine = currentLine + 1;
						duChkgrp = request.getParameterValues("duChkgrp");
						if(duChkgrp == null){

						}
						else{
							for (int j = 0; j < duChkgrp.length; j++){
								currentLine = currentLine + 1;
								paragraph.add(new Chunk("\n                    \u2022  " + duChkgrp[j] + "\n",fontSubHead));
								currentLine = currentLine + 1;
							}
						}
						paragraph.add(new Chunk("\n"));
						currentLine = currentLine + 1;

						if((request.getParameter("ipDuSite")) != ""){
							ipDuSite = request.getParameter("ipDuSite"); 
							paragraph.add(new Chunk("                    Site: " + ipDuSite + "\n\n",fontSubHead));
							currentLine = currentLine + 1;
						}
						
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}

					else if(mainGrp[i].equals("Delirium")){
						
						String[] delichkgrp;
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n",font));
						currentLine = currentLine + 1;
						delichkgrp = request.getParameterValues("delichkgrp");
						if(delichkgrp == null){

						}
						else{
							for (int j = 0; j < delichkgrp.length; j++){
								currentLine = currentLine + 1;
								paragraph.add(new Chunk("\n                    \u2022  " + delichkgrp[j] + "\n",fontSubHead));
								currentLine = currentLine + 1;
							}
						}
						paragraph.add(new Chunk("\n\n"));
						currentLine = currentLine + 1;
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}						
					else if(mainGrp[i].equals("Encephalopathy")){
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;

						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);

					}
					else if(mainGrp[i].equals("Pleural Effusion")){
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;

						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}

					else if(mainGrp[i].equals("Pneumonia")){
						
						String[] pneuchkgrp;
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;
						pneuchkgrp = request.getParameterValues("pneuchkgrp");
						if(pneuchkgrp == null){

						}
						else{
							for (int j = 0; j < pneuchkgrp.length; j++){
								currentLine = currentLine + 1;
								paragraph.add(new Chunk("\n                    \u2022  " + pneuchkgrp[j] + "\n",fontSubHead));
								currentLine = currentLine + 1;
							}
						}


						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}

					else if(mainGrp[i].equals("PSVT")){
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;


						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("Seizure")){
						
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + mainGrp[i] + "\n\n",font));
						currentLine = currentLine + 1;

						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("SepsisOther")){
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + "Sepsis for reasons listed below" + "\n\n",font));
						currentLine = currentLine + 1;
						String SepsisOtherComments = "";
						SepsisOtherComments = request.getParameter("sepsisOtherComments");
						paragraph.add(new Chunk(spacesLevelThree + "Reasons: " + SepsisOtherComments + "\n\n" ,subFont));
						currentLine = currentLine + 3;
						
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("SepsisOther")){
						paragraph = new Paragraph();
						paragraph.add(new Chunk("\n     \u2022  " + "Sepsis for reasons listed below" + "\n\n",font));
						currentLine = currentLine + 1;
						String SepsisOtherComments = "";
						SepsisOtherComments = request.getParameter("sepsisOtherComments");
						paragraph.add(new Chunk(spacesLevelThree + "Reasons: " + SepsisOtherComments + "\n\n" ,subFont));
						currentLine = currentLine + 3;
						
						currentLine = setPageTemplate(currentLine, document, To_be_Added);
						document.add(paragraph);
					}
					else if(mainGrp[i].equals("comments")){
						String comments = "";
						comments = request.getParameter("commentsid");
						//String newcomments = comments.replace("/\n\r?/g", ",");
						String newcomments = comments.replace(",", "\n\r                   ");
						
						if(comments.isEmpty() != true || comments != null){
							paragraph = new Paragraph();
							paragraph.add(new Chunk("\n     \u2022  " + "Other Comorbidities: " + "\n\n",font));
							currentLine = currentLine + 1;
							paragraph.add(new Chunk(spacesLevelThree + newcomments + "\n\n" ,subFont));
							currentLine = currentLine + 3;
							
							currentLine = setPageTemplate(currentLine, document, To_be_Added);
							document.add(paragraph);
						}
					}
				}
			}
										
			paragraph = new Paragraph("\n");
			cell = new PdfPCell(paragraph);
			cell.setBorderWidthBottom(0);
			cell.setBorderWidthTop(0);
			table.addCell(cell);

			DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy h:mm a");
			Date date = new Date();
			String Date = dateFormat.format(date);

			font = FontFactory.getFont("Times-Roman",14, Font.BOLD);

			paragraph = new Paragraph();
			paragraph.add(new Chunk("Physician Name:  _________________________"+ "  " + "ID #:  _________________________" + 
					"\n\n" +
					"Physician Signature:   _______________________" + "  ",font));
			

			paragraph.add(new Chunk("Date: ",font));
			paragraph.add(new Chunk(Date.substring(0,10) + "  ",FontFactory.getFont("Times-Roman",14)));
			paragraph.add(new Chunk("Time: ",font));
			paragraph.add(new Chunk(Date.substring(11) + "\n\n",FontFactory.getFont("Times-Roman",14)));
			currentLine = currentLine + 5;
			currentLine = setPageTemplate(currentLine, document, To_be_Added);
			
			document.add(paragraph);
			
			table = new PdfPTable(1);
			paragraph = new Paragraph("\n\n");
			cell = new PdfPCell(paragraph);
			cell.setBorderWidthBottom(0);
			cell.setBorderWidthRight(0);
			cell.setBorderWidthLeft(0);
			table.addCell(cell);
			table.setWidthPercentage(100);
			document.add(table);
			
			//document.close();

			/* This adds a new page for the timer*/	
			/*Paragraph paragraph1 = new Paragraph("\n");

			document.newPage();
			document.add(To_be_Added);
			document.add(new Paragraph("\n"));
			
			paragraph1 = new Paragraph("  CO-MORBIDITIES",font);
			paragraph1 = new Paragraph();
			timer = request.getParameterValues("clock");
			paragraph1.add(new Chunk("               " + timer[0]));
			document.add(paragraph1);

			document.add(new Paragraph("\n"));
			document.close();*/


		}
		catch (DocumentException e) {
			//System.out.println("Document Exception");
			e.printStackTrace();
		}
		document.close();
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);

	}

}
