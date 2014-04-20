package comorb;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
 
import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;
public class XMLGenerator {
	public ArrayList<String> ss=new ArrayList<String>();
	File f;
	FileWriter fw;
	BufferedWriter bw;
	BufferedReader reader;
	String printString;
	
	public XMLGenerator(){
		printString="";
		
		f=new File("cc.txt");
		//f=new File("C:\\Users\\iramakris\\Documents\\cc.txt");
		System.out.println("test this ____________>>>>>>>>>"+f.getAbsolutePath());
	}
	
		  public String generateXMLString(Document doc){
			  String line=null;
			  String resultString="";
			 
			  try {
			
	 
			// write the content into xml file
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource source = new DOMSource(doc);
			
			StreamResult result = new StreamResult(f);
			transformer.transform(source, result);
			
			try {
				 reader = new BufferedReader(new FileReader(f));
					while ((line = reader.readLine()) != null) {
						
							resultString=resultString+line;
						}
					 
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
			
			
			  
			System.out.println("File saved!");
	 
		  
		  } catch (TransformerException t) {
			t.printStackTrace();
		  }
			return resultString;
	
	}
	
		 
}
