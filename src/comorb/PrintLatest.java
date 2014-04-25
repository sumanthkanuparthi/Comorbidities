package comorb;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.*;

import org.apache.jasper.tagplugins.jstl.core.Redirect;
import org.openqa.selenium.By;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

import comorb.PrintInterface.ComorbiditiesFunctor;

@SuppressWarnings("serial")
public class PrintLatest extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final static Font errorFont = FontFactory.getFont("Courier",10, Font.BOLD, BaseColor.RED);
	final Font font1 = FontFactory.getFont("Times-Roman",14, Font.BOLD);

	/*<a href ="http://172.31.133.123:8080/CoMorbidities/CoMorbMain.jsp?<%=request.getSession().getAttribute("prevURL")%>">back</a>
	 * This Map maintains a record of all Comorbidities with the Comorbidity name as its key and an object
	 * of that Comorbidity's class as its value. Every Comorbidity class implements the 'ComorbiditiesFunctor'
	 * interface, which can be found in 'PrintInterface.java'
	 */
	final static Map<String, ComorbiditiesFunctor> comorbMap = new HashMap<String, ComorbiditiesFunctor>()
			{{
				
				final Font font = FontFactory.getFont("Times-Roman",14, Font.BOLD);
				final Font fontSubHead = FontFactory.getFont("Courier",12, Font.BOLD);
				final Font subFont = FontFactory.getFont("Courier" ,10);

				final String spacesLevelTwo = "          ";
				final String spacesLevelThree = "                    ";

				ComorbiditiesFunctor _ElevatedBloodGlucose = new ElevatedBloodGlucose(font, subFont, errorFont, spacesLevelThree);
				put(_ElevatedBloodGlucose.getName(), _ElevatedBloodGlucose);

				ComorbiditiesFunctor _Hypoglycemia = new Hypoglycemia(font, subFont, spacesLevelThree);
				put(_Hypoglycemia.getName(), _Hypoglycemia);

				ComorbiditiesFunctor _AcuteKidneyInjury = new AcuteKidneyInjury(font, fontSubHead, subFont, errorFont, spacesLevelThree, spacesLevelTwo);
				put(_AcuteKidneyInjury.getName(), _AcuteKidneyInjury);

				ComorbiditiesFunctor _Anemia = new Anemia(font, fontSubHead, subFont, errorFont, spacesLevelThree, spacesLevelTwo);
				put(_Anemia.getName(), _Anemia);

				ComorbiditiesFunctor _Hypoxia = new Hypoxia(font, subFont, spacesLevelThree);
				put(_Hypoxia.getName(), _Hypoxia);

				ComorbiditiesFunctor _Granulocytopenia = new Granulocytopenia(font, subFont, spacesLevelThree);
				put(_Granulocytopenia.getName(), _Granulocytopenia);

				ComorbiditiesFunctor _LacticAcidosis = new LacticAcidosis(font, subFont, spacesLevelThree);
				put(_LacticAcidosis.getName(), _LacticAcidosis);

				ComorbiditiesFunctor _ChronicKidneyDisease = new ChronicKidneyDisease(font, fontSubHead, subFont, errorFont, spacesLevelThree, spacesLevelTwo);
				put(_ChronicKidneyDisease.getName(), _ChronicKidneyDisease);

				ComorbiditiesFunctor _HyperCholesterolemia = new HyperCholesterolemia(font, subFont, spacesLevelThree);
				put(_HyperCholesterolemia.getName(), _HyperCholesterolemia);

				ComorbiditiesFunctor _Dehydration = new Dehydration(font, subFont, spacesLevelThree);
				put(_Dehydration.getName(), _Dehydration);

				ComorbiditiesFunctor _Malnutrition = new Malnutrition(font, subFont, spacesLevelThree);
				put(_Malnutrition.getName(), _Malnutrition);

				ComorbiditiesFunctor _Obesity = new Obesity(font, subFont, spacesLevelThree);
				put(_Obesity.getName(), _Obesity);

				ComorbiditiesFunctor _MorbidObesity = new MorbidObesity(font, subFont, spacesLevelThree);
				put(_MorbidObesity.getName(), _MorbidObesity);

				ComorbiditiesFunctor _Hypertension = new Hypertension(font, subFont, errorFont, spacesLevelThree);
				put(_Hypertension.getName(), _Hypertension);

				ComorbiditiesFunctor _Shock = new Shock(font, fontSubHead, subFont, errorFont, spacesLevelThree, spacesLevelTwo);
				put(_Shock.getName(), _Shock);

				ComorbiditiesFunctor _CardiogenicShock = new CardiogenicShock(font, fontSubHead, subFont, errorFont, spacesLevelThree, spacesLevelTwo);
				put(_CardiogenicShock.getName(), _CardiogenicShock);

				ComorbiditiesFunctor _Uti = new Uti(font, fontSubHead, subFont, errorFont, spacesLevelThree, spacesLevelTwo);
				put(_Uti.getName(), _Uti);

				ComorbiditiesFunctor _ElectrolyteAbnormality = new ElectrolyteAbnormality(font, fontSubHead, subFont, errorFont, spacesLevelThree, spacesLevelTwo);
				put(_ElectrolyteAbnormality.getName(), _ElectrolyteAbnormality);

				ComorbiditiesFunctor _Comments = new Comments(font, subFont, errorFont, spacesLevelThree,fontSubHead);
				put(_Comments.getName(), _Comments);

				ComorbiditiesFunctor _SepsisOther = new SepsisOther(font, subFont, errorFont, spacesLevelThree,fontSubHead);
				put(_SepsisOther.getName(), _SepsisOther);

				ComorbiditiesFunctor _Seizure = new Seizure(font);
				put(_Seizure.getName(), _Seizure);

				ComorbiditiesFunctor _PSVT = new PSVT(font);
				put(_PSVT.getName(), _PSVT);

				ComorbiditiesFunctor _Pneumonia = new Pneumonia(font, fontSubHead, errorFont);
				put(_Pneumonia.getName(), _Pneumonia);

				ComorbiditiesFunctor _PleuralEffusion = new PleuralEffusion(font);
				put(_PleuralEffusion.getName(), _PleuralEffusion);

				ComorbiditiesFunctor _Encephalopathy = new Encephalopathy(font, fontSubHead, errorFont);
				put(_Encephalopathy.getName(), _Encephalopathy);

				ComorbiditiesFunctor _Delirium = new Delirium(font, fontSubHead, errorFont);
				put(_Delirium.getName(), _Delirium);

				ComorbiditiesFunctor _DecubitisUlcer = new DecubitisUlcer(font, fontSubHead, errorFont);
				put(_DecubitisUlcer.getName(), _DecubitisUlcer);

				ComorbiditiesFunctor _Coma = new Coma(font);
				put(_Coma.getName(), _Coma);

				ComorbiditiesFunctor _AnoxicBrainInjury = new AnoxicBrainInjury(font);
				put(_AnoxicBrainInjury.getName(), _AnoxicBrainInjury);

				ComorbiditiesFunctor _AcutePulmonaryEdema = new AcutePulmonaryEdema(font);
				put(_AcutePulmonaryEdema.getName(), _AcutePulmonaryEdema);

				ComorbiditiesFunctor _Sepsis = new Sepsis(font, fontSubHead, subFont, spacesLevelThree, spacesLevelTwo, errorFont);
				put(_Sepsis.getName(), _Sepsis);

				ComorbiditiesFunctor _RespiratoryFailure = new RespiratoryFailure(font, fontSubHead, subFont, errorFont, spacesLevelThree, spacesLevelTwo);
				put(_RespiratoryFailure.getName(), _RespiratoryFailure);

			}};

			@Override
			protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException 
			{	
				//final ByteArrayOutputStream memstream = new ByteArrayOutputStream();
				final Document document = new Document();
				WriteHelper writer = null;	
				int flag=0;
				String ustring="";
				String furl="";
				furl=request.getParameter("encntr_id")+","+request.getParameter("user_id")+",'";
				//String prevXml = request.getParameter("prevXml");
				String prevXml = request.getSession().getAttribute("prevXml1").toString();
				System.out.println("Retreived XMl............"+prevXml);
				System.out.println("PrintLatest doGet request started: "+new Date());
				System.out.println("yaha hai kya prevCreat------^^^^^ "+ request.getParameter("PrevCreat"));

				try {			
					//String act = request.getParameter("print");
					Cookie[] cookies = request.getCookies();

					for (int i = 0; i < cookies.length; i++) {
						String name = cookies[i].getName();
						String value = cookies[i].getValue();
						if("print".equals(name)&&("print".equals(value)||"commit".equals(value)))
						{
							if("commit".equals(value))
								flag=1;
							else 
								flag=0;
							System.out.println("The name is "+name+" "+"the value is: "+value+" "+flag);

						}
						cookies[i].setValue("null");
						cookies[i].setPath("/");
						cookies[i].setMaxAge(0);

					}
					//System.out.println(act);
					String temp="";
					String[] mainGrp;
					String[] timer;
					String toPrint = "",relativeWebPath="",absoluteDiskPath="";
					Font font=FontFactory.getFont("Times-Roman",14, Font.BOLD),fontSubHead,subFont;
					Paragraph paragraph,paragraph1;
					PdfPTable table=new PdfPTable(1);
					PdfPCell cell;

					//code exclusive for printing pdf
					if(flag==0)
					{
						response.setContentType("application/pdf");    			
						//PdfWriter.getInstance(document, memstream);
						PdfWriter.getInstance(document, response.getOutputStream());

						font = FontFactory.getFont("Times-Roman",14, Font.BOLD);
						fontSubHead = FontFactory.getFont("Courier",12, Font.BOLD);
						subFont = FontFactory.getFont("Courier" ,12);
						document.open();

						relativeWebPath = "barcode.bmp";
						absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);

						final Image To_be_Added = Image.getInstance(absoluteDiskPath);    	
						To_be_Added.setAlignment(Image.MIDDLE);
						To_be_Added.setBorder(Rectangle.BOX);
						To_be_Added.scalePercent(50);

						writer = new WriteHelper(document, To_be_Added);
						timer = request.getParameterValues("clock");

						paragraph1 = new Paragraph("  " + timer[0],subFont);

						document.add(paragraph1);

						document.add(To_be_Added);    	        
						document.add(new Paragraph("\n"));
						//prev CoMorb
						paragraph = new Paragraph();
						
						paragraph = new Paragraph(" PREVIOUS CO-MORBIDITIES/CLINICAL CONDITIONS",font);
					
						document.add(paragraph);

						document.add(new Paragraph("\n"));
						
						table = new PdfPTable(1);
						 cell = new PdfPCell();

						paragraph = new Paragraph("\n");
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthRight(0);
						cell.setBorderWidthLeft(0);
						
						table.addCell(cell);
						table.setWidthPercentage(100);
						document.add(table);
						//font1 = FontFactory.getFont("Times-Roman",14, Font.BOLD);
						String printThis=request.getParameter("printPrevCoMorb").toString();
					System.out.println("hhhhhhhhhhhhhhhhhhh ---------->>>>>>"+ printThis);
					paragraph = new Paragraph();

					paragraph = new Paragraph(printThis,font);

					document.add(paragraph);
						//prev CoMorb ends

						paragraph = new Paragraph();

						paragraph = new Paragraph("  CO-MORBIDITIES/CLINICAL CONDITIONS",font);

						document.add(paragraph);

						document.add(new Paragraph("\n"));

						table = new PdfPTable(1);
						cell = new PdfPCell();

						paragraph = new Paragraph("\n");
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthRight(0);
						cell.setBorderWidthLeft(0);

						table.addCell(cell);
						table.setWidthPercentage(100);
						document.add(table);

						font = FontFactory.getFont("Times-Roman",14, Font.BOLD);
					}
					mainGrp = request.getParameterValues("mainGrp");

					if(mainGrp == null)
					{
						if(flag==0)
						{
							toPrint = "Error";
							document.add(new Paragraph("     " + toPrint,font));
						}

					}
					else
					{ 
						boolean first=true;
						String body=null;
						String header=null;
						if(prevXml != null && !prevXml.isEmpty())
						{
							if(prevXml.indexOf("<computed>") > 0)
							{
								ustring = prevXml.substring(0,prevXml.indexOf("</computed>"));
							}
							else
								ustring = new String("<?xml version=\"1.0\" encoding=\"UTF-16\"?><gg>");								
						}
						else{
						ustring = new String("<?xml version=\"1.0\" encoding=\"UTF-16\"?><gg>");
						}
						for (int i = 0; i < mainGrp.length; i++) 
						{
							ComorbiditiesFunctor comorbidity = comorbMap.get(mainGrp[i]);
							if(comorbidity!=null)
							{
								//if(flag==0)

								if(flag==1)
								{

									String tep=comorbidity.writeToDocument(request, writer,flag);
									
									if(first){
									//	header=tep.substring(0,39);
									body=tep.substring(39,tep.length());
									//line=line.substring(54);
									if(ustring.indexOf("<computed>")<0)
									ustring=ustring+"<computed>"+body;
									else
										ustring += body;
									first=false;
									
								  //result=result+line;
								 
									}else
									{
										//line=line.substring(54);
										tep=tep.substring(39);
										ustring=ustring+tep;
									
									}
									//ustring=tep;
									System.out.println("----------->>>>"+tep);
									//if(!("print".equals(tep)))
										//ustring=ustring+tep;



								}

								else
									temp=comorbidity.writeToDocument(request, writer,flag);	

								//else
								//System.out.println("commit");
								continue;
							}
							
						}
						ustring += "</computed>";
					} 
						String[] otherGrp = request.getParameterValues("otherGrp");
						
						if(otherGrp == null)
						{
							if(flag==0)
							{
								toPrint = "Error";
								document.add(new Paragraph("     " + toPrint,font));
							}

						}
						else
						{ 
							boolean first=true;
							String body;
							
							
							
							for (int i = 0; i < otherGrp.length; i++) 
							{
								ComorbiditiesFunctor comorbidity = comorbMap.get(otherGrp[i]);
								if(comorbidity!=null)
								{
									//if(flag==0)

									if(flag==1)
									{

										String tep=comorbidity.writeToDocument(request, writer,flag);
										
										if(first){
											
												body=tep.substring(39,tep.length());
												//line=line.substring(54);
												int manualindex = 0;
												if((prevXml != null && !prevXml.isEmpty())&&(manualindex=prevXml.indexOf("<manual>"))>0)
												{
													
													if(!(ustring!=null && !ustring.isEmpty())){
														ustring = new String(prevXml.substring(0, prevXml.indexOf("</manual>")));
													    ustring+=body;
													}
														//ustring+=prevXml.substring(0, prevXml.indexOf("</manual>"))+body;
													else
													   ustring+=prevXml.substring(manualindex, prevXml.indexOf("</manual>"))+body;
													
													
												}
												else{
												   if((ustring.indexOf("xml")<0)&&(prevXml != null && !prevXml.isEmpty())&&(prevXml.indexOf("<computed>") > 0))
												   {
													   
													   ustring = new String(prevXml.substring(0,prevXml.indexOf("</computed>")));
													   ustring+= "</computed>";
												   }
												   else if(ustring.indexOf("xml")<0)
													   ustring = new String("<?xml version=\"1.0\" encoding=\"UTF-16\"?><gg>");
												
												    ustring=ustring+"<manual>"+body;
												}
												first=false;
												
											  //result=result+line;
											 
												}
											else
											 {
												//line=line.substring(54);
												tep=tep.substring(39);
												ustring=ustring+tep;
											
											}
											//ustring=tep;
											System.out.println("----------->>>>"+tep);
											//if(!("print".equals(tep)))
												//ustring=ustring+tep;



									}

									else
										temp=comorbidity.writeToDocument(request, writer,flag);	

									//else
									//System.out.println("commit");
									continue;
								}
								
								
							}
						ustring=ustring+"</manual>";
						}
						
						if((ustring!=null && !ustring.isEmpty())&&(prevXml != null && !prevXml.isEmpty()))
						{
							if((prevXml.indexOf("<manual>")>0) && (ustring.indexOf("<manual>")<0))
									{
								       ustring+=prevXml.substring(prevXml.indexOf("<manual>"), prevXml.indexOf("</manual>"));
								       ustring+="</manual>";
									}
							
						}
						
						
						ustring=ustring+"</gg>";
						System.out.println("Generated XML:"+ustring);
				
						if(flag==1){
							//ustring.replaceAll("ICD9 CODE:","");
							/*StringTokenizer st = new StringTokenizer(ustring,",(ICD9 CODE: ");
				String str1;
				int uflag=0;
				 if(flag==1){
				while(st.hasMoreElements())
				{

					StringTokenizer st2=new StringTokenizer(st.nextToken(),")");
					//if("".equals(furl))
						//furl=st2.nextToken();
					//else
					if(uflag==0)
					{
						furl=furl+st2.nextToken();
					uflag++;	
					}

					else
						furl=furl+"|"+st2.nextToken();


				}  */
							//furl=furl+ustring;
					//appending new comorbidities to prev xml
					
							WebDriver driver = new HtmlUnitDriver();
							String pageHead=null;
							String link="http://172.31.133.112:8080/test/test.jsp";  //radiology server
							//String link="http://172.24.236.101:8080/test/test.jsp";  //test server
							//String link="http://127.0.0.1:8080/test/test.jsp";
							//byte[] sendBytes = ustring.getBytes();
							//String send = DatatypeConverter.printBase64Binary(sendBytes);
							//System.out.println("encoded url --------------->"+send);
							//String link="http://172.31.133.112:8080/test.html";
							//String link="https://starsmobile.cernerworks.com/discern/mpages/reports/uhmc_mp_add_diagnoses?parameters=";
							  //https://starsmobile.cernerworks.com/discern/mpages/reports/uhmc_mp_add_diagnoses?parameters=
							 // driver.get(link+furl);
							driver.get(link);
							  
							  System.out.println("the title is "+driver.getTitle());
							  System.out.println( driver.getCurrentUrl());
							  driver.findElement(By.id("tbXML")).sendKeys(ustring);
							  driver.findElement(By.id("tbEncId")).sendKeys(request.getParameter("encntr_id"));
						      //driver.findElement(By.id("password")).sendKeys("cerner3");
						      //driver.findElement(By.id("Domain")).sendKeys("B159");
						      
						      driver.findElement(By.id("submit")).submit();
						      Thread.sleep(1000);
						      
						      if(!(pageHead=driver.getTitle()).equals("success")){
							/*
							String link="https://unvrnympnp.cernerworks.com/mp_mobile/mpages/reports/uhmc_mp_add_diagnoses?parameters=";
							//String link="https://starsmobile.cernerworks.com/discern/mpages/reports/uhmc_mp_add_diagnoses?parameters=";
							//https://starsmobile.cernerworks.com/discern/mpages/reports/uhmc_mp_add_diagnoses?parameters=
							driver.get(link+furl);
							pageHead=driver.getTitle();
							System.out.println("the title is "+driver.getTitle());
							System.out.println( driver.getCurrentUrl());
							driver.findElement(By.id("username")).sendKeys("cerner3");
							driver.findElement(By.id("password")).sendKeys("cerner3");
							//driver.findElement(By.id("Domain")).sendKeys("B159");

							driver.findElement(By.className("txtb")).submit();
							System.out.println( driver.getCurrentUrl());    */
						    pageHead = "Error: Could not commit";
						    }
							request.getSession().setAttribute("error",pageHead);
						    

							//PrintWriter out = response.getWriter();  
							response.setContentType("text/html");  
							String rp="Commit.jsp";
							//HttpServletResponse.sendRedirect(rp);
							
						/*	String url = request.getRequestURL()+"?"+request.getQueryString();
							request.setAttribute("url",url);
							ServletContext context= getServletContext();
							RequestDispatcher rd= context.getRequestDispatcher("/LoggedIn");
							rd.forward(request, response);
                             */
							 
						     System.out.println("prevURL_print--->"+request.getParameter("prevURL_print"));
							getServletContext().getRequestDispatcher("/Commit.jsp").forward(request, response);
						     
							
							
							//response.sendRedirect(rp);
							//System.out.println(furl);
						}

					
					if(flag==0)
					{
						paragraph = new Paragraph("\n");
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthTop(0);

						table.addCell(cell);

						DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy h:mm a");
						Date date = new Date();
						String Date = dateFormat.format(date);

						font = FontFactory.getFont("Times-Roman",14, Font.BOLD);

						writer.beginParagraph();

						writer.outLine("\n Physician Name:  _________________________"+ "  " + "ID #:  _________________________" + 
								"\n\n" +
								"Physician Signature:   _______________________" + "  ",font);
						writer.outLine("Date: ",font);
						writer.outLine(Date.substring(0,10) + "  ", FontFactory.getFont("Times-Roman",14));
						writer.outLine("Time: ",font);
						writer.outLine(Date.substring(11) + "\n\n", FontFactory.getFont("Times-Roman",14));

						writer.endParagraph();

						table = new PdfPTable(1);
						paragraph = new Paragraph("\n\n");
						cell = new PdfPCell(paragraph);
						cell.setBorderWidthBottom(0);
						cell.setBorderWidthRight(0);
						cell.setBorderWidthLeft(0);
						table.addCell(cell);
						table.setWidthPercentage(100);
						document.add(table);
					}
				}
				catch (Exception e) {
					if(writer!=null)
					{
						try 
						{
							writer.cancelParagraph();
							writer.beginParagraph();
							writer.outLine("Error in document generation "+e.getMessage()+"\n"+Arrays.asList(e.getStackTrace()), errorFont);
							writer.endParagraph();
						} 
						catch (DocumentException e1) 
						{
							e1.printStackTrace();
						}
					}	
					else
					{
						e.printStackTrace();
					}
				}
				if(flag==0)
					document.close();		
				//memstream.flush();
				//response.getOutputStream().write(memstream.toByteArray());
				/*		final PrintWriter out = response.getWriter();
		out.println("<body><IMG SRC=\"barcode.bmp\"><br>");
		for(int i=0; i<100000; i++)
			out.println(i+"; <font color=\"blue\">Hello World print latest response,</font> time = "+new Date()+"<br>");
		out.println("</body>");*/
				System.out.println("PrintLatest doGet request done: "+new Date());
			}
			@Override
			protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

				doGet(request, response);

			}
}

