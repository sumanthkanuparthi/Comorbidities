<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.HashMap"%> 
<%@page import="java.util.Map.Entry"%>  
<%@page import="comorb.*"%>
<%@page import="java.util.logging.*" %>
<%@page import="org.openqa.selenium.By"%>
<%@page import="org.openqa.selenium.WebDriver"%>
<%@page import="org.openqa.selenium.htmlunit.HtmlUnitDriver"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.ParserConfigurationException"%>
<%@page import="javax.xml.transform.Transformer"%>
<%@page import="javax.xml.transform.TransformerException"%>
<%@page import="javax.xml.transform.TransformerFactory"%>
<%@page import="javax.xml.transform.dom.DOMSource"%>
<%@page import="javax.xml.transform.stream.StreamResult"%>
<%@page import="org.w3c.dom.Attr"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.xml.sax.InputSource"%>
<%@page import="java.io.File"%>
<%@page import="org.w3c.dom.Node" %>
<%@page import="org.w3c.dom.NodeList" %>
<%@page import="java.io.StringReader" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Receiving Data</title>

<style type="text/css">

#ulcheckboxlist li{list-style-type:none;
                    line-height: 150%;}

</style>

<style type="text/css">

.imageBackSingle{
width:410px; 
height:350px; 
position: absolute; 
margin-left: 30px;  
margin-top: -45px;
display:none;
background: transparent;
}

.imageBack{
width:375px; 
height:300px;
position: absolute; 
margin-left: 20px; 
margin-top: -125px; 
display:none;
background: transparent;
}

.dynamicDiv {
position: relative; 
margin-left: 45px;
margin-top: -270px; 
/* display: none;  */
border: 1px solid red; 
padding-left: 13px; 
padding-bottom : 2%;
font-family: sans-serif;
font-size: 14px;
}

.borderMain {

padding-left: 3%;
padding-bottom : 2%;
padding-top: 1%;

}  

span{
font-size: 16px;
font-weight: 700;
}

.test {
text-align: center;
font-size: 16px;
padding: 4px;
width: 19%;
border-width: 1px;
border-style: solid;
border-color: #cc0000;
background-color: #EEEDD8;
}

tr{
    height:25px;
    cursor: pointer;
}

a {
    cursor: pointer;
}
</style>
<script src="javascript/datetimepicker_css.js"> </script>
<script src="javascript/MpageServerInterface.js"> </script>
</head>

<body onload="startstop()" bgcolor = "white" style="font-family: sans-serif; font-size: 14px; ">
<div>
        
<!-- <form name="form1" action="Print" method="get" target="_blank"> -->
<!-- <form name="form1" action="" method="get" target=""> --> 
<!-- <form name="form1" action="htmlPrint.jsp" method="get" target="_blank"> -->
<script src="javascript/CoMorbMain.js"> </script>
<form name="form1" action="PrintLatest" method="get" target="_top">

    <p class="test" onclick="prevComputedCoMorb()">Previously Computed CoMorbidities/Clinical Conditions&nbsp;&nbsp;
    <img id="arrow-top" border="0" src="images/arrow-down.gif" alt="Computed CoMorbidities "/>
    </p>
    <div id="prevComputedCoMorb" class="borderMain" style="display: none;">
    <%String spaces = " ";
	Map<String,Map<String, String>> valueMatch=new HashMap<String,Map<String, String>>(); //ValueMatch
    String printPrevCoMorb="";
	int somevalue=0;
    ArrayList<String> disableCoMorb=new ArrayList<String>();
    System.out.println("the selenium testing 1 2 3 ----------------------------");
    String encounterID=request.getParameter("encntr_id");
    WebDriver driver = new HtmlUnitDriver();
    //File queryFile=new File("query.txt");
    //File queryFile= new File("C:\\Users\\iramakris\\Documents\\query.xml");
    
  //String pageHead="";
   String link="http://172.31.133.112:8080/test/test.jsp";  //radiology server
//String link="http://172.24.236.101:8080/test/test.jsp";  //test server
//	String link="http://127.0.0.1:8080/test/test.jsp"; 
  	

  	driver.get(link);
    
    
    driver.findElement(By.id("tbEncId")).sendKeys(encounterID);
   
    driver.findElement(By.id("submit")).submit();
    //pageHead=driver.getTitle();
   
    //String queryResult= driver.findElement(By.id("xml")).getText();
    String queryResult=driver.getTitle();
    //String specialString="";
    String infoBoxString="";
    request.getSession().setAttribute("prevXml1",queryResult);
    
    System.out.println("coming ------------------))))))) "+queryResult);
    if(!queryResult.equals("-1")){
    	
    	Document document;
	    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();  
	    DocumentBuilder builder;  
	    try  
	    {  
	        builder = factory.newDocumentBuilder();  
	        document = builder.parse( new InputSource( new StringReader( queryResult ) ) );  
	   
	    TransformerFactory transformerFactory = TransformerFactory.newInstance();
		Transformer transformer = transformerFactory.newTransformer();
		DOMSource source = new DOMSource(document);
		
		//StreamResult result1 = new StreamResult(queryFile);
		//transformer.transform(source, result1);
	    } catch (Exception e) {  
	        e.printStackTrace();  
	    } 
    
    
    
    
    } 
    try{
		//File fXmlFile = new File("testQuery.xml");
	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
	Document doc = dBuilder.parse(new InputSource(new StringReader(queryResult)));
 
	//optional, but recommended
	//read this - http://stackoverflow.com/questions/13786607/normalization-in-dom-parsing-with-java-how-does-it-work
	doc.getDocumentElement().normalize();
	
	
 
	System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
 
	Node previousComorb = doc.getElementsByTagName("computed").item(0);
	//
	if(previousComorb!=null){
	   NodeList comorbidityList = previousComorb.getChildNodes();
 %>
		<label id="lbComputed" onclick="prevComputedCoMorb1()">+ Computed comorbidities</label>
 		<div id="ComputedCoMorb1" class="borderMain" style="display: none">
 		<table id="prevtable" border = "0">

<%
	
	for (int temp = 0; temp < comorbidityList.getLength(); temp++) 
	{
		Map<String, String> values=new HashMap<String, String>(); //ValueMatch
		String nodeName="",nodeValue=""; //ValueMatch
		int noSubCategory=0, valuesCaptured=0;//ValueMatch
		Node comorbidityNode = comorbidityList.item(temp);
		String combName=""; //ValueMatch
		System.out.println("\nCurrent Element :" + comorbidityNode.getNodeName());
 
		if (comorbidityNode.getNodeType() == Node.ELEMENT_NODE) 
		{
			Element comorbidityElement = (Element) comorbidityNode; 
			combName=comorbidityElement.getElementsByTagName("name").item(0).getTextContent();
			printPrevCoMorb+=comorbidityElement.getElementsByTagName("name").item(0).getTextContent()+"\n";
			disableCoMorb.add(temp,comorbidityElement.getElementsByTagName("name").item(0).getTextContent());
			NodeList nll= comorbidityElement.getChildNodes();
			for(int j=0;j<nll.getLength();j++)
			{
				if(!nll.item(j).getNodeName().equals("subcategory"))
				{
					printPrevCoMorb+=nll.item(j).getNodeName()+": "+nll.item(j).getTextContent()+"\n";
					infoBoxString+=nll.item(j).getNodeName()+": "+nll.item(j).getTextContent()+"\n";
				}
			}
			
			///////// test this code 
			if(comorbidityElement.getElementsByTagName("name").item(0).getTextContent().equals("Morbid Obesity") || comorbidityElement.getElementsByTagName("name").item(0).getTextContent().equals("Obesity") || comorbidityElement.getElementsByTagName("name").item(0).getTextContent().equals("Dehydration"))
			{ 
				for(int j=0;j<nll.getLength();j++)
				{
					if(!nll.item(j).getNodeName().equals("subcategory"))
					{
						//printPrevCoMorb+=nll.item(j).getNodeName()+": "+nll.item(j).getTextContent()+"\n";
						//infoBoxString+=nll.item(j).getNodeName()+": "+nll.item(j).getTextContent()+"\n";
						if(!nll.item(j).getNodeName().equals("name") || !nll.item(j).getNodeName().equals("date") || !nll.item(j).getNodeName().equals("icd") || !nll.item(j).getNodeName().equals("time") || !nll.item(j).getNodeName().equals("datesys") || !nll.item(j).getNodeName().equals("subname") )
						{ 	//ValueMatch:Generating HashMap of testnames and values which are there in the main comorbidity
							noSubCategory=1;
							nodeName=nll.item(j).getNodeName();
							nodeValue=nll.item(j).getTextContent();
							System.out.println("NodeName :"+nodeName+"\t-->\tNodeValue :"+nodeValue);
							values.put(nodeName,nodeValue);
						}
					}
				}
				if(noSubCategory==1)
				{
					int match=0;
					Iterator iSameComorb=valueMatch.entrySet().iterator();
					while(iSameComorb.hasNext())
					{
						Entry e=(Entry)iSameComorb.next();
						if(e.getKey().equals(combName))
						{
							Map<String, String> valuesIn=new HashMap<String, String>();
							valuesIn=(Map<String, String>)e.getValue();
							Map<String, String> valuesToInsert=new HashMap<String, String>();
							valuesToInsert.putAll(valuesIn);
							valuesToInsert.putAll(values);
							iSameComorb.remove();
							valueMatch.put((String)e.getKey(),valuesToInsert);
							match=1;
						}
					}
					if(match==0)
					{
						valueMatch.put(combName,values);
					}
					/*Iterator imatch=values.entrySet().iterator();
					while(imatch.hasNext())
					{
						Entry e7=(Entry)imatch.next();
						System.out.println("N Name ==> "+e7.getKey()+"\t N Value ==>"+e7.getValue());
					}*/
				}
				%>
			
			<tr onmouseover="mouseOverPara('imageMobesity','<%=temp%>')" onmouseout="mouseOutPara('imageMobesity','<%=temp%>')" >
	            <td id="<%=temp%>">
	                <span style="color: blue;">
	                    <a onmouseover="makeDivVisible('Mobesity+<%=temp%>')" onmouseout="makeDivHidden('Mobesity+<%=temp%>')"><input type="checkbox" checked disabled name="39" id="Id+<%=temp %>"  value="<%=temp%>">
	                    <%=comorbidityElement.getElementsByTagName("name").item(0).getTextContent() %>&nbsp;&nbsp;</a></span>
	            </td>
	            <td>
	                    <div id="Mobesity+<%=temp %>" class="imageBack"><img src="images/divSingle.png" width="100%"; height="100%"/>
	                        <div id="Mobesity+<%=temp %>" class="dynamicDiv" style="width:275px; height:220px;">
	                        <br/><span style = "color: #858384; font-weight: bold;">
	                            Values are:<br/><br/></span>
	                                <%
	                                out.print(spaces +infoBoxString+"<br/>");
	                                %>
	                               
	                        </div>
	                    </div>
	                    <a id="imageMobesity" onmouseover="makeDivVisible('Mobesity')" 
	                    onmouseout="makeDivHidden('Mobesity')" style="visibility: hidden;">
	                    <img src="images/button1.jpg" alt="Details"/></a> 
	            </td>
	        </tr>    
				
			<% }
			
			//List<String> prevCombList = new List<String>();
			////// test code ends
			else{
			System.out.println("First Name : " + comorbidityElement.getElementsByTagName("name").item(0).getTextContent());
			String comorbname = new String(comorbidityElement.getElementsByTagName("name").item(0).getTextContent());
			%>
								<tr>
						            <td>
						                <span style="color: black;">
						                <input id="<%=comorbidityElement.getElementsByTagName("name").item(0).getTextContent() %>" type="checkbox" checked disabled name="mainGrp" value="<%=comorbidityElement.getElementsByTagName("name").item(0).getTextContent()%>"/><%=comorbidityElement.getElementsByTagName("name").item(0).getTextContent() %>
						               </span>
						            </td>
						            <td></td>
						        </tr>
						            
			
			
			<% 
		 
			//if(!comorbidityElement.getElementsByTagName("icd").item(0).getTextContent().isEmpty()){
			System.out.println("Last Name : " + comorbidityElement.getElementsByTagName("icd").item(0).getTextContent());}
			System.out.println("Nick Name : " + comorbidityElement.getElementsByTagName("date").item(0).getTextContent());
			System.out.println("Salary : " + comorbidityElement.getElementsByTagName("time").item(0).getTextContent());
			
			NodeList subcatNodeList=comorbidityElement.getElementsByTagName("subcategory");
			
			System.out.println("subcomorbidity size "+subcatNodeList.getLength());
			for(int i=0;i<subcatNodeList.getLength();i++)
			{
				Node subcatNode=subcatNodeList.item(i);
				System.out.println("subcat node name "+i+"is"+ subcatNode.getNodeName());
				if (subcatNode.getNodeType() == Node.ELEMENT_NODE) {
					 
					Element subcatElement = (Element) subcatNode;
					NodeList subcatChildList = subcatElement.getChildNodes();
					System.out.println("child node of a subcat "+ subcatChildList.getLength());
					String displayString="";
					for(int j=0;j<subcatChildList.getLength();j++)
					{
						
						if(subcatChildList.item(j).getNodeType()==Node.ELEMENT_NODE){
							printPrevCoMorb+=subcatChildList.item(j).getNodeName()+":"+subcatChildList.item(j).getTextContent()+"\n";	
							if(!subcatChildList.item(j).getNodeName().equals("subname")){
								displayString+=subcatChildList.item(j).getNodeName()+":"+subcatChildList.item(j).getTextContent()+"<br/>";	
							}
						}
						//if(!nll.item(j).getNodeName().equals("name") || !nll.item(j).getNodeName().equals("date") || !nll.item(j).getNodeName().equals("icd") || !nll.item(j).getNodeName().equals("time") || !nll.item(j).getNodeName().equals("datesys") || !nll.item(j).getNodeName().equals("subname") )
						//{	
							//ValueMatch: Generating HashMap for test name and values which are there in sub-comorbidities
							valuesCaptured=1;
							nodeName=nll.item(j).getNodeName();
							System.out.println("NodeName :"+nodeName+"\t-->\tNodeValue :"+nodeValue);
							nodeValue=nll.item(j).getTextContent();
							values.put(subcatChildList.item(j).getNodeName(),subcatChildList.item(j).getTextContent());
						//}
					}
					
					%>
					<tr onmouseover="mouseOverPara('imageAbl','<%=i %>')" onmouseout="mouseOutPara('imageAbl','<%=i%>')">
						<td></td>
						<td></td>
						<td id = "<%=i%>">
					   
							<span style="color: black;">
							<input id="<%=subcatElement.getElementsByTagName("subname").item(0).getTextContent() %>" type="checkbox" checked disabled name="an" value="<%=subcatElement.getElementsByTagName("subname").item(0).getTextContent()%>"/>
							<a onmouseover="makeDivVisible('<%=i+"div"%>')" onmouseout="makeDivHidden('<%=i+"div"%>')">
							<%=subcatElement.getElementsByTagName("subname").item(0).getTextContent()%>&nbsp;&nbsp;</a></span><br/>
							</td>
							<td>
							 <div id="<%=i+"div"%>" class="imageBack" style="width:450px; height:400px;"><img src="images/div.png" width="100%"; height="100%"/>
							 <div id="<%=i+"div"%>" class="dynamicDiv" style="width:350px; height:320px; margin-left: 55px ; margin-top: -370px;">

								<br/><span style = "color: #858384; font-weight: bold;">
								Values are:<br/><br/></span>
						<%
									out.print(spaces +displayString+"<br/>");
						  
						   %>           
							   
							</div>
						</div>                 
						<a id="imageAbl" onmouseover="makeDivVisible('<%=i+"div"%>')" 
						onmouseout="makeDivHidden('<%=i+"div"%>')" style="visibility: hidden;">
						<img src="images/button1.jpg" alt="Details"/></a> 
						</td>    
					</tr>
							
							<%	
				              
							//System.out.println("name "+subcatChildList.item(j).getNodeName()+" value ="+ subcatChildList.item(j).getTextContent());
							
					
					}
				}
				if(valuesCaptured==1)
				{
					int match=0;
					Iterator iSameComorb=valueMatch.entrySet().iterator();
					while(iSameComorb.hasNext())
					{
						Entry e=(Entry)iSameComorb.next();
						if(e.getKey().equals(combName))
						{
							Map<String, String> valuesIn=new HashMap<String, String>();
							valuesIn=(Map<String, String>)e.getValue();
							Map<String, String> valuesToInsert=new HashMap<String, String>();
							valuesToInsert.putAll(valuesIn);
							valuesToInsert.putAll(values);
							iSameComorb.remove();
							valueMatch.put((String)e.getKey(),valuesToInsert);
							match=1;
						}
					}
					if(match==0)
					{
						valueMatch.put(combName,values);
					}
				/*	Iterator imatch2=values.entrySet().iterator();
					while(imatch2.hasNext())
					{
						Entry e5=(Entry)imatch2.next();
						System.out.println("NL Name ==>"+e5.getKey()+"\t NL Value ==>"+e5.getValue());
					}*/
					somevalue=1;
				}
			
		}
	 }
	System.out.println("SOme Value :"+somevalue);
	if(somevalue==1)	
	{
		Iterator itest1=valueMatch.entrySet().iterator();
		while(itest1.hasNext())
		{
			Entry e=(Entry)itest1.next();
			System.out.println("Comorbidity Name : "+e.getKey());
			Map<String, String> ival=new HashMap<String, String>();
			ival=(Map<String, String>)e.getValue();
			Iterator itest2=ival.entrySet().iterator();
			while(itest2.hasNext())
			{
				Entry e1=(Entry)itest2.next();
				System.out.println("Node Name ==>"+e1.getKey()+"\tNode Value ==>"+e1.getValue());
			}
		}
	}
		
		%>
		  </table>
          </div>
            <br>
            <br>
		<% 
	} //added to close if condition for Computed values
    //added to close for loop
    %>
  
  
<%

		Node manualComorb = doc.getElementsByTagName("manual").item(0);
        if(manualComorb!=null){
		NodeList comorbidityList1 = manualComorb.getChildNodes();
%>    
 		<label id="lbManual" onclick="prevComputedCoMorb2()">+ Other comorbidities</label>
 		<div id="ManualCoMorb" class="borderMain" style="display: none">
 		<table id="manualtable" border = "0">

<%  String infoBoxString1="";
	String printPrevCoMorb1="";
	
	for (int temp = 0; temp < comorbidityList1.getLength(); temp++) {
 
		Node comorbidityNode = comorbidityList1.item(temp);
 
		System.out.println("\nCurrent Element :" + comorbidityNode.getNodeName());
 
		if (comorbidityNode.getNodeType() == Node.ELEMENT_NODE) {
 
			Element comorbidityElement1 = (Element) comorbidityNode;
			
 
			//System.out.println("Staff id : " + eElement.getAttribute("id"));
			printPrevCoMorb1+=comorbidityElement1.getElementsByTagName("name").item(0).getTextContent()+"\n";
			NodeList nll= comorbidityElement1.getChildNodes();
			for(int j=0;j<nll.getLength();j++){
				if(!nll.item(j).getNodeName().equals("subcategory")){
					printPrevCoMorb1+=nll.item(j).getNodeName()+": "+nll.item(j).getTextContent()+"\n";
					infoBoxString1+=nll.item(j).getNodeName()+": "+nll.item(j).getTextContent()+"\n";
				}
				
			}
			///////// test this code 
			if(comorbidityElement1.getElementsByTagName("name").item(0).getTextContent().equals("Coma") || comorbidityElement1.getElementsByTagName("name").item(0).getTextContent().equals("Acute Pulmonary Edema") || comorbidityElement1.getElementsByTagName("name").item(0).getTextContent().equals("Anoxic Brain Injury")|| comorbidityElement1.getElementsByTagName("name").item(0).getTextContent().equals("Pleural Effusion")|| comorbidityElement1.getElementsByTagName("name").item(0).getTextContent().equals("PSVT")){  %>
				<tr onmouseover="mouseOverPara('imageMobesity','<%=temp%>')" onmouseout="mouseOutPara('imageMobesity','<%=temp%>')" >
	            <td id="<%=temp%>">
	                <span style="color: blue;">
	                    <a onmouseover="makeDivVisible('Mobesity1+<%=temp%>')" onmouseout="makeDivHidden('Mobesity1+<%=temp%>')"><input type="checkbox" checked disabled name="39" id="Id+<%=temp %>"  value="<%=temp%>">
	                    <%=comorbidityElement1.getElementsByTagName("name").item(0).getTextContent() %>&nbsp;&nbsp;</a></span>
	            </td>
	            <td>
	                    <div id="Mobesity1+<%=temp %>" class="imageBack"><img src="images/divSingle.png" width="100%"; height="100%"/>
	                        <div id="Mobesity1+<%=temp %>" class="dynamicDiv" style="width:275px; height:220px;">
	                        <br/><span style = "color: #858384; font-weight: bold;">
	                            Values are:<br/><br/></span>
	                                <%
	                                out.print(spaces +infoBoxString1+"<br/>");
	                                %>
	                               
	                        </div>
	                    </div>
	                    <a id="imageMobesity" onmouseover="makeDivVisible('Mobesity')" 
	                    onmouseout="makeDivHidden('Mobesity')" style="visibility: hidden;">
	                    <img src="images/button1.jpg" alt="Details"/></a> 
	                </td>
	        </tr>    
				
			<% }
			
			//List<String> prevCombList = new List<String>();
			////// test code ends
			else{
			System.out.println("First Name : " + comorbidityElement1.getElementsByTagName("name").item(0).getTextContent());
			String comorbname = new String(comorbidityElement1.getElementsByTagName("name").item(0).getTextContent());

			%>
								<tr>
						            <td>
						                <span style="color: black;">
						                <input id="<%=comorbidityElement1.getElementsByTagName("name").item(0).getTextContent() %>" type="checkbox" checked disabled name="mainGrp" value="<%=comorbidityElement1.getElementsByTagName("name").item(0).getTextContent()%>"/><%=comorbidityElement1.getElementsByTagName("name").item(0).getTextContent() %>
						               </span>
						            </td>
						            <td></td>
						        </tr>
						            
			
			
			<% 
		 
			//if(!comorbidityElement.getElementsByTagName("icd").item(0).getTextContent().isEmpty()){
			System.out.println("Last Name : " + comorbidityElement1.getElementsByTagName("icd").item(0).getTextContent());}
			System.out.println("Nick Name : " + comorbidityElement1.getElementsByTagName("date").item(0).getTextContent());
			System.out.println("Salary : " + comorbidityElement1.getElementsByTagName("time").item(0).getTextContent());
			
			NodeList subcatNodeList1=comorbidityElement1.getElementsByTagName("subcategory");
			
			System.out.println("subcomorbidity size "+subcatNodeList1.getLength());
			for(int i=0;i<subcatNodeList1.getLength();i++){
				Node subcatNode1=subcatNodeList1.item(i);
				System.out.println("subcat node name "+i+"is"+ subcatNode1.getNodeName());
				if (subcatNode1.getNodeType() == Node.ELEMENT_NODE) {
					 
					Element subcatElement1 = (Element) subcatNode1;
					NodeList subcatChildList1 = subcatElement1.getChildNodes();
					System.out.println("child node of a subcat "+ subcatChildList1.getLength());
					String displayString="";
					for(int j=0;j<subcatChildList1.getLength();j++){
						
						if(subcatChildList1.item(j).getNodeType()==Node.ELEMENT_NODE){
							printPrevCoMorb+=subcatChildList1.item(j).getNodeName()+":"+subcatChildList1.item(j).getTextContent()+"\n";	
							if(!subcatChildList1.item(j).getNodeName().equals("subname")){
						displayString+=subcatChildList1.item(j).getNodeName()+":"+subcatChildList1.item(j).getTextContent()+"<br/>";	}
						}
					}
					
					%>
					<tr onmouseover="mouseOverPara('imageAbl','<%=i %>')" onmouseout="mouseOutPara('imageAbl','<%=i%>')">
	                <td></td>
	                <td></td>
	                <td id = "<%=i%>">
	               
	                    <span style="color: black;">
	                    <input id="<%=subcatElement1.getElementsByTagName("subname").item(0).getTextContent() %>" type="checkbox" checked disabled name="an" value="<%=subcatElement1.getElementsByTagName("subname").item(0).getTextContent()%>"/>
	                    <a onmouseover="makeDivVisible('<%=i+"div1"%>')" onmouseout="makeDivHidden('<%=i+"div1"%>')">
	                    <%=subcatElement1.getElementsByTagName("subname").item(0).getTextContent()%>&nbsp;&nbsp;</a></span><br/>
					</td>
	                    <td>
                   		 <div id="<%=i+"div1"%>" class="imageBack" style="width:450px; height:400px;"><img src="images/div.png" width="100%"; height="100%"/>
                       	 <div id="<%=i+"div1"%>" class="dynamicDiv" style="width:350px; height:320px; margin-left: 55px ; margin-top: -370px;">

                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
	                <%
                                out.print(spaces +displayString+"<br/>");
                      
                       %>           
                           
                        </div>
                    </div>                 
                    <a id="imageAbl" onmouseover="makeDivVisible('<%=i+"div1"%>')" 
                    onmouseout="makeDivHidden('<%=i+"div1"%>')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>    
            </tr>
							
							<%	
				              
								
					}
				}
			
		}
	}
	%>
	  </table>
      </div>
	<% 
	} //added to close if
	}//added to close try 
	catch (Exception e) {
	e.printStackTrace();
    }
    
    %>
  
     <input type="hidden" name="printPrevCoMorb" id="printPrevCoMorb" value="<%=printPrevCoMorb%>">
    	<!--  input type="hidden" name="queryResult" id="queryResult" value="<%=queryResult%>"-->
    </div>
    
    
    <p class="test" onclick="computedCoMorb()">Computed CoMorbidities/Clinical Conditions&nbsp;&nbsp;
    <img id="arrow-computed" border="0" src="images/arrow-up.gif" alt="Computed CoMorbidities "/>
    </p>
    <div id="computedCoMorb" class="borderMain" style="display: block;">
    
    <%    
    
    //String encounterID=request.getParameter("encntr_id");
    String userID=request.getParameter("user_id");
    System.out.println("+++++++++++++++++++++"+encounterID+"ggggg"+userID);%>
    <input type="hidden" name="encntr_id" id="encntr_id" value="<%=encounterID%>">
	<input type="hidden" name="user_id" id="user_id" value="<%=userID%>">
    
    
    <%
    System.out.println("the value I am printing"+request.getParameter("printer"));
    
    //Heart Rate
        String maxhRate = request.getParameter("hr_max_val"),
               minhRate = request.getParameter("hr_min_val"),
               maxhDate = request.getParameter("hr_max_date"),
               minhDate = request.getParameter("hr_min_date"),
               hLow = request.getParameter("hr_low"),
               hHigh = request.getParameter("hr_high"),
               newmaxhDate = "",
              
               newminhDate = "";
    
    //Formatting the date when the date is present else setting the date to N/A
            if(maxhDate.isEmpty() != true){
                String newmaxhYear = maxhDate.substring(0, 4), newmaxhMonth = maxhDate.substring(5, 7), newmaxhDay = maxhDate.substring(8, 10);
                newmaxhDate = "on" + newmaxhMonth + "/" + newmaxhDay + "/" + newmaxhYear + " at " + maxhDate.substring(11, 16);     
                
            }
            else{
                newmaxhDate = "N/A";
                
            }
            if(minhDate.isEmpty() != true){
                String newminhYear = minhDate.substring(0, 4), newminhMonth = minhDate.substring(5, 7), newminhDay = minhDate.substring(8, 10);
                newminhDate = "on " + newminhMonth + "/" + newminhDay + "/" + newminhYear + " at " + minhDate.substring(11, 16);     
                
            }
            else{
                newminhDate  = "N/A" ;
                
            }        
            System.out.println("Max heart rate: " + maxhRate);
            System.out.println("Min heart rate: " + minhRate);
            System.out.println("Max heart rate Date: " + newmaxhDate);
            System.out.println("Min heart rate Date: " + newminhDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max heart rate: " + maxhRate);
            logger.log(Level.INFO, "Min heart rate: " + minhRate);
            logger.log(Level.INFO, "Max heart rate Date: " + newmaxhDate);
            logger.log(Level.INFO, "Min heart rate Date: " + newminhDate); */
        
            
            
        //Respiratory rate
            String maxrRate = request.getParameter("rr_max_val"),
                   minrRate = request.getParameter("rr_min_val"),
                   maxrDate = request.getParameter("rr_max_date"),
                   minrDate = request.getParameter("rr_min_date"),
                   rLow = request.getParameter("rr_low"),
                   rHigh = request.getParameter("rr_high"),
                   newmaxrDate = "",
                   newminrDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
            if(maxrDate.isEmpty() != true){
                String newmaxrYear = maxrDate.substring(0, 4), newmaxrMonth = maxrDate.substring(5, 7), newmaxrDay = maxrDate.substring(8, 10);
                newmaxrDate = "on " + newmaxrMonth + "/" + newmaxrDay + "/" + newmaxrYear + " at " + maxrDate.substring(11, 16);     
            }
            else{
                newmaxrDate = "N/A";
            }
            if(minrDate.isEmpty() != true){
                String newminrYear = minrDate.substring(0, 4), newminrMonth = minrDate.substring(5, 7), newminrDay = minrDate.substring(8, 10);
                newminrDate = " on " + newminrMonth + "/" + newminrDay + "/" + newminrYear + " Time = " + minrDate.substring(11, 16);     
            }
            else{
                newminrDate = "N/A";
            }        
            System.out.println("Max Respiratory rate: " + maxrRate);
            System.out.println("Min Respiratory rate: " + minrRate);
            System.out.println("Max Respiratory rate Date: " + newmaxrDate);
            System.out.println("Min Respiratory rate Date: " + newminrDate);
            /* 
            logger.log(Level.INFO, "Max Respiratory rate: " + maxrRate);
            logger.log(Level.INFO, "Min Respiratory rate: " + minrRate);
            logger.log(Level.INFO, "Max Respiratory rate Date: " + newmaxrDate);
            logger.log(Level.INFO, "Min Respiratory rate Date: " + newminrDate); */
        
            //Haemoglobin
            String     maxhb = request.getParameter("hb_max_val"),
                    minhb = request.getParameter("hb_min_val"),
                       maxhbDate = request.getParameter("hb_max_date"),
                    minhbDate = request.getParameter("hb_min_date"),
                       hbLow = request.getParameter("hb_low"),
                       hbHigh = request.getParameter("hb_high"),
                       newmaxhbDate = "",
                    newminhbDate = "";
            
        //Formatting the date when the date is present else setting the date to N/A
        if(maxhbDate.isEmpty() != true){
            String newmaxhbYear = maxhbDate.substring(0, 4), newmaxhbMonth = maxhbDate.substring(5, 7), newmaxhbDay = maxhbDate.substring(8, 10);
            newmaxhbDate = " on " + newmaxhbMonth + "/" + newmaxhbDay + "/" + newmaxhbYear + " at " + maxhbDate.substring(11, 16);     
        }
        else{
            newmaxhbDate = "N/A";
        }
        if(minhbDate.isEmpty() != true){
            String newminhbYear = minhbDate.substring(0, 4), newminhbMonth = minhbDate.substring(5, 7), newminhbDay = minhbDate.substring(8, 10);
            newminhbDate = " on " + newminhbMonth + "/" + newminhbDay + "/" + newminhbYear + " at " + minhbDate.substring(11, 16);     
        }
        else{
            newminhbDate = "N/A";
        }
        
        System.out.println("Max hb: " + maxhb);
        System.out.println("Min hb: " + minhb);
        System.out.println("Max hb Date: " + newmaxhbDate );
        System.out.println("Min hb Date: " + newminhbDate);
        
        /*
        * Logging to file here
        */
        /* logger.log(Level.INFO, "Max hb: " + maxhb);
        logger.log(Level.INFO, "Min hb: " + minhb);
        logger.log(Level.INFO, "Max hb Date: " + newmaxhbDate);
        logger.log(Level.INFO, "Min hb Date: " + newminhbDate); */
            
        
        String     maxhb_prev = request.getParameter("hb_prev_max_val"),
                minhb_prev = request.getParameter("hb_prev_min_val"),
                   maxhb_prevDate = request.getParameter("hb_prev_max_date"),
                minhb_prevDate = request.getParameter("hb_prev_min_date"),
                   hb_prevLow = request.getParameter("hb_prev_low"),
                   hb_prevHigh = request.getParameter("hb_prev_high"),
                   newmaxhb_prevDate = "",
                newminhb_prevDate = "";
        
    //Formatting the date when the date is present else setting the date to N/A
    if(maxhb_prevDate.isEmpty() != true){
        String newmaxhb_prevYear = maxhb_prevDate.substring(0, 4), newmaxhb_prevMonth = maxhb_prevDate.substring(5, 7), newmaxhb_prevDay = maxhb_prevDate.substring(8, 10);
        newmaxhb_prevDate = " on " + newmaxhb_prevMonth + "/" + newmaxhb_prevDay + "/" + newmaxhb_prevYear + " at " + maxhb_prevDate.substring(11, 16);
    }
    else{
        newmaxhb_prevDate = "N/A";
    }
    if(minhb_prevDate.isEmpty() != true){
        String newminhb_prevYear = minhb_prevDate.substring(0, 4), newminhb_prevMonth = minhb_prevDate.substring(5, 7), newminhb_prevDay = minhb_prevDate.substring(8, 10);
        newminhb_prevDate = " on " + newminhb_prevMonth + "/" + newminhb_prevDay + "/" + newminhb_prevYear + " at " + minhb_prevDate.substring(11, 16);     
    }
    else{
        newminhb_prevDate = "N/A";
    }
    System.out.println("Max hb_prev: " + maxhb_prev);
    System.out.println("Min hb_prev: " + minhb_prev);
    System.out.println("Max hb_prev Date: " + newmaxhb_prevDate );
    System.out.println("Min hb_prev Date: " + newminhb_prevDate);
    
    /*
    * Logging to file here
    */
    /* logger.log(Level.INFO, "Max hb_prev: " + maxhb_prev);
    logger.log(Level.INFO, "Min hb_prev: " + minhb_prev);
    logger.log(Level.INFO, "Max hb_prev Date: " + newmaxhb_prevDate);
    logger.log(Level.INFO, "Min hb_prev Date: " + newminhb_prevDate); */
            
    //Haematocrit
            String     maxhc = request.getParameter("hc_max_val"),
                    minhc = request.getParameter("hc_min_val"),
                       maxhcDate = request.getParameter("hc_max_date"),
                    minhcDate = request.getParameter("hc_min_date"),
                       hcLow = request.getParameter("hc_low"),
                       hcHigh = request.getParameter("hc_high"),
                       newmaxhcDate = "",
                    newminhcDate = "";
    
    
        //Formatting the date when the date is present else setting the date to N/A
        if(maxhcDate.isEmpty() != true){
            String newmaxhcYear = maxhcDate.substring(0, 4), newmaxhcMonth = maxhcDate.substring(5, 7), newmaxhcDay = maxhcDate.substring(8, 10);
            newmaxhcDate = " on " + newmaxhcMonth + "/" + newmaxhcDay + "/" + newmaxhcYear + " at " + maxhcDate.substring(11, 16);     
        }
        else{
            newmaxhcDate = "N/A";
        }
        if(minhcDate.isEmpty() != true){
            String newminhcYear = minhcDate.substring(0, 4), newminhcMonth = minhcDate.substring(5, 7), newminhcDay = minhcDate.substring(8, 10);
            newminhcDate = " on " + newminhcMonth + "/" + newminhcDay + "/" + newminhcYear + " at " + minhcDate.substring(11, 16);     
        }
        else{
            newminhcDate = "N/A";
        }
        System.out.println("Max hc: " + maxhc);
        System.out.println("Min hc: " + minhc);
        System.out.println("Max hc Date: " + newmaxhcDate );
        System.out.println("Min hc Date: " + newminhcDate);
        
        /*
        * Logging to file here
        */
        /* logger.log(Level.INFO, "Max hc: " + maxhc);
        logger.log(Level.INFO, "Min hc: " + minhc);
        logger.log(Level.INFO, "Max hc Date: " + newmaxhcDate);
        logger.log(Level.INFO, "Min hc Date: " + newminhcDate); */
            
        
        //Haematocrit previous values
        String     maxhc_prev = request.getParameter("hc_prev_max_val"),
                minhc_prev = request.getParameter("hc_prev_min_val"),
                   maxhc_prevDate = request.getParameter("hc_prev_max_date"),
                minhc_prevDate = request.getParameter("hc_prev_min_date"),
                   hc_prevLow = request.getParameter("hc_prev_low"),
                   hc_prevHigh = request.getParameter("hc_prev_high"),
                   newmaxhc_prevDate = "",
                newminhc_prevDate = "";
    
    
    //Formatting the date when the date is present else setting the date to N/A    
    if(maxhc_prevDate.isEmpty() != true){
        String newmaxhc_prevYear = maxhc_prevDate.substring(0, 4), newmaxhc_prevMonth = maxhc_prevDate.substring(5, 7), newmaxhc_prevDay = maxhc_prevDate.substring(8, 10);
        newmaxhc_prevDate = " on " + newmaxhc_prevMonth + "/" + newmaxhc_prevDay + "/" + newmaxhc_prevYear + " at " + maxhc_prevDate.substring(11, 16);     
    }
    else{
        newmaxhc_prevDate = "N/A";
    }
    if(minhc_prevDate.isEmpty() != true){
        String newminhc_prevYear = minhc_prevDate.substring(0, 4), newminhc_prevMonth = minhc_prevDate.substring(5, 7), newminhc_prevDay = minhc_prevDate.substring(8, 10);
        newminhc_prevDate = " on " + newminhc_prevMonth + "/" + newminhc_prevDay + "/" + newminhc_prevYear + " at " + minhc_prevDate.substring(11, 16);     
    }
    else{
        newminhc_prevDate = "N/A";
    }
    System.out.println("Max hc_prev: " + maxhc_prev);
    System.out.println("Min hc_prev: " + minhc_prev);
    System.out.println("Max hc_prev Date: " + newmaxhc_prevDate );
    System.out.println("Min hc_prev Date: " + newminhc_prevDate);
    
    /*
    * Logging to file here
    */
    /* logger.log(Level.INFO, "Max hc_prev: " + maxhc_prev);
    logger.log(Level.INFO, "Min hc_prev: " + minhc_prev);
    logger.log(Level.INFO, "Max hc_prev Date: " + newmaxhc_prevDate);
    logger.log(Level.INFO, "Min hc_prev Date: " + newminhc_prevDate); */
        
        //Temperature
        String     maxtemp = request.getParameter("temp_max_val"),
                mintemp = request.getParameter("temp_min_val"),
                   maxtempDate = request.getParameter("temp_max_date"),
                mintempDate = request.getParameter("temp_min_date"),
                   tempLow = request.getParameter("temp_low"),
                   tempHigh = request.getParameter("temp_high"),
                   newmaxtempDate = "",
                newmintempDate = "";
    
        //Formatting the date when the date is present else setting the date to N/A
        if(maxtempDate.isEmpty() != true){
            String newmaxtempYear = maxtempDate.substring(0, 4), newmaxtempMonth = maxtempDate.substring(5, 7), newmaxtempDay = maxtempDate.substring(8, 10);
            newmaxtempDate = " on " + newmaxtempMonth + "/" + newmaxtempDay + "/" + newmaxtempYear + " at " + maxtempDate.substring(11, 16);     
        }
        else{
            newmaxtempDate = "N/A";
        }
        if(mintempDate.isEmpty() != true){
            String newmintempYear = mintempDate.substring(0, 4), newmintempMonth = mintempDate.substring(5, 7), newmintempDay = mintempDate.substring(8, 10);
            newmintempDate = " on " + newmintempMonth + "/" + newmintempDay + "/" + newmintempYear + " at " + mintempDate.substring(11, 16);     
        }
        else{
            newmintempDate = "N/A";
        }
        System.out.println("Max Temperatur: " + maxtemp);
        System.out.println("Min Temperature: " + mintemp);
        System.out.println("Max Temperature Date: " + newmaxtempDate );
        System.out.println("Min Temperature Date: " + newmintempDate);
        
        /*
        * Logging to file here
        */
        /* logger.log(Level.INFO, "Max Temperatur: " + maxtemp);
        logger.log(Level.INFO, "Min Temperature: " + mintemp);
        logger.log(Level.INFO, "Max Temperature Date: " + newmaxtempDate);
        logger.log(Level.INFO, "Min Temperature Date: " + newmintempDate); */
        
        // Lactate
        String maxlactate = request.getParameter("lactate_max_val"),
               minlactate = request.getParameter("lactate_min_val"),
               maxlactateDate = request.getParameter("lactate_max_date"),
               minlactateDate = request.getParameter("lactate_min_date"),
               lactateLow = request.getParameter("lactate_low"),
               lactateHigh = request.getParameter("lactate_high"),
               newmaxlactateDate = "",
               newminlactateDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
        if(maxlactateDate.isEmpty() != true){
            String newmaxlactateYear = maxlactateDate.substring(0, 4), newmaxlactateMonth = maxlactateDate.substring(5, 7), newmaxlactateDay = maxlactateDate.substring(8, 10);
            newmaxlactateDate = " on " + newmaxlactateMonth + "/" + newmaxlactateDay + "/" + newmaxlactateYear + " at " + maxlactateDate.substring(11, 16);     
        }
        else{
            newmaxlactateDate = "N/A";
        }
        if(minlactateDate.isEmpty() != true){
            String newminlactateYear = minlactateDate.substring(0, 4), newminlactateMonth = minlactateDate.substring(5, 7), newminlactateDay = minlactateDate.substring(8, 10);
            newminlactateDate = " on " + newminlactateMonth + "/" + newminlactateDay + "/" + newminlactateYear + " at " + minlactateDate.substring(11, 16);     
        }
        else{
            newminlactateDate = "N/A";
        }
        System.out.println("Max Lactate: " + maxlactate);
        System.out.println("Min Lactate: " + minlactate);
        System.out.println("Max Lactate Date: " + newmaxlactateDate );
        System.out.println("Min Lactate Date: " + newminlactateDate);
        
        /*
        * Logging to file here
        */
        /*logger.log(Level.INFO, "Max Lactate: " + maxlactate);
        logger.log(Level.INFO, "Min Lactate: " + minlactate);
        logger.log(Level.INFO, "Max Lactate Date: " + newmaxlactateDate);
        logger.log(Level.INFO, "Min Lactate Date: " + newminlactateDate); */
        
        //Glucose
            String maxglucResult = request.getParameter("glucose_max_val"),
                   minglucResult = request.getParameter("glucose_min_val"),
                   maxglucDate = request.getParameter("glucose_max_date"),
                   minglucDate = request.getParameter("glucose_min_date"),
                   glucLow = request.getParameter("glucose_low"), 
                   glucHigh = request.getParameter("glucose_high"),
                   newmaxglucDate = "",
                   newminglucDate = "";
            if (glucHigh.isEmpty())
            {
                glucHigh = "150";
            }
        
            //Formatting the date when the date is present else setting the date to N/A
            if(maxglucDate.isEmpty() != true){
                String newmaxglucYear = maxglucDate.substring(0, 4), newmaxglucMonth = maxglucDate.substring(5, 7), newmaxglucDay = maxglucDate.substring(8, 10);
                newmaxglucDate = " on " + newmaxglucMonth + "/" + newmaxglucDay + "/" + newmaxglucYear + " at " + maxglucDate.substring(11, 16);     
            }
            else{
                newmaxglucDate = "N/A";
            }
            if(minglucDate.isEmpty() != true){
                String newminglucYear = minglucDate.substring(0, 4), newminglucMonth = minglucDate.substring(5, 7), newminglucDay = minglucDate.substring(8, 10);
                newminglucDate = " on " + newminglucMonth + "/" + newminglucDay + "/" + newminglucYear + " at " + minglucDate.substring(11, 16);     
            }
            else{
                newminglucDate = "N/A";
            }
            System.out.println("Max Glucose: " + maxglucResult);
            System.out.println("Min Glucose: " + minglucResult);
            System.out.println("Max Glucose Date: " + newmaxglucDate );
            System.out.println("Min Glucose Date: " + newminglucDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max Glucose: " + maxglucResult);
            logger.log(Level.INFO, "Min Glucose: " + minglucResult);
            logger.log(Level.INFO, "Max Glucose Date: " + newmaxglucDate);
            logger.log(Level.INFO, "Min Glucose Date: " + newminglucDate); */
        
             
    //GFR
            String maxgfrResult = request.getParameter("gfr_max_val"),
                   mingfrResult = request.getParameter("gfr_min_val"),
                   maxgfrDate = request.getParameter("gfr_max_date"),
                   mingfrDate = request.getParameter("gfr_min_date"),
                   //gfrLow = request.getParameter("gfr_low"), 
                   //gfrHigh = request.getParameter("gfr_high"),
                   newmaxgfrDate = "",
                 newmingfrDate = "";
    
        //Formatting the date when the date is present else setting the date to N/A
            if(maxgfrDate.isEmpty() != true){
                    String newmaxgfrYear = maxgfrDate.substring(0, 4), newmaxgfrMonth = maxgfrDate.substring(5, 7), newmaxgfrDay = maxgfrDate.substring(8, 10);
                    newmaxgfrDate = " on " + newmaxgfrMonth + "/" + newmaxgfrDay + "/" + newmaxgfrYear + " at " + maxgfrDate.substring(11, 16);     
            }
            else{
                newmaxgfrDate = "N/A";
            }
            if(mingfrDate.isEmpty() != true){
                String newmingfrYear = mingfrDate.substring(0, 4), newmingfrMonth = mingfrDate.substring(5, 7), newmingfrDay = mingfrDate.substring(8, 10);
                newmingfrDate = " on " + newmingfrMonth + "/" + newmingfrDay + "/" + newmingfrYear + " at " + mingfrDate.substring(11, 16);     
            }
            else{
                newmingfrDate = "N/A";
            }
            System.out.println("Max gfr: " + maxgfrResult);
            System.out.println("Min gfr: " + mingfrResult);
            System.out.println("Max gfr Date: " + newmaxgfrDate );
            System.out.println("Min gfr Date: " + newmingfrDate); 
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max gfr: " + maxgfrResult);
            logger.log(Level.INFO, "Min gfr: " + mingfrResult);
            logger.log(Level.INFO, "Max gfr Date: " + newmaxgfrDate);
            logger.log(Level.INFO, "Min gfr Date: " + newmingfrDate); */
            
        //Cholesterol
            String maxcholesterolResult = request.getParameter("cholesterol_max_val"),
                   mincholesterolResult = request.getParameter("cholesterol_min_val"),
                   cholesterolLow = request.getParameter("cholesterol_low"), 
                   cholesterolHigh  = request.getParameter("cholesterol_high"),
                   maxcholesterolDate = request.getParameter("cholesterol_max_date"),
                   mincholesterolDate = request.getParameter("cholesterol_min_date"),
                   newmaxcholesterolDate = "",
                   newmincholesterolDate = "";
            
        //Formatting the date when the date is present else setting the date to N/A
            if(maxcholesterolDate.isEmpty() != true){
                String newmaxcholesterolYear = maxcholesterolDate.substring(0, 4), newmaxcholesterolMonth = maxcholesterolDate.substring(5, 7), newmaxcholesterolDay = maxcholesterolDate.substring(8, 10);
                newmaxcholesterolDate = " on " + newmaxcholesterolMonth + "/" + newmaxcholesterolDay + "/" + newmaxcholesterolYear + " at " + maxcholesterolDate.substring(11, 16);     
            }
            else{
                newmaxcholesterolDate = "N/A";
            }
            if(mincholesterolDate.isEmpty() != true){
                String newmincholesterolYear = mincholesterolDate.substring(0, 4), newmincholesterolMonth = mincholesterolDate.substring(5, 7), newmincholesterolDay = mincholesterolDate.substring(8, 10);
                newmincholesterolDate = " on " + newmincholesterolMonth + "/" + newmincholesterolDay + "/" + newmincholesterolYear + " at " + mincholesterolDate.substring(11, 16);     
            }
            else{
                newmincholesterolDate = "N/A";
            }
            System.out.println("Max Cholesterol: " + maxcholesterolResult);
            System.out.println("Min Cholesterol: " + mincholesterolResult);
            System.out.println("Max Cholesterol Date: " + newmaxcholesterolDate );
            System.out.println("Min Cholesterol Date: " + newmincholesterolDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max Cholesterol: " + maxcholesterolResult);
            logger.log(Level.INFO, "Min Cholesterol: " + mincholesterolResult);
            logger.log(Level.INFO, "Max Cholesterol Date: " + newmaxcholesterolDate);
            logger.log(Level.INFO, "Min Cholesterol Date: " + newmincholesterolDate); */
                
        //Sodium
            String maxsodiumResult = request.getParameter("sodium_max_val"),
                   minsodiumResult = request.getParameter("sodium_min_val"),
                   sodiumLow = request.getParameter("sodium_low"), 
                   sodiumHigh  = request.getParameter("sodium_high"),
                   maxsodiumDate = request.getParameter("sodium_max_date"),
                   minsodiumDate = request.getParameter("sodium_min_date"),
                   newmaxsodiumDate = "",
                        
                   newminsodiumDate = "";
            
        //Formatting the date when the date is present else setting the date to N/A
        if(maxsodiumDate.isEmpty() != true){
                String newmaxsodiumYear = maxsodiumDate.substring(0, 4), newmaxsodiumMonth = maxsodiumDate.substring(5, 7), newmaxsodiumDay = maxsodiumDate.substring(8, 10);
                newmaxsodiumDate = " on " + newmaxsodiumMonth + "/" + newmaxsodiumDay + "/" + newmaxsodiumYear + " at " + maxsodiumDate.substring(11, 16); 
                
            }
            else{
                newmaxsodiumDate = "N/A";
                
            }
            if(minsodiumDate.isEmpty() != true){
                String newminsodiumYear = minsodiumDate.substring(0, 4), newminsodiumMonth = minsodiumDate.substring(5, 7), newminsodiumDay = minsodiumDate.substring(8, 10);
                newminsodiumDate = " on " + newminsodiumMonth + "/" + newminsodiumDay + "/" + newminsodiumYear + " at " + minsodiumDate.substring(11, 16);     
                
            }
            else{
                newminsodiumDate = "N/A";
                
            }
            System.out.println("Max Sodium: " + maxsodiumResult);
            System.out.println("Min Sodium: " + minsodiumResult);
            System.out.println("Max Sodium Date: " + newmaxsodiumDate );
            System.out.println("Min Sodium Date: " + newminsodiumDate);    
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max Sodium: " + maxsodiumResult);
            logger.log(Level.INFO, "Min Sodium: " + minsodiumResult);
            logger.log(Level.INFO, "Max Sodium Date: " + newmaxsodiumDate);
            logger.log(Level.INFO, "Min Sodium Date: " + newminsodiumDate); */
        

            
        //Potassium    
        String         maxpotassiumResult = request.getParameter("potassium_max_val"),
                   minpotassiumResult = request.getParameter("potassium_min_val"),
                   potassiumLow = request.getParameter("potassium_low"), 
                   potassiumHigh  = request.getParameter("potassium_high"),
                   maxpotassiumDate = request.getParameter("potassium_max_date"),
                   minpotassiumDate = request.getParameter("potassium_min_date"),
                   newmaxpotassiumDate = "",
                   newminpotassiumDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
            if(maxpotassiumDate.isEmpty() != true){
                String newmaxpotassiumYear = maxpotassiumDate.substring(0, 4), newmaxpotassiumMonth = maxpotassiumDate.substring(5, 7), newmaxpotassiumDay = maxpotassiumDate.substring(8, 10);
                //newmaxpotassiumDate = newmaxpotassiumMonth + "/" + newmaxpotassiumDay + "/" + newmaxpotassiumYear + " " + newmaxpotassiumDay;
                newmaxpotassiumDate = " on " + newmaxpotassiumMonth + "/" + newmaxpotassiumDay + "/" + newmaxpotassiumYear + " at " + maxpotassiumDate.substring(11, 16);
            }
            else{
                newmaxpotassiumDate = "N/A";
            }
            if(minpotassiumDate.isEmpty() != true){
                String newminpotassiumYear = minpotassiumDate.substring(0, 4), newminpotassiumMonth = minpotassiumDate.substring(5, 7), newminpotassiumDay = minpotassiumDate.substring(8, 10);
                //newminpotassiumDate = newminpotassiumMonth + "/" + newminpotassiumDay + "/" + newminpotassiumYear + " " + newminpotassiumTime;
                newminpotassiumDate = " on " + newminpotassiumMonth + "/" + newminpotassiumDay + "/" + newminpotassiumYear + " at " + minpotassiumDate.substring(11, 16);
            }
            else{
                newminpotassiumDate = "N/A";
            }
            System.out.println("Max Potassium: " + maxpotassiumResult);
            System.out.println("Min Potassium: " + minpotassiumResult);
            System.out.println("Max Potassium Date: " + newmaxpotassiumDate );
            System.out.println("Min Potassium Date: " + newminpotassiumDate);
            
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max Potassium: " + maxpotassiumResult);
            logger.log(Level.INFO, "Min Potassium: " + minpotassiumResult);
            logger.log(Level.INFO, "Max Potassium Date: " + newmaxpotassiumDate);
            logger.log(Level.INFO, "Min Potassium Date: " + newminpotassiumDate); */
            
        //Calcium
        String maxcalciumResult = request.getParameter("calcium_max_val"),
                   mincalciumResult = request.getParameter("calcium_min_val"),
                   calciumLow = request.getParameter("calcium_low"), 
                   calciumHigh  = request.getParameter("calcium_high"),
                   maxcalciumDate = request.getParameter("calcium_max_date"),
                   mincalciumDate = request.getParameter("calcium_min_date"),
                   
                   newmaxcalciumDate = "",
                   newmincalciumDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
            if(maxcalciumDate.isEmpty() != true){
                String newmaxcalciumYear = maxcalciumDate.substring(0, 4), newmaxcalciumMonth = maxcalciumDate.substring(5, 7), newmaxcalciumDay = maxcalciumDate.substring(8, 10);
                newmaxcalciumDate = " on " + newmaxcalciumMonth + "/" + newmaxcalciumDay + "/" + newmaxcalciumYear + " at " + maxcalciumDate.substring(11, 16);
                     
            }
            else{
                newmaxcalciumDate = "N/A";
            }
            if(mincalciumDate.isEmpty() != true){
                String newmincalciumYear = mincalciumDate.substring(0, 4), newmincalciumMonth = mincalciumDate.substring(5, 7), newmincalciumDay = mincalciumDate.substring(8, 10);
                newmincalciumDate = " on " + newmincalciumMonth + "/" + newmincalciumDay + "/" + newmincalciumYear + " at " + mincalciumDate.substring(11, 16);
                     
            }
            else{
                newmincalciumDate = "N/A";
            }
            System.out.println("Max Calcium: " + maxcalciumResult);
            System.out.println("Min Calcium: " + mincalciumResult);
            System.out.println("Max Calcium Date: " + newmaxcalciumDate );
            System.out.println("Min Calcium Date: " + newmincalciumDate);    
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max Calcium: " + maxcalciumResult);
            logger.log(Level.INFO, "Min Calcium: " + mincalciumResult);
            logger.log(Level.INFO, "Max Calcium Date: " + newmaxcalciumDate);
            logger.log(Level.INFO, "Min Calcium Date: " + newmincalciumDate); */
            
        //Magnesium
        String maxmagnesiumResult = request.getParameter("magnesium_max_val"),
                   minmagnesiumResult = request.getParameter("magnesium_min_val"),
                   magnesiumLow = request.getParameter("magnesium_low"), 
                   magnesiumHigh  = request.getParameter("magnesium_high"),
                   maxmagnesiumDate = request.getParameter("magnesium_max_date"),
                   minmagnesiumDate = request.getParameter("magnesium_min_date"),
                   newmaxmagnesiumDate = "",
                   newminmagnesiumDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
            if(maxmagnesiumDate.isEmpty() != true){
                String newmaxmagnesiumYear = maxmagnesiumDate.substring(0, 4), newmaxmagnesiumMonth = maxmagnesiumDate.substring(5, 7), newmaxmagnesiumDay = maxmagnesiumDate.substring(8, 10);
                newmaxmagnesiumDate = " on " + newmaxmagnesiumMonth + "/" + newmaxmagnesiumDay + "/" + newmaxmagnesiumYear + " at " + maxmagnesiumDate.substring(11, 16);     
            }
            else{
                newmaxmagnesiumDate = "N/A";
            }
            if(minmagnesiumDate.isEmpty() != true){
                String newminmagnesiumYear = minmagnesiumDate.substring(0, 4), newminmagnesiumMonth = minmagnesiumDate.substring(5, 7), newminmagnesiumDay = minmagnesiumDate.substring(8, 10);
                newminmagnesiumDate = " on " + newminmagnesiumMonth + "/" + newminmagnesiumDay + "/" + newminmagnesiumYear + " at " + minmagnesiumDate.substring(11, 16);     
            }
            else{
                newminmagnesiumDate = "N/A";
            }
            System.out.println("Max Magnesium: " + maxmagnesiumResult);
            System.out.println("Min Magnesium: " + minmagnesiumResult);
            System.out.println("Max Magnesium Date: " + newmaxmagnesiumDate );
            System.out.println("Min Magnesium Date: " + newminmagnesiumDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max Magnesium: " + maxmagnesiumResult);
            logger.log(Level.INFO, "Min Magnesium: " + minmagnesiumResult);
            logger.log(Level.INFO, "Max Magnesium Date: " + newmaxmagnesiumDate);
            logger.log(Level.INFO, "Min Magnesium Date: " + newminmagnesiumDate); */
        
            
        //Phosphorus
        String maxphosphorusResult = request.getParameter("phosphorus_max_val"),
                   minphosphorusResult = request.getParameter("phosphorus_min_val"),
                   phosphorusLow = request.getParameter("phosphorus_low"), 
                   phosphorusHigh  = request.getParameter("phosphorus_high"),
                   maxphosphorusDate = request.getParameter("phosphorus_max_date"),
                   minphosphorusDate = request.getParameter("phosphorus_min_date"),
                   newmaxphosphorusDate = "",
                   newminphosphorusDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
            if(maxphosphorusDate.isEmpty() != true){
                String newmaxphosphorusYear = maxphosphorusDate.substring(0, 4), newmaxphosphorusMonth = maxphosphorusDate.substring(5, 7), newmaxphosphorusDay = maxphosphorusDate.substring(8, 10);
                newmaxphosphorusDate = " on " + newmaxphosphorusMonth + "/" + newmaxphosphorusDay + "/" + newmaxphosphorusYear + " at " + maxphosphorusDate.substring(11, 16);     
            }
            else{
                newmaxphosphorusDate = "N/A";
            }
            if(minphosphorusDate.isEmpty() != true){
                String newminphosphorusYear = minphosphorusDate.substring(0, 4), newminphosphorusMonth = minphosphorusDate.substring(5, 7), newminphosphorusDay = minphosphorusDate.substring(8, 10);
                newminphosphorusDate = " on " + newminphosphorusMonth + "/" + newminphosphorusDay + "/" + newminphosphorusYear + " at " + minphosphorusDate.substring(11, 16);     
            }
            else{
                newminphosphorusDate = "N/A";
            }
            System.out.println("Max Phosphorus: " + maxphosphorusResult);
            System.out.println("Min Phosphorus: " + minphosphorusResult);
            System.out.println("Max Phosphorus Date: " + newmaxphosphorusDate );
            System.out.println("Min Phosphorus Date: " + newminphosphorusDate);    
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max Phosphorus: " + maxphosphorusResult);
            logger.log(Level.INFO, "Min Phosphorus: " + minphosphorusResult);
            logger.log(Level.INFO, "Max Phosphorus Date: " + newmaxphosphorusDate);
            logger.log(Level.INFO, "Min Phosphorus Date: " + newminphosphorusDate); */
            
        //Creatinine
        String maxcreatResult = request.getParameter("creat_max_val"),
                   mincreatResult = request.getParameter("creat_min_val"),
                   creatLow = request.getParameter("creat_low"), 
                   creatHigh  = request.getParameter("creat_high"),
                   maxcreatDate = request.getParameter("creat_max_date"),
                   mincreatDate = request.getParameter("creat_min_date"),
                   newmaxcreatDate = "",
                   newmincreatDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
            if(maxcreatDate.isEmpty() != true){
                String newmaxcreatYear = maxcreatDate.substring(0, 4), newmaxcreatMonth = maxcreatDate.substring(5, 7), newmaxcreatDay = maxcreatDate.substring(8, 10);
                newmaxcreatDate = " on " + newmaxcreatMonth + "/" + newmaxcreatDay + "/" + newmaxcreatYear + " at " + maxcreatDate.substring(11, 16);     
            }
            else{
                newmaxcreatDate = "N/A";
            }
            if(mincreatDate.isEmpty() != true){
                String newmincreatYear = mincreatDate.substring(0, 4), newmincreatMonth = mincreatDate.substring(5, 7), newmincreatDay = mincreatDate.substring(8, 10);
                newmincreatDate = " on " + newmincreatMonth + "/" + newmincreatDay + "/" + newmincreatYear + " at " + mincreatDate.substring(11, 16);     
            }
            else{
                newmincreatDate = "N/A";
            }
            System.out.println("Max Creatinine: " + maxcreatResult);
            System.out.println("Min Creatinine: " + mincreatResult);
            System.out.println("Max Creatinine Date: " + newmaxcreatDate );
            System.out.println("Min Creatinine Date: " + newmincreatDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max Creatinine: " + maxcreatResult);
            logger.log(Level.INFO, "Min Creatinine: " + mincreatResult);
            logger.log(Level.INFO, "Max Creatinine Date: " + newmaxcreatDate);
            logger.log(Level.INFO, "Min Creatinine Date: " + newmincreatDate); */
            

        //Previous Creatinine
        String maxcreatprevResult = request.getParameter("creat_prev_max_val"),
                   mincreatprevResult = request.getParameter("creat_prev_min_val"),
                   creatprevLow = request.getParameter("creat_prev_low"), 
                   creatprevHigh  = request.getParameter("creat_prev_high"),
                   maxcreatprevDate = request.getParameter("creat_prev_max_date"),
                   mincreatprevDate = request.getParameter("creat_prev_min_date"),
                   newmaxcreatprevDate = "",
                   newmincreatprevDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
            if(maxcreatprevDate.isEmpty() != true){
                String newmaxcreatprevYear = maxcreatprevDate.substring(0, 4), newmaxcreatprevMonth = maxcreatprevDate.substring(5, 7), newmaxcreatprevDay = maxcreatprevDate.substring(8, 10);
                newmaxcreatprevDate = " on " + newmaxcreatprevMonth + "/" + newmaxcreatprevDay + "/" + newmaxcreatprevYear + " at " + maxcreatprevDate.substring(11, 16);     
            }
            else{
                newmaxcreatprevDate = "N/A";
            }
            if(mincreatprevDate.isEmpty() != true){
                String newmincreatprevYear = mincreatprevDate.substring(0, 4), newmincreatprevMonth = mincreatprevDate.substring(5, 7), newmincreatprevDay = mincreatprevDate.substring(8, 10);
                newmincreatprevDate = " on " + newmincreatprevMonth + "/" + newmincreatprevDay + "/" + newmincreatprevYear + " at " + mincreatprevDate.substring(11, 16);     
            }
            else{
                newmincreatprevDate = "N/A";
            }
            System.out.println("Max Previous Creatinine: " + maxcreatprevResult);
            System.out.println("Min Previous Creatinine: " + mincreatprevResult);
            System.out.println("Max Previous Creatinine Date: " + newmaxcreatprevDate );
            System.out.println("Min Previous Creatinine Date: " + newmincreatprevDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max Previous Creatinine: " + maxcreatprevResult);
            logger.log(Level.INFO, "Min Previous Creatinine: " + mincreatprevResult);
            logger.log(Level.INFO, "Max Previous Creatinine Date: " + newmaxcreatprevDate);
            logger.log(Level.INFO, "Min Previous Creatinine Date: " + newmincreatprevDate); */
            
        
        
        //Neutrophil
            String maxneutrophil  = request.getParameter("neutrophil_max_val"),
                minneutrophil  = request.getParameter("neutrophil_min_val"),
                maxneutrophilDate = request.getParameter("neutrophil_max_date"),
                minneutrophilDate = request.getParameter("neutrophil_min_date"),
                neutrophilLow = request.getParameter("neutrophil_low"),
                neutrophilHigh = request.getParameter("neutrophil_high"),
                newMaxneutrophilDate = "",
                newMinneutrophilDate = "";
        
            //Formatting the date when the date is present else setting the date to N/A
            if(maxneutrophilDate.isEmpty() != true){
            String newmaxneutrophilYear = maxneutrophilDate.substring(0, 4), newmaxneutrophilMonth = maxneutrophilDate.substring(5, 7), newmaxneutrophilDay = maxneutrophilDate.substring(8, 10);
            newMaxneutrophilDate = " on " + newmaxneutrophilMonth + "/" + newmaxneutrophilDay + "/" + newmaxneutrophilYear + " at " + maxneutrophilDate.substring(11, 16);
            }
            else
                newMaxneutrophilDate = "N/A";
            if(minneutrophilDate.isEmpty() != true){
                String newminneutrophilYear = minneutrophilDate.substring(0, 4), newminneutrophilMonth = minneutrophilDate.substring(5, 7), newminneutrophilDay = minneutrophilDate.substring(8, 10);
                newMinneutrophilDate = " on " + newminneutrophilMonth + "/" + newminneutrophilDay + "/" + newminneutrophilYear + " at " + minneutrophilDate.substring(11, 16);
                }
            else
                newMinneutrophilDate = "N/A";
            System.out.println("Max neutrophil: " + maxneutrophil);
            System.out.println("Min neutrophil: " + minneutrophil);
            System.out.println("Max neutrophil Date: " + newMaxneutrophilDate);
            System.out.println("Min neutrophil Date: " + newMinneutrophilDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max neutrophil: " + maxneutrophil);
            logger.log(Level.INFO, "Min neutrophil: " + minneutrophil);
            logger.log(Level.INFO, "Max neutrophil Date: " + newMaxneutrophilDate);
            logger.log(Level.INFO, "Min neutrophil Date: " + newMinneutrophilDate); */
            
        
        //Lactic Acid
            String maxLacticAcid  = request.getParameter("lactic_acid_max_val"),
                minLacticAcid  = request.getParameter("lactic_acid_min_val"),
                maxLacticAcidDate = request.getParameter("lactic_acid_max_date"),
                minLacticAcidDate = request.getParameter("lactic_acid_min_date"),
                LacticAcidLow = request.getParameter("lactic_acid_low"),
                LacticAcidHigh = request.getParameter("lactic_acid_high"),
                newMaxLacticAcidDate = "",
                newMinLacticAcidDate = "";
        
            //Formatting the date when the date is present else setting the date to N/A
            if(maxLacticAcidDate.isEmpty() != true){
            String newmaxLacticAcidYear = maxLacticAcidDate.substring(0, 4), newmaxLacticAcidMonth = maxLacticAcidDate.substring(5, 7), newmaxLacticAcidDay = maxLacticAcidDate.substring(8, 10);
            newMaxLacticAcidDate = " on " + newmaxLacticAcidMonth + "/" + newmaxLacticAcidDay + "/" + newmaxLacticAcidYear + " at " + maxLacticAcidDate.substring(11, 16);
            }
            else
                newMaxLacticAcidDate = "N/A";
            if(minLacticAcidDate.isEmpty() != true){
                String newminLacticAcidYear = minLacticAcidDate.substring(0, 4), newminLacticAcidMonth = minLacticAcidDate.substring(5, 7), newminLacticAcidDay = minLacticAcidDate.substring(8, 10);
                newMinLacticAcidDate = " on " + newminLacticAcidMonth + "/" + newminLacticAcidDay + "/" + newminLacticAcidYear + " at " + minLacticAcidDate.substring(11, 16);
                }
            else
                newMinLacticAcidDate = "N/A";
            System.out.println("Max LacticAcid: " + maxLacticAcid);
            System.out.println("Min LacticAcid: " + minLacticAcid);
            System.out.println("Max LacticAcid Date: " + newMaxLacticAcidDate);
            System.out.println("Min LacticAcid Date: " + newMinLacticAcidDate);
            System.out.println("LacticAcid Low: " + LacticAcidLow);
            System.out.println("LacticAcid High: " + LacticAcidHigh);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max LacticAcid: " + maxLacticAcid);
            logger.log(Level.INFO, "Min LacticAcid: " + minLacticAcid);
            logger.log(Level.INFO, "Max LacticAcid Date: " + newMaxLacticAcidDate);
            logger.log(Level.INFO, "Min LacticAcid Date: " + newMinLacticAcidDate);
            logger.log(Level.INFO, "LacticAcid Low: " + LacticAcidLow);
            logger.log(Level.INFO, "LacticAcid High: " + LacticAcidHigh); */
            
            
        
        
        //Height
    String maxheight  = request.getParameter("height_max_val"),
           minheight  = request.getParameter("height_min_val"),
           maxheightDate = request.getParameter("height_max_date"),
           minheightDate = request.getParameter("height_min_date"),
           newMaxheightDate = "",
           newMinheightDate = "";
        
    //Formatting the date when the date is present else setting the date to N/A
            if(maxheightDate.isEmpty() != true){
            String newheightYear = maxheightDate.substring(0, 4), newheightMonth = maxheightDate.substring(5, 7), newheightDay = maxheightDate.substring(8, 10);
            newMaxheightDate = " on " + newheightMonth + "/" + newheightDay + "/" + newheightYear + " at " + maxheightDate.substring(11, 16);
            }
            else
                newMaxheightDate = "N/A";
            if(minheightDate.isEmpty() != true){
                String newheightYear = minheightDate.substring(0, 4), newheightMonth = minheightDate.substring(5, 7), newheightDay = minheightDate.substring(8, 10);
                newMinheightDate = " on " + newheightMonth + "/" + newheightDay + "/" + newheightYear + " at " + minheightDate.substring(11, 16);
                }
            else
                newMinheightDate = "N/A";
            
            System.out.println("Max height: " + maxheight);
            System.out.println("Min height: " + minheight);
            System.out.println("Max height Date: " + newMaxheightDate);
            System.out.println("Min height Date: " + newMinheightDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max height: " + maxheight);
            logger.log(Level.INFO, "Min height: " + minheight);
            logger.log(Level.INFO, "Max height Date: " + newMaxheightDate);
            logger.log(Level.INFO, "Min height Date: " + newMinheightDate); */
            
        
        //Weight
    String maxweight  = request.getParameter("weight_max_val"),
           minweight  = request.getParameter("weight_min_val"),
           maxweightDate = request.getParameter("weight_max_date"),
           minweightDate = request.getParameter("weight_min_date"),
           newMaxweightDate = "",
           newMinweightDate = "";
        
    //Formatting the date when the date is present else setting the date to N/A
            if(maxweightDate.isEmpty() != true){
            String newweightYear = maxweightDate.substring(0, 4), newweightMonth = maxweightDate.substring(5, 7), newweightDay = maxweightDate.substring(8, 10);
            newMaxweightDate = " on " + newweightMonth + "/" + newweightDay + "/" + newweightYear + " at " + maxweightDate.substring(11, 16);
            }
            else
                newMaxweightDate = "N/A";
            if(minweightDate.isEmpty() != true){
                String newweightYear = minweightDate.substring(0, 4), newweightMonth = minweightDate.substring(5, 7), newweightDay = minweightDate.substring(8, 10);
                newMinweightDate = " on " + newweightMonth + "/" + newweightDay + "/" + newweightYear + " at " + minweightDate.substring(11, 16);
                }
            else
                newMinweightDate = "N/A";
            System.out.println("Max weight: " + maxweight);
            System.out.println("Min weight: " + minweight);
            System.out.println("Max weight Date: " + newMaxweightDate);
            System.out.println("Min weight Date: " + newMinweightDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max weight: " + maxweight);
            logger.log(Level.INFO, "Min weight: " + minweight);
            logger.log(Level.INFO, "Max weight Date: " + newMaxweightDate);
            logger.log(Level.INFO, "Min weight Date: " + newMinweightDate); */
            
        
        //Systolic Blood Pressure
    String maxsysBP  = request.getParameter("Systolic_Blood_Pressure_max_val"),
                minsysBP  = request.getParameter("Systolic_Blood_Pressure_min_val"),
                maxsysBPDate = request.getParameter("Systolic_Blood_Pressure_max_date"),
                minsysBPDate = request.getParameter("Systolic_Blood_Pressure_min_date"),
                sysBPLow = request.getParameter("Systolic_Blood_Pressure_low"),
                sysBPHigh = request.getParameter("Systolic_Blood_Pressure_high"),
                newMaxsysBPDate = "",
                newMinsysBPDate = "";
            
    //Formatting the date when the date is present else setting the date to N/A
            if(maxsysBPDate.isEmpty() != true){
            String newsysBPYear = maxsysBPDate.substring(0, 4), newsysBPMonth = maxsysBPDate.substring(5, 7), newsysBPDay = maxsysBPDate.substring(8, 10);
            newMaxsysBPDate = " on " + newsysBPMonth + "/" + newsysBPDay + "/" + newsysBPYear + " at " + maxsysBPDate.substring(11, 16);
            }
            else
                newMaxsysBPDate = "N/A";
            if(minsysBPDate.isEmpty() != true){
                String newsysBPYear = minsysBPDate.substring(0, 4), newsysBPMonth = minsysBPDate.substring(5, 7), newsysBPDay = minsysBPDate.substring(8, 10);
                newMinsysBPDate = " on " + newsysBPMonth + "/" + newsysBPDay + "/" + newsysBPYear + " at " + minsysBPDate.substring(11, 16);
                }
            else
                newMinsysBPDate = "N/A";
            System.out.println("Max sysBP: " + maxsysBP);
            System.out.println("Min sysBP: " + minsysBP);
            System.out.println("Max sysBP Date: " + newMaxsysBPDate);
            System.out.println("Min sysBP Date: " + newMinsysBPDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max sysBP: " + maxsysBP);
            logger.log(Level.INFO, "Min sysBP: " + minsysBP);
            logger.log(Level.INFO, "Max sysBP Date: " + newMaxsysBPDate);
            logger.log(Level.INFO, "Min sysBP Date: " + newMinsysBPDate); */
            
        
        // Diastolic Blood Pressure
        String maxdiasBP  = request.getParameter("Diastolic_Blood_Pressure_max_val"),
                mindiasBP  = request.getParameter("Diastolic_Blood_Pressure_min_val"),
                maxdiasBPDate = request.getParameter("Diastolic_Blood_Pressure_max_date"),
                mindiasBPDate = request.getParameter("Diastolic_Blood_Pressure_min_date"),
                diasBPLow = request.getParameter("Diastolic_Blood_Pressure_low"),
                diasBPHigh = request.getParameter("Diastolic_Blood_Pressure_high"),
                newMaxdiasBPDate = "",
                newMindiasBPDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
            if(maxdiasBPDate.isEmpty() != true){
            String newdiasBPYear = maxdiasBPDate.substring(0, 4), newdiasBPMonth = maxdiasBPDate.substring(5, 7), newdiasBPDay = maxdiasBPDate.substring(8, 10);
            newMaxdiasBPDate = " on " + newdiasBPMonth + "/" + newdiasBPDay + "/" + newdiasBPYear + " at " + maxdiasBPDate.substring(11, 16);
            }
            else
                newMaxdiasBPDate = "N/A";
            if(mindiasBPDate.isEmpty() != true){
                String newdiasBPYear = mindiasBPDate.substring(0, 4), newdiasBPMonth = mindiasBPDate.substring(5, 7), newdiasBPDay = mindiasBPDate.substring(8, 10);
                newMindiasBPDate = " on " + newdiasBPMonth + "/" + newdiasBPDay + "/" + newdiasBPYear + " at " + mindiasBPDate.substring(11, 16);
                }
            else
                newMindiasBPDate = "N/A";
            System.out.println("Max diasBP: " + maxdiasBP);
            System.out.println("Min diasBP: " + mindiasBP);
            System.out.println("Max diasBP Date: " + newMaxdiasBPDate);
            System.out.println("Min diasBP Date: " + newMindiasBPDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max diasBP: " + maxdiasBP);
            logger.log(Level.INFO, "Min diasBP: " + mindiasBP);
            logger.log(Level.INFO, "Max diasBP Date: " + newMaxdiasBPDate);
            logger.log(Level.INFO, "Min diasBP Date: " + newMindiasBPDate); */
            
        
        //PCO2
    String maxpco2  = request.getParameter("pco2_max_val"),
                minpco2  = request.getParameter("pco2_min_val"),
                maxpco2Date = request.getParameter("pco2_max_date"),
                minpco2Date = request.getParameter("pco2_min_date"),
                pco2Low = request.getParameter("pco2_low"),
                pco2High = request.getParameter("pco2_high"),
                newMaxpco2Date = "",
                newMinpco2Date = "";
        
    //Formatting the date when the date is present else setting the date to N/A
            if(maxpco2Date.isEmpty() != true){
            String newpco2Year = maxpco2Date.substring(0, 4), newpco2Month = maxpco2Date.substring(5, 7), newpco2Day = maxpco2Date.substring(8, 10);
            newMaxpco2Date = " on " + newpco2Month + "/" + newpco2Day + "/" + newpco2Year + " at " + maxpco2Date.substring(11, 16);
            }
            else
                newMaxpco2Date = "N/A";
            if(minpco2Date.isEmpty() != true){
                String newpco2Year = minpco2Date.substring(0, 4), newpco2Month = minpco2Date.substring(5, 7), newpco2Day = minpco2Date.substring(8, 10);
                newMinpco2Date = " on " + newpco2Month + "/" + newpco2Day + "/" + newpco2Year + " at " + minpco2Date.substring(11, 16);
                }
            else
                newMinpco2Date = "N/A";
            System.out.println("Max pco2: " + maxpco2);
            System.out.println("Min pco2: " + minpco2);
            System.out.println("Max pco2 Date: " + newMaxpco2Date);
            System.out.println("Min pco2 Date: " + newMinpco2Date);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max pco2: " + maxpco2);
            logger.log(Level.INFO, "Min pco2: " + minpco2);
            logger.log(Level.INFO, "Max pco2 Date: " + newMaxpco2Date);
            logger.log(Level.INFO, "Min pco2 Date: " + newMinpco2Date); */
            
        
        String maxprevpco2  = request.getParameter("pco2_prev_max_val"),
                minprevpco2  = request.getParameter("pco2_prev_min_val"),
                maxprevpco2Date = request.getParameter("pco2_prev_max_date"),
                minprevpco2Date = request.getParameter("pco2_prev_min_date"),
                prevpco2Low = request.getParameter("pco2_prev_low"),
                prevpco2High = request.getParameter("pco2_prev_high"),
                newMaxprevpco2Date = "",
                newMinprevpco2Date = "";
        
        //Formatting the date when the date is present else setting the date to N/A
            if(maxprevpco2Date.isEmpty() != true){
            String newprevpco2Year = maxprevpco2Date.substring(0, 4), newprevpco2Month = maxprevpco2Date.substring(5, 7), newprevpco2Day = maxprevpco2Date.substring(8, 10);
            newMaxprevpco2Date = " on " + newprevpco2Month + "/" + newprevpco2Day + "/" + newprevpco2Year + " at " + maxprevpco2Date.substring(11, 16);
            }
            else
                newMaxprevpco2Date = "N/A";
            if(minprevpco2Date.isEmpty() != true){
                String newprevpco2Year = minprevpco2Date.substring(0, 4), newprevpco2Month = minprevpco2Date.substring(5, 7), newprevpco2Day = minprevpco2Date.substring(8, 10);
                newMinprevpco2Date = " on " + newprevpco2Month + "/" + newprevpco2Day + "/" + newprevpco2Year + " at " + minprevpco2Date.substring(11, 16);
                }
            else
                newMinprevpco2Date = "N/A";
            System.out.println("Max prevpco2: " + maxprevpco2);
            System.out.println("Min prevpco2: " + minprevpco2);
            System.out.println("Max prevpco2 Date: " + newMaxprevpco2Date);
            System.out.println("Min prevpco2 Date: " + newMinprevpco2Date);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max prevpco2: " + maxprevpco2);
            logger.log(Level.INFO, "Min prevpco2: " + minprevpco2);
            logger.log(Level.INFO, "Max prevpco2 Date: " + newMaxprevpco2Date);
            logger.log(Level.INFO, "Min prevpco2 Date: " + newMinprevpco2Date); */
            
        
        //Etco
        String maxEtco2  = request.getParameter("etco2_max_val"),
                minEtco2  = request.getParameter("etco2_min_val"),
                maxEtco2Date = request.getParameter("etco2_max_date"),
                minEtco2Date = request.getParameter("etco2_min_date"),
                Etco2Low = request.getParameter("etco2_low"),
                Etco2High = request.getParameter("etco2_high"),
                newMaxEtco2Date = "",
                newMinEtco2Date = "";
        
        //Formatting the date when the date is present else setting the date to N/A
            if(maxEtco2Date.isEmpty() != true){
            String newEtco2Year = maxEtco2Date.substring(0, 4), newEtco2Month = maxEtco2Date.substring(5, 7), newEtco2Day = maxEtco2Date.substring(8, 10);
            newMaxEtco2Date = " on " + newEtco2Month + "/" + newEtco2Day + "/" + newEtco2Year + " at " + maxEtco2Date.substring(11, 16);
            }
            else
                newMaxEtco2Date = "N/A";
            if(minEtco2Date.isEmpty() != true){
                String newEtco2Year = minEtco2Date.substring(0, 4), newEtco2Month = minEtco2Date.substring(5, 7), newEtco2Day = minEtco2Date.substring(8, 10);
                newMinEtco2Date = " on " + newEtco2Month + "/" + newEtco2Day + "/" + newEtco2Year + " at " + minEtco2Date.substring(11, 16);
                }
            else
                newMinEtco2Date = "N/A";
            System.out.println("Max Etco2: " + maxEtco2);
            System.out.println("Min Etco2: " + minEtco2);
            System.out.println("Max Etco2 Date: " + newMaxEtco2Date);
            System.out.println("Min Etco2 Date: " + newMinEtco2Date);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max Etco2: " + maxEtco2);
            logger.log(Level.INFO, "Min Etco2: " + minEtco2);
            logger.log(Level.INFO, "Max Etco2 Date: " + newMaxEtco2Date);
            logger.log(Level.INFO, "Min Etco2 Date: " + newMinEtco2Date); */
            
        
        String maxprevEtco2  = request.getParameter("etco2_prev_max_val"),
                minprevEtco2  = request.getParameter("etco2_prev_min_val"),
                maxprevEtco2Date = request.getParameter("etco2_prev_max_date"),
                minprevEtco2Date = request.getParameter("etco2_prev_min_date"),
                prevEtco2Low = request.getParameter("etco2_prev_low"),
                prevEtco2High = request.getParameter("etco2_prev_high"),
                newMaxprevEtco2Date = "",
                newMinprevEtco2Date = "";
        
        //Formatting the date when the date is present else setting the date to N/A
            if(maxprevEtco2Date.isEmpty() != true){
            String newprevEtco2Year = maxprevEtco2Date.substring(0, 4), newprevEtco2Month = maxprevEtco2Date.substring(5, 7), newprevEtco2Day = maxprevEtco2Date.substring(8, 10);
            newMaxprevEtco2Date = " on " + newprevEtco2Month + "/" + newprevEtco2Day + "/" + newprevEtco2Year + " at " + maxprevEtco2Date.substring(11, 16);
            }
            else
                newMaxprevEtco2Date = "N/A";
            if(minprevEtco2Date.isEmpty() != true){
                String newprevEtco2Year = minprevEtco2Date.substring(0, 4), newprevEtco2Month = minprevEtco2Date.substring(5, 7), newprevEtco2Day = minprevEtco2Date.substring(8, 10);
                newMinprevEtco2Date = " on " + newprevEtco2Month + "/" + newprevEtco2Day + "/" + newprevEtco2Year + " at " + minprevEtco2Date.substring(11, 16);
                }
            else
                newMinprevEtco2Date = "N/A";
            System.out.println("Max prevEtco2: " + maxprevEtco2);
            System.out.println("Min prevEtco2: " + minprevEtco2);
            System.out.println("Max prevEtco2 Date: " + newMaxprevEtco2Date);
            System.out.println("Min prevEtco2 Date: " + newMinprevEtco2Date);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max prevEtco2: " + maxprevEtco2);
            logger.log(Level.INFO, "Min prevEtco2: " + minprevEtco2);
            logger.log(Level.INFO, "Max prevEtco2 Date: " + newMaxprevEtco2Date);
            logger.log(Level.INFO, "Min prevEtco2 Date: " + newMinprevEtco2Date); */
            
        
        //PO2
        String maxpo2  = request.getParameter("po2_max_val"),
            minpo2  = request.getParameter("po2_min_val"),
            maxpo2Date = request.getParameter("po2_max_date"),
            minpo2Date = request.getParameter("po2_min_date"),
            po2Low = request.getParameter("po2_low"),
            po2High = request.getParameter("po2_high"),
            newMaxpo2Date = "",
            newMinpo2Date = "";
        
        //Formatting the date when the date is present else setting the date to N/A
        if(maxpo2Date.isEmpty() != true){
        String newpo2Year = maxpo2Date.substring(0, 4), newpo2Month = maxpo2Date.substring(5, 7), newpo2Day = maxpo2Date.substring(8, 10);
        newMaxpo2Date = " on " + newpo2Month + "/" + newpo2Day + "/" + newpo2Year + " at " + maxpo2Date.substring(11, 16);
        }
        else
            newMaxpo2Date = "N/A";
        if(minpo2Date.isEmpty() != true){
            String newpo2Year = minpo2Date.substring(0, 4), newpo2Month = minpo2Date.substring(5, 7), newpo2Day = minpo2Date.substring(8, 10);
            newMinpo2Date = " on " + newpo2Month + "/" + newpo2Day + "/" + newpo2Year + " at " + minpo2Date.substring(11, 16);
            }
        else
            newMinpo2Date = "N/A";
        System.out.println("Max po2: " + maxpo2);
        System.out.println("Min po2: " + minpo2);
        System.out.println("Max po2 Date: " + newMaxpo2Date);
        System.out.println("Min po2 Date: " + newMinpo2Date);
        
        /*
        * Logging to file here
        */
        /* logger.log(Level.INFO, "Max po2: " + maxpo2);
        logger.log(Level.INFO, "Min po2: " + minpo2);
        logger.log(Level.INFO, "Max po2 Date: " + newMaxpo2Date);
        logger.log(Level.INFO, "Min po2 Date: " + newMinpo2Date); */
        
        
        //O2sat
        String maxo2sat  = request.getParameter("o2sat_max_val"),
            mino2sat  = request.getParameter("o2sat_min_val"),
            maxo2satDate = request.getParameter("o2sat_max_date"),
            mino2satDate = request.getParameter("o2sat_min_date"),
            o2satLow = request.getParameter("o2sat_low"),
            o2satHigh = request.getParameter("o2sat_high"),
            newMaxo2satDate = "",
            newMino2satDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
        if(maxo2satDate.isEmpty() != true){
        String newo2satYear = maxo2satDate.substring(0, 4), newo2satMonth = maxo2satDate.substring(5, 7), newo2satDay = maxo2satDate.substring(8, 10);
        newMaxo2satDate = " on " + newo2satMonth + "/" + newo2satDay + "/" + newo2satYear + " at " + maxo2satDate.substring(11, 16);
        }
        else
            newMaxo2satDate = "N/A";
        if(mino2satDate.isEmpty() != true){
            String newo2satYear = mino2satDate.substring(0, 4), newo2satMonth = mino2satDate.substring(5, 7), newo2satDay = mino2satDate.substring(8, 10);
            newMino2satDate = " on " + newo2satMonth + "/" + newo2satDay + "/" + newo2satYear + " at " + mino2satDate.substring(11, 16);
            }
        else
            newMino2satDate = "N/A";
        System.out.println("Max o2sat: " + maxo2sat);
        System.out.println("Min o2sat: " + mino2sat);
        System.out.println("Max o2sat Date: " + newMaxo2satDate);
        System.out.println("Min o2sat Date: " + newMino2satDate);
        
        /*
        * Logging to file here
        */
        /* logger.log(Level.INFO, "Max o2sat: " + maxo2sat);
        logger.log(Level.INFO, "Min o2sat: " + mino2sat);
        logger.log(Level.INFO, "Max o2sat Date: " + newMaxo2satDate);
        logger.log(Level.INFO, "Min o2sat Date: " + newMino2satDate); */
        
        //pulse oximetry
            String maxoximetry  = request.getParameter("oximetry_max_val"),
                minoximetry  = request.getParameter("oximetry_min_val"),
                maxoximetryDate = request.getParameter("oximetry_max_date"),
                minoximetryDate = request.getParameter("oximetry_min_date"),
                oximetryLow = request.getParameter("oximetry_low"),
                oximetryHigh = request.getParameter("oximetry_high"),
                newMaxoximetryDate = "",
                newMinoximetryDate = "";
            if(oximetryLow.isEmpty()){
                oximetryLow = "90";
            }
        
            //Formatting the date when the date is present else setting the date to N/A
            if(maxoximetryDate.isEmpty() != true){
            String newoximetryYear = maxoximetryDate.substring(0, 4), newoximetryMonth = maxoximetryDate.substring(5, 7), newoximetryDay = maxoximetryDate.substring(8, 10);
            newMaxoximetryDate = " on " + newoximetryMonth + "/" + newoximetryDay + "/" + newoximetryYear + " at " + maxoximetryDate.substring(11, 16);
            }
            else
                newMaxoximetryDate = "N/A";
            if(minoximetryDate.isEmpty() != true){
                String newoximetryYear = minoximetryDate.substring(0, 4), newoximetryMonth = minoximetryDate.substring(5, 7), newoximetryDay = minoximetryDate.substring(8, 10);
                newMinoximetryDate = " on " + newoximetryMonth + "/" + newoximetryDay + "/" + newoximetryYear + " at " + minoximetryDate.substring(11, 16);
                }
            else
                newMinoximetryDate = "N/A";
            System.out.println("Max oximetry: " + maxoximetry);
            System.out.println("Min oximetry: " + minoximetry);
            System.out.println("Max oximetry Date: " + newMaxoximetryDate);
            System.out.println("Min oximetry Date: " + newMinoximetryDate);
            
            /*
            * Logging to file here
            */
            /* logger.log(Level.INFO, "Max oximetry: " + maxoximetry);
            logger.log(Level.INFO, "Min oximetry: " + minoximetry);
            logger.log(Level.INFO, "Max oximetry Date: " + newMaxoximetryDate);
            logger.log(Level.INFO, "Min oximetry Date: " + newMinoximetryDate); */
        
        // Cardiac troponin
        String maxct  = request.getParameter("ct_max_val"),
            minct  = request.getParameter("ct_min_val"),
            maxctDate = request.getParameter("ct_max_date"),
            minctDate = request.getParameter("ct_min_date"),
            ctLow = request.getParameter("ct_low"),
            ctHigh = request.getParameter("ct_high"),
            newMaxctDate = "",
            newMinctDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
        if(maxctDate.isEmpty() != true){
        String newctYear = maxctDate.substring(0, 4), newctMonth = maxctDate.substring(5, 7), newctDay = maxctDate.substring(8, 10);
        newMaxctDate = " on " + newctMonth + "/" + newctDay + "/" + newctYear + " at " + maxctDate.substring(11, 16);
        }
        else
            newMaxctDate = "N/A";
        if(minctDate.isEmpty() != true){
            String newctYear = minctDate.substring(0, 4), newctMonth = minctDate.substring(5, 7), newctDay = minctDate.substring(8, 10);
            newMinctDate = " on " + newctMonth + "/" + newctDay + "/" + newctYear + " at " + minctDate.substring(11, 16);
            }
        else
            newMinctDate = "N/A";
        System.out.println("Max ct: " + maxct);
        System.out.println("Min ct: " + minct);
        System.out.println("Max ct Date: " + newMaxctDate);
        System.out.println("Min ct Date: " + newMinctDate);
        
        /*
        * Logging to file here
        */
        /* logger.log(Level.INFO, "Max ct: " + maxct);
        logger.log(Level.INFO, "Min ct: " + minct);
        logger.log(Level.INFO, "Max ct Date: " + newMaxctDate);
        logger.log(Level.INFO, "Min ct Date: " + newMinctDate); */

        //Bun
        String maxbun  = request.getParameter("bun_max_val"),
            minbun  = request.getParameter("bun_min_val"),
            maxbunDate = request.getParameter("bun_max_date"),
            minbunDate = request.getParameter("bun_min_date"),
            bunLow = request.getParameter("bun_low"),
            bunHigh = request.getParameter("bun_high"),
            newMaxbunDate = "",
            newMinbunDate = "";
        

        //Formatting the date when the date is present else setting the date to N/A
        if(maxbunDate.isEmpty() != true){
        String newbunYear = maxbunDate.substring(0, 4), newbunMonth = maxbunDate.substring(5, 7), newbunDay = maxbunDate.substring(8, 10);
        newMaxbunDate = " on " + newbunMonth + "/" + newbunDay + "/" + newbunYear + " at " + maxbunDate.substring(11, 16);
        }
        else
            newMaxbunDate = "N/A";
        if(minbunDate.isEmpty() != true){
            String newbunYear = minbunDate.substring(0, 4), newbunMonth = minbunDate.substring(5, 7), newbunDay = minbunDate.substring(8, 10);
            newMinbunDate = " on " + newbunMonth + "/" + newbunDay + "/" + newbunYear + " at " + minbunDate.substring(11, 16);
            }
        else
            newMinbunDate = "N/A";
        System.out.println("Max bun: " + maxbun);
        System.out.println("Min bun: " + minbun);
        System.out.println("Max bun Date: " + newMaxbunDate);
        System.out.println("Min bun Date: " + newMinbunDate);
        
        /*
        * Logging to file here
        */
        /* logger.log(Level.INFO, "Max bun: " + maxbun);
        logger.log(Level.INFO, "Min bun: " + minbun);
        logger.log(Level.INFO, "Max bun Date: " + newMaxbunDate);
        logger.log(Level.INFO, "Min bun Date: " + newMinbunDate); */
        
        //WBC 
        String maxwbc  = request.getParameter("wbc_max_val"),
            minwbc  = request.getParameter("wbc_min_val"),
            maxwbcDate = request.getParameter("wbc_max_date"),
            minwbcDate = request.getParameter("wbc_min_date"),
            wbcLow = request.getParameter("wbc_low"),
            wbcHigh = request.getParameter("wbc_high"),
            newMaxwbcDate = "",
            newMinwbcDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
        if(maxwbcDate.isEmpty() != true){
        String newWbcYear = maxwbcDate.substring(0, 4), newWbcMonth = maxwbcDate.substring(5, 7), newWbcDay = maxwbcDate.substring(8, 10);
        newMaxwbcDate = " on " + newWbcMonth + "/" + newWbcDay + "/" + newWbcYear + " at " + maxwbcDate.substring(11, 16);
        }
        else
            newMaxwbcDate = "N/A";
        if(minwbcDate.isEmpty() != true){
            String newWbcYear = minwbcDate.substring(0, 4), newWbcMonth = minwbcDate.substring(5, 7), newWbcDay = minwbcDate.substring(8, 10);
            newMinwbcDate = " on " + newWbcMonth + "/" + newWbcDay + "/" + newWbcYear + " at " + minwbcDate.substring(11, 16);
            }
        else
            newMinwbcDate = "N/A";
        System.out.println("Max wbc: " + maxwbc);
        System.out.println("Min wbc: " + minwbc);
        System.out.println("Max wbc Date: " + newMaxwbcDate);
        System.out.println("Min wbc Date: " + newMinwbcDate);
        
        /*
        * Logging to file here
        */
        /* logger.log(Level.INFO, "Max wbc: " + maxwbc);
        logger.log(Level.INFO, "Min wbc: " + minwbc);
        logger.log(Level.INFO, "Max wbc Date: " + newMaxwbcDate);
        logger.log(Level.INFO, "Min wbc Date: " + newMinwbcDate); */
        
        
        
        //UTI WBC 
        String maxUtiWbc  = request.getParameter("utiWbc_max_val"),
            minUtiWbc  = request.getParameter("utiWbc_min_val"),
            maxUtiWbcDate = request.getParameter("utiWbc_max_date"),
            minUtiWbcDate = request.getParameter("utiWbc_min_date"),
            UtiWbcLow = request.getParameter("utiWbc_low"),
            UtiWbcHigh = request.getParameter("utiWbc_high"),
            newMaxUtiWbcDate = "",
            newMinUtiWbcDate = "";
        
        //Formatting the date when the date is present else setting the date to N/A
        if(maxUtiWbcDate.isEmpty() != true){
        String newWbcYear = maxUtiWbcDate.substring(0, 4), newWbcMonth = maxUtiWbcDate.substring(5, 7), newWbcDay = maxUtiWbcDate.substring(8, 10);
        newMaxUtiWbcDate = " on " + newWbcMonth + "/" + newWbcDay + "/" + newWbcYear + " at " + maxUtiWbcDate.substring(11, 16);
        }
        else
            newMaxUtiWbcDate = "N/A";
        if(minUtiWbcDate.isEmpty() != true){
            String newWbcYear = minUtiWbcDate.substring(0, 4), newWbcMonth = minUtiWbcDate.substring(5, 7), newWbcDay = minUtiWbcDate.substring(8, 10);
            newMinUtiWbcDate = " on " + newWbcMonth + "/" + newWbcDay + "/" + newWbcYear + " at " + minUtiWbcDate.substring(11, 16);
            }
        else
            newMinUtiWbcDate = "N/A";
        System.out.println("Max UTIWbc: " + maxUtiWbc);
        System.out.println("Min UTIWbc: " + minUtiWbc);
        System.out.println("Max UTIWbc Date: " + newMaxUtiWbcDate);
        System.out.println("Min UTIWbc Date: " + newMinUtiWbcDate);
        
        /*
        * Logging to file here
        */
        /* logger.log(Level.INFO, "Max UTIWbc: " + maxUtiWbc);
        logger.log(Level.INFO, "Min UTIWbc: " + minUtiWbc);
        logger.log(Level.INFO, "Max UTIWbc Date: " + newMaxUtiWbcDate);
        logger.log(Level.INFO, "Min UTIWbc Date: " + newMinUtiWbcDate); */
        
        
        //Leucocyte Nitrite 
    String maxurini  = request.getParameter("leucocyte_nitrite_max_val"),
            minurini  = request.getParameter("leucocyte_nitrite_min_val"),
            maxuriniDate = request.getParameter("leucocyte_nitrite_max_date"),
            minuriniDate = request.getParameter("leucocyte_nitrite_min_date"),
            uriniLow = request.getParameter("leucocyte_nitrite_low"),
            uriniHigh = request.getParameter("leucocyte_nitrite_high"),
            newMaxuriniDate = "",
            newMinuriniDate = "";
        
    //Formatting the date when the date is present else setting the date to N/A
        if(maxuriniDate.isEmpty() != true){
        String newuriniYear = maxuriniDate.substring(0, 4), newuriniMonth = maxuriniDate.substring(5, 7), newuriniDay = maxuriniDate.substring(8, 10);
        newMaxuriniDate = " on " + newuriniMonth + "/" + newuriniDay + "/" + newuriniYear + " at " + maxuriniDate.substring(11, 16);
        }
        else
            newMaxuriniDate = "N/A";
        if(minuriniDate.isEmpty() != true){
            String newuriniYear = minuriniDate.substring(0, 4), newuriniMonth = minuriniDate.substring(5, 7), newuriniDay = minuriniDate.substring(8, 10);
            newMinuriniDate = " on " + newuriniMonth + "/" + newuriniDay + "/" + newuriniYear + " at " + minuriniDate.substring(11, 16);
            }
        else
            newMinuriniDate = "N/A";
        System.out.println("Max Urini: " + maxurini);
        System.out.println("Min Urini: " + minurini);
        System.out.println("Max Urini Date: " + newMaxuriniDate);
        System.out.println("Min Urine Date: " + newMinuriniDate);
        
        /*
        * Logging to file here
        */
        /* logger.log(Level.INFO, "Max Urini: " + maxurini);
        logger.log(Level.INFO, "Min Urini: " + minurini);
        logger.log(Level.INFO, "Max Urini Date: " + newMaxuriniDate);
        logger.log(Level.INFO, "Min Urine Date: " + newMinuriniDate);
         */
        // Leucocyte Esterate    
    String maxurinest  = request.getParameter("leucocyte_esterate_max_val"),
            minurinest  = request.getParameter("leucocyte_esterate_min_val"),
            maxurinestDate = request.getParameter("leucocyte_esterate_max_date"),
            minurinestDate = request.getParameter("leucocyte_esterate_min_date"),
            urinestLow = request.getParameter("leucocyte_esterate_low"),
            urinestHigh = request.getParameter("leucocyte_esterate_high"),
            newMaxurinestDate = "",
            newMinurinestDate = "";
        
    //Formatting the date when the date is present else setting the date to N/A
        if(maxurinestDate.isEmpty() != true){
        String newurinestYear = maxurinestDate.substring(0, 4), newurinestMonth = maxurinestDate.substring(5, 7), newurinestDay = maxurinestDate.substring(8, 10);
        newMaxurinestDate = " on " + newurinestMonth + "/" + newurinestDay + "/" + newurinestYear + " at " + maxurinestDate.substring(11, 16);
        }
        else
            newMaxurinestDate = "N/A";
        if(minurinestDate.isEmpty() != true){
            String newurinestYear = minurinestDate.substring(0, 4), newurinestMonth = minurinestDate.substring(5, 7), newurinestDay = minurinestDate.substring(8, 10);
            newMinurinestDate = " on " + newurinestMonth + "/" + newurinestDay + "/" + newurinestYear + " at " + minurinestDate.substring(11, 16);
            }
        else
            newMinurinestDate = "N/A";
        System.out.println("Max Urine Estimate: " + maxurinest);
        System.out.println("Min Urine Estimate: " + minurinest);
        System.out.println("Max Urine Estimate Date: " + newMaxurinestDate);
        System.out.println("Min Urine Estimate: " + newMinurinestDate);
        
        /*
        * Logging to file here
        */
        /* logger.log(Level.INFO, "Max Urine Estimate: " + maxurinest);
        logger.log(Level.INFO, "Min Urine Estimate: " + minurinest);
        logger.log(Level.INFO, "Max Urine Estimate Date: " + newMaxurinestDate);
        logger.log(Level.INFO, "Min Urine Estimate: " + newMinurinestDate); */
        

        int result;
        double result_dehydration;
        double result_obesity;
        double result_morbidobesity;
        double result_malnutrition;
    
        
                //Dehydration
                String bunValue  = request.getParameter("bun_val"),
                    creatinineValue  = request.getParameter("creatinine_val"),
                    dehydrationCreatDate = request.getParameter("dehydration_creat_date"),
                    dehydrationBunDate = request.getParameter("dehydration_bun_date"),
                    newdehydrationCreatDate = "",
                    newdehydrationBunDate = "";
                
                //Formatting the date when the date is present else setting the date to N/A                
                if(dehydrationCreatDate.isEmpty() != true){
                String newdehydrationCreatYear = dehydrationCreatDate.substring(0, 4), newdehydrationCreatMonth = dehydrationCreatDate.substring(5, 7), newdehydrationCreatDay = dehydrationCreatDate.substring(8, 10);
                newdehydrationCreatDate = " on " + newdehydrationCreatMonth + "/" + newdehydrationCreatDay + "/" + newdehydrationCreatYear + " at " + dehydrationCreatDate.substring(11, 16);
                }
                else
                    newdehydrationCreatDate = "N/A";
                
                if(dehydrationBunDate.isEmpty() != true){
                    String newdehydrationBunYear = dehydrationBunDate.substring(0, 4), newdehydrationBunMonth = dehydrationBunDate.substring(5, 7), newdehydrationBunDay = dehydrationBunDate.substring(8, 10);
                    newdehydrationBunDate = " on " + newdehydrationBunMonth + "/" + newdehydrationBunDay + "/" + newdehydrationBunYear + " at " + dehydrationBunDate.substring(11, 16);
                    }
                else
                    newdehydrationBunDate = "N/A";
                
                System.out.println("Max bun: " + maxbun);
                System.out.println("Min bun: " + minbun);
                System.out.println("Max bun Date: " + newMaxbunDate);
                System.out.println("Min bun Date: " + newMinbunDate);
                
                /*
                * Logging to file here
                */
    
    // Creating an object of the rules class
    CoMorbRules coMorbChk = new CoMorbRules();

    %>
    
    <table id="table" border = "0">
    

    <!-- ************************************** Anemia ******************************************* -->
    <% 
    //Invoking rule
    boolean anemiaFlag=false;
    int anemiaValueMatch=0;
    result  = coMorbChk.anemia(minhb, minhc, hbLow, hcLow, minhb_prev, minhc_prev);
    if(result !=0)
    {
    	System.out.println("Anemia: " + result); 
    	int valueMatchFlag=0;
    	Iterator imain=valueMatch.entrySet().iterator();
    	Map<String, String> values =new HashMap<String, String>();
    	while(imain.hasNext())
    	{
    			Entry e=(Entry)imain.next();
    			if(e.getKey().equals("Anemia"))
    			{
    				anemiaFlag=true;
    				values=(Map<String, String>)e.getValue();
    				break;
    			}
    	}
    	if(anemiaFlag)
    	{
    		/*Iterator ival=values.entrySet().iterator();
    		while(ival.hasNext())
    		{
    			Entry e=(Entry)ival.next();
    			String testName=(String)e.getKey();
    			String testVal=(String)e.getValue();
    			if(testName.equals("chhglo"))
    			{
    				if(!testVal.isEmpty() && !minhb.isEmpty())
    				{
    					if(Double.parseDouble(testVal)!=Double.parseDouble(minhb))
    						anemiaValueMatch=1;
    				}
    				else
       				{
       					if(!minhb.isEmpty())
       						anemiaValueMatch=1;
       				}
    			}	
    			if(!minhb.isEmpty() && !values.containsKey("chhglo"))
				{
    				anemiaFlag=false;
    				anemiaValueMatch=1;
				}
    			if(testName.equals("prechhglo")) 
    			{
    				if(!testVal.isEmpty() && !minhb_prev.isEmpty())
    				{
    					if(Double.parseDouble(testVal)!=Double.parseDouble(minhb_prev))
    						anemiaValueMatch=1;
    				}
    				else
       				{
       					if(!minhb_prev.isEmpty())
       						anemiaValueMatch=1;
       				}
    			}
    			if(!minhb_prev.isEmpty() && !values.containsKey("prechhglo"))
    			{
    				anemiaFlag=false;
    				anemiaValueMatch=1;
    			}
    			if(testName.equals("chhcrit")) 
    			{	
    				if(!testVal.isEmpty() && !minhc.isEmpty())
    				{
    					if(Double.parseDouble(testVal)!=Double.parseDouble(minhc))
    						anemiaValueMatch=1;
    				}
    				else
       				{
       					if(!minhc.isEmpty())
       						anemiaValueMatch=1;
       				}
    			}					
    			if(!minhc.isEmpty() && !values.containsKey("chhcrit"))
				{
    				anemiaFlag=false;
    				anemiaValueMatch=1;
				}
    			if(testName.equals("prechhcrit"))
    			{
    				if(!testVal.isEmpty() && !minhc_prev.isEmpty())
    				{
    					if(Double.parseDouble(testVal)!=Double.parseDouble(minhc_prev))
    						anemiaValueMatch=1;
    				}
    				else
       				{
       					if(!minhc_prev.isEmpty())
       						anemiaValueMatch=1;
       				}
    			}	
    			if(!minhc_prev.isEmpty() && !values.containsKey("prechhcrit"))
    			{		
    				anemiaFlag=false;
    				anemiaValueMatch=1;
    			}
    		}*/
    		anemiaValueMatch=0;
    	}
    	else
    	{
    		anemiaValueMatch=1;
    	}
    }
    
    if(anemiaValueMatch != 0)
    {
    	
     %>
        <tr>
            <td>
                <span style="color: black;">
                <%if(anemiaFlag){
                	%><input id="anemia" type="checkbox" checked disabled name="mainGrp" value="Anemia :" />Anemia :
                	
                <%} %>
                
                <input id="anemia" type="checkbox" name="mainGrp" value="Anemia :" onclick="unCheck('anemia','anemiaChkGrp');"/>Anemia :
                <input type="hidden" name="AnHglo" id="AnHglo" value="<%=minhb%>">
                <input type="hidden" name="AnHgloDate" id="AnHgloDate" value="<%=newminhbDate%>">
                <input type="hidden" name="preAnHglo" id="preAnHglo" value="<%=minhb_prev%>">
                <input type="hidden" name="preAnHgloDate" id="preChHgloDate" value="<%=newminhb_prevDate%>">
                <input type="hidden" name="AnHcrit" id="AnHcrit" value="<%=minhc%>">
                <input type="hidden" name="AnHcritDate" id="AnHcritDate" value="<%=newminhcDate%>">
                <input type="hidden" name="preAnHcrit" id="preAnHcrit" value="<%=minhc_prev%>">
                <input type="hidden" name="preAnHcritDate" id="preAnHcritDate" value="<%=newminhc_prevDate%>">
                <input type="hidden" name="normalHBLow" id="normalHBLow" value="<%=hbLow%>">
                <input type="hidden" name="normalHCLow" id="normalHCLow" value="<%=hcLow%>">
                <input type="hidden" name="result" id="result" value="<%=result%>">
                </span>
            </td>
                        
                        
            
            <td></td>
            <td></td>
            
        </tr>
        <% 
        // 1 - Acute, 2- NOs, 3 - Chronic
        
        %>
            <tr onmouseover="mouseOverPara('imageAbl','ablCol')" onmouseout="mouseOutPara('imageAbl','ablCol')">
                <td></td>
                <td></td>
                <td id = "ablCol">
                <%
                // if it is chronic, this option is displayed in "blue" else it is dsiplayed in "black" and the corresponding values are also displayed 
                if(result == 1) 
                {
                %>
                    <span style="color: blue;">
                    <%if(anemiaFlag){
                	%><input id="anemiaAbl" type="checkbox" checked disabled name="anemiaChkGrp" value="Acute blood loss" >
                    <a onmouseover="makeDivVisible('abl')" onmouseout="makeDivHidden('abl')">
                    Acute&nbsp;&nbsp;</a></span><br/>
                	
                <%} else{%>
                    <input id="anemiaAbl" type="checkbox" name="anemiaChkGrp" value="Acute blood loss" onclick="checkMain('anemia');">
                    <a onmouseover="makeDivVisible('abl')" onmouseout="makeDivHidden('abl')">
                    Acute&nbsp;&nbsp;</a></span><br/>
                <%
                }
                }
                else
                {
                %>
                    <span style="color: black;">
                    <%if(anemiaFlag){
                	%><input id="anemiaAbl" type="checkbox" checked disabled name="anemiaChkGrp" value="Acute blood loss" >
                    <a onmouseover="makeDivVisible('abl')" onmouseout="makeDivHidden('abl')">
                    Acute&nbsp;&nbsp;</a></span><br/>
                	
                <%}else{ %>
                    <input id="anemiaAbl" type="checkbox" name="anemiaChkGrp" value="Acute blood loss" onclick="checkMain('anemia');">
                    <a onmouseover="makeDivVisible('abl')" onmouseout="makeDivHidden('abl')">
                    Acute&nbsp;&nbsp;</a></span><br/>
                <%
                }
                }
                %>
                </td>
                <td>
                    <div id="abl" class="imageBack" style="width:450px; height:400px;"><img src="images/div.png" width="100%"; height="100%"/>
                        <div id="abl" class="dynamicDiv" style="width:350px; height:320px; margin-left: 55px ; margin-top: -370px;">
                        <% 
                        //if(result == 1) 
                        {
                        %>
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                            <%
                            if(minhb.isEmpty() != true /* && (Double.parseDouble(minhb) < Double.parseDouble(hbLow)) */){
                                out.print(spaces + "Hemoglobin (Latest):         "+minhb+" "+ newminhbDate + "<br/>");
                            }
                                
                            
                            if(minhb_prev.isEmpty() != true /* && (Double.parseDouble(minhb_prev) > Double.parseDouble(hbLow)) */)
                                out.print(spaces + "Hemoglobin (Previous Visit): "+minhb_prev+" "+ newminhb_prevDate + "<br/>");    
                            
                            if(minhc.isEmpty() != true /* && (Double.parseDouble(minhc) < Double.parseDouble(hcLow)) */)
                                out.print(spaces + "Hematocrit (Latest):         "+minhc+" "+ newminhcDate +"<br/>");    
                            
                            if(minhc_prev.isEmpty() != true /* && (Double.parseDouble(minhc_prev) > Double.parseDouble(hcLow)) */)
                                out.print(spaces + "Hematocrit (Previous Visit): "+minhc_prev+" "+ newminhc_prevDate +"<br/>");
                            
                            %>
                        <%
                        }
                        %>        

                            <!-- <br/><span style = "color: #858384; font-weight: bold;"> 
                            Normal Reference Range:<br/><br/></span>
                            For current visit:<br/>
                            -->
                            <% 
                            /*
                            if(hbLow.isEmpty() != true)
                                out.print("Hemoglobin : " + hbLow + " or greater" + "\n" + "<br/>");
                        
                            if(hcLow.isEmpty() != true)
                                out.print("Hematocrit : " + hcLow + " or greater" + "\n");
                            */
                            %>
                                                
                            <br/><br/><span style = "color: #858384; font-weight: bold;"> 
                            Determined by the Rule:<br/><br/></span>
                            <%
                            if(hbLow.isEmpty() != true && hbLow.isEmpty() != true)
                                out.print(spaces + "Current Hemoglobin < " + hbLow + "    and" + "<br/>");
                            
                            if(minhb_prev.isEmpty() != true && hbLow.isEmpty() != true)
                                out.print(spaces + "Previous Hemoglobin > " + hbLow + "<br/>");    
                            
                            if(minhc.isEmpty() != true && hcLow.isEmpty() != true)
                                out.print(spaces + "Current Hematocrit < " + hcLow + "    and" + "<br/>");    
                            
                            if(minhc_prev.isEmpty() != true && hcLow.isEmpty() != true)
                                out.print(spaces + "Previous Hematocrit > " + hcLow +"<br/>");
                            %>
                        </div>
                    </div>                 
                    <a id="imageAbl" onmouseover="makeDivVisible('abl')" 
                    onmouseout="makeDivHidden('abl')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>    
            </tr>
            <%
        
        //else if(result == 3)
        
            %>
                <tr onmouseover="mouseOverPara('imageCd','cdCol')" onmouseout="mouseOutPara('imageCd','cdCol')" >
                    <td></td>
                    <td></td>
                    <td id = "cdCol">
                    
                    <%
                    
                    // if it is chronic, this option is displayed in "blue" else it is dsiplayed in "black" and the corresponding values are also displayed 
                    if(result == 3) 
                    {
                    %>
                        <span style="color: blue;">
                        <%if(anemiaFlag){
                	%><input id="amemiaCd" type="checkbox" name="anemiaChkGrp" checked disabled value="Anemia: Chronic Disease" >
                        <a onmouseover="makeDivVisible('cd')" onmouseout="makeDivHidden('cd')">
                        Chronic&nbsp;&nbsp;</a></span><br/>
                	
                <%}else{ %>
                        <input id="amemiaCd" type="checkbox" name="anemiaChkGrp" value="Anemia: Chronic Disease" onclick="checkMain('anemia');">
                        <a onmouseover="makeDivVisible('cd')" onmouseout="makeDivHidden('cd')">
                        Chronic&nbsp;&nbsp;</a></span><br/>
                    <%
                    }
        			}
                    else
                    {
                    %>
                        <span style="color: black;">
                        <%if(anemiaFlag){
                	%><input id="amemiaCd" type="checkbox" name="anemiaChkGrp" checked disabled value="Anemia: Chronic Disease" >
                        <a onmouseover="makeDivVisible('cd')" onmouseout="makeDivHidden('cd')">
                        Chronic&nbsp;&nbsp;</a></span><br/>
                	
                <%}else{ %>
                        <input id="amemiaCd" type="checkbox" name="anemiaChkGrp" value="Anemia: Chronic Disease" onclick="checkMain('anemia');">
                        <a onmouseover="makeDivVisible('cd')" onmouseout="makeDivHidden('cd')">
                        Chronic&nbsp;&nbsp;</a></span><br/>
                    <%
                    }
                    }
                    %>
                    </td>
                    <td>
                        <div id="cd" class="imageBack" style="width:450px; height:400px;"><img src="images/div.png" width="100%"; height="100%"/>
                            <div id="cd" class="dynamicDiv" style="width:350px; height:320px; margin-left: 55px ; margin-top: -370px;">
                            <%
                            //if(result == 3)
                            {
                            %>
                                <br/><span style = "color: #858384; font-weight: bold;">
                                Values are:<br/><br/></span>
                                <%
                                if(minhb.isEmpty() != true /* && (Double.parseDouble(minhb) < Double.parseDouble(hbLow)) &&
                                                                (Double.parseDouble(minhb_prev) < Double.parseDouble(hbLow)) */)
                                {
                                    out.print(spaces + "Hemoglobin (Latest):         "+minhb+" "+ newminhbDate +"<br/>");
                                    //out.print(spaces + "Hemoglobin (Previous Visit): "+minhb_prev+" "+  newminhb_prevDate +"<br/>");
                                }
                                if(minhb_prev.isEmpty() != true){
                                    out.print(spaces + "Hemoglobin (Previous Visit): "+minhb_prev+" "+  newminhb_prevDate +"<br/>");
                                }
                                
                                if(minhc.isEmpty() != true /* && (Double.parseDouble(minhc) < Double.parseDouble(hcLow)) &&
                                                                (Double.parseDouble(minhc_prev) < Double.parseDouble(hcLow)) */)
                                {
                                    out.print(spaces + "Hematocrit (Latest):         "+minhc+" "+  newminhcDate +"<br/>");
                                    //out.print(spaces + "Hematocrit (Previous Visit): "+minhc_prev+" "+  newminhc_prevDate +"<br/>");
                                }
                                if(minhc_prev.isEmpty() != true){
                                    out.print(spaces + "Hematocrit (Previous Visit): "+minhc_prev+" "+  newminhc_prevDate +"<br/>");
                                }
                                %>
                            <%
                            }
                            %>            
                                    <!-- 
                                    <br/><span style = "color: #858384; font-weight: bold;"> 
                                    Normal Reference Range:<br/><br/></span>
                                    &nbsp;&nbsp;&nbsp;&nbsp; For both current and previous visits, <br/>
                                    -->
                                    <%
                                    /*
                                    if(hbLow.isEmpty() != true)
                                        out.print("Hemoglobin : " + hbLow + " or greater" + "\n" + "<br/>");
                                
                                    if(hcLow.isEmpty() != true)
                                        out.print("Hematocrit : " + hcLow + " or greater" + "\n");
                                    */
                                    %>    
                                        
                                    <br/><br/><span style = "color: #858384; font-weight: bold;"> 
                                    Determined by the Rule:<br/><br/></span>
                                    
                                    <%
                                    if(minhb.isEmpty() != true)
                                        out.print(spaces + "Both Current and Previous Hemoglobin < " + hbLow + "<br/>");
                                    
                                    /*if(minhb_prev.isEmpty() != true)
                                        out.print(spaces + "Previous Hemoglobin < " + hbLow + "<br/>");*/    
                                    
                                    if(minhc.isEmpty() != true)
                                        out.print(spaces + "Both Current and Previous Hematocrit < " + hcLow + "<br/>");
                                    %>
                                                 
                            </div>
                        </div>
                        <a id="imageCd" onmouseover="makeDivVisible('cd')" onmouseout="makeDivHidden('cd')" style="visibility: hidden;">
                        <img src="images/button1.jpg" alt="Details"/>
                        </a> 
                       </td>
                   </tr>
                   <%
        
        //else if(result == 2)
        
                   %>
                   <tr onmouseover="mouseOverPara('imageAnmNOS','anmNOScol')" onmouseout="mouseOutPara('imageAnmNOS','anmNOScol')">
            <td></td>
            <td></td>
            <td id = "anmNOScol">
            
            <%
            // if it is NOS, this option is displayed in "blue" else it is dsiplayed in "black" and the corresponding values are also displayed
            if(result == 2) 
            {
            %>
                <span style="color: blue;">
                <%if(anemiaFlag){
                	%> <input id="anemiaNos" type="checkbox" name="anemiaChkGrp" checked disabled value="Anemia: NOS" >
                <a onmouseover="makeDivVisible('anmNOS')" onmouseout="makeDivHidden('anmNOS')">
                 Not otherwise specified&nbsp;&nbsp;</a></span><br/>
                	
                <%}else{ %>
                <input id="anemiaNos" type="checkbox" name="anemiaChkGrp" value="Anemia: NOS" onclick="checkMain('anemia');">
                <a onmouseover="makeDivVisible('anmNOS')" onmouseout="makeDivHidden('anmNOS')">
                 Not otherwise specified&nbsp;&nbsp;</a></span><br/>
            <%
            }
            }
            else
            {
            %>
                <span style="color: black;">
                <%if(anemiaFlag){
                	%> <input id="anemiaNos" type="checkbox" name="anemiaChkGrp" checked disabled value="Anemia: NOS" >
                <a onmouseover="makeDivVisible('anmNOS')" onmouseout="makeDivHidden('anmNOS')">
                 Not otherwise specified&nbsp;&nbsp;</a></span><br/>
                	
                <%}else{ %>
                <input id="anemiaNos" type="checkbox" name="anemiaChkGrp" value="Anemia: NOS" onclick="checkMain('anemia');">
                <a onmouseover="makeDivVisible('anmNOS')" onmouseout="makeDivHidden('anmNOS')">
                 Not otherwise specified&nbsp;&nbsp;</a></span><br/>
            <%
                }
            }
            %>
            </td>
            <td>
                <div id="anmNOS" class="imageBack" style="width:450px; height:400px;"><img src="images/div.png" width="100%"; height="100%"/>
                    <div id="anmNOS" class="dynamicDiv" style="width:350px; height:320px; margin-left: 55px ; margin-top: -370px;">
                            <%
                            //if(result == 2)
                            {
                            %>
                                <br/><span style = "color: #858384; font-weight: bold;">
                                Values are:<br/><br/></span>
                                <%
                                if(minhb.isEmpty() != true /* && (Double.parseDouble(minhb) < Double.parseDouble(hbLow)) && minhb_prev.isEmpty() == true */)
                                    out.print(spaces + "Hemoglobin (Latest):         "+minhb+" "+ newminhbDate +"<br/>");        
    
                                if(minhc.isEmpty() != true /* && (Double.parseDouble(minhc) < Double.parseDouble(hcLow)) && minhc_prev.isEmpty() == true */)
                                    out.print(spaces + "Hematocrit (Latest): "+minhc+" "+  newminhcDate +"<br/>");        
                                %>
                            <%
                            }
                            %>        
                            <!--<br/><span style = "color: #858384; font-weight: bold;"> 
                            Normal Reference Range:<br/><br/></span>
                            For current visit:<br/>    
                            -->        
                            <%
                            /*
                            if(hbLow.isEmpty() != true)
                                out.print("Hemoglobin : " + hbLow + " or greater" + "\n" + "<br/>");
                        
                            if(hcLow.isEmpty() != true)
                                out.print("Hematocrit : " + hcLow + " or greater" + "\n");
                            */
                            %>    
                                        
                            <br/><br/><span style = "color: #858384; font-weight: bold;"> 
                            Determined by the Rule:<br/><br/></span>
                            
                            <%
                            if(hbLow.isEmpty() != true)
                                out.print(spaces + "Current Hemoglobin < " + hbLow + " and previous visit's Hemoglobin is not available." + "<br/>");
                            
                            if(minhc.isEmpty() != true)
                                out.print(spaces + "Current Hematocrit < " + hcLow + " and previous visit's Hematocrit is not available." + "<br/>");    
                            %>
                            
                    </div>
                </div>
                <a id="imageAnmNOS" onmouseover="makeDivVisible('anmNOS')" onmouseout="makeDivHidden('anmNOS')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/>
                </a> 
               </td>
            </tr> 
            <%
            
            //else if(result == 2)
            {
            %>
                   <tr onmouseover="mouseOverPara('imageAnmNOS','anmNOScol')" onmouseout="mouseOutPara('imageAnmNOS','anmNOScol')">
                <td></td>
                <td></td>
                <td id = "anmNOScol">
                        <span style="color: black;">
                        <%if(anemiaFlag){
                	%>  <input id="anemiaBloodLoss" type="checkbox" checked disabled name="anemiaChkGrp" value="Anemia: Blood Loss" >
                        Due to blood loss &nbsp;&nbsp;</span><br/>
                	
                <%}else{ %>
                        <input id="anemiaBloodLoss" type="checkbox" name="anemiaChkGrp" value="Anemia: Blood Loss" onclick="checkMain('anemia');">
                        Due to blood loss &nbsp;&nbsp;</span><br/>
                        <%} %>
                </td>
                <td>
                        
            <%
            }
            %>
                   
    <%
    }
    %>
    
    <!-- ************************************** Kidney Injury ******************************************* -->
    
    <% 
    boolean KIFlag=false;
    int KIValueMatch=0;
    //Invoking rule
        result = coMorbChk.acuteKidneyInjury(maxcreatResult, maxcreatprevResult, creatHigh);
    //if default DB value is not present, we set creatHigh = 1.2
    if (creatHigh.isEmpty() == true){
        creatHigh = "1.2";
    }
    System.out.println("Creat: " + maxcreatResult);
    System.out.println("Prev creat: " + maxcreatprevResult);
    System.out.println("High Creat: " + creatHigh);
    System.out.println("Acute Kidney Injury: " + result);
    if(result != 0)
    {
    	Iterator imain=valueMatch.entrySet().iterator();
    	Map<String, String> values =new HashMap<String, String>();
    	while(imain.hasNext())
    	{
    			Entry e=(Entry)imain.next();
    			if(e.getKey().equals("Acute Kidney Injury"))
    			{
    				KIFlag=true;
    				values=(Map<String, String>)e.getValue();
    				break;
    			}
    	}
    	if(KIFlag)
    	{
    		Iterator ival=values.entrySet().iterator();
    		while(ival.hasNext())
    		{
    			Entry e=(Entry)ival.next();
    			String testName=(String)e.getKey();
    			String testVal=(String)e.getValue();
    			if(testName.equals("creat"))
    			{
    				if(!testVal.isEmpty() && !maxcreatResult.isEmpty())
    				{
    					if(Double.parseDouble(testVal)!=Double.parseDouble(maxcreatResult))
    					KIValueMatch=1;
    				}
    				else
       				{
       					if(!maxcreatResult.isEmpty())
       						KIValueMatch=1;
       				}
    			}	
    			/*if(!maxcreatResult.isEmpty() && !values.containsKey("creat"))
    			{
					KIFlag=false;
    				KIValueMatch=1;
    			}*/
    			if(testName.equals("prevcreat"))  
    			{
    				if(!testVal.isEmpty() && !maxcreatprevResult.isEmpty())
    				{
    					if(Double.parseDouble(testVal)!=Double.parseDouble(maxcreatprevResult))
    					KIValueMatch=1;
    				}
    				else
       				{
       					if(!maxcreatprevResult.isEmpty())
       						KIValueMatch=1;
       				}
    			}
    			/*if(!maxcreatprevResult.isEmpty() && !values.containsKey("prevcreat"))
    			{
					KIFlag=false;	
    				KIValueMatch=1;
    			}*/
    		}
    	}
    	else
    	{
    		KIValueMatch=1;
    	}
    }
    if(KIValueMatch!=0)
    {
    	
    %>
        
        <input type="hidden" name="CreatDate" id="CreatDate" value="<%=newmaxcreatDate%>">
        <input type="hidden" name="Creat" id="Creat" value="<%=maxcreatResult%>">
        <input type="hidden" name="CreatPrev" id="CreatPrev" value="<%=maxcreatprevResult%>">
        <input type="hidden" name="CreatPrevDate" id="CreatPrevDate" value="<%=newmaxcreatprevDate%>">
        <tr>
                <td>
                        <span style="color: black">
                        <%if(KIFlag){
                	%>  <input type="checkbox" id="aki" name="mainGrp"  checked disabled value="Acute Kidney Injury" />
                        Kidney Injury&nbsp;&nbsp;
                        </span>
                	
                <%}else{ %>
                        <input type="checkbox" id="aki" name="mainGrp" value="Acute Kidney Injury" onclick="unCheck('aki','akiChkGrp');"/>
                        Kidney Injury&nbsp;&nbsp;
                        </span>
                        <%} %>
                </td>
                <td></td>
                <td></td>
                <td></td>
        </tr>
            <% //acute
            //if(result == 2) 
            {%>
            <tr onmouseover="mouseOverPara('imageRfAcute','RfAcuteCol')" onmouseout="mouseOutPara('imageRfAcute','RfAcuteCol')">
                <td></td>
                <td></td>
                <td id ="RfAcuteCol">
                <%if(result == 2){ %>
                        <span style="color: blue;">
                        <%if(KIFlag){
                	%>  <a onmouseover="makeDivVisible('RfAcute')" onmouseout="makeDivHidden('RfAcute')"><input type="checkbox" checked disabled name="akiChkGrp" value="Acute Kidney Injury :Acute"/>
                                Acute &nbsp;&nbsp;</a>
                        </span>
                	
                <%}else{ %>
                                <a onmouseover="makeDivVisible('RfAcute')" onmouseout="makeDivHidden('RfAcute')"><input type="checkbox" name="akiChkGrp" value="Acute Kidney Injury :Acute" onclick="checkMain('aki');"/>
                                Acute &nbsp;&nbsp;</a>
                        </span>
                <%}}else{ %>
                
                <span style="color: black;">
                <%if(KIFlag){
                	%>  <a onmouseover="makeDivVisible('RfAcute')" onmouseout="makeDivHidden('RfAcute')"><input type="checkbox" checked disabled name="akiChkGrp" value="Acute Kidney Injury :Acute"/>
                                Acute &nbsp;&nbsp;</a>
                        </span>
                	
                <%}else{ %>
                                <a onmouseover="makeDivVisible('RfAcute')" onmouseout="makeDivHidden('RfAcute')"><input type="checkbox" name="akiChkGrp" value="Acute Kidney Injury :Acute" onclick="checkMain('aki');"/>
                                Acute &nbsp;&nbsp;</a>
                        </span>
                
                <%}} %>
                        
                </td>
                 
                <td>
                        <div id="RfAcute" class="imageBack" style="width:450px; height:330px;"><img src="images/div.png" width="100%" height="100%"/>
                            <div id="RfAcute" class="dynamicDiv" style="width:360px; height:265px; margin-top: -305px;">
                                <br/>
                                
                                
                                <span style = "color: #858384; font-weight: bold;">
                                
                                
                                Values are:<br/><br/></span>
                                <%
                                out.print(spaces + "Creatinine (Latest): &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+maxcreatResult+" "+ newmaxcreatDate +"<br/>");
                                if(maxcreatprevResult.equalsIgnoreCase("-99999.0")!=true && maxcreatprevResult.equalsIgnoreCase("99999.0")!= true)
                                out.print(spaces + "Creatinine (Previous Visit): "+maxcreatprevResult+" "+  newmaxcreatprevDate +"<br/>");
                                %>
                                <!-- <span>
                                <input type="hidden" name="AcrfaCreatDate" id="AcrfaCreatDate" value="<%=newmaxcreatDate%>">
                                <input type="hidden" name="AcrfaCreat" id="AcrfaCreat" value="<%=maxcreatResult%>">
                                <input type="hidden" name="AcrfaCreatPrev" id="AcrfaCreatPrev" value="<%=maxcreatprevResult%>">
                                <input type="hidden" name="AcrfaCreatPrevDate" id="AcrfaCreatPrevDate" value="<%=newmaxcreatprevDate%>">
                        </span>-->
                        
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                    Determined by the Rule:<br/><br/></span>
                                    
                                    Latest creatinine > <%=creatHigh %> and 
                                    previous creatinine <= <%=creatHigh %> or
                                    latest creatinine = 1.5 x previous creatinine
                        </div>
                    </div>
                    <a id="imageRfAcute" onmouseover="makeDivVisible('RfAcute')" 
                    onmouseout="makeDivHidden('RfAcute')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
                
            </tr>
                        
            <%
            }
            //else if(result==3) chronic
            {%>
            
            <tr onmouseover="mouseOverPara('imageRfChronic','RfChronicCol')" onmouseout="mouseOutPara('imageRfChronic','RfChronicCol')">
            <td></td>
            <td></td>
            <td id ="RfChronicCol">
            <%if(result==3){ %>
            <span style="color: blue;">
            <%if(KIFlag){
                	%>    <a onmouseover="makeDivVisible('RfAcuteChronic')" onmouseout="makeDivHidden('RfAcuteChronic')"><input type="checkbox" checked disabled name="akiChkGrp" value="Chronic Kidney Disease :Chronic"> <!-- name="ckdChkGrp" onclick="checkMain('ckd');" --> 
                            Chronic &nbsp;&nbsp;</a>
            </span>
                	
                <%}else{ %>
                            <a onmouseover="makeDivVisible('RfAcuteChronic')" onmouseout="makeDivHidden('RfAcuteChronic')"><input type="checkbox"  name="akiChkGrp" value="Chronic Kidney Disease :Chronic" onclick="checkMain('aki');"> <!-- name="ckdChkGrp" onclick="checkMain('ckd');" --> 
                            Chronic &nbsp;&nbsp;</a>
            </span>
            <%} }else{ %>
            <span style="color: black;">
            <%if(KIFlag){
                	%>    <a onmouseover="makeDivVisible('RfAcuteChronic')" onmouseout="makeDivHidden('RfAcuteChronic')"><input type="checkbox" checked disabled name="akiChkGrp" value="Chronic Kidney Disease :Chronic"> <!-- name="ckdChkGrp" onclick="checkMain('ckd');" --> 
                            Chronic &nbsp;&nbsp;</a>
            </span>
                	
                <%}else{ %>
                            <a onmouseover="makeDivVisible('RfAcuteChronic')" onmouseout="makeDivHidden('RfAcuteChronic')"><input type="checkbox"  name="akiChkGrp" value="Chronic Kidney Disease :Chronic" onclick="checkMain('aki');"> <!-- name="ckdChkGrp" onclick="checkMain('ckd');" --> 
                            Chronic &nbsp;&nbsp;</a>
            </span>            
            <%}} %>
            </td>
            <td>
            
                    
                    <div id="RfAcuteChronic" class="imageBack" style="width:450px; height:330px;"><img src="images/div.png" width="100%" height="100%"/>
                            <div id="RfAcute" class="dynamicDiv" style="width:360px; height:265px; margin-top: -305px;">
                                <br/>
                                
                                <span style = "color: #858384; font-weight: bold;">
                                
                                Values are:<br/><br/></span>
                                <%
                                out.print(spaces + "Creatinine (Latest): &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+maxcreatResult+" "+ newmaxcreatDate +"<br/>");
                                if(maxcreatprevResult.equalsIgnoreCase("-99999.0")!=true && maxcreatprevResult.equalsIgnoreCase("99999.0")!= true)
                                out.print(spaces + "Creatinine (Previous Visit): "+maxcreatprevResult+" "+  newmaxcreatprevDate +"<br/>");
                                %>
                                <!-- <span>
                                <input type="hidden" name="rfcCreatDate" id="rfcCreatDate" value="<%=newmaxcreatDate%>">
                                <input type="hidden" name="rfcCreat" id="rfcCreat" value="<%=maxcreatResult%>">
                                <input type="hidden" name="rfcCreatPrev" id="rfcCreatPrev" value="<%=maxcreatprevResult%>">
                                <input type="hidden" name="rfcCreatPrevDate" id="rfcCreatPrevDate" value="<%=newmaxcreatprevDate%>">
                        </span>-->
                    
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                    Determined by the Rule:<br/><br/></span>
                            
                            Previous and current creatinine both > <%=creatHigh %><br/>
                        </div>
                    </div>
                    <a id="imageRfChronic" onmouseover="makeDivVisible('RfAcuteChronic')" 
                    onmouseout="makeDivHidden('RfAcuteChronic')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                    
                
            </td>
            </tr>
            
            <%}
            //else if (result == 1) NOS
            {%>
            
            <tr onmouseover="mouseOverPara('imageRfAcuteNOS','RfAcuteNOSCol')" onmouseout="mouseOutPara('imageRfAcuteNOS','RfAcuteNOSCol')">
                <td></td>
                <td></td>
                <td id ="RfAcuteNOSCol">
                <%if (result == 1){ %>
                <span style="color: blue;">
                <%if(KIFlag){
                	%>         <a onmouseover="makeDivVisible('RfAcuteNOS')" onmouseout="makeDivHidden('RfAcuteNOS')"><input type="checkbox" checked disabled name="akiChkGrp" value="Acute Kidney Injury :NOS"/>
                                Not Otherwise Specified &nbsp;&nbsp;</a>
                </span>
                	
                <%}else{ %>
                                <a onmouseover="makeDivVisible('RfAcuteNOS')" onmouseout="makeDivHidden('RfAcuteNOS')"><input type="checkbox" name="akiChkGrp" value="Acute Kidney Injury :NOS" onclick="checkMain('aki');"/>
                                Not Otherwise Specified &nbsp;&nbsp;</a>
                </span>
                <%}} else{ %>
                    
                <span style="color: black;">
                 <%if(KIFlag){
                	%>         <a onmouseover="makeDivVisible('RfAcuteNOS')" onmouseout="makeDivHidden('RfAcuteNOS')"><input type="checkbox" checked disabled name="akiChkGrp" value="Acute Kidney Injury :NOS"/>
                                Not Otherwise Specified &nbsp;&nbsp;</a>
                </span>
                	
                <%}else{ %>
                                <a onmouseover="makeDivVisible('RfAcuteNOS')" onmouseout="makeDivHidden('RfAcuteNOS')"><input type="checkbox" name="akiChkGrp" value="Acute Kidney Injury :NOS" onclick="checkMain('aki');"/>
                                Not Otherwise Specified &nbsp;&nbsp;</a>
                </span>
                    
                <%}} %>
                </td>
                
                <td>
                        <div id="RfAcuteNOS" class="imageBack" style="width:450px; height:330px;"><img src="images/div.png" width="100%" height="100%"/>
                            <div id="RfAcuteNOS" class="dynamicDiv" style="width:360px; height:265px; margin-top: -305px;">
                                <br/>
                                
                                <span style = "color: #858384; font-weight: bold;">
                                
                                Values are:<br/><br/></span>
                                <%
                                out.print(spaces + "Creatinine (Latest): "+maxcreatResult+" " + newmaxcreatDate + "<br/>");
                                %>
                                <!-- <span>
                                <input type="hidden" name="ChrfaCreatDate" id="ChrfaCreatDate" value="<%=newmaxcreatDate%>">
                                <input type="hidden" name="ChrfaCreat" id="ChrfaCreat" value="<%=maxcreatResult%>">
                                </span>-->
                                
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                    Determined by the Rule:<br/><br/></span>
                                    
                                    Latest creatinine > <%=creatHigh %> and previous visit's creatinine is not available.
                        </div>
                    </div>
                    <a id="imageRfAcuteNOS" onmouseover="makeDivVisible('RfAcuteNOS')" 
                    onmouseout="makeDivHidden('RfAcuteNOS')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
                
            </tr>
            
            <%
            }%>    
      <%}%>
      
      <!-- ************************************** Chronic Kidney Disease ******************************************* -->
    <% 
    //Invoking rule
    boolean CKDFlag=false;
    int CKValueMatch=0;
    result = coMorbChk.chronicKidneyDisease(maxcreatResult,maxcreatprevResult, creatHigh); 
    System.out.println("Chronic Kidney Injury: " + result);
    if(result != 0)
    {
    	Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
        while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("Chronic Kidney Disease"))
        		{
        			CKDFlag=true;
        			values=(Map<String, String>)e.getValue();
       				break;
      			}
        }
        if(CKDFlag)
        {
        	Iterator ival=values.entrySet().iterator();
        	while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
      			String testName=(String)e.getKey();
       			String testVal=(String)e.getValue();
       			if(testName.equals("rfcCreat")) 
       			{	
       				if(!testVal.isEmpty() && !maxcreatResult.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(maxcreatResult))
							CKValueMatch=1;
       				}
       				else
       				{
       					if(!maxcreatResult.isEmpty())
       						CKValueMatch=1;
       				}
       			}
       			/*if(!maxcreatResult.isEmpty() && !values.containsKey("rfcCreat"))
       			{
					CKDFlag=false;
       				CKValueMatch=1;
       			}*/
				if(testName.equals("rfcPrevCreat"))  
				{
					if(!testVal.isEmpty() && !maxcreatprevResult.isEmpty())
					{
						if(Double.parseDouble(testVal)!=Double.parseDouble(maxcreatprevResult))
							CKValueMatch=1;
					}
					else
       				{
       					if(!maxcreatprevResult.isEmpty())
       						CKValueMatch=1;
       				}
				}
				/*if(!maxcreatprevResult.isEmpty() && !values.containsKey("rfcPrevCreat"))
				{
					CKDFlag=false;
					CKValueMatch=1;
				}*/
        	}
        }
        else
        {
        	CKValueMatch=1;
        }
    }
    if(CKValueMatch!=0)   
    {   	
   	%>
        <tr>
            <td>
                    <span style="color: black">
                    <%if(CKDFlag){
                	%>         <input type="checkbox" checked disabled id="ckd" name="mainGrp" value="Chronic Kidney Disease">
                    Chronic Kidney Disease&nbsp;&nbsp;</span>
                	
                <%}else{ %>
                    <input type="checkbox" id="ckd" name="mainGrp" value="Chronic Kidney Disease">
                    Chronic Kidney Disease&nbsp;&nbsp;</span>
                    <%} %>
                    <input type="hidden" name="rfcprevDate" id="rfcprevDate" value="<%=newmaxcreatprevDate%>">
                    <input type="hidden" name="rfcprevCreat" id="rfcprevCreat" value="<%=maxcreatprevResult%>">
                    <input type="hidden" name="rfcDate" id="rfcDate" value="<%=newmaxcreatDate%>">
                    <input type="hidden" name="rfcCreat" id="rfcCreat" value="<%=maxcreatResult%>">
                    <input type="hidden" name="rfcMaxGfr" id="rfcMaxGfr" value="<%=maxgfrResult%>">
                    <input type="hidden" name="rfcMaxGfrDate" id="rfcMaxGfrDate" value="<%=newmaxgfrDate%>">
                    <input type="hidden" name="rfcMinGfr" id="rfcMinGfr" value="<%=mingfrResult%>">
                    <input type="hidden" name="rfcMinGfrDate" id="rfcMinGfrDate" value="<%=newmingfrDate%>"> 
            </td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <%if(result == 1){%>
            <tr onmouseover="mouseOverPara('imageRfChronicNOS','RfChronicNOSCol')" onmouseout="mouseOutPara('imageRfChronicNOS','RfChronicNOSCol')">
            <td></td>
            <td></td>
            <td id ="RfChronicNOSCol"><span style="color: blue;">
            	<%if(CKDFlag){
                	%>        <a onmouseover="makeDivVisible('RfChronicNOS')" onmouseout="makeDivHidden('RfChronicNOS')"><input type="checkbox" checked disabled name="ckdChkGrp" value="Chronic Kidney Disease :NOS" >
                            Not Otherwise Specified &nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                            <a onmouseover="makeDivVisible('RfChronicNOS')" onmouseout="makeDivHidden('RfChronicNOS')"><input type="checkbox" name="ckdChkGrp" value="Chronic Kidney Disease :NOS" onclick="checkMain('ckd');">
                            Not Otherwise Specified &nbsp;&nbsp;</a></span>
                            <%} %>
            </td>
            <td>
                    <div id="RfChronicNOS" class="imageBack" style="width:430px; height:330px;"><img src="images/div.png" width="100%" height="100%"/>
                        <div id="RfChronicNOS" class="dynamicDiv" style="width:350px; height:270px; margin-top: -305px;">
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                            <%
                                out.print(spaces + "Creatinine: "+ maxcreatResult+" "+  newmaxcreatDate +"<br/>");
                            if(maxgfrResult.isEmpty()!=true){
                                out.print(spaces + "Maximum GFR: "+ maxgfrResult+" "+  newmaxgfrDate + "<br/>");
                                }
                                if(mingfrResult.isEmpty()!=true){
                                out.print(spaces + "Minimum GFR: "+ mingfrResult+" " + newmingfrDate +"<br/>");
                                }
                            %>
                            <br/><span style = "color: #858384; font-weight: bold;"> 
                            Determined by the Rule:<br/><br/></span>
                            
                            Previous creatinine values are unavailable.<br/>
                            Current creatinine is > 1.2
                    </div>
                </div>
                <a id="imageRfChronicNOS" onmouseover="makeDivVisible('RfChronicNOS')" 
                onmouseout="makeDivHidden('RfChronicNOS')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
            </td>
            </tr>
            <%}
        if(result == 2){%>
            <tr onmouseover="mouseOverPara('imageRfChronic','RfChronicCol')" onmouseout="mouseOutPara('imageRfChronic','RfChronicCol')">
            <td></td>
            <td></td>
            <td id ="RfChronicCol"><span style="color: blue;">
            <%if(CKDFlag){
                	%>        <a onmouseover="makeDivVisible('RfChronic')" onmouseout="makeDivHidden('RfChronic')"><input type="checkbox" checked disabled name="ckdChkGrp" value="Chronic Kidney Disease :Chronic" >
                            Chronic &nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                            <a onmouseover="makeDivVisible('RfChronic')" onmouseout="makeDivHidden('RfChronic')"><input type="checkbox" name="ckdChkGrp" value="Chronic Kidney Disease :Chronic" onclick="checkMain('ckd');">
                            Chronic &nbsp;&nbsp;</a></span>
                            <%} %>
            </td>
            <td>
                    <div id="RfChronic" class="imageBack" style="width:430px; height:330px;"><img src="images/div.png" width="100%" height="100%"/>
                        <div id="RfChronic" class="dynamicDiv" style="width:350px; height:270px; margin-top: -305px;">
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                            <%
                                
                                out.print(spaces + "Previous Creatinine: "+maxcreatprevResult+" " + newmaxcreatprevDate + "<br/>");
                                out.print(spaces + "Creatinine: "+maxcreatResult+" " + newmaxcreatDate +"<br/>");
                                if(maxgfrResult.isEmpty()!=true){
                                out.print(spaces + "Maximum GFR: "+ maxgfrResult+" "+  newmaxgfrDate + "<br/>");
                                }
                                if(mingfrResult.isEmpty()!=true){
                                out.print(spaces + "Minimum GFR: "+ mingfrResult+" " + newmingfrDate +"<br/>");
                                }

                            %>        
                            <br/><span style = "color: #858384; font-weight: bold;"> 
                            Determined by the Rule:<br/><br/></span>
                            
                            Previous and current creatinine both > 1.2.<br/>
                    </div>
                </div>
                <a id="imageRfChronic" onmouseover="makeDivVisible('RfChronic')" 
                onmouseout="makeDivHidden('RfChronic')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
            </td>
            </tr>
            <%}%>
        <%}%>
      
     
    <!-- ************************************** Dehydration ******************************************* -->
    <%
    boolean DFlag=false;
    int DehydrationValueMatch=0;
    //Invoking rules
    result_dehydration = coMorbChk.dehydration(creatinineValue, bunValue);
    System.out.println("Dehydration: " + result_dehydration);
    if(result_dehydration !=0)
    {
    	
    	Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("Dehydration"))
        		{
       				DFlag=true;
       				System.out.println("Entered Dehydration");
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
       	}
       	if(DFlag)
       	{
       		if(!creatinineValue.isEmpty() && !bunValue.isEmpty())
        	{
        		double x=Double.parseDouble(creatinineValue);
        		double y=Double.parseDouble(bunValue);
        		if((int)(y/x)>20)
        		{
        			creatinineValue="8.0";
        			bunValue="-99999.0";
        		}
        	}
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
        		System.out.println("Test Name:"+testName+"Test Val:"+testVal);
       			if(testName.equals("hydracreatinine")) 
       			{		
       				if(!testVal.isEmpty() && !creatinineValue.isEmpty())
       				{
       					System.out.println("CreatinineValue :"+creatinineValue);
       					if(Double.parseDouble(testVal)!=Double.parseDouble(creatinineValue))
       						DehydrationValueMatch=1;
       				}
       				else
       				{
       					if(!creatinineValue.isEmpty())
       						DehydrationValueMatch=1;
       				}
       				
       			}
       			/*if(!creatinineValue.isEmpty() && !values.containsKey("hydracreatinine"))
       			{
       				DFlag=false;
       				DehydrationValueMatch=1;
       			}*/
       			if(testName.equals("hydrabunresult"))
       			{
       			
       				if(!testVal.isEmpty() && !bunValue.isEmpty())
       				{
       					System.out.println("BunValue :"+Double.parseDouble(bunValue));
       						if(Double.parseDouble(testVal)!=Double.parseDouble(bunValue))
       							DehydrationValueMatch=1;
       				}
       				else
       				{
       					if(!bunValue.isEmpty())
       						DehydrationValueMatch=1;
       				}
       			}
       			/*if(!bunValue.isEmpty() && !values.containsKey("hydrabunresult"))
       			{	
						DehydrationValueMatch=1;
						DFlag=false;
       			}*/
        	}
       		System.out.println("Result dehydration :"+result_dehydration);
       	}
       	else
       	{
       		DehydrationValueMatch=1;
       	}
    }
    if(DehydrationValueMatch!= 0)
    {
    %>
        <tr onmouseover="mouseOverPara('imageDehydration','Dehydrationcol1')" onmouseout="mouseOutPara('imageDehydration','Dehydrationcol1')" >
            <td id="Dehydrationcol1">
                <span style="color: blue;">
                <%if(DFlag){
                	%>        <a onmouseover="makeDivVisible('Dehydration')" onmouseout="makeDivHidden('Dehydration')"><input type="checkbox" checked disabled name="mainGrp" value="Dehydration">
                    Dehydration&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('Dehydration')" onmouseout="makeDivHidden('Dehydration')"><input type="checkbox" name="mainGrp" value="Dehydration">
                    Dehydration&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                    <div id="Dehydration" class="imageBackSingle"><img src="images/divSingle.png" width="100%"; height="100%"/>
                        <div id="Dehydration" class="dynamicDiv" style="width:320px; height:270px; margin-left: 40px; margin-top: -320px">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>

                                <%
                                    //out.print(spaces + "Date: "+newheightDate+" "+"<br/>");
                                    out.print(spaces + "Creatinine: &nbsp;&nbsp;&nbsp;"+creatinineValue+" "+ newdehydrationCreatDate +"<br/>");
                                    out.print(spaces + "BUN: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp"+bunValue+" "+ newdehydrationBunDate +"<br/>");
                                    out.print(spaces + "Dehydration: "+result_dehydration+" "+"<br/>");
                                %>    
                                <input type="hidden" name="hydracreatDate" id="hydracreatDate" value="<%=newmincreatDate%>">
                                <input type="hidden" name="hydracreatinine" id="hydracreatinine" value="<%=mincreatResult%>">
                                <input type="hidden" name="hydrabunDate" id="hydrabunDate" value="<%=newMaxbunDate%>">
                                <input type="hidden" name="hydrabunResult" id="hydrabunResult" value="<%=maxbun%>">
                                <input type="hidden" name="hydration" id="hydration" value="<%=result_dehydration%>">
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Reference Range:<br/><br/></span>
                                &nbsp;&nbsp;&nbsp;&nbsp;Dehydration if BUN/creatinine > 20 for age upto 1 year <br/><br/>
                                &nbsp;&nbsp;&nbsp;&nbsp;Dehydration if BUN/creatinine > 30 for age more than 1 year
                        </div>
                    </div>
                    <a id="imageDehydration" onmouseover="makeDivVisible('Dehydration')" 
                    onmouseout="makeDivHidden('Dehydration')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
         </tr>    
		<%} %>    
	
    
    <!-- ********************************************* Elevated Blood Glucose************************************************* -->
    <% 
    boolean EBGFlag=false;
    int EBGValueMatch=0;
    result = coMorbChk.Diabetes(maxglucResult,glucHigh);
    System.out.println("Elevated Blood Glucose: " + result);
     if(result != 0) 
     { 
        Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("ElevatedBloodGlucose"))
        		{
       				EBGFlag=true;
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
       	}
       	if(EBGFlag)
       	{
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
       			
       			if(testName.equals("glucresult")) 
       			{	
       				if(!testVal.isEmpty() && !maxglucResult.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(maxglucResult))
       						EBGValueMatch=1;
       				}
       				else
       				{
       					if(!maxglucResult.isEmpty())
       						EBGValueMatch=1;
       				}
       			}
       			/*if(!maxglucResult.equals("-99999.0") && !values.containsKey("glucresult"))
       			{	
       				EBGFlag=false;
       				EBGValueMatch=1;
       			}*/
       			
       		}
       	}
       	else
       	{
       		EBGValueMatch=1;
       	}
     }
     if(EBGValueMatch!=0)
     {
    %>
     <tr>
            <td>
                    <span style="color: black">
                    <%if(EBGFlag){
                	%>   <input type="checkbox" checked disabled id="Ebg" name="mainGrp" value="ElevatedBloodGlucose" />
                    Elevated Blood Glucose&nbsp;&nbsp;
                    </span>
                	
                <%}else{ %>
                    <input type="checkbox" id="Ebg" name="mainGrp" value="ElevatedBloodGlucose" onclick="unCheck('Ebg','EbgChkGrp');"/>
                    Elevated Blood Glucose&nbsp;&nbsp;
                    </span> <%} %>
                    <span>
                    <input type="hidden" name="glucDate" id="glucDate" value="<%=newmaxglucDate%>">
                    <input type="hidden" name="glucResult" id="glucResult" value="<%=maxglucResult%>">
                    </span>
            </td>
            <td></td>
            <td></td>
            <td></td>
    </tr>
     <tr onmouseover="mouseOverPara('imageHyperglycemia','HyperglycemiaCol1')" onmouseout="mouseOutPara('imageHyperglycemia','HyperglycemiaCol1')" >
         <td></td>
        <td></td>
        <td id="HyperglycemiaCol1">
                <span style="color: blue;">
                <%if(EBGFlag){
                	%>   <a onmouseover="makeDivVisible('EbgHyperglycemia')" onmouseout="makeDivHidden('EbgHyperglycemia')"><input type="checkbox" checked disabled name="EbgChkGrp" value="Hyperglycemia" >
                    Hyperglycemia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('EbgHyperglycemia')" onmouseout="makeDivHidden('EbgHyperglycemia')"><input type="checkbox" name="EbgChkGrp" value="Hyperglycemia" onclick="checkMain('Ebg');">
                    Hyperglycemia&nbsp;&nbsp;</a></span> <%} %>
        </td>
        <td>
            <div id="EbgHyperglycemia" class="imageBackSingle" style="width:340px; height:270px;"><img src="images/divSingle.png" width="100%"; height="100%"/>
                        <div id="EbgHyperglycemia" class="dynamicDiv" style="width:250px; height:210px; margin-left: 45px ; margin-top: -245px;">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                    out.print(spaces + "Glucose level: " + maxglucResult + " " + newmaxglucDate + "<br/>");
                                %>        
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                &nbsp;&nbsp;Reference Rule:<br/><br/></span>
                                &nbsp;
                                Glucose Value > 150
                        </div>
                        
            </div>
                    <a id="imageHyperglycemia" onmouseover="makeDivVisible('EbgHyperglycemia')" 
                    onmouseout="makeDivHidden('EbgHyperglycemia')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a>     
        
        </td>
     </tr>
     
     <tr onmouseover="mouseOverPara('imageDiabetes','DiabetesCol1')" onmouseout="mouseOutPara('imageDiabetes','DiabetesCol1')" >
         <td></td>
        <td></td>
         <td id="DiabetesCol1">
                <span style="color: blue;">
                <%if(EBGFlag){
                	%>   <a onmouseover="makeDivVisible('Diabetes')" onmouseout="makeDivHidden('Diabetes')"><input type="checkbox" checked disabled name="EbgChkGrp" value="Diabetes" >
                    Diabetes&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('Diabetes')" onmouseout="makeDivHidden('Diabetes')"><input type="checkbox" name="EbgChkGrp" value="Diabetes" onclick="checkMain('Ebg');">
                    Diabetes&nbsp;&nbsp;</a></span> <%} %>
        </td>
         <td>
            <div id="Diabetes" class="imageBackSingle" style="width:340px; height:270px;"><img src="images/divSingle.png" width="100%"; height="100%"/>
                        <div id="Diabetes" class="dynamicDiv" style="width:250px; height:210px; margin-left: 45px ; margin-top: -245px;">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                //out.print(spaces + "Date: "+ newglucDate +" "+"<br/>");
                                out.print(spaces + "Glucose level: " + maxglucResult + " " + newmaxglucDate +"<br/>");
                            
                                %>        
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Reference Rule:<br/><br/></span>
                                Glucose Value > 150 
                        </div>
                        
                    </div>
                    <a id="imageDiabetes" onmouseover="makeDivVisible('Diabetes')" 
                    onmouseout="makeDivHidden('Diabetes')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
        </td>
     
     
     </tr>
     
     <%} %>
    
    
    <!-- ********************************************* Hypoglycemia************************************************* -->
    <% 
    boolean HGFlag=false;
    int HGValueMatch=0;
    result = coMorbChk.HypoGylecmia(minglucResult,glucLow);
       System.out.println("Hypogylcemia: " + result);
     if(result == 1)
     { 
        Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("Hypoglycemia"))
        		{
       				HGFlag=true;
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
       	}
       	if(HGFlag)
       	{
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
       			if(testName.equals("glucResult")) 
       			{	
       				if(!testVal.isEmpty() && !minglucResult.isEmpty())	
       				{
       					if(Double.parseDouble(testVal) !=Double.parseDouble(minglucResult))
       					HGValueMatch=1;
       				}
       				else
       				{
       					if(!minglucResult.isEmpty())
       						HGValueMatch=1;
       				}
       			}
       			/*if(!minglucResult.isEmpty() && !values.containsKey("glucResult"))
       			{
       				HGFlag=false;
       				HGValueMatch=1;
       			}*/
       		}
       	}
       	else
       	{
       		HGValueMatch=1;
       	}
     }
    if(HGValueMatch!=0)
    {
    %>
        <tr onmouseover="mouseOverPara('imageHypogylcemia','HypogylcemiaCol1')" onmouseout="mouseOutPara('imageHypogylcemia','HypogylcemiaCol1')" >
            <td id="HypogylcemiaCol1">
                <span style="color: blue;">
                <%if(HGFlag){
                	%>   <a onmouseover="makeDivVisible('Hypoglycemia')" onmouseout="makeDivHidden('Hypoglycemia')"><input type="checkbox" checked disabled name="mainGrp" value="Hypoglycemia">
                    Hypoglycemia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('Hypoglycemia')" onmouseout="makeDivHidden('Hypoglycemia')"><input type="checkbox" name="mainGrp" value="Hypoglycemia">
                    Hypoglycemia&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                    <div id="Hypogylcemia" class="imageBackSingle" style="width:340px; height:270px;"><img src="images/divSingle.png" width="100%"; height="100%"/>
                        <div id="Hypogylcemia" class="dynamicDiv" style="width:240px; height:210px; margin-left: 45px ; margin-top: -245px;">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                
                                    //out.print(spaces + "Date: "+ newglucDate +" "+"<br/>");
                                out.print(spaces + "Glucose level: "+minglucResult+" "+ newminglucDate +"<br/>");

                                %>        
                                <input type="hidden" name="hypoglucDate" id="hypoglucDate" value="<%=newminglucDate%>">
                                <input type="hidden" name="hypoglucResult" id="hypoglucResult" value="<%=minglucResult%>">
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Reference Range:<br/><br/></span>
                                
                                Glucose Value : [<%=glucLow%>-<%=glucHigh%>]
                        </div>
                    </div>
                    <a id="imageHypogylcemia" onmouseover="makeDivVisible('Hypogylcemia')" 
                    onmouseout="makeDivHidden('Hypogylcemia')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
        </tr>
    <%}%>
    
    <!-- ********************************************* Hypoxia************************************************* -->
    <% boolean HypoxiaFlag=false;
    	int HypoxiaValueMatch=0;
    	boolean resultoxi = coMorbChk.hypoxia(oximetryLow ,minoximetry);
       System.out.println("Hypoxia: " + resultoxi);
     if(resultoxi) 
     { 
        Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("Hypoxia"))
        		{
       				HypoxiaFlag=true;
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
       	}
       	if(HypoxiaFlag)
       	{
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
       			if(testName.equals("oximetryResult")) 
       			{	
       				if(!testVal.isEmpty() && !oximetryLow.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(oximetryLow))
       							HypoxiaValueMatch=1;
       				}
       				else
       				{
       					if(!oximetryLow.isEmpty())
       						HypoxiaValueMatch=1;
       				}
       			}
       			if(!oximetryLow.isEmpty() && !values.containsKey("oximetryResult"))
       			{
       				HypoxiaFlag=false;
       				HypoxiaValueMatch=1;
       			}
       		}
       	}
       	else
       	{
       		HypoxiaValueMatch=1;
       	}
     }
     if(HypoxiaValueMatch!=0)
     {
    %>
        <tr onmouseover="mouseOverPara('imageHypoxia','HypoxiaCol1')" onmouseout="mouseOutPara('imageHypoxia','HypoxiaCol1')" >
            <td id="HypoxiaCol1">
                <span style="color: blue;">
                <%if(HypoxiaFlag){
                	%>   <a onmouseover="makeDivVisible('Hypoxia')" onmouseout="makeDivHidden('Hypoxia')"><input type="checkbox"  checked disabled name="mainGrp" value="Hypoxia">
                    Hypoxia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('Hypoxia')" onmouseout="makeDivHidden('Hypoxia')"><input type="checkbox" name="mainGrp" value="Hypoxia">
                    Hypoxia&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                    <div id="Hypoxia" class="imageBackSingle" style="width:340px; height:270px;"><img src="images/divSingle.png" width="100%"; height="100%"/>
                        <div id="Hypoxia" class="dynamicDiv" style="width:250px; height:210px;margin-left: 40px ; margin-top: -247px;">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                
                                    //out.print(spaces + "Date: "+ newglucDate +" "+"<br/>");
                                    out.print(spaces + "Pulse Oximetry level: "+ minoximetry+" " + newMinoximetryDate + "<br/>");
                                
                                %>        
                                <input type="hidden" name="oximetryDate" id="oximetryDate" value="<%=newMinoximetryDate%>">
                                <input type="hidden" name="oximetryResult" id="oximetryResult" value="<%=minoximetry%>">
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                &nbsp;&nbsp;Reference Rule:<br/><br/></span>
                                
                                Pulse Oximetry level < 90 
                        </div>
                    </div>
                    <a id="imageHypoxia" onmouseover="makeDivVisible('Hypoxia')" 
                    onmouseout="makeDivHidden('Hypoxia')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
        </tr>
    <%} %>
    
    <!-- ********************************************* Granulocytopenia************************************************* -->
    <% boolean  granFlag=false;
    	int granValueMatch=0;
    result = coMorbChk.granulocytopenia(minneutrophil, neutrophilLow);
       System.out.println("Granulocytopenia: " + result);
     if(result == 1) 
     {
    	Iterator imain=valueMatch.entrySet().iterator();
    	Map<String, String> values =new HashMap<String, String>();
   		while(imain.hasNext())
    	{
    		Entry e=(Entry)imain.next();
    		if(e.getKey().equals("Granulocytopenia"))
    		{
   				granFlag=true;
   				values=(Map<String, String>)e.getValue();
   				break;
   			}
   		}
   		if(granFlag)
   		{
   			Iterator ival=values.entrySet().iterator();
   			while(ival.hasNext())
    		{
    			Entry e=(Entry)ival.next();
    			String testName=(String)e.getKey();
    			String testVal=(String)e.getValue();
   				if(testName.equals("minneutrophilResult"))
   				{
   					if(!testVal.isEmpty() && !minneutrophil.isEmpty())
   					{
   						if(Double.parseDouble(testVal)!=Double.parseDouble(minneutrophil))
   							granValueMatch=1;
   					}
   					else
   	   				{
   	   					if(!minneutrophil.isEmpty())
   	   						granValueMatch=1;
   	   				}
   				}
   				if(!minneutrophil.isEmpty() && !values.containsKey("minneutrophilResult"))
   				{
   					granFlag=false;
   					granValueMatch=1;
   				}
    		}
   		}
   		else
   		{
   			granValueMatch=1;
   		}
     }
    if(granValueMatch !=0)
    {
    %>
        <tr onmouseover="mouseOverPara('imageGranulocytopenia','GranulocytopeniaCol1')" onmouseout="mouseOutPara('imageGranulocytopenia','GranulocytopeniaCol1')" >
            <td id="GranulocytopeniaCol1">
                <span style="color: blue;">
                <%if(granFlag){
                	%>   <a onmouseover="makeDivVisible('Granulocytopenia')" onmouseout="makeDivHidden('Granulocytopenia')"><input type="checkbox" checked disabled name="mainGrp" value="Granulocytopenia">
                    Granulocytopenia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('Granulocytopenia')" onmouseout="makeDivHidden('Granulocytopenia')"><input type="checkbox" name="mainGrp" value="Granulocytopenia">
                    Granulocytopenia&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                    <div id="Granulocytopenia" class="imageBackSingle" style="width:340px; height:270px;"><img src="images/divSingle.png" width="100%"; height="100%"/>
                        <div id="Granulocytopenia" class="dynamicDiv" style="width:250px; height:205px; margin-left: 40px ; margin-top: -245px;">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                out.print(spaces + "Neutrophil (Minimum): "+minneutrophil+" "+ newMinneutrophilDate +"<br/>");

                                %>        
                                <input type="hidden" name="neutrophilMinDate" id="neutrophilMinDate" value="<%=newMinneutrophilDate%>">
                                <input type="hidden" name="neutrophilMinResult" id="neutrophilMinResult" value="<%=minneutrophil%>">
                                <input type="hidden" name="neutrophilMaxDate" id="neutrophilMaxDate" value="<%=newMaxneutrophilDate%>">
                                <input type="hidden" name="neutrophilMaxResult" id="neutrophilMaxResult" value="<%=maxneutrophil%>">
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Reference Range:<br/><br/></span>
                                
                                <%out.print("Neutrophil Level Acceptable low:&nbsp;[" + neutrophilLow + "]");%>
                                
                        </div>
                    </div>
                    <a id="imageGranulocytopenia" onmouseover="makeDivVisible('Granulocytopenia')" 
                    onmouseout="makeDivHidden('Granulocytopenia')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
        </tr>
    <%}%>
    
    
    
    
    <!-- ********************************************* Lactic acidosis ************************************************* -->
    <% boolean laFlag=false;
    	int laValueMatch=0;
    result = coMorbChk.lacticAcidosis(maxLacticAcid, LacticAcidHigh);
       System.out.println("Lactic acidosis: " + result);
     if(result == 1) 
     {
        Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("LacticAcidosis"))
        		{
       				laFlag=true;
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
       	}
       	if(laFlag)
       	{
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
       			if(testName.equals("lacticAcidResult")) 
       			{
       				if(!testVal.isEmpty() && !maxLacticAcid.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(maxLacticAcid))
       						laValueMatch=1;
       				}
       				else
       				{
       					if(!maxLacticAcid.isEmpty())
       						laValueMatch=1;
       				}
       			}
       			if(!maxLacticAcid.equals("-99999.0") && !values.containsKey("lacticAcidResult"))
       			{
       				laFlag=false;
       				laValueMatch=1;
       			}
       		}
       	}
       	else
       	{
       		laValueMatch=1;
       	}
     }
     if(laValueMatch!=0)
     {
    %>
        <tr onmouseover="mouseOverPara('imageLacticAcidosis','LacticAcidosisCol1')" onmouseout="mouseOutPara('imageLacticAcidosis','LacticAcidosisCol1')" >
            <td id="LacticAcidosisCol1">
                <span style="color: blue;">
                <%if(laFlag){
                	%>   <a onmouseover="makeDivVisible('LacticAcidosis')" onmouseout="makeDivHidden('LacticAcidosis')"><input type="checkbox"  checked disabled name="mainGrp" value="LacticAcidosis">
                    Lactic Acidosis&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('LacticAcidosis')" onmouseout="makeDivHidden('LacticAcidosis')"><input type="checkbox" name="mainGrp" value="LacticAcidosis">
                    Lactic Acidosis&nbsp;&nbsp;</a></span> <%} %>
            </td>
            <td>
                    <div id="LacticAcidosis" class="imageBackSingle" style="width:340px; height:270px;"><img src="images/divSingle.png" width="100%"; height="100%"/>
                        <div id="LacticAcidosis" class="dynamicDiv" style="width:250px; height:210px; margin-left: 40px ; margin-top: -247px;">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                out.print(spaces + "Lactic Acid: "+maxLacticAcid+" "+ newMaxLacticAcidDate +"<br/>");
                                %>        
                                <input type="hidden" name="lacticAcidDate" id="lacticAcidDate" value="<%=newMaxLacticAcidDate%>">
                                <input type="hidden" name="lacticAcidResult" id="lacticAcidResult" value="<%=maxLacticAcid%>">
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Reference Range:<br/><br/></span>
                                
                                <%out.print("Lactic Acid Level > " + LacticAcidHigh);%>
                        </div>
                    </div>
                    <a id="imageLacticAcidosis" onmouseover="makeDivVisible('LacticAcidosis')" 
                    onmouseout="makeDivHidden('LacticAcidosis')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
        </tr>
    <%} %>

    <!-- ************************************** Electrolyte Abnormality ******************************************* -->
    <%
    boolean eaFlag=false;
    int eaValueMatch=0;
    boolean result1 = coMorbChk.hypo(potassiumLow, minpotassiumResult),
            result2 = coMorbChk.hyper(potassiumHigh, maxpotassiumResult),
            result3 = coMorbChk.hypo(sodiumLow, minsodiumResult),
            result4 = coMorbChk.hyper(sodiumHigh, maxsodiumResult),
            result5 = coMorbChk.hypo(calciumLow, mincalciumResult),
            result6 = coMorbChk.hyper(calciumHigh, maxcalciumResult),
            result7 = coMorbChk.hypo(phosphorusLow, minphosphorusResult),
            result8 = coMorbChk.hyper(phosphorusHigh, maxphosphorusResult),
            result9 = coMorbChk.hypo(magnesiumLow, minmagnesiumResult),
            result10 = coMorbChk.hyper(magnesiumHigh, maxmagnesiumResult);
    System.out.println("Hypokalemnia: " + result1);
    System.out.println("Hyperkalemia: " + result2);
    System.out.println("Hyponatremia: " + result3);
    System.out.println("Hypernatremia: " + result4);
    System.out.println("Hypocalcemia: " + result5);
    System.out.println("Hypercalcemia: " + result6);
    System.out.println("Hypophosphatemia: " + result7);
    System.out.println("Hyperphosphatemia: " + result8);
    System.out.println("Hypomagnesemia: " + result9);
    System.out.println("Hypermagnesemia: " + result10);
    if (result1 || result2 || result3 || result4 || result5 || result6 || result7 || result8 || result9 || result10)
    {
    	
    	Iterator imain=valueMatch.entrySet().iterator();
    	Map<String, String> values =new HashMap<String, String>();
   		while(imain.hasNext())
    	{
    		Entry e=(Entry)imain.next();
    		if(e.getKey().equals("Electrolyte Abnormality"))
    		{
    			System.out.println("******Map is into EA Abnormality*******");
   				eaFlag=true;
   				values=(Map<String, String>)e.getValue();
   				break;
   			}
   		}
   		if(eaFlag)
   		{
   			System.out.println("After eaFlag");
   			Iterator ival=values.entrySet().iterator();
   			while(ival.hasNext())
    		{		
    			System.out.println("it has values");
    			Entry e=(Entry)ival.next();
    			String testName=(String)e.getKey();
    			String testVal=(String)e.getValue();
   				if(testName.equals("hypokalpot"))
   				{
   					System.out.println("HypokalPot is in Node list");
   					if(!testVal.isEmpty() && !minpotassiumResult.isEmpty())
   					{
   						System.out.println("HypokalPot tag value and new value are not NULL");
   						if(Double.parseDouble(testVal)!=Double.parseDouble(minpotassiumResult))
   						{
   							System.out.println("HypokalPot value Match");
   							eaValueMatch=1;
   						}
   					}
   					else
   	   				{
   						System.out.println("HypokalPot One of the values is null");
   	   					if(!minpotassiumResult.isEmpty())
   	   					{
   	   						System.out.println("HypokalPot value from cernet is in not null");
   	   						eaValueMatch=1;
   	   					}
   	   				}
   				}
   				/*if(!minpotassiumResult.equals("99999.0") && !values.containsKey("hypokalpot"))
  				{
  						System.out.println("HypokalPot value from cernet is in not null2");
  						eaFlag=false;
  						eaValueMatch=1;
  				}*/
   				if(testName.equals("hyperkalpot")) 
   				{
   					if(!testVal.isEmpty() && !maxpotassiumResult.isEmpty())
   					{
   						if(Double.parseDouble(testVal)!=Double.parseDouble(maxpotassiumResult))
   							eaValueMatch=1;
   					}
   					else
   	   				{
   	   					if(!maxpotassiumResult.isEmpty())
   	   						eaValueMatch=1;
   	   				}
   				}
   				/*if(!maxpotassiumResult.equals("-99999.0") && !values.containsKey("hyperkalpot"))
  				{					
  						System.out.println("HyperkalPot null2");
  						eaFlag=false;
  						eaValueMatch=1;
  				}*/
   				if(testName.equals("hyponatsod"))  
   				{
   					if(!testVal.isEmpty() && !minsodiumResult.isEmpty())
   					{
   						if(Double.parseDouble(testVal)!=Double.parseDouble(minsodiumResult))
   							eaValueMatch=1;
   					}
   					else
   	   				{
   						System.out.println("HyponatSod One of the values is null");
   						if(!minsodiumResult.isEmpty())
   						{
   							System.out.println("HyponatSod value from cernet is in not null");
   							eaValueMatch=1;
   						}
   	   				}
   				}
   				/*if(!minsodiumResult.equals("99999.0") && !values.containsKey("hyponatsod"))
				{
					System.out.println("HyponatSod value from cernet is in not null2");
					eaFlag=false;
					eaValueMatch=1;
				}*/
   				if(testName.equals("hypernatsod")) 
   				{	
   					
   					if(!testVal.isEmpty() && !maxsodiumResult.isEmpty())
   					{	
   						if(Double.parseDouble(testVal) !=Double.parseDouble(maxsodiumResult))
   							eaValueMatch=1;
   					}
   					else
   	   				{
   						System.out.println("HypernatSod One of the values is null");
   						if(!maxsodiumResult.isEmpty())
   						{
   							System.out.println("HypernatSod value from cernet is in not null");
   							eaValueMatch=1;
   						}
   	   				}
   				}
   				/*if(!maxsodiumResult.equals("-99999.0") && !values.containsKey("hypernatsod"))
				{
						System.out.println("HypernatSod value from cernet is in not null2");
						eaFlag=false;
						eaValueMatch=1;
				}*/
   				if(testName.equals("hypocalcal"))  
   				{
   					if(!testVal.isEmpty() && !mincalciumResult.isEmpty())
   					{	
   						if(Double.parseDouble(testVal)!=Double.parseDouble(mincalciumResult))
   							eaValueMatch=1;
   					}
   					else
   	   				{
   	   					if(!mincalciumResult.isEmpty())
   	   						eaValueMatch=1;
   	   				}
   				}
   				/*if(!mincalciumResult.isEmpty() && !values.containsKey("hypocalcal"))
   				{		
   					System.out.println("in second if lcal");
   					eaValueMatch=1;
   					eaFlag=false;
   				}*/
				if(testName.equals("hypercalcal")) 
				{	
					if(!testVal.isEmpty() && !maxcalciumResult.isEmpty())
   					{	
						if(Double.parseDouble(testVal)!=Double.parseDouble(maxcalciumResult))
							eaValueMatch=1;
   					}
					else
   	   				{
   	   					if(!maxcalciumResult.isEmpty())
   	   						eaValueMatch=1;
   	   				}
				}
				/*if(!maxcalciumResult.isEmpty() && !values.containsKey("hypercalcal"))
				{	
					System.out.println("in second if hcal");
					eaFlag=false;
					eaValueMatch=1;
				}*/
				if(testName.equals("hypophosphos")) 
				{	
					if(!testVal.isEmpty() && !minphosphorusResult.isEmpty())
					{
						if(Double.parseDouble(testVal)!=Double.parseDouble(minphosphorusResult))
							eaValueMatch=1;
					}
					else
   	   				{
   	   					if(!minphosphorusResult.isEmpty())
   	   						eaValueMatch=1;
   	   				}
				}
				/*if(!minphosphorusResult.isEmpty() && !values.containsKey("hypophosphos"))
				{	
					System.out.println("in second if lphos");
					eaFlag=false;
					eaValueMatch=1;
				}*/
				if(testName.equals("hyperphosphos"))
				{
					if(!testVal.isEmpty() && !maxphosphorusResult.isEmpty())
					{
						if(Double.parseDouble(testVal)!=Double.parseDouble(maxphosphorusResult))
							eaValueMatch=1;
					}
					else
   	   				{
   	   					if(!maxphosphorusResult.isEmpty())
   	   						eaValueMatch=1;
   	   				}
				}
				/*if(!maxphosphorusResult.isEmpty() && !values.containsKey("hyperphosphos"))
				{		
					System.out.println("in second if hphos");
					eaFlag=false;
					eaValueMatch=1;
				}*/
				if(testName.equals("hypomagmag")) 
				{
					
					if(!testVal.isEmpty() && !minmagnesiumResult.isEmpty())
					{
						if(Double.parseDouble(testVal)!=Double.parseDouble(minmagnesiumResult))
							eaValueMatch=1;
					}
					else
   	   				{
   	   					if(!minmagnesiumResult.isEmpty())
   	   						eaValueMatch=1;
   	   				}
				}
				/*if(!minmagnesiumResult.isEmpty() && !values.containsKey("hypomagmag"))
				{		
					System.out.println("in second if lmag");
					eaFlag=false;
					eaValueMatch=1;
				}*/
				if(testName.equals("hypermagmag")) 
				{	
					if(!testVal.isEmpty() && !maxmagnesiumResult.isEmpty())
					{
						if(Double.parseDouble(testVal)!=Double.parseDouble(maxmagnesiumResult))
							eaValueMatch=1;
					}
					else
   	   				{
   	   					if(!maxmagnesiumResult.isEmpty())
   	   						eaValueMatch=1;
   	   				}
				}
  				/*if(!maxmagnesiumResult.isEmpty() && !values.containsKey("hypermagmag"))
  				{		
  					System.out.println("in second if hmag");
  					eaFlag=false;
  					eaValueMatch=1;
  				}*/
   			}
   		}
   		else
   		{
   			eaValueMatch=1;
   		}
    }
    if(eaValueMatch!=0)
    {
    %>
        <tr>
               <td>
                   <span style="color: black;">
                   <%if(eaFlag){
                	%>   <input id="Ea" type="checkbox" checked disabled name="mainGrp" value="Electrolyte Abnormality" />&nbsp;Electrolyte Abnormality :
                   </span>
                	
                <%}else{ %>
                   <input id="Ea" type="checkbox" name="mainGrp" value="Electrolyte Abnormality" onclick="unCheck('Ea','EaChkGrp');"/>&nbsp;Electrolyte Abnormality :
                   </span><%} %>
               </td>
               <td width="15"></td>    
               <td></td>
               <td></td>
           </tr>
        <% if(result1)
           {%>
           <tr onmouseover="mouseOverPara('imageEaHypokal','EaHypokalCol')" onmouseout="mouseOutPara('imageEaHypokal','EaHypokalCol')">
                <td></td>
                <td width="15"></td>
                <td id="EaHypokalCol">
                <span style="color: blue;">
                <%if(eaFlag){
                	%>  <a onmouseover="makeDivVisible('EaHypokal')" onmouseout="makeDivHidden('EaHypokal')"><input type="checkbox" checked disabled name="EaChkGrp" id="hypoKalemia"value="Electrolyte Abnormality :Hypokalemia">
                Hypokalemia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                <a onmouseover="makeDivVisible('EaHypokal')" onmouseout="makeDivHidden('EaHypokal')"><input type="checkbox" name="EaChkGrp" id="hypoKalemia"value="Electrolyte Abnormality :Hypokalemia" onclick="checkMain('Ea');">
                Hypokalemia&nbsp;&nbsp;</a></span> <%} %>
                </td>
                <td>
                    <div id="EaHypokal" class="imageBack"><img src="images/div.png" width="100%"; height="100%"/>
                        <div id="EaHypokal" class="dynamicDiv" style="width:280px; height:230px;">
                                <br/><span style = "color: #858384; font-weight: bold;">
                                Values are:<br/><br/></span>
                                
                                <%
                                out.print(spaces + "Potassium: "+ minpotassiumResult+" "+ newminpotassiumDate +"<br/>");
                                %>        
                                <input type="hidden" name="hypokalDate" id="hypokalDate" value="<%=newminpotassiumDate%>">
                                <input type="hidden" name="hypokalPot" id="hypokalPot" value="<%=minpotassiumResult%>">
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Reference Range:<br/><br/></span>
                                
                                <%out.print("Potassium Level:&nbsp;[" + potassiumLow + "-" + potassiumHigh + "]");%>   
                        </div>
                    </div>
                    <a id="imageEaHypokal" onmouseover="makeDivVisible('EaHypokal')" 
                    onmouseout="makeDivHidden('EaHypokal')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a>
                </td>
            </tr>
        <%}%>
        <% if(result2)
           {%>
            <tr onmouseover="mouseOverPara('imageEaHyperkal','EaHyperkalCol')" 
                onmouseout="mouseOutPara('imageEaHyperkal','EaHyperkalCol')">
                    <td></td>
                    <td></td>
                    <td id="EaHyperkalCol">
                    <span style="color: blue">
                    <%if(eaFlag){
                	%>  <a onmouseover="makeDivVisible('EaHyperkal')" onmouseout="makeDivHidden('EaHyperkal')"><input type="checkbox" checked disabled id="hyperKalemia" name="EaChkGrp" value="Electrolyte Abnormality :Hyperkalemia">
                    Hyperkalemia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('EaHyperkal')" onmouseout="makeDivHidden('EaHyperkal')"><input type="checkbox" id="hyperKalemia" name="EaChkGrp" value="Electrolyte Abnormality :Hyperkalemia" onclick="checkMain('Ea');">
                    Hyperkalemia&nbsp;&nbsp;</a></span> <%} %>
                    <td>
                    <div id="EaHyperkal" class="imageBack"><img src="images/div.png" width="100%"; height="100%"/>
                        <div id="EaHyperkal" class="dynamicDiv" style="width:280px;height:230px;">
                                <br/><span style = "color: #858384; font-weight: bold;">
                                Values are:<br/><br/></span>
                                    <%
                                    
                                    out.print(spaces + "Potassium: "+maxpotassiumResult+" " + newmaxpotassiumDate +"<br/>");
                                
                                    %>
                                <input type="hidden" name="hyperkalDate" id="hyperkalDate" value="<%=newmaxpotassiumDate%>">
                                <input type="hidden" name="hyperkalPot" id="hyperkalPot" value="<%=maxpotassiumResult%>">    
                                <br/><span style = "color: #858384;font-weight: bold;"> 
                                Reference Range:<br/><br/></span>
                                
                                <%out.print("Potassium Level:&nbsp;[" + potassiumLow + "-" + potassiumHigh + "]");%>  
                        </div>
                    </div>
                    <a id="imageEaHyperkal" onmouseover="makeDivVisible('EaHyperkal')" 
                    onmouseout="makeDivHidden('EaHyperkal')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a>
                    </td>
                </tr>
        <%}%>
        <% if(result3)
           {%>
           <tr onmouseover="mouseOverPara('imageEaHyponat','EaHyponatCol')" onmouseout="mouseOutPara('imageEaHyponat','EaHyponatCol')">
                <td></td>
                <td></td>
                <td id="EaHyponatCol">
                <span style="color: blue">
                 <%if(eaFlag){
                	%>  <a onmouseover="makeDivVisible('EaHyponat')" onmouseout="makeDivHidden('EaHyponat')"><input type="checkbox" checked disabled name="EaChkGrp" id="hypoAtremia" value="Electrolyte Abnormality :Hyponatremia" >
                Hyponatremia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                <a onmouseover="makeDivVisible('EaHyponat')" onmouseout="makeDivHidden('EaHyponat')"><input type="checkbox" name="EaChkGrp" id="hypoAtremia" value="Electrolyte Abnormality :Hyponatremia" onclick="checkMain('Ea');">
                Hyponatremia&nbsp;&nbsp;</a></span><%} %>
                </td>
                <td>
                <div id="EaHyponat" class="imageBack"><img src="images/div.png" width="100%"; height="100%" />
                    <div id="EaHyponat" class="dynamicDiv" style="width:280px; height:230px;">
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                
                                <% 
                                out.print("Sodium: "+minsodiumResult+" "+ newminsodiumDate +"<br/>");
                                %>
                            <input type="hidden" name="hyponatDate" id="hyponatDate" value="<%=newminsodiumDate%>">
                            <input type="hidden" name="hyponatSod" id="hyponatSod" value="<%=minsodiumResult%>">    
                            <br/><span style = "color: #858384;font-weight: bold;"> 
                            Reference Range:<br/><br/></span>
                            
                            <%out.print("Sodium Level:&nbsp;[" + sodiumLow + "-" + sodiumHigh + "]");%> 
                    </div>
                </div>
                <a id="imageEaHyponat" onmouseover="makeDivVisible('EaHyponat')" 
                onmouseout="makeDivHidden('EaHyponat')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a>
                </td>
            </tr>
        <%}%>
        <%if(result4) 
          {%>
          <tr onmouseover="mouseOverPara('imageEaHypernat','EaHypernatCol')" onmouseout="mouseOutPara('imageEaHypernat','EaHypernatCol')">
                <td></td>
                <td></td>
                <td id="EaHypernatCol">

                <span style="color: blue">
                <%if(eaFlag){
                	%> <a onmouseover="makeDivVisible('EaHypernat')" onmouseout="makeDivHidden('EaHypernat')"><input type="checkbox" checked disabled id="hyperAtremia" name="EaChkGrp" value="Electrolyte Abnormality :Hypernatremia" >
                Hypernatremia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                <a onmouseover="makeDivVisible('EaHypernat')" onmouseout="makeDivHidden('EaHypernat')"><input type="checkbox" id="hyperAtremia" name="EaChkGrp" value="Electrolyte Abnormality :Hypernatremia" onclick="checkMain('Ea');">
                Hypernatremia&nbsp;&nbsp;</a></span><%} %>
                </td>
                <td>
                <div id="EaHypernat" class="imageBack"><img src="images/div.png" width="100%"; height="100%"/>
                    <div id="EaHypernat" class="dynamicDiv" style="width:280px; height:230px;">
                            
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                
                                <% 
                                    //out.print(spaces + "Date: "+newsodiumDate+" "+"<br/>");
                                out.print(spaces + "Sodium: "+maxsodiumResult+" "+ newmaxsodiumDate +"<br/>");
                                %>
                            <input type="hidden" name="hypernatDate" id="hypernatDate" value="<%=newmaxsodiumDate%>">
                            <input type="hidden" name="hypernatSod" id="hypernatSod" value="<%=maxsodiumResult%>">    
                            <br/><span style = "color: #858384;font-weight: bold;"> 
                            Reference Range:<br/><br/></span>
                            
                            <%out.print("Sodium Level:&nbsp;[" + sodiumLow + "-" + sodiumHigh + "]");%>
                    </div>
                </div>
                <a id="imageEaHypernat" onmouseover="makeDivVisible('EaHypernat')" 
                onmouseout="makeDivHidden('EaHypernat')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
            </tr>
        <%}%>
        <%if(result5)
            {%>
            <tr onmouseover="mouseOverPara('imageEaHypocal','EaHypocalCol')" 
            onmouseout="mouseOutPara('imageEaHypocal','EaHypocalCol')">
                <td></td>
                <td></td>
                <td id="EaHypocalCol">
                <span style="color: blue">
                <%if(eaFlag){
                	%> <a onmouseover="makeDivVisible('EaHypocal')" onmouseout="makeDivHidden('EaHypocal')"><input type="checkbox" checked  disabled id="hypoCalcemia" name="EaChkGrp" value="Electrolyte Abnormality :Hypocalcemia">
                Hypocalcemia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                <a onmouseover="makeDivVisible('EaHypocal')" onmouseout="makeDivHidden('EaHypocal')"><input type="checkbox" id="hypoCalcemia" name="EaChkGrp" value="Electrolyte Abnormality :Hypocalcemia" onclick="checkMain('Ea');">
                Hypocalcemia&nbsp;&nbsp;</a></span><%} %>
                </td>
                <td>
                <div id="EaHypocal" class="imageBack"><img src="images/div.png" width="100%"; height="100%"/>
                    <div id="EaHypocal" class="dynamicDiv" style="width:280px; height:230px;">
                            
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                
                                <%                    
                                out.print(spaces + "Calcium: "+mincalciumResult+" "+ newmincalciumDate +"<br/>");
                                %>
                            <input type="hidden" name="hypocalDate" id="hypocalDate" value="<%=newmincalciumDate%>">
                            <input type="hidden" name="hypocalCal" id="hypocalCal" value="<%=mincalciumResult%>">    
                            <br/><span style = "color: #858384;font-weight: bold;"> 
                            Reference Range:<br/><br/></span>
                            
                            <%out.print("Calcium Level:&nbsp;[" + calciumLow + "-" + calciumHigh + "]");%>
                    </div>
                </div> 
                <a id="imageEaHypocal" onmouseover="makeDivVisible('EaHypocal')" 
                onmouseout="makeDivHidden('EaHypocal')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
            </tr>
    <%}%>
    <%if(result6) 
      {%>
      <tr onmouseover="mouseOverPara('imageEaHypercal','EaHypercalCol')"
        onmouseout= "mouseOutPara('imageEaHypercal','EaHypercalCol')" >
            <td></td>
            <td></td>
            <td id="EaHypercalCol">
            <span style="color: blue">
            <%if(eaFlag){
                	%> <a onmouseover="makeDivVisible('EaHypercal')" onmouseout="makeDivHidden('EaHypercal')"><input type="checkbox" checked disabled id="hyperCalcemia" name="EaChkGrp" value="Electrolyte Abnormality :Hypercalcemia">
            Hypercalcemia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
            <a onmouseover="makeDivVisible('EaHypercal')" onmouseout="makeDivHidden('EaHypercal')"><input type="checkbox" id="hyperCalcemia" name="EaChkGrp" value="Electrolyte Abnormality :Hypercalcemia" onclick="checkMain('Ea');">
            Hypercalcemia&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                <div id="EaHypercal" class="imageBack"><img src="images/div.png" width="100%"; height="100%"/>
                    <div id="EaHypercal" class="dynamicDiv" style="width:280px; height:230px;">    
                            
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                
                                <% 
                                //out.print(spaces + "Date: "+newcalciumDate+" "+"<br/>");
                                out.print(spaces + "Calcium: "+maxcalciumResult+" "+ newmaxcalciumDate +"<br/>");
                                %>
                            <input type="hidden" name="hypercalDate" id="hypercalDate" value="<%=newmaxcalciumDate%>">
                            <input type="hidden" name="hypercalCal" id="hypercalCal" value="<%=maxcalciumResult%>">    
                            <br/><span style = "color: #858384;font-weight: bold;"> 
                            Reference Range:<br/><br/></span>
                            
                            <%out.print("Calcium Level:&nbsp;[" + calciumLow + "-" + calciumHigh + "]");%>
                    </div>
                </div>
                <a id="imageEaHypercal" onmouseover="makeDivVisible('EaHypercal')" 
                onmouseout="makeDivHidden('EaHypercal')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a>
            </td>
        </tr>
      <%}%>
        <%if(result7)
        {%>
        <tr onmouseover="mouseOverPara('imageEaHypophos','EaHypophosCol')" 
            onmouseout="mouseOutPara('imageEaHypophos','EaHypophosCol')">
                <td></td>
                <td></td>
                <td id="EaHypophosCol">
                <span style="color: blue">
                <%if(eaFlag){
                	%> <a onmouseover="makeDivVisible('EaHypophos')" onmouseout="makeDivHidden('EaHypophos')"><input type="checkbox" checked disabled name="EaChkGrp" id="hypoPhosphatemia" value="Electrolyte Abnormality :Hypophosphatemia" >
                Hypophosphatemia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                <a onmouseover="makeDivVisible('EaHypophos')" onmouseout="makeDivHidden('EaHypophos')"><input type="checkbox" name="EaChkGrp" id="hypoPhosphatemia" value="Electrolyte Abnormality :Hypophosphatemia" onclick="checkMain('Ea');">
                Hypophosphatemia&nbsp;&nbsp;</a></span><%} %>
                </td>
                <td>
                <div id="EaHypophos" class="imageBack"><img src="images/div.png" width="100%"; height="100%"/>
                    <div id="EaHypophos" class="dynamicDiv" style="width:280px; height:230px;">
                            
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                
                                <% 
                                out.print(spaces + "Phosphorus: "+minphosphorusResult+" "+ newminphosphorusDate +"<br/>");
                                %>
                            <input type="hidden" name="hypophosDate" id="hypophosDate" value="<%=newminphosphorusDate%>">
                            <input type="hidden" name="hypophosPhos" id="hypophosPhos" value="<%=minphosphorusResult%>">    
                            <br/><span style = "color: #858384;font-weight: bold;"> 
                            Reference Range:<br/><br/></span>
                            
                            <%out.print("Phosphorus Level:&nbsp;[" + phosphorusLow + "-" + phosphorusHigh + "]");%>
                    </div>
                </div> 
                <a id="imageEaHypophos" onmouseover="makeDivVisible('EaHypophos')" 
                onmouseout="makeDivHidden('EaHypophos')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
            </tr>
      <%}%>
      <%if(result8) 
          {%>
        <tr onmouseover="mouseOverPara('imageEaHyperphos','EaHyperphosCol')"
        onmouseout= "mouseOutPara('imageEaHyperphos','EaHyperphosCol')" >
            <td></td>
            <td></td>
            <td id="EaHyperphosCol">
            <span style="color: blue">
            <%if(eaFlag){
                	%>  <a onmouseover="makeDivVisible('EaHyperphos')" onmouseout="makeDivHidden('EaHyperphos')"><input type="checkbox" checked disabled id="hyperPhosphatemia" name="EaChkGrp" value="Electrolyte Abnormality :Hyperphosphatemia">
            Hyperphosphatemia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
            <a onmouseover="makeDivVisible('EaHyperphos')" onmouseout="makeDivHidden('EaHyperphos')"><input type="checkbox" id="hyperPhosphatemia" name="EaChkGrp" value="Electrolyte Abnormality :Hyperphosphatemia" onclick="checkMain('Ea');">
            Hyperphosphatemia&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                <div id="EaHyperphos" class="imageBack"><img src="images/div.png" width="100%"; height="100%"/>
                    <div id="EaHyperphos" class="dynamicDiv" style="width:280px; height:230px;">    
                            
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                
                                <% 
                                out.print(spaces + "Phosphorus: "+maxphosphorusResult+" "+ newmaxphosphorusDate +"<br/>");
                                %>
                            <input type="hidden" name="hyperphosDate" id="hyperphosDate" value="<%=newmaxphosphorusDate%>">
                            <input type="hidden" name="hyperphosPhos" id="hyperphosPhos" value="<%=maxphosphorusResult%>">    
                            <br/><span style = "color: #858384;font-weight: bold;"> 
                            Reference Range:<br/><br/></span>
                            
                            <%out.print("Phosphorus Level:&nbsp;[" + phosphorusLow + "-" + phosphorusHigh + "]");%>
                    </div>
                </div>
                <a id="imageEaHyperphos" onmouseover="makeDivVisible('EaHyperphos')" 
                onmouseout="makeDivHidden('EaHyperphos')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a>
            </td>
        </tr>
      <%}%>
        <%if(result9)
        {%>
            <tr onmouseover="mouseOverPara('imageEaHypomag','EaHypomagCol')" 
            onmouseout="mouseOutPara('imageEaHypomag','EaHypomagCol')">
                <td></td>
                <td></td>
                <td id="EaHypomagCol">
                <span style="color: blue">
                <%if(eaFlag){
                	%>  <a onmouseover="makeDivVisible('EaHypomag')" onmouseout="makeDivHidden('EaHypomag')"><input type="checkbox" checked disabled id="hypoMagnesemia" name="EaChkGrp" value="Electrolyte Abnormality :Hypomagnesemia">
                Hypomagnesemia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                <a onmouseover="makeDivVisible('EaHypomag')" onmouseout="makeDivHidden('EaHypomag')"><input type="checkbox" id="hypoMagnesemia" name="EaChkGrp" value="Electrolyte Abnormality :Hypomagnesemia" onclick="checkMain('Ea');">
                Hypomagnesemia&nbsp;&nbsp;</a></span><%} %>
                </td>
                <td>
                <div id="EaHypomag" class="imageBack"><img src="images/div.png" width="100%"; height="100%"/>
                    <div id="EaHypomag" class="dynamicDiv" style="width:280px; height:230px;">
                            
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                
                                <% 
                                out.print(spaces + "Magnesium: "+ minmagnesiumResult+" "+ newminmagnesiumDate +"<br/>");
                                %>
                            <input type="hidden" name="hypomagDate" id="hypomagDate" value="<%=newminmagnesiumDate%>">
                            <input type="hidden" name="hypomagMag" id="hypomagMag" value="<%=minmagnesiumResult%>">    
                            <br/><span style = "color: #858384;font-weight: bold;"> 
                            Reference Range:<br/><br/></span>
                            
                            <%out.print("Magnesium Level:&nbsp;[" + magnesiumLow + "-" + magnesiumHigh + "]");%>
                    </div>
                </div> 
                <a id="imageEaHypomag" onmouseover="makeDivVisible('EaHypomag')" 
                onmouseout="makeDivHidden('EaHypomag')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
            </tr>
      <%}%>
        <%if(result10) 
      {%>
      <tr onmouseover="mouseOverPara('imageEaHypermag','EaHypermagCol')"
        onmouseout= "mouseOutPara('imageEaHypermag','EaHypermagCol')" >
            <td></td>
            <td></td>
            <td id="EaHypermagCol">
            <span style="color: blue">
            <%if(eaFlag){
                	%>  <a onmouseover="makeDivVisible('EaHypermag')" onmouseout="makeDivHidden('EaHypermag')"><input type="checkbox" checked disabled id="hyperMagnesemia" name="EaChkGrp" value="Electrolyte Abnormality :Hypermagnesemia">
            Hypermagnesemia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
            <a onmouseover="makeDivVisible('EaHypermag')" onmouseout="makeDivHidden('EaHypermag')"><input type="checkbox" id="hyperMagnesemia" name="EaChkGrp" value="Electrolyte Abnormality :Hypermagnesemia" onclick="checkMain('Ea');">
            Hypermagnesemia&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                <div id="EaHypermag" class="imageBack"><img src="images/div.png" width="100%"; height="100%"/>
                    <div id="EaHypermag" class="dynamicDiv" style="width:280px; height:230px;">    
                            
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                
                                <% 
                                out.print(spaces + "Magnesium: "+maxmagnesiumResult+" "+ newmaxmagnesiumDate +"<br/>");
                                %>
                            <input type="hidden" name="hypermagDate" id="hypermagDate" value="<%=newmaxmagnesiumDate%>">
                            <input type="hidden" name="hypermagMag" id="hypermagMag" value="<%=maxmagnesiumResult%>">    
                            <br/><span style = "color: #858384;font-weight: bold;"> 
                            Reference Range:<br/><br/></span>
                            
                            <%out.print("Magnesium Level:&nbsp;[" + magnesiumLow + "-" + magnesiumHigh + "]");%>
                    </div>
                </div>
                <a id="imageEaHypermag" onmouseover="makeDivVisible('EaHypermag')" 
                onmouseout="makeDivHidden('EaHypermag')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a>
            </td>
        </tr>
      <%}%>
    
    
    <%}%>
    
    <!-- ********************************************* Hypercholesterolemia************************************************* -->
    <% boolean hclFlag=false;
    int HCLValueMatch=0;
    double result_HyperCholestrolemia = coMorbChk.HyperCholestrolemia(maxcholesterolResult);
       System.out.println("HyperCholesterolemia: " + result);
     if(result_HyperCholestrolemia == 1) 
     { 
        Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("HyperCholesterolemia"))
        		{
       				hclFlag=true;
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
       	}
       	if(hclFlag)
       	{
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
       			if(testName.equals("cholesterolResult")) 
       			{	
       				if(!testVal.isEmpty() && !maxcholesterolResult.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(maxcholesterolResult))
       						HCLValueMatch=1;
       				}
       				else
   	   				{
   	   					if(!maxcholesterolResult.isEmpty())
   	   						HCLValueMatch=1;
   	   				}
       			}
       			if(!maxcholesterolResult.isEmpty() && !values.containsKey("cholesterolResult"))
       			{
       				hclFlag=false;
       				HCLValueMatch=1;
       			}
       		}
       	}
       	else
       	{
       		HCLValueMatch=1;
       	}
     }
     if(HCLValueMatch!=0)
     {
    %>
        <tr onmouseover="mouseOverPara('imageCholesterol','CholesterolCol1')" onmouseout="mouseOutPara('imageCholesterol','CholesterolCol1')" >
            <td id="CholesterolCol1">
                <span style="color: blue;">
                 <%if(hclFlag){
                	%>    <a onmouseover="makeDivVisible('HyperChol')" onmouseout="makeDivHidden('HyperCol')"><input type="checkbox" checked disabled name="mainGrp" value="HyperCholesterolemia">
                    HyperCholesterolemia&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('HyperChol')" onmouseout="makeDivHidden('HyperCol')"><input type="checkbox" name="mainGrp" value="HyperCholesterolemia">
                    HyperCholesterolemia&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                    <div id="HyperChol" class="imageBackSingle" style="width:340px; height:270px;"><img src="images/divSingle.png" width="100%"; height="100%"/>
                        <div id="HyperChol" class="dynamicDiv" style="width:250px; height:210px; margin-left: 40px ; margin-top: -247px;">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                
                                    //out.print(spaces + "Date: "+ newglucDate +" "+"<br/>");
                                out.print(spaces + "Total Cholesterol level: "+maxcholesterolResult+" "+ newmaxcholesterolDate +"<br/>");

                                
                                %>        
                                <input type="hidden" name="cholesterolDate" id="cholesterolDate" value="<%=newmaxcholesterolDate%>">
                                <input type="hidden" name="cholesterolResult" id="cholesterolResult" value="<%=maxcholesterolResult%>">
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Reference Range:<br/><br/></span>
                                
                                Total Cholesterol Level > 200
                        </div>
                    </div>
                    <a id="imageCholesterol" onmouseover="makeDivVisible('HyperChol')" 
                    onmouseout="makeDivHidden('HyperChol')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
        </tr>
    <%} %>
    
    <!-- ************************************** Malnutrition ******************************************* -->
    <%
    //Invoking rules
    boolean mFlag=false;
    int malValueMatch=0;
    result_malnutrition = coMorbChk.malnutrition(minweight,maxheight);
    System.out.println("Malnutrition: " + result_malnutrition);
    if(result_malnutrition != 0)
    {
        Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("Malnutrition"))
        		{
       				mFlag=true;
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
        		
       	}
       	if(mFlag)
       	{
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
       			if(testName.equals("malHeight")) 
       			{
       				if(!testVal.isEmpty() && !maxheight.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(maxheight))
       						malValueMatch=1;
       				}
       				else
   	   				{
   	   					if(!maxheight.isEmpty())
   	   						malValueMatch=1;
   	   				}
       			}
       			/*if(!maxheight.isEmpty() && !values.containsKey("malHeight"))
       			{
  					mFlag=false;	
       				malValueMatch=1;
       			}*/
       			if(testName.equals("malWeight")) 
       			{
       				if(!testVal.isEmpty() && !minweight.isEmpty())
       				{
       					if(!testVal.equals(minweight))
       						malValueMatch=1;
       				}
       				else
   	   				{
   	   					if(!minweight.isEmpty())
   	   						malValueMatch=1;
   	   				}
       			}
       			/*if(!minweight.isEmpty() && !values.containsKey("malWeight"))
       			{
  					mFlag=false;	
       				malValueMatch=1;
       			}*/
       		}
       	}
       	else
       	{
       		malValueMatch=1;
       	}
    }
    if(malValueMatch!=0)
    {
    %>
        <tr onmouseover="mouseOverPara('imageMalnutrition','Malnutritioncol1')" onmouseout="mouseOutPara('imageMalnutrition','Malnutritioncol1')" >
            <td id="Malnutritioncol1">
                <span style="color: blue;">
                 <%if(mFlag){
                	%>    <a onmouseover="makeDivVisible('Malnutrition')" onmouseout="makeDivHidden('Malnutrition')"><input type="checkbox" checked disabled name="mainGrp" value="Malnutrition">
                    Malnutrition&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('Malnutrition')" onmouseout="makeDivHidden('Malnutrition')"><input type="checkbox" name="mainGrp" value="Malnutrition">
                    Malnutrition&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                    <div id="Malnutrition" class="imageBack"><img src="images/divSingle.png" width="100%"; height="100%"/>
                        <div id="Malnutrition" class="dynamicDiv" style="width:270px; height:220px;">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                    //out.print(spaces + "Date: "+newheightDate+" "+"<br/>");
                                out.print(spaces + "Height: &nbsp;"+maxheight+" "+ newMaxheightDate +"<br/>");
                                //out.print(spaces + "Date: "+newweightDate+" "+"<br/>");
                                out.print(spaces + "Weight: "+minweight+" "+ newMinweightDate +"<br/>");
                                out.print(spaces + "BMI: &nbsp;&nbsp;&nbsp;&nbsp;"+result_malnutrition+" "+"<br/>");
                                %>        
                                <input type="hidden" name="malHeightDate" id="malHeightDate" value="<%=newMaxheightDate%>">
                                <input type="hidden" name="malHeight" id="malHeight" value="<%=maxheight%>">
                                <input type="hidden" name="malWeightDate" id="malWeightDate" value="<%=newMinweightDate%>">
                                <input type="hidden" name="malWeight" id="malWeight" value="<%=minweight%>">
                                <input type="hidden" name="malBmi" id="malBmi" value="<%=result_malnutrition%>">
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Reference Range:<br/><br/></span>
                                
                                BMI = [19-40]
                        </div>
                    </div>
                    <a id="imageMalnutrition" onmouseover="makeDivVisible('Malnutrition')" 
                    onmouseout="makeDivHidden('Malnutrition')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
         </tr>    
    <%} %>
    
    <!-- ************************************** Obesity ******************************************* -->
    <% 
    //Invoking Rule
    boolean oFlag=false;
    int oValueMatch=0;
    result_obesity = coMorbChk.obesity(maxweight, minheight);
    System.out.println("Obesity: " + result_obesity);
    if(result_obesity != 0)
    {
    	int valueMatchFlag=0;
        Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("Obesity"))
        		{
       				oFlag=true;
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
       	}
       	if(oFlag)
       	{
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
       			if(testName.equals("obweight")) 
       			{	
       				if(!testVal.isEmpty() && !maxweight.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(maxweight))
       						oValueMatch=1;
       				}
       				else
   	   				{
   	   					if(!maxweight.isEmpty())
   	   						oValueMatch=1;
   	   				}
       			}			
       			/*if(!maxweight.isEmpty() && !values.containsKey("obweight"))
       			{
  					oFlag=false;	
       				oValueMatch=1;
       			}*/
       			if(testName.equals("obheight")) 
       			{	
       				
       				if(!testVal.isEmpty() && !minheight.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(minheight))
       						oValueMatch=1;
       				}
       				else
   	   				{
   	   					if(!minheight.isEmpty())
   	   						oValueMatch=1;
   	   				}
       			}
       			/*if(!minheight.isEmpty() && !values.containsKey("obheight"))
       			{
  					oFlag=false;	
       				oValueMatch=1;
       			}*/
       		}
       	}
       	else
       	{
       		oValueMatch=1;
       	}
    }
    if(oValueMatch!=0)
    {
    %>
        <tr onmouseover="mouseOverPara('imageMobesity','MobesityCol1')" onmouseout="mouseOutPara('imageMobesity','MobesityCol1')" >
            <td id="MobesityCol1">
                <span style="color: blue;">
                 <%if(oFlag){
                	%>     <a onmouseover="makeDivVisible('Mobesity')" onmouseout="makeDivHidden('Mobesity')"><input type="checkbox" checked disabled name="mainGrp" value="Obesity">
                    Obesity&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('Mobesity')" onmouseout="makeDivHidden('Mobesity')"><input type="checkbox" name="mainGrp" value="Obesity">
                    Obesity&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                    <div id="Mobesity" class="imageBack"><img src="images/divSingle.png" width="100%"; height="100%"/>
                        <div id="Mobesity" class="dynamicDiv" style="width:275px; height:220px;">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                    //out.print(spaces + "Date: "+newheightDate+" "+"<br/>");
                                out.print(spaces + "Height: &nbsp;"+minheight+" "+ newMinheightDate +"<br/>");
                                //out.print(spaces + "Date: "+newweightDate+" "+"<br/>");
                                out.print(spaces + "Weight: "+maxweight+" "+ newMaxweightDate +"<br/>");
                                    out.print(spaces + "BMI: &nbsp;&nbsp;&nbsp;&nbsp;"+result_obesity+" "+"<br/>");
                                %>        
                                <input type="hidden" name="obHeightDate" id="obHeightDate" value="<%=newMinheightDate%>">
                                <input type="hidden" name="obHeight" id="obHeight" value="<%=minheight%>">
                                <input type="hidden" name="obWeightDate" id="obWeightDate" value="<%=newMaxweightDate%>">
                                <input type="hidden" name="obWeight" id="obWeight" value="<%=maxweight%>">
                                <input type="hidden" name="obBmi" id="obBmi" value="<%=result_obesity%>">
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Reference Range:<br/><br/></span>
                                
                                40 > BMI > 30  
                        </div>
                    </div>
                    <a id="imageMobesity" onmouseover="makeDivVisible('Mobesity')" 
                    onmouseout="makeDivHidden('Mobesity')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
        </tr>    
    <%}%>
    <!-- ************************************** Morbid Obesity ******************************************* -->
    <% 
    //Invoking Rule
    boolean moFlag=false;
    int moValueMatch=0;
    result_morbidobesity = coMorbChk.morbidObesity(maxweight, minheight);
    System.out.println("Morbid Obesity: " + result);
    if(result_morbidobesity != 0)
    {
        Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
       		System.out.println("Entering WHILE!!!1");	

        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("Morbid Obesity"))
        		{
        			
        			System.out.println("Entering GETKEY");
       				moFlag=true;
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
       	}
       	if(moFlag)
       	{
       		
            System.out.println("Entering MAFLAG!!!!!!!1");
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
       			if(testName.equals("mobweight")) 
       			{	
       			
       				if(!testVal.isEmpty() && !maxweight.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(maxweight))
       						moValueMatch=1;
       				}
       				else
   	   				{
   	   					if(!maxweight.isEmpty())
   	   						moValueMatch=1;
   	   				}
       			}
	   			/*if(!maxweight.isEmpty() && !values.containsKey("mobweight"))
	   			{
	   				moFlag=false;
	   				moValueMatch=1;
	   			}*/
       			if(testName.equals("mobheight")) 
       			{	
       				if(!testVal.isEmpty() && !minheight.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(minheight))
       						moValueMatch=1;
       				}
       				else
   	   				{
   	   					if(!minheight.isEmpty())
   	   						moValueMatch=1;
   	   				}
       			}
       			/*if(!minheight.isEmpty() && !values.containsKey("mobheight"))
	   			{
	   				moFlag=false;
	   				moValueMatch=1;
	   			}*/
       			
       		}
       	}
       	else
       		moValueMatch=1;
       		
    }
    if(moValueMatch!=0)
    {
    %>
        <tr onmouseover="mouseOverPara('imageMobesity','MobesityCol1')" onmouseout="mouseOutPara('imageMobesity','MobesityCol1')" >
            <td id="MobesityCol1">
                <span style="color: blue;">
                 <%if(moFlag){
                	%>    <a onmouseover="makeDivVisible('Mobesity')" onmouseout="makeDivHidden('Mobesity')"><input type="checkbox" checked disabled name="mainGrp" id="morbidObesityId"  value="Morbid Obesity">
                    Morbid Obesity&nbsp;&nbsp;</a></span>
                	
                <%}else{ %>
                    <a onmouseover="makeDivVisible('Mobesity')" onmouseout="makeDivHidden('Mobesity')"><input type="checkbox" name="mainGrp" id="morbidObesityId"  value="Morbid Obesity">
                    Morbid Obesity&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                    <div id="Mobesity" class="imageBack"><img src="images/divSingle.png" width="100%"; height="100%"/>
                        <div id="Mobesity" class="dynamicDiv" style="width:275px; height:220px;">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                    //out.print(spaces + "Date: "+newheightDate+" "+"<br/>");
                                out.print(spaces + "Height: &nbsp"+minheight+" "+ newMinheightDate +"<br/>");
                                //out.print(spaces + "Date: "+newweightDate+" "+"<br/>");
                                out.print(spaces + "Weight: "+maxweight+" "+ newMaxweightDate +"<br/>");
                                    out.print(spaces + "BMI: &nbsp;&nbsp;&nbsp;&nbsp;"+result_morbidobesity+" "+"<br/>");
                                %>        
                                <input type="hidden" name="mobHeightDate" id="mobHeightDate" value="<%=newMinheightDate%>">
                                <input type="hidden" name="mobHeight" id="mobHeight" value="<%=minheight%>">
                                <input type="hidden" name="mobWeightDate" id="mobWeightDate" value="<%=newMaxweightDate%>">
                                <input type="hidden" name="mobWeight" id="mobWeight" value="<%=maxweight%>">
                                <input type="hidden" name="mobBmi" id="mobBmi" value="<%=result_morbidobesity%>">
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Reference Range:<br/><br/></span>
                                
                                BMI > 40 
                        </div>
                    </div>
                    <a id="imageMobesity" onmouseover="makeDivVisible('Mobesity')" 
                    onmouseout="makeDivHidden('Mobesity')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
        </tr>    
    <%}%>
    
    <!-- ************************************** Malignant/Accelerated Hypertension ******************************************* -->
    
    <% boolean htFlag=false;     
    int htValueMatch=0;
    result = coMorbChk.hypertension(maxsysBP, maxdiasBP);
    System.out.println("Mal Hypertension: " + result);
    if(result != 0)
    {
        Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("Hypertension"))
        		{
       				htFlag=true;
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
       	}
       	if(htFlag)
       	{
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
       			if(testName.equals("htnbpsys")) 
       			{
       				if(!testVal.isEmpty() && !maxsysBP.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(maxsysBP))
       						htValueMatch=1;
       				}
       				else
   	   				{
   	   					if(!maxsysBP.isEmpty())
   	   						htValueMatch=1;
   	   				}
       			}
       			/*if(!maxsysBP.isEmpty() && !values.containsKey("htnbpsys"))
       			{
  					htFlag=false;
       				htValueMatch=1;
       			}*/
       			if(testName.equals("htnbpdia")) 
       			{		
       				if(!testVal.isEmpty() && !maxdiasBP.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(maxdiasBP))
       						htValueMatch=1;
       				}
       				else
   	   				{
   	   					if(!maxdiasBP.isEmpty())
   	   						htValueMatch=1;
   	   				}
       			}
       			/*if(!maxdiasBP.isEmpty() && !values.containsKey("htnbpdia"))
       			{
       				htFlag=false;
       				htValueMatch=1;
       			}*/
       		}
       	}
       	else
       	{
       		htValueMatch=1;
       	}
    }
    if(htValueMatch!=0)
    {
    %>
    <tr>
            <td>
                    <span style="color: black">
                     <%if(htFlag){
                	%>    <input type="checkbox" checked disabled id="ht" name="mainGrp" value="Hypertension"/>&nbsp;Hypertension :
                    </span>
                	
                <%}else{ %>
                    <input type="checkbox" id="ht" name="mainGrp" value="Hypertension" onclick="unCheck('ht','htChkGrp');"/>&nbsp;Hypertension :
                    </span><%} %>
                    <span>
                    <input type="hidden" name="htnDate" id="htnDate" value="<%=newMaxdiasBPDate%>">
                    <input type="hidden" name="htnBpDia" id="htnBpDia" value="<%=maxdiasBP%>">
                    <input type="hidden" name="htnDateSys" id="htnDateSys" value="<%=newMaxsysBPDate%>">
                    <input type="hidden" name="htnBpSys" id="htnBpSys" value="<%=maxsysBP%>">
                    </span>
            </td>
            <td></td>
            <td></td>
            <td></td>
    </tr>
    <tr onmouseover="mouseOverPara('imageHt','HtCol')" onmouseout="mouseOutPara('imageHt','HtCol')">
        <td></td>
        <td></td>
        <td id ="HtCol">
                <span style="color: blue;">
                <%if(htFlag){
                	%>    <a onmouseover="makeDivVisible('htht')" onmouseout="makeDivHidden('htht')"><input type="checkbox" checked disabled name="htChkGrp" value="Hypertension: Hypertension"/>
                            Hypertension &nbsp;&nbsp;</a>
                    </span>
                	
                <%}else{ %>
                            <a onmouseover="makeDivVisible('htht')" onmouseout="makeDivHidden('htht')"><input type="checkbox" name="htChkGrp" value="Hypertension: Hypertension" onclick="checkMain('ht');"/>
                            Hypertension &nbsp;&nbsp;</a>
                    </span><%} %>
            </td>
            <td>
                    <div id="htht" class="imageBack" ><img src="images/div.png" width="100%" height="100%"/>
                        <div id="htht" class="dynamicDiv" style="width:280px; height:230px; margin-left: 45px ; margin-top: -275px;">
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                            <%
                            if(maxsysBP.isEmpty()!=true)
                                out.print(spaces + "Systolic BP: &nbsp;"+maxsysBP+" "+ newMaxsysBPDate +"<br/>");
                            
                            if (maxdiasBP.isEmpty()!=true)
                                out.print(spaces + "Diastolic BP: "+maxdiasBP+" "+ newMaxdiasBPDate +"<br/>");
                            %>
                            <br/><span style = "color: #858384; font-weight: bold;"> 
                            Determined by the Rule:<br/></span>
                            Blood pressure (systolic) > 140 OR <br/> 
                            Blood pressure (diastolic) > 90 <br /> 
                    </div>
                </div>
                <a id=imageHt onmouseover="makeDivVisible('htht')" 
                onmouseout="makeDivHidden('htht')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
            </td>
        </tr>
        
        <tr onmouseover="mouseOverPara('imageElevBP','ElevBPCol')" onmouseout="mouseOutPara('imageElevBP','ElevBPCol')">
        <td></td>
        <td></td>
        <td id ="ElevBPCol">
                <span style="color: blue;">
                 <%if(htFlag){
                	%>   <a onmouseover="makeDivVisible('ElevBP')" onmouseout="makeDivHidden('ElevBP')"><input type="checkbox" checked disabled name="htChkGrp" value="Hypertension: Elevated BP"/>
                            Elevated Blood Pressure &nbsp;&nbsp;</a>
                    </span>
                <%}else{ %>
                            <a onmouseover="makeDivVisible('ElevBP')" onmouseout="makeDivHidden('ElevBP')"><input type="checkbox" name="htChkGrp" value="Hypertension: Elevated BP" onclick="checkMain('ht');"/>
                            Elevated Blood Pressure &nbsp;&nbsp;</a>
                    </span><%} %>
            </td>
            <td>
                    <div id="ElevBP" class="imageBack" ><img src="images/div.png" width="100%" height="100%"/>
                        <div id="ElevBP" class="dynamicDiv" style="width:280px; height:230px; margin-left: 45px ; margin-top: -275px;">
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                            <%
                            if(maxsysBP.isEmpty()!=true)
                                out.print(spaces + "Systolic BP: &nbsp"+maxsysBP+" "+ newMaxsysBPDate +"<br/>");
                            if(maxdiasBP.isEmpty()!=true)
                                out.print(spaces + "Diastolic BP: "+maxdiasBP+" "+ newMaxdiasBPDate +"<br/>");
                            %>
                            <br/><span style = "color: #858384; font-weight: bold;"> 
                            Determined by the Rule:<br/></span>
                            Blood pressure (systolic) > 140 OR <br/> 
                            Blood pressure (diastolic) > 90 <br />
                    </div>
                </div>
                <a id=imageElevBP onmouseover="makeDivVisible('ElevBP')" 
                onmouseout="makeDivHidden('ElevBP')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
            </td>
        </tr>                            
    <%}%>
    
    
    <!-- ************************************** Shock ******************************************* -->
    <%
    boolean shockFlag=false;
    int shockValueMatch=0;
    result = coMorbChk.shock(minsysBP,maxct, ctHigh);
    System.out.println("Shock:" + result);
    if(result != 0)
    {
        Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("Shock"))
        		{
       				shockFlag=true;
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
       	}
       	if(shockFlag)
       	{
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
       			if(testName.equals("shockbp"))
       			{
       				if(!testVal.isEmpty() && !minsysBP.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(minsysBP))
       					shockValueMatch=1;
       				}
       				else
       				{
       					if(!minsysBP.isEmpty())		
       					shockValueMatch=1;
       				}
       			}
       			/*if(!minsysBP.isEmpty() && !values.containsKey("shockbp"))
       			{
   					shockFlag=false;
       				shockValueMatch=1;
       			}*/
       		}
       	}
       	else
       	{
       		shockValueMatch=1;
       	}
    }
    if(shockValueMatch!=0)
    {
        if(result == 2)    
          {%>
            <tr ><!-- onmouseover="mouseOverPara('imageShock','ShockCol')" onmouseout="mouseOutPara('imageShock','ShockCol')"> -->
                <td> <!-- id = "ShockCol"> -->
                    <span style="color: black;">
                    <%if(shockFlag){
                	%>    <a onmouseover="makeDivVisible('Shock')" onmouseout="makeDivHidden('Shock')"><input id="shock" type="checkbox" checked disabled name="mainGrp" value="Shock">
                        Shock&nbsp;&nbsp;</a></span>
                <%}else{ %>
                        <a onmouseover="makeDivVisible('Shock')" onmouseout="makeDivHidden('Shock')"><input id="shock" type="checkbox" name="mainGrp" value="Shock" onclick="unCheck('shock','shockChkGrp');">
                        Shock&nbsp;&nbsp;</a></span><%} %>
                </td>
                <td width="15"></td>
                <td></td>
            
                <td>
                    <div id="Shock" class="imageBackSingle"><img src="images/divSingle.png" width="410px" height="300px"/>
                        <div id="Shock" class="dynamicDiv" style="width:310px; height:215px; margin-top: -260px">
                                <br/><span style = "color: #858384; font-weight: bold;">
                                    Values are:<br/><br/></span>
                                        <%
                                        //out.print(spaces + "Date: "+newsysBPDate+" "+"<br/>");
                                        out.print(spaces + "Blood Pressure(systolic): "+minsysBP+" "+ newMinsysBPDate +"<br/>");

                                        %>        
                                        <input type="hidden" name="shockDate" id="shockDate" value="<%=newMinsysBPDate%>">
                                        <input type="hidden" name="shockBp" id="shockBp" value="<%=minsysBP%>">
                                        <br/><span style = "color: #858384; font-weight: bold;"> 
                                        Reference Range:<br/><br/></span>
                                        
                                        SBP : [< 90]
                        </div>
                    </div>
                    <a id="imageShock" onmouseover="makeDivVisible('Shock')" onmouseout="makeDivHidden('Shock')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
            </tr>    
            <tr onmouseover="mouseOverPara('imageShock2','ShockCol2')" onmouseout="mouseOutPara('imageShock2','ShockCol2')">
            <td></td>
            <td width="15"></td>
            <td id = "ShockCol2"><span style="color: blue;">
            <%if(shockFlag){
                	%>    <a onmouseover="makeDivVisible('Shock2')" onmouseout="makeDivHidden('Shock2')"><input type="checkbox" checked disabled name="shockChkGrp"  value="Shock:Septic">
                        Septic&nbsp;&nbsp;</a></span>
                <%}else{ %>
                        <a onmouseover="makeDivVisible('Shock2')" onmouseout="makeDivHidden('Shock2')"><input type="checkbox" name="shockChkGrp"  value="Shock:Septic" onclick="checkMain('shock');">
                        Septic&nbsp;&nbsp;</a></span><%} %></td>
            <td><div id="Shock2" class="imageBackSingle"><img src="images/divSingle.png" width="410px" height="300px"/>
                        <div id="Shock2" class="dynamicDiv" style="width:310px; height:215px; margin-top: -260px">
                                <br/><span style = "color: #858384; font-weight: bold;">
                                    Values are:<br/><br/></span>
                                        <%
                                        //out.print(spaces + "Date: "+newsysBPDate+" "+"<br/>");
                                        out.print(spaces + "Blood Pressure(systolic): "+minsysBP+" "+ newMinsysBPDate +"<br/>");

                                        %>        
                                        <input type="hidden" name="shockDate" id="shockDate" value="<%=newMinsysBPDate%>">
                                        <input type="hidden" name="shockBp" id="shockBp" value="<%=minsysBP%>">
                                        <br/><span style = "color: #858384; font-weight: bold;"> 
                                        Reference Range:<br/><br/></span>
                                        
                                        SBP : [< 90]
                        </div>
                    </div>
                    <a id="imageShock2" onmouseover="makeDivVisible('Shock2')" onmouseout="makeDivHidden('Shock2')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a>
			</td>
            </tr>
            <tr onmouseover="mouseOverPara('imageShock3','ShockCol3')" onmouseout="mouseOutPara('imageShock3','ShockCol3')">
            <td></td>
            <td width="15"></td>
            <td id = "ShockCol3"><span style="color: blue;">
            <%if(shockFlag){
                	%>    <a onmouseover="makeDivVisible('Shock3')" onmouseout="makeDivHidden('Shock3')"><input type="checkbox" checked disabled value="Shock:Hypovolemic" name="shockChkGrp">
                        Hypovolemic&nbsp;&nbsp;</a></span>
                <%}else{ %>
                        <a onmouseover="makeDivVisible('Shock3')" onmouseout="makeDivHidden('Shock3')"><input type="checkbox" value="Shock:Hypovolemic" name="shockChkGrp"  onclick="checkMain('shock');">
                        Hypovolemic&nbsp;&nbsp;</a></span><%} %></td>
            <td><div id="Shock3" class="imageBackSingle"><img src="images/divSingle.png" width="410px" height="300px"/>
                        <div id="Shock3" class="dynamicDiv" style="width:310px; height:215px; margin-top: -260px">
                                <br/><span style = "color: #858384; font-weight: bold;">
                                    Values are:<br/><br/></span>
                                        <%
                                        //out.print(spaces + "Date: "+newsysBPDate+" "+"<br/>");
                                        out.print(spaces + "Blood Pressure(systolic): "+minsysBP+" "+ newMinsysBPDate +"<br/>");

                                        %>        
                                        <input type="hidden" name="shockDate" id="shockDate" value="<%=newMinsysBPDate%>">
                                        <input type="hidden" name="shockBp" id="shockBp" value="<%=minsysBP%>">
                                        <br/><span style = "color: #858384; font-weight: bold;"> 
                                        Reference Range:<br/><br/></span>
                                        
                                        SBP : [< 90]
                        </div>
                    </div>
                    <a id="imageShock3" onmouseover="makeDivVisible('Shock3')" onmouseout="makeDivHidden('Shock3')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> </td>
            </tr>
            <tr onmouseover="mouseOverPara('imageShock4','ShockCol4')" onmouseout="mouseOutPara('imageShock4','ShockCol4')">
            <td></td>
            <td width="15"></td>
            <td id = "ShockCol4"><span style="color: blue;">
            <%if(shockFlag){
                	%>     <a onmouseover="makeDivVisible('Shock4')" onmouseout="makeDivHidden('Shock4')"><input type="checkbox" checked disabled value="Shock:Obstructive" name="shockChkGrp" >
                        Obstructive&nbsp;&nbsp;</a></span>
                <%}else{ %>
                        <a onmouseover="makeDivVisible('Shock4')" onmouseout="makeDivHidden('Shock4')"><input type="checkbox" value="Shock:Obstructive" name="shockChkGrp"  onclick="checkMain('shock');">
                        Obstructive&nbsp;&nbsp;</a></span><%} %></td>
            <td><div id="Shock4" class="imageBackSingle"><img src="images/divSingle.png" width="410px" height="300px"/>
                        <div id="Shock4" class="dynamicDiv" style="width:310px; height:215px; margin-top: -260px">
                                <br/><span style = "color: #858384; font-weight: bold;">
                                    Values are:<br/><br/></span>
                                        <%
                                        
                                        out.print(spaces + "Blood Pressure(systolic): "+minsysBP+" "+ newMinsysBPDate +"<br/>");

                                        %>        
                                        <input type="hidden" name="shockDate" id="shockDate" value="<%=newMinsysBPDate%>">
                                        <input type="hidden" name="shockBp" id="shockBp" value="<%=minsysBP%>">
                                        <br/><span style = "color: #858384; font-weight: bold;"> 
                                        Reference Range:<br/><br/></span>
                                        
                                        SBP : [< 90]
                        </div>
                    </div>
                    <a id="imageShock4" onmouseover="makeDivVisible('Shock4')" onmouseout="makeDivHidden('Shock4')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> </td>
            </tr>
            <tr onmouseover="mouseOverPara('imageShock5','ShockCol5')" onmouseout="mouseOutPara('imageShock5','ShockCol5')">
            <td></td>
            <td width="15"></td>
            <td id = "ShockCol5"><span style="color: blue;">
             <%if(shockFlag){
                	%>     <a onmouseover="makeDivVisible('Shock5')" onmouseout="makeDivHidden('Shock5')"><input type="checkbox" checked disabled value="Shock:NOS" name="shockChkGrp">
                        NOS&nbsp;&nbsp;</a></span>
                <%}else{ %>
                        <a onmouseover="makeDivVisible('Shock5')" onmouseout="makeDivHidden('Shock5')"><input type="checkbox" value="Shock:NOS" name="shockChkGrp"  onclick="checkMain('shock');">
                        NOS&nbsp;&nbsp;</a></span><%} %></td>
            <td><div id="Shock5" class="imageBackSingle"><img src="images/divSingle.png" width="410px" height="300px"/>
                        <div id="Shock5" class="dynamicDiv" style="width:310px; height:215px; margin-top: -260px">
                                <br/><span style = "color: #858384; font-weight: bold;">
                                    Values are:<br/><br/></span>
                                        <%
                                        //out.print(spaces + "Date: "+newsysBPDate+" "+"<br/>");
                                        out.print(spaces + "Blood Pressure(systolic): "+minsysBP+" "+ newMinsysBPDate +"<br/>");

                                        %>        
                                        <input type="hidden" name="shockDate" id="shockDate" value="<%=newMinsysBPDate%>">
                                        <input type="hidden" name="shockBp" id="shockBp" value="<%=minsysBP%>">
                                        <br/><span style = "color: #858384; font-weight: bold;"> 
                                        Reference Range:<br/><br/></span>
                                        
                                        SBP : [< 90]
                        </div>
                    </div>
                    <a id="imageShock5" onmouseover="makeDivVisible('Shock5')" onmouseout="makeDivHidden('Shock5')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> </td>
            </tr>
        <%}
    
        else if(result == 1)
          {%>
            <tr> <!-- onmouseover="mouseOverPara('imageCardShock','CardShockCol')" onmouseout="mouseOutPara('imageCardShock','CardShockCol')"> -->
                <td> <!-- id = "CardShockCol"> -->
                    <span style="color: black;">
                    <%if(shockFlag){
                	%>     <a onmouseover="makeDivVisible('CardShock')" onmouseout="makeDivHidden('CardShock')"><input id="cshock" type="checkbox" checked disabled name="mainGrp" value="Cardiogenic Shock">
                    Cardiogenic Shock&nbsp;&nbsp;</a></span>
                <%}else{ %>
                    <a onmouseover="makeDivVisible('CardShock')" onmouseout="makeDivHidden('CardShock')"><input id="cshock" type="checkbox" name="mainGrp" value="Cardiogenic Shock" onclick="unCheck('cshock','cshockChkGrp');">
                    Cardiogenic Shock&nbsp;&nbsp;</a></span><%} %>
                </td>
                <td width="15"></td>
                <td></td>
                <td>
                    <div id="CardShock" class="imageBackSingle" ><img src="images/divSingle.png" width="410px" height="300px"/>
                        <div id="CardShock" class="dynamicDiv" style="width:310px; height:240px; margin-top: -280px ">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                    //out.print(spaces + " Date: "+newsysBPDate+" "+"<br/>");
                                    out.print(spaces + "Blood Pressure(systolic): <b>"+minsysBP+"</b> "+ newMinsysBPDate +"<br/>");
                                    //out.print(spaces + " Date Cardio Troponin: "+newctDate+" "+"<br/>");
                                    out.print(spaces + " Cardio Troponin: <b>" + maxct + "</b> " + newMaxctDate +"<br/>");                        
                        
                                %>        
                                <input type="hidden" name="cShockDate" id="cShockDate" value="<%=newMinsysBPDate%>">
                                <input type="hidden" name="cShockBP" id="cShockBP" value="<%=minsysBP%>">
                                <input type="hidden" name="cDateShockTrop" id="cDateShockTrop" value="<%=newMaxctDate%>">
                                <input type="hidden" name="cShockTrop" id="cShockTrop" value="<%=maxct%>">    
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Determined by the Rule:<br/><br/></span>
                                
                                SBP: [< 90] and Cardiactroponin: [> <%=ctHigh %>]
                        </div>
                    </div>
                    <a id="imageCardShock" onmouseover="makeDivVisible('CardShock')" 
                    onmouseout="makeDivHidden('CardShock')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
            </tr>
             <tr onmouseover="mouseOverPara('imageCardShock2','CardShockCol2')" onmouseout="mouseOutPara('imageCardShock2','CardShockCol2')">
            <td></td>
            <td width="15"></td>
           <td id = "CardShockCol2">
                    <span style="color: blue;">
                    <%if(shockFlag){
                	%>      <a onmouseover="makeDivVisible('CardShock2')" onmouseout="makeDivHidden('CardShock2')"><input type="checkbox" checked disabled value="Cardiogenic Shock:Cardiogenic Shock" name="cshockChkGrp">
                    Cardiogenic Shock&nbsp;&nbsp;</a></span>
                <%}else{ %>
                    <a onmouseover="makeDivVisible('CardShock2')" onmouseout="makeDivHidden('CardShock2')"><input type="checkbox" value="Cardiogenic Shock:Cardiogenic Shock" name="cshockChkGrp"  onclick="checkMain('cshock');">
                    Cardiogenic Shock&nbsp;&nbsp;</a></span><%} %>
                </td>
            <td><div id="CardShock2" class="imageBackSingle" ><img src="images/divSingle.png" width="410px" height="300px"/>
                        <div id="CardShock2" class="dynamicDiv" style="width:310px; height:240px; margin-top: -280px ">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                    //out.print(spaces + " Date: "+newsysBPDate+" "+"<br/>");
                                    out.print(spaces + "Blood Pressure(systolic): <b>"+minsysBP+"</b> "+ newMinsysBPDate +"<br/>");
                                    //out.print(spaces + " Date Cardio Troponin: "+newctDate+" "+"<br/>");
                                    out.print(spaces + " Cardio Troponin: <b>" + maxct + "</b> " + newMaxctDate +"<br/>");                        
                        
                                %>        
                                <input type="hidden" name="cShockDate" id="cShockDate" value="<%=newMinsysBPDate%>">
                                <input type="hidden" name="cShockBP" id="cShockBP" value="<%=minsysBP%>">
                                <input type="hidden" name="cDateShockTrop" id="cDateShockTrop" value="<%=newMaxctDate%>">
                                <input type="hidden" name="cShockTrop" id="cShockTrop" value="<%=maxct%>">    
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Determined by the Rule:<br/><br/></span>
                                
                                SBP: [< 90] and Cardiactroponin: [> <%=ctHigh %>]
                        </div>
                    </div>
                    <a id="imageCardShock2" onmouseover="makeDivVisible('CardShock2')" 
                    onmouseout="makeDivHidden('CardShock2')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
            </tr>
           <tr onmouseover="mouseOverPara('imageCardShock3','CardShockCol3')" onmouseout="mouseOutPara('imageCardShock3','CardShockCol3')">
            <td></td>
            <td width="15"></td>
           <td id = "CardShockCol3">
                    <span style="color: blue;">
                    <%if(shockFlag){
                	%>      <a onmouseover="makeDivVisible('CardShock3')" onmouseout="makeDivHidden('CardShock3')"><input type="checkbox" checked disabled value="Cardiogenic Shock:Septic" name="cshockChkGrp">
                    Septic&nbsp;&nbsp;</a></span>
                <%}else{ %>
                    <a onmouseover="makeDivVisible('CardShock3')" onmouseout="makeDivHidden('CardShock3')"><input type="checkbox" value="Cardiogenic Shock:Septic" name="cshockChkGrp"  onclick="checkMain('cshock');">
                    Septic&nbsp;&nbsp;</a></span><%} %>
                </td>
            <td><div id="CardShock3" class="imageBackSingle" ><img src="images/divSingle.png" width="410px" height="300px"/>
                        <div id="CardShock3" class="dynamicDiv" style="width:310px; height:240px; margin-top: -280px ">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                out.print(spaces + "Blood Pressure(systolic): <b>"+minsysBP+"</b> "+ newMinsysBPDate +"<br/>");
                                out.print(spaces + " Cardio Troponin: <b>" + maxct + "</b> " + "(" + newMaxctDate + ")"+"<br/>");                        
                                %>        
                                <input type="hidden" name="cShockDate" id="cShockDate" value="<%=newMinsysBPDate%>">
                                <input type="hidden" name="cShockBP" id="cShockBP" value="<%=minsysBP%>">
                                <input type="hidden" name="cDateShockTrop" id="cDateShockTrop" value="<%=newMaxctDate%>">
                                <input type="hidden" name="cShockTrop" id="cShockTrop" value="<%=maxct%>">    
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Determined by the Rule:<br/><br/></span>
                                
                                SBP: [< 90] and cardiactroponin: [> <%=ctHigh %>]
                        </div>
                    </div>
                    <a id="imageCardShock3" onmouseover="makeDivVisible('CardShock3')" 
                    onmouseout="makeDivHidden('CardShock3')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
            </tr>
            <tr onmouseover="mouseOverPara('imageCardShock4','CardShockCol4')" onmouseout="mouseOutPara('imageCardShock4','CardShockCol4')">
            <td></td>
            <td width="15"></td>
           <td id = "CardShockCol4">
                    <span style="color: blue;">
                    <%if(shockFlag){
                	%>      <a onmouseover="makeDivVisible('CardShock4')" onmouseout="makeDivHidden('CardShock4')"><input type="checkbox" checked disabled value="Cardiogenic Shock:Hypovolemic" name="cshockChkGrp">
                    Hypovolemic&nbsp;&nbsp;</a></span>
                <%}else{ %>
                    <a onmouseover="makeDivVisible('CardShock4')" onmouseout="makeDivHidden('CardShock4')"><input type="checkbox" value="Cardiogenic Shock:Hypovolemic" name="cshockChkGrp"  onclick="checkMain('cshock');">
                    Hypovolemic&nbsp;&nbsp;</a></span><%} %>
                </td>
            <td><div id="CardShock4" class="imageBackSingle"><img src="images/divSingle.png" width="410px" height="300px"/>
                        <div id="CardShock4" class="dynamicDiv" style="width:310px; height:240px; margin-top: -280px ">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                    //out.print(spaces + " Date: "+newsysBPDate+" "+"<br/>");
                                out.print(spaces + " Systolic Blood Pressure: <b>"+minsysBP+"</b> "+ newMinsysBPDate +"<br/>");
                                //out.print(spaces + " Date Cardio Troponin: "+newctDate+" "+"<br/>");
                                out.print(spaces + " Cardio Troponin: <b>" + maxct + "</b> " + newMaxctDate +"<br/>");                        
                        
                                %>        
                                <input type="hidden" name="cShockDate" id="cShockDate" value="<%=newMinsysBPDate%>">
                                <input type="hidden" name="cShockBP" id="cShockBP" value="<%=minsysBP%>">
                                <input type="hidden" name="cDateShockTrop" id="cDateShockTrop" value="<%=newMaxctDate%>">
                                <input type="hidden" name="cShockTrop" id="cShockTrop" value="<%=maxct%>">    
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Determined by the Rule:<br/><br/></span>
                                
                                SBP: [< 90] and cardiactroponin: [> <%=ctHigh %>]
                        </div>
                    </div>
                    <a id="imageCardShock4" onmouseover="makeDivVisible('CardShock4')" 
                    onmouseout="makeDivHidden('CardShock4')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
            </tr>
            <tr onmouseover="mouseOverPara('imageCardShock5','CardShockCol5')" onmouseout="mouseOutPara('imageCardShock5','CardShockCol5')">
            <td></td>
            <td width="15"></td>
           <td id = "CardShockCol5">
                    <span style="color: blue;">
                    <%if(shockFlag){
                	%>      <a onmouseover="makeDivVisible('CardShock5')" onmouseout="makeDivHidden('CardShock5')"><input type="checkbox" checked disabled value="Cardiogenic Shock:Obstructive" name="cshockChkGrp">
                    Obstructive&nbsp;&nbsp;</a></span>
                <%}else{ %>
                    <a onmouseover="makeDivVisible('CardShock5')" onmouseout="makeDivHidden('CardShock5')"><input type="checkbox" value="Cardiogenic Shock:Obstructive" name="cshockChkGrp"  onclick="checkMain('cshock');">
                    Obstructive&nbsp;&nbsp;</a></span><%} %>
                </td>
            <td><div id="CardShock5" class="imageBackSingle"><img src="images/divSingle.png" width="410px" height="300px"/>
                        <div id="CardShock5" class="dynamicDiv" style="width:310px; height:240px; margin-top: -280px ">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                    //out.print(spaces + " Date: "+newsysBPDate+" "+"<br/>");
                                out.print(spaces + " Systolic Blood Pressure: <b>"+minsysBP+"</b> "+ newMinsysBPDate +"<br/>");
                                //out.print(spaces + " Date Cardio Troponin: "+newctDate+" "+"<br/>");
                                out.print(spaces + " Cardio Troponin: <b>" + maxct + "</b> " + newMaxctDate +"<br/>");                        
                        
                                %>        
                                <input type="hidden" name="cShockDate" id="cShockDate" value="<%=newMinsysBPDate%>">
                                <input type="hidden" name="cShockBP" id="cShockBP" value="<%=minsysBP%>">
                                <input type="hidden" name="cDateShockTrop" id="cDateShockTrop" value="<%=newMaxctDate%>">
                                <input type="hidden" name="cShockTrop" id="cShockTrop" value="<%=maxct%>">    
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Determined by the Rule:<br/><br/></span>
                                
                                SBP: [< 90] and cardiactroponin: [> <%=ctHigh %>]
                        </div>
                    </div>
                    <a id="imageCardShock5" onmouseover="makeDivVisible('CardShock5')" 
                    onmouseout="makeDivHidden('CardShock5')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
            </tr>
            <tr onmouseover="mouseOverPara('imageCardShock6','CardShockCol6')" onmouseout="mouseOutPara('imageCardShock6','CardShockCol6')">
            <td></td>
            <td width="15"></td>
           <td id = "CardShockCol6">
                    <span style="color: blue;">
                    <%if(shockFlag){
                	%>       <a onmouseover="makeDivVisible('CardShock6')" onmouseout="makeDivHidden('CardShock6')"><input type="checkbox" checked disabled value="Cardiogenic Shock:NOS" name="cshockChkGrp">
                    NOS&nbsp;&nbsp;</a></span>
                <%}else{ %>
                    <a onmouseover="makeDivVisible('CardShock6')" onmouseout="makeDivHidden('CardShock6')"><input type="checkbox" value="Cardiogenic Shock:NOS" name="cshockChkGrp"  onclick="checkMain('cshock');">
                    NOS&nbsp;&nbsp;</a></span><%} %>
                </td>
            <td><div id="CardShock6" class="imageBackSingle" ><img src="images/divSingle.png" width="410px" height="300px"/>
                        <div id="CardShock6" class="dynamicDiv" style="width:310px; height:240px; margin-top: -280px ">
                        <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                                <%
                                    //out.print(spaces + " Date: "+newsysBPDate+" "+"<br/>");
                                out.print(spaces + " Systolic Blood Pressure: <b>"+minsysBP+"</b> "+ newMinsysBPDate +"<br/>");
                                //out.print(spaces + " Date Cardio Troponin: "+newctDate+" "+"<br/>");
                                out.print(spaces + " Cardio Troponin: <b>" + maxct + "</b> " + newMaxctDate +"<br/>");                        
                        
                                %>        
                                <input type="hidden" name="cShockDate" id="cShockDate" value="<%=newMinsysBPDate%>">
                                <input type="hidden" name="cShockBP" id="cShockBP" value="<%=minsysBP%>">
                                <input type="hidden" name="cDateShockTrop" id="cDateShockTrop" value="<%=newMaxctDate%>">
                                <input type="hidden" name="cShockTrop" id="cShockTrop" value="<%=maxct%>">    
                                <br/><span style = "color: #858384; font-weight: bold;"> 
                                Determined by the Rule:<br/><br/></span>
                                
                                SBP: [< 90] and cardiactroponin: [> <%=ctHigh %>]
                        </div>
                    </div>
                    <a id="imageCardShock6" onmouseover="makeDivVisible('CardShock6')" 
                    onmouseout="makeDivHidden('CardShock6')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
            </tr>
        <%}//remove these%>
    <%}//remove theese%> 
    
    
    <!-- ************************************** UTI ******************************************* -->

    <%    
    //Invoke Rule
    // Since, urinest is a string, we will need to check which value to use
    
    boolean utiFlag=false;
    int utiValueMatch=0;
    String urinest = "";
    String urinestdate = "";
    if(maxurinest.equalsIgnoreCase("NEGATIVE")) {
        urinest = minurinest;
        urinestdate = minurinestDate;
    }
    else {
        urinest = maxurinest;
        urinestdate = maxurinestDate;
    }
    String urini = "";
    String urinidate = "";
    if(maxurini.equalsIgnoreCase("NEGATIVE")) {
        urini = minurini;
        urinidate = minuriniDate;
    }
    else {
        urini = maxurini;
        urinidate = maxuriniDate;
    }
    result = coMorbChk.UTI(maxUtiWbc, urini, urinest); 
    System.out.println("UTI:" + result);
    if(result!=0)
    {
    	Iterator imain=valueMatch.entrySet().iterator();
		Map<String, String> values =new HashMap<String, String>();
		while(imain.hasNext())
		{
			Entry e=(Entry)imain.next();
			if(e.getKey().equals("Uti"))
			{
				utiFlag=true;
				values=(Map<String, String>)e.getValue();
				break;
			}
		}
		if(utiFlag)
		{
			Iterator ival=values.entrySet().iterator();
			while(ival.hasNext())
			{
				Entry e=(Entry)ival.next();
				String testName=(String)e.getKey();
				String testVal=(String)e.getValue();
			
				if(testName.equals("wbccount"))
				{
					if(!testVal.isEmpty() && !maxUtiWbc.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(maxUtiWbc))
       						utiValueMatch=1;
       				}
					else
   	   				{
   	   					if(!maxUtiWbc.isEmpty())
   	   						utiValueMatch=1;
   	   				}
				}
				/*if(!maxUtiWbc.isEmpty() && !values.containsKey("wbccount"))
				{
					utiFlag=false;
					utiValueMatch=1;
				}*/
				if(testName.equals("utiuln"))
				{
					if(!testVal.isEmpty() && !urini.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(urini))
       						utiValueMatch=1;
       				}
					else
   	   				{
   	   					if(!urini.isEmpty())
   	   						utiValueMatch=1;
   	   				}
				}
				/*if(!urini.isEmpty() && !values.containsKey("utiuln"))
				{
					utiFlag=false;
					utiValueMatch=1;
				}*/
				if(testName.equals("utiule"))
				{
					if(!testVal.isEmpty() && !urinest.isEmpty())
       				{
       					if(Double.parseDouble(testVal)!=Double.parseDouble(urinest))
						utiValueMatch=1;
       				}
					else
   	   				{
   	   					if(!urinest.isEmpty())
   	   						utiValueMatch=1;
   	   				}
				}
				/*if(!urinest.isEmpty() && !values.containsKey("utiule"))
				{
  					utiFlag=false;	
					utiValueMatch=1;
				}*/
			}
		}
		else
		{
			utiValueMatch=1;
		}
    }
    if(utiValueMatch != 0)
    {
     %>    
    <tr onmouseover="mouseOverPara('imageUti','UtiCol1')" 
                onmouseout="mouseOutPara('imageUti','UtiCol1')">
        <td id = "UtiCol1">
            <span style="color: blue;">
            <%if(utiFlag){
                	%>      <a onmouseover="makeDivVisible('Uti')" onmouseout="makeDivHidden('Uti')"><input id="UrinTI" type="checkbox" checked disabled name="mainGrp" value="Uti"/>&nbsp;UTI
            </a></span>
                <%}else{ %>
            <a onmouseover="makeDivVisible('Uti')" onmouseout="makeDivHidden('Uti')"><input id="UrinTI" type="checkbox" name="mainGrp" value="Uti" onclick="unCheck('UrinTI','catheterAssoc');"/>&nbsp;UTI
            </a></span><%} %>
        </td>
        <td></td>
        <td>
        <div id="Uti" class="imageBackSingle"  style="width:400px; height:350px; margin-top: -55px "><img src="images/divSingle.png" width="100%" height="100%"/>
            <div id="Uti" class="dynamicDiv" style="width:300px; height:270px; margin-top: -320px">
                    <br/><span style = "color: #858384; font-weight: bold;">
                        Values are:<br/><br/></span>
                        <% 
                        
                        //out.print(spaces + "WBC Date: "+newutiWbcDate+" "+"<br/>");
                        out.print(spaces + "WBC Count: <b>"+ maxUtiWbc+"</b> "+ maxUtiWbcDate +"<br/>");
                        //out.print(spaces + "Date of Urinalysis,  Nitrite: "+newuriniDate+" "+"<br/>"); 
                        if(maxurini.equalsIgnoreCase("POSITIVE") || maxurini.equalsIgnoreCase("LARGE") || maxurini.equalsIgnoreCase("MOD") || 
                                maxurini.equalsIgnoreCase("SMALL") || maxurini.equalsIgnoreCase("TRACE")){
                            out.print(spaces + "Urinalysis,  Nitrite:<b> "+ urini +"</b> "+ urinidate +"<br/>");
                        }
                        //out.print(spaces + "Date of Urinalysis, Leukocyte Esterase: "+newurinestDate+" "+"<br/>"); 
                        if(maxurinest.equalsIgnoreCase("POSITIVE")|| maxurinest.equalsIgnoreCase("LARGE") || maxurinest.equalsIgnoreCase("MOD") || 
                                maxurinest.equalsIgnoreCase("SMALL") || maxurinest.equalsIgnoreCase("TRACE")){
                            out.print(spaces + "Urinalysis, Leukocyte Esterase:<b>"+ urinest +"</b> "+ urinestdate +"<br/>");
                        }
                
                        %>    
                        <input type="hidden" name="utiDate" id="utiDate" value="<%=maxUtiWbcDate%>">        
                        <input type="hidden" name="utiWbc" id="utiWbc" value="<%=maxUtiWbc%>">
                        <input type="hidden" name="utiUln" id="utiUln" value="<%=urini%>">
                        <input type="hidden" name="utiUlndate" id="utiUlndate" value="<%=urinidate%>">
                        <input type="hidden" name="utiUle" id="utiUle" value="<%=urinest%>">
                        <input type="hidden" name="utiUledate" id="utiUledate" value="<%=urinestdate%>">
                            
                            <br/><span style = "color: #858384; font-weight: bold;"> 
                            &nbsp;&nbsp;UTI if the following is true: <br/><br/></span>
                            <ul>
                                <li>WBC Count > 5 and</li>
                                <li>Either Urinalysis, Leukocyte Esterase is NOT NEGATIVE or</li>
                                <li>Urinalysis, Nitrite is NOT NEGATIVE</li>
                            </ul> 
            </div>
        </div>
                <a id="imageUti" onmouseover="makeDivVisible('Uti')" 
                onmouseout="makeDivHidden('Uti')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
            </td>
    </tr>
    <tr>
    
    <td></td>
                <td></td>
                <td>                
                <span style="color: black;">
                <%if(utiFlag){
                	%>     <input type="checkbox" checked disabled name="catheterAssoc" value="Catherter Associated" >
                Catheter Associated&nbsp;&nbsp;</span>
                <%}else{ %>
                <input type="checkbox" name="catheterAssoc" value="Catherter Associated" onclick="checkMain('UrinTI');">
                Catheter Associated&nbsp;&nbsp;</span> <%} %>                  
                </td>
    
    </tr>
    <% } %> 
    
    
    <!-- ************************************** Respiratory Failure ******************************************* -->
    
    <% 
    boolean rfFlag=false;
    result = coMorbChk.respFailure(maxpco2, maxEtco2, maxprevpco2, maxprevEtco2, minpo2, minoximetry);
    System.out.println("Respiratory Result:" + result);
    if(result != 0)
    {
   
   	 /*	Iterator imain=valueMatch.entrySet().iterator();
    	Map<String, String> values =new HashMap<String, String>();
   		while(imain.hasNext())
    	{
    		Entry e=(Entry)imain.next();
    		if(e.getKey().equals("Respiratory Failure"))
    		{
   				rfFlag=true;
   				values=(Map<String, String>)e.getValue();
   				break;
   			}
   		}
   		if(rfFlag)
   		{
   			Iterator ival=values.entrySet().iterator();
   			while(ival.hasNext())
    		{
    			Entry e=(Entry)ival.next();
    			String testName=(String)e.getKey();
    			String testVal=(String)e.getValue();
   				if(testName.equals(" "))
   					if(!testVal.equals(""))
   						rfFlag=false;
   			
   			}
   		}*/
    
    %>
    <tr>
        <td>
            <span style="color: black;">
            <%if(rfFlag){
                	%>    <input id="respFail" type="checkbox" checked disabled name="mainGrp" value="Respiratory Failure :"/>&nbsp;Respiratory Failure :
            </span>
                <%}else{ %>
            <input id="respFail" type="checkbox" name="mainGrp" value="Respiratory Failure :" onclick="unCheck('respFail','respFailChkGrp');"/>&nbsp;Respiratory Failure :
            </span><%} %>
        </td>
        <td width="15"></td>
        <td></td>
        <td></td>
    </tr>
    
        
        <%//if(((result/10)%10) == 1) //acute
			{%>
            <tr onmouseover="mouseOverPara('imageRespAcute','RespAcuteCol')" onmouseout="mouseOutPara('imageRespAcute','RespAcuteCol')" >
                <td></td>
                <td></td>
                <td id = "RespAcuteCol">
                <%if(result==2){//if(((result/10)%10) == 1){
                    %>                    
                    <span style="color:blue;">
                    <%if(rfFlag){
                	%>   <a onmouseover="makeDivVisible('RespAcute')" onmouseout="makeDivHidden('RespAcute')"><input type="checkbox" checked disabled name="respFailChkGrp" value="Respiratory Failure :Acute">
                        Acute&nbsp;&nbsp;</a>
                    </span>
                <%}else{ %>
                        <a onmouseover="makeDivVisible('RespAcute')" onmouseout="makeDivHidden('RespAcute')"><input type="checkbox" name="respFailChkGrp" value="Respiratory Failure :Acute" onclick="checkMain('respFail');">
                        Acute&nbsp;&nbsp;</a>
                    </span> <%} %>               
                    <%}else{ %>
                    <span style="color:black;">
                        <a onmouseover="makeDivVisible('RespAcute')" onmouseout="makeDivHidden('RespAcute')"><input type="checkbox" name="respFailChkGrp" value="Respiratory Failure :Acute" onclick="checkMain('respFail');">
                        Acute&nbsp;&nbsp;</a>
                    </span>
                    
                    <%} %>    
                </td>
                <td>
                <div id="RespAcute" class="imageBack" ><img src="images/div.png" width="100%"; height="100%"/>
                    <div id="RespAcute" class="dynamicDiv" style="width:280px; height:230px;">
                            <br/><span style = "color: #858384; font-weight: bold;">
                            <%if(result==2){ %>
                            Values are:<br/><br/></span>
                            <% 
                            if(minpo2.isEmpty() != true && Double.parseDouble(minpo2) <= 60 ){
                                out.print(spaces + "PO<sub>2</sub>   <b>:"+minpo2+"</b> "+ newMinpo2Date +"<br/>"); 
                                }
                                
                            if(minoximetry.isEmpty() != true && Double.parseDouble(minoximetry) <= 90 ) {
                                out.print(spaces + "Pulse Oximetry: <b>"+minoximetry+"</b> "+ newMinoximetryDate +"<br/>"); 
                            }
                            %>
                            <%} %>
                            <input type="hidden" name="respPo2Date" id="respPo2Date" value="<%=newMinpo2Date%>">
                            <input type="hidden" name="respPo" id="respPo" value="<%=minpo2%>">
                            <input type="hidden" name="respO2satDate" id="respO2satDate" value="<%=newMinoximetryDate%>">
                            <input type="hidden" name="respO2sat" id="respO2sat" value="<%=minoximetry%>">
                            <br/><span style = "color: #858384; font-weight: bold;"> 
                            Determined by the Rule:<br/><br/></span>
                            
                            Acute if PO2 <= 60 or Pulse Oximetry <= 90
                    </div>
                </div>
                <a id="imageRespAcute" onmouseover="makeDivVisible('RespAcute')" 
                onmouseout="makeDivHidden('RespAcute')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
            </tr>         
		<%}%>
        
        <%//if(((result/100)%10) == 1) //chronic
          {%>
            <tr onmouseover="mouseOverPara('imageRespChronic','RespChronicCol')" onmouseout="mouseOutPara('imageRespChronic','RespChronicCol')" >
                <td></td>
                <td></td>
                <td id = "RespChronicCol">
                <% if(result==3)//if(((result/100)%10) == 1)
                { %>
                    <span style="color: blue;">
                    <%if(rfFlag){
                	%>   <a onmouseover="makeDivVisible('RespChronic')" onmouseout="makeDivHidden('RespChronic')"><input type="checkbox" checked disabled name="respFailChkGrp" value="Respiratory Failure :Chronic">
                        Chronic&nbsp;&nbsp;</a>
                    </span>
                <%}else{ %>
                        <a onmouseover="makeDivVisible('RespChronic')" onmouseout="makeDivHidden('RespChronic')"><input type="checkbox" name="respFailChkGrp" value="Respiratory Failure :Chronic" onclick="checkMain('respFail');">
                        Chronic&nbsp;&nbsp;</a>
                    </span> <%} %>               
                    <%}else{ %>
                    
                    <span style="color: black;">
                    <%if(rfFlag){
                	%>   <a onmouseover="makeDivVisible('RespChronic')" onmouseout="makeDivHidden('RespChronic')"><input type="checkbox" checked disabled name="respFailChkGrp" value="Respiratory Failure :Chronic">
                        Chronic&nbsp;&nbsp;</a>
                    </span>
                <%}else{ %>
                        <a onmouseover="makeDivVisible('RespChronic')" onmouseout="makeDivHidden('RespChronic')"><input type="checkbox" name="respFailChkGrp" value="Respiratory Failure :Chronic" onclick="checkMain('respFail');">
                        Chronic&nbsp;&nbsp;</a>
                    </span><%} %>
                    <%} %>        
                </td>
                <td>
                <div id="RespChronic" class="imageBack" style="width:400px; height:360px; margin-top:-150px;"><img src="images/div.png" width="100%"; height="100%"/>
                    <div id="RespChronic" class="dynamicDiv" style="width:310px; height:280px; margin-top: -330px;">
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                            <%
                            if(maxpco2.isEmpty() != true && Double.parseDouble(maxpco2) > 45){ 
                            out.print(spaces + "PCO<sub>2</sub>: <b>"+maxpco2+"</b> "+ newMaxpco2Date +"<br/>");
                            }
                            if(maxEtco2.isEmpty() != true && Double.parseDouble(maxEtco2) > 45){
                            out.print(spaces + "ETCO<sub>2</sub>: <b>"+maxEtco2+"</b> "+ newMaxEtco2Date +"<br/>");
                            }
                            if(maxprevpco2.isEmpty() != true && Double.parseDouble(maxprevpco2) > 45){
                            out.print(spaces + "Previous PCO<sub>2</sub>: <b>"+maxprevpco2+"</b> "+ newMaxprevpco2Date +"<br/>");
                            }
                            if(maxprevEtco2.isEmpty() != true && Double.parseDouble(maxprevEtco2) > 45){
                            out.print(spaces + "Previous ETCO<sub>2</sub>: <b>"+maxprevEtco2+"</b> "+ newMaxprevEtco2Date +"<br/>");
                            }
                            %>
                            <input type="hidden" name="respPco2Date" id="respPco2Date" value="<%=newMaxpco2Date%>">
                            <input type="hidden" name="respPco2" id="respPco2" value="<%=maxpco2%>">
                            <input type="hidden" name="respEtco2Date" id="respEtco2Date" value="<%=newMaxEtco2Date%>">
                            <input type="hidden" name="respEtco2" id="respEtco2" value="<%=maxEtco2%>">
                            <input type="hidden" name="respPrevPco2Date" id="respPrevPco2Date" value="<%=newMaxprevpco2Date%>">
                            <input type="hidden" name="respPrevPco2" id="respPrevPco2Date" value="<%=maxprevpco2%>">
                            <input type="hidden" name="respPrevEtco2Date" id="respPrevEtco2Date" value="<%=newMaxprevEtco2Date%>">
                            <input type="hidden" name="respPrevEtco2" id="respPrevEtco2" value="<%=maxprevEtco2%>">
                            <br/><span style = "color: #858384; font-weight: bold;"> 
                            Determined by the Rule:<br/><br/></span>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            Chronic if Current PCO2 or ETCO2 > 45 and Previous PCO2 or Previous ETCO2 >45
                    </div>
                </div>
                <a id="imageRespChronic" onmouseover="makeDivVisible('RespChronic')" 
                onmouseout="makeDivHidden('RespChronic')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
            </tr>
        <%}%>
        <%//if(((result/1000)%10) == 1) //chronic on acute
          {%>
            <tr onmouseover="mouseOverPara('imageRespACChronic','RespACChronicCol')" onmouseout="mouseOutPara('imageRespACChronic','RespACChronicCol')" >
                <td></td>
                <td></td>
                <td id = "RespACChronicCol">
                <% if(result==4)//if(((result/1000)%10) == 1)
                { %>    
                    <span style="color: blue;">
                    <%if(rfFlag){
                	%>   <a onmouseover="makeDivVisible('RespACChronic')" onmouseout="makeDivHidden('RespACChronic')"><input type="checkbox" checked disabled name="respFailChkGrp" value="Respiratory Failure :Acute on Chronic">
                        Acute on Chronic&nbsp;&nbsp;</a>
                    </span>
                <%}else{ %>
                        <a onmouseover="makeDivVisible('RespACChronic')" onmouseout="makeDivHidden('RespACChronic')"><input type="checkbox" name="respFailChkGrp" value="Respiratory Failure :Acute on Chronic" onclick="checkMain('respFail');">
                        Acute on Chronic&nbsp;&nbsp;</a>
                    </span><%} %>
                    <%}else{ %>
                    <span style="color: black;">
                     <%if(rfFlag){
                	%>   <a onmouseover="makeDivVisible('RespACChronic')" onmouseout="makeDivHidden('RespACChronic')"><input type="checkbox" checked disabled name="respFailChkGrp" value="Respiratory Failure :Acute on Chronic">
                        Acute on Chronic&nbsp;&nbsp;</a>
                    </span>
                <%}else{ %>
                        <a onmouseover="makeDivVisible('RespACChronic')" onmouseout="makeDivHidden('RespACChronic')"><input type="checkbox" name="respFailChkGrp" value="Respiratory Failure :Acute on Chronic" onclick="checkMain('respFail');">
                        Acute on Chronic&nbsp;&nbsp;</a>
                    </span><%} %>
                    <%} %>
                </td>
                <td>
                <div id="RespACChronic" class="imageBack" style="width:410px; height:350px; margin-top:-150px;"><img src="images/div.png" width="100%"; height="100%"/>
                    <div id="RespACChronic" class="dynamicDiv" style="width:320px; height:280px; margin-top: -330px">
                            <br/><span style = "color: #858384; font-weight: bold;">
                            Values are:<br/><br/></span>
                            <%
                            if(minpo2.isEmpty() != true && Double.parseDouble(minpo2) <= 60 ){
                                out.print(spaces + "PO<sub>2</sub>   <b>:"+minpo2+"</b> "+ newMinpo2Date +"<br/>"); 
                                }
                                
                                if(minoximetry.isEmpty() != true && Double.parseDouble(minoximetry) <= 90 ) {
                                out.print(spaces + "Pulse Oximetry: <b>"+minoximetry+"</b> "+ newMinoximetryDate +"<br/>"); 
                            }
                                if(maxpco2.isEmpty() != true && Double.parseDouble(maxpco2) > 45){ 
                                    out.print(spaces + "PCO<sub>2</sub>: <b>"+maxpco2+"</b> "+ newMaxpco2Date +"<br/>");
                                    }
                                    if(maxEtco2.isEmpty() != true && Double.parseDouble(maxEtco2) > 45){
                                    out.print(spaces + "ETCO<sub>2</sub>: <b>"+maxEtco2+"</b> "+ newMaxEtco2Date +"<br/>");
                                    }
                                    if(maxprevpco2.isEmpty() != true && Double.parseDouble(maxprevpco2) > 45){
                                    out.print(spaces + "Previous PCO<sub>2</sub>: <b>"+maxprevpco2+"</b> "+ newMaxprevpco2Date +"<br/>");
                                    }
                                    if(maxprevEtco2.isEmpty() != true && Double.parseDouble(maxprevEtco2) > 45){
                                    out.print(spaces + "Previous ETCO<sub>2</sub>: <b>"+maxprevEtco2+"</b> "+ newMaxprevEtco2Date +"<br/>");
                                    }
                            %>
                            <input type="hidden" name="respPco2Date" id="respPco2Date" value="<%=newMaxpco2Date%>">
                            <input type="hidden" name="respPco2" id="respPco2" value="<%=maxpco2%>">
                            <input type="hidden" name="respEtco2Date" id="respEtco2Date" value="<%=newMaxEtco2Date%>">
                            <input type="hidden" name="respEtco2" id="respEtco2" value="<%=maxEtco2%>">
                            <input type="hidden" name="respPrevPco2Date" id="respPrevPco2Date" value="<%=newMaxprevpco2Date%>">
                            <input type="hidden" name="respPrevPco2" id="respPrevPco2Date" value="<%=maxprevpco2%>">
                            <input type="hidden" name="respPrevEtco2Date" id="respPrevEtco2Date" value="<%=newMaxprevEtco2Date%>">
                            <input type="hidden" name="respPrevEtco2" id="respPrevEtco2" value="<%=maxprevEtco2%>">
                            <input type="hidden" name="respPo2Date" id="respPo2Date" value="<%=newMinpo2Date%>">
                            <input type="hidden" name="respPo" id="respPo" value="<%=minpo2%>">
                            <input type="hidden" name="respO2satDate" id="respO2satDate" value="<%=newMinoximetryDate%>">
                            <input type="hidden" name="respO2sat" id="respO2sat" value="<%=minoximetry%>">
                            <br/><span style = "color: #858384; font-weight: bold;"> 
                            Determined by the Rule:<br/><br/></span>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            ( Current PO2 <= 60 or Current Pulse Oximetry <= 90) and 
                            (Current PCO2 or Current ETCO2 >45) and (Previous PCO2 or Previous ETCO2 > 45)
                            
                    </div>
                </div>
                <a id="imageRespACChronic" onmouseover="makeDivVisible('RespACChronic')" 
                onmouseout="makeDivHidden('RespACChronic')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
                </td>
            </tr>
        <%}%>        
    <%}%>

    
    <!-- ************************************** Sepsis ******************************************* -->
    <%     
    //Invoking Rule
    boolean sepsisFlag=false;
    result = coMorbChk.sepsis(maxhRate, minhRate, maxrRate, maxwbc, minwbc, minsysBP, maxtemp, mintemp, maxlactate,lactateHigh);
    System.out.println("SEPSIS MAX WBC:" + maxwbc);
    System.out.println("SEPSIS MIN WBC:" + minwbc);
    if(result != 0)
    {
    
        /*Iterator imain=valueMatch.entrySet().iterator();
        Map<String, String> values =new HashMap<String, String>();
       	while(imain.hasNext())
        {
        		Entry e=(Entry)imain.next();
        		if(e.getKey().equals("Sepsis"))
        		{
       				sepsisFlag=true;
       				values=(Map<String, String>)e.getValue();
       				break;
       			}
       	}
       	if(sepsisFlag)
       	{
       		Iterator ival=values.entrySet().iterator();
       		while(ival.hasNext())
        	{
        		Entry e=(Entry)ival.next();
        		String testName=(String)e.getKey();
        		String testVal=(String)e.getValue();
       				if(testName.equals(" ") 
       						if(!testVal.equals(""))
       							sepsisFlag=false;
       		
       			
       		}
       	}*/
        %>
        <tr onmouseover="mouseOverPara('imageSepsis','SepsisCol1')" onmouseout="mouseOutPara('imageSepsis','SepsisCol1')" >
            <td id = "SepsisCol1">
                <span style="color: blue;">
                <%if(sepsisFlag){
                	%>   <a onmouseover="makeDivVisible('RespACChronic')" onmouseout="makeDivHidden('RespACChronic')"><input type="checkbox" checked disabled name="respFailChkGrp" value="Respiratory Failure :Acute on Chronic">
                        Acute on Chronic&nbsp;&nbsp;</a>
                    </span>
                <%}else{ %>
                    <a onmouseover="makeDivVisible('Sepsis')" onmouseout="makeDivHidden('Sepsis')"><input type="checkbox" name="mainGrp" value="Sepsis">
                    Sepsis&nbsp;&nbsp;</a></span><%} %>
            </td>
            <td>
                <div id="Sepsis" class="imageBackSingle" style="width:500px; height:540px; margin-top: -55px "><img src="images/divSingle.png" width="100%"; height="100%"/>
                    <div id="Sepsis" class="dynamicDiv" style="width:390px; height:430px; margin-top: -500px; margin-left:50px;">
                            <br/><span style = "color: #858384; font-weight: bold;">
                                Values are:<br/></span>
                                    <% 
                                     if(maxhRate.isEmpty() != true && Double.parseDouble(maxhRate) > 100.0){
                                            out.print(spaces + "Heart Rate: <b>"+maxhRate+"</b> "+ newmaxhDate +"<br/>");
                                    }
                                    if( minhRate.isEmpty() != true && Double.parseDouble(minhRate) < 40.0){
                                        out.print(spaces + "Heart Rate: <b>"+minhRate+"</b> "+ newminhDate +"<br/>");

                                    }
                                    if(maxrRate.isEmpty() != true && Double.parseDouble(maxrRate) > 26.0){
                                        out.print(spaces + "Respiratory Rate: <b>"+maxrRate+"</b> "+ newmaxrDate +"<br/>");

                                    }
                                    if(maxwbc.isEmpty() != true && Double.parseDouble(maxwbc) > 12.0){
                                        out.print(spaces + "WBC Count: <b>"+ maxwbc+"</b> "+ newMaxwbcDate +"<br/>");

                                    }
                                    if(minwbc.isEmpty() != true && Double.parseDouble(minwbc) < 4.0){
                                        out.print(spaces + "WBC Count: <b>"+ minwbc+"</b> "+ newMinwbcDate +"<br/>");

                                    }
                                    if(minsysBP.isEmpty() != true && Double.parseDouble(minsysBP) <= 90.0){
                                        out.print(spaces + "Systolic BP: <b>"+ minsysBP+"</b> "+ newMinsysBPDate +"<br/>");

                                    }
                                    if(maxtemp.isEmpty() != true && Double.parseDouble(maxtemp) >= 38.88){
                                        out.print(spaces + "Temperature: <b>"+maxtemp+"&deg;C</b> "+ newmaxtempDate +"<br/>");

                                    }
                                    if(mintemp.isEmpty() != true &&  Double.parseDouble(mintemp) < 36){
                                        out.print(spaces + "Temperature: <b>"+mintemp+"&deg;C</b> "+ newmintempDate +"<br/>");

                                    }
                                    if( maxlactate.isEmpty() != true && Double.parseDouble(maxlactate) > Double.parseDouble(lactateHigh)){
                                        out.print(spaces + "Lactate: <b>"+ maxlactate+"</b> "+ newmaxlactateDate +"<br/>");
                                    } 
                                    %>
                                    <input type="hidden" name="maxsepHrDate" id="maxsepHrDate" value="<%=newmaxhDate%>">
                                    <input type="hidden" name="minsepHrDate" id="minsepHrDate" value="<%=newminhDate%>">
                                    <input type="hidden" name="sepRrDate" id="sepRrDate" value="<%=newmaxrDate%>">
                                    <input type="hidden" name="maxsepWbcDate" id="maxsepWbcDate" value="<%=newMaxwbcDate%>">
                                    <input type="hidden" name="minsepWbcDate" id="minsepWbcDate" value="<%=newMinwbcDate%>">
                                    <input type="hidden" name="sepSysBPDate" id="sepSysBPDate" value="<%=newMinsysBPDate%>">
                                    <input type="hidden" name="maxsepTemDate" id="maxsepTemDate" value="<%=newmaxtempDate%>">
                                    <input type="hidden" name="minsepTemDate" id="minsepTemDate" value="<%=newmintempDate%>">
                                    <input type="hidden" name="sepLacDate" id="sepLacDate" value="<%=newmaxlactateDate%>">
                                    <input type="hidden" name="maxsepHr" id="maxsepHr" value="<%=maxhRate%>">
                                    <input type="hidden" name="minsepHr" id="minsepHr" value="<%=minhRate%>">
                                    <input type="hidden" name="sepRr" id="sepRr" value="<%=maxrRate%>">
                                    <input type="hidden" name="maxsepWbc" id="maxsepWbc" value="<%=maxwbc%>">
                                    <input type="hidden" name="minsepWbc" id="minsepWbc" value="<%=minwbc%>">                         
                                    <input type="hidden" name="sepSysBP" id="sepDd" value="<%=minsysBP%>">
                                    <input type="hidden" name="maxsepTem" id="maxsepAlb" value="<%=maxtemp%>">
                                    <input type="hidden" name="minsepTem" id="minsepAlb" value="<%=mintemp%>">
                                    <input type="hidden" name="sepLac" id="sepLac" value="<%=maxlactate%>">                
                                    <input type="hidden" name="sepLacHigh" id="sepLacHigh" value="<%=lactateHigh%>">
                                    <br/><span style = "color: #858384; font-weight: bold;"> 
                                    Determined by the Rule: On current encounter, 2 or more of the following are present<br/><br/></span>
                                    <ul>
                                        <li>Temperature >= 38.88</li>
                                        <li>Temperature < 36</li>
                                        <li>HR < 40 or > 100</li>
                                        <li>RR >= 26</li>
                                        <li>Serum WBC (>12,000 or < 4,000 or 10% bands on the differential)</li>
                                        <li>Systolic BP <= 90</li>
                                        <li>Lactate Value > Acceptable normal high</li>
                                        <li>Urine output in the last 8 hours <= 240cc</li>
                                        <li>Positive blood culture </li>
                                    </ul>
                                     
                    </div>
                </div>
                <a id="imageSepsis" onmouseover="makeDivVisible('Sepsis')" 
                onmouseout="makeDivHidden('Sepsis')" style="visibility: hidden;">
                <img src="images/button1.jpg" alt="Details"/></a> 
            </td>
        </tr>
    <%}%>
        
    
    </table>    
    </div>    
    
    <%System.out.println("All calculations done"); %>
    
 <!-- ************* OTHER CO-MORBS *****************************************************************  -->
    <p class="test" onclick="otherCoMorb();">Other CoMorbidities/Clinical Conditions&nbsp;&nbsp;
    <img id="arrow-bottom" border="0" src="images/arrow-down.gif" alt="Other CoMorbidities"/>
    </p>
        
    <div id="hidden" class="borderMain" style="display: none;">
    <br/><br/>    
    
        <table id="table" border = "0">
            
            <!--******************** Acute Pulmonary Edema***************************  -->
        <tr>
            <td><% 
             for(String s:disableCoMorb){
        	if(s.equals("Acute Pulmonary Edema")){ %>
        	<input id="ipApe" type="checkbox" checked disabled name="otherGrp" value="Acute Pulmonary Edema" >Acute Pulmonary Edema<br/><br/>	
       <% }else{%>
            <input id="ipApe" type="checkbox" name="otherGrp" value="Acute Pulmonary Edema" >Acute Pulmonary Edema<br/><br/>
            <%}} %>
            </td>
        </tr>
        <tr></tr>
            
            
        <tr>
            <!-- *********** Anoxic Brain Injury**************************** -->
            <td><% 
             for(String s:disableCoMorb){
        	if(s.equals("Anoxic Brain Injury")){ %>
        		<input id="ipAbi" type="checkbox" checked disabled name="otherGrp" value="Anoxic Brain Injury" >Anoxic Brain Injury<br/><br/>
       <% }else{%>
            <input id="ipAbi" type="checkbox" name="otherGrp" value="Anoxic Brain Injury" >Anoxic Brain Injury<br/><br/>
            <%}} %>
            
            
            </td>
        </tr>
        <tr></tr>            
    
            <!--*************** Coma ************************** -->
        <tr >
            <td id="ComaCol1">
            <input id="ipComa" type="checkbox" name="otherGrp" value="Coma" > Coma
            <br/><br/>    
            </td>
        </tr>
        <tr></tr>
            
            
            
        <!-- ***************** Decubitis Ulcer *************************** -->
        <tr>
            <td>
            <input id="ipDu" type="checkbox" name="otherGrp" value="Decubitis Ulcer" onclick="otherForm('du','ipDu');"> Decubitis Ulcer<br/><br/>
            <div id="du" style="display: none;">
                <table border="0" style="margin-top: -140px; margin-bottom: 40px; margin-left: 60px;" cellpadding="5px">
                    <tr onmouseover="mouseOverPara('imageUlcer1','stage1')" 
                        onmouseout="mouseOutPara('imageUlcer1','stage1')">
                        <br>
                    <td id="stage1"><input id="ipDu1" type="checkbox" name="duChkgrp" value="Stage 1"  > Stage 1</td>
                    <td>
                    <!-- -  --><div id="stage1div" class="imageBackSingle" style="width:300px; height:160px; margin-top:-10px; "><img src="images/divSingle.png" width="100%"; height="100%"/>
                    <div id="stage1div" class="dynamicDiv" style="width:225px; height:125px; margin-top: -145px">
                        <p>Stage 1: </p>
                        <p>Pressure Pre-Ulcer skin changes limited to persistent focal erythema</p>
                    </div>
                    </div>
                    <a id="imageUlcer1" onmouseover="makeDivVisible('stage1div')" 
                    onmouseout="makeDivHidden('stage1div')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                    </td><br/><br/>
                    </tr>
                    
                    <tr onmouseover="mouseOverPara('imageUlcer2','stage2')" 
                        onmouseout="mouseOutPara('imageUlcer2','stage2')">
                    <td id="stage2"><input id="ipDu2" type="checkbox" name="duChkgrp" value="Stage 2" > Stage 2</td>
                    <td>
                    <div id="stage2div" class="imageBackSingle" style="width:300px; height:160px; margin-top:-10px; "><img src="images/divSingle.png" width="100%"; height="100%"/>
                    <div id="stage2div" class="dynamicDiv" style="width:220px; height:125px; margin-top: -145px">
                        <p>Stage 2: </p>
                        <p>Pressure ulcer with abrasion, blister, partial thickness skin loss involving epidermis and/or dermis</p>
                    </div>
                    </div>
                    <a id="imageUlcer2" onmouseover="makeDivVisible('stage2div')" 
                    onmouseout="makeDivHidden('stage2div')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                    </td><br/><br/>
                    </tr>
                    
                    <tr onmouseover="mouseOverPara('imageUlcer3','stage3')" 
                        onmouseout="mouseOutPara('imageUlcer3','stage3')">
                    <td id="stage3"><input id="ipDu3" type="checkbox" name="duChkgrp" value="Stage 3" > Stage 3</td>
                    <td>
                    <div id="stage3div" class="imageBackSingle" style="width:300px; height:160px; margin-top:-10px; "><img src="images/divSingle.png" width="100%"; height="100%"/>
                    <div id="stage3div" class="dynamicDiv" style="width:220px; height:125px; margin-top: -145px">
                        <p>Stage 3: </p>
                        <p>Pressure ulcer with partial thickness skin loss involving damage or necrosis of subcutaneous tissue</p>
                    </div>
                    </div>
                    <a id="imageUlcer3" onmouseover="makeDivVisible('stage3div')" 
                    onmouseout="makeDivHidden('stage3div')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                    </td><br/><br/>
                    </tr>
                    
                    <tr onmouseover="mouseOverPara('imageUlcer4','stage4')" 
                        onmouseout="mouseOutPara('imageUlcer4','stage4')">
                    <td id="stage4"><input id="ipDu4" type="checkbox" name="duChkgrp" value="Stage 4" > Stage 4</td>
                    <td>
                    <div id="stage4div" class="imageBackSingle" style="width:300px; height:160px; margin-top:-10px; "><img src="images/divSingle.png" width="100%"; height="100%"/>
                    <div id="stage4div" class="dynamicDiv" style="width:220px; height:125px; margin-top: -145px">
                        <p>Stage 4: </p>
                        <p>Pressure ulcer with necrosis of soft tissue through to underlying muscle, tendon, or bone</p>
                    </div>
                    </div>
                    <a id="imageUlcer4" onmouseover="makeDivVisible('stage4div')" 
                    onmouseout="makeDivHidden('stage4div')" style="visibility: hidden;">
                    <img src="images/button1.jpg" alt="Details"/></a> 
                    </td><br/>
                    </tr>
                    
                    <tr>
                    <td><input id="ipDu5" type="checkbox" name="duChkgrp" value="Unstageable" > Unstageable</td>
                    </tr>
                    
                    <tr>
                    <td><input id="ipDu6" type="checkbox" name="duChkgrp" value="Unspecified" > Unspecified Stage</td>
                    </tr>
                    
                    <tr>
                    <td>Site:&nbsp;&nbsp;
                    <input type="Text" id="ipDuSite" name="ipDuSite" size="10"/></td>
                    </tr>
                
                </table>
            </div>    
            </td>
        </tr>
        <tr></tr>
            
            
            
            <!-- ***************** Delirium due to********************* -->
        <tr>
            <td>
            <input id="ipDelirium" type="checkbox" name="otherGrp" value="Delirium" onclick="otherForm('delirium','ipDelirium');"> Delirium<br/><br/>
            </td>
        </tr>
        <tr>
            <td> 
            <div id="delirium" style="display: none; margin-left: 60px;">
                
                
                <input id="ipDelirium1" type="checkbox" name="delichkgrp" value="Infection" > Infection<br/><br/>
                
                
                <input id="ipDelirium2" type="checkbox" name="delichkgrp" value="Drugs or toxin" > Drugs or toxin<br/><br/>
                
                 
                <input id="ipDelirium3" type="checkbox" name="delichkgrp" value="Metabolic Effect" > Metabolic Effect<br/><br/>
                
                
                <input id="None of the Above" type="checkbox" name="delichkgrp" value="None of the Above" > None of the Above<br/><br/>
            </div>
        </tr>

            
            
                    <!--********* Encephalopathy********** -->
                    <tr>
                        <td><input id="ipEncephalopathy"
                            type="checkbox" name="otherGrp" value="Encephalopathy"
                            onclick="otherForm('encephalopathy','ipEncephalopathy');">
                            Encephalopathy<br /> <br /></td>
                    </tr>
                    <tr>

                        <td>
                            <div id="encephalopathy"
                                style="display: none; margin-left: 60px;">


                                <input id="ipencephalopathy1" type="checkbox" name="encchkGrp"
                                    value="Metabolic Encephalopathy"> Metabolic
                                Encephalopathy<br /> <br /> <input id="ipencephalopathy2"
                                    type="checkbox" name="encchkGrp" value="Hepatic Encephalopathy">
                                Hepatic Encephalopathy<br /> <br /> <input
                                    id="ipencephalopathy3" type="checkbox" name="encchkGrp"
                                    value="Septic Encephalopathy"> Septic Encephalopathy<br />
                                <br /> <input id="ipencephalopathy4" type="checkbox"
                                    name="encchkGrp" value="Toxic Encephalopathy"> Toxic
                                Encephalopathy<br /> <br /> <input id="ipencephalopathy5"
                                    type="checkbox" name="encchkGrp"
                                    value="Hypertensive Encephalopathy"> Hypertensive
                                Encephalopathy<br /> <br /> <input id="ipencephalopathy6"
                                    type="checkbox" name="encchkGrp" value=" Anoxic Encephalopathy">
                                Anoxic Encephalopathy<br /> <br /> <input
                                    id="ipencephalopathy7" type="checkbox" name="encchkGrp"
                                    value="Alcoholic Encephalopathy"> Alcoholic
                                Encephalopathy<br /> <br /> <input id="ipencephalopathy8"
                                    type="checkbox" name="encchkGrp"
                                    value="Other (Please Specify):"> None<br /> <br />


                            </div>
                    </tr>


            
                    
            <!--************ Pleural Effusion************-->
        <tr>
            <td>
            <input id="ipPlueff" type="checkbox" name="otherGrp" value="Pleural Effusion" > Pleural Effusion<br/><br/>
            
            </td>
        </tr>    
        <tr></tr>        
            
            
            
            <!-- **************** Pneumonia*************** -->
        <tr>
            <td>
            <input id="ipPneumonia" type="checkbox" name="otherGrp" value="Pneumonia" onclick="otherForm('pneumonia','ipPneumonia');">  Pneumonia<br/><br/>
            </td>
        </tr>
        <tr>
            <td>
            <div id="pneumonia" style="display: none; margin-left: 60px;">
                
                
                <input id="ipPneumonia1" type="checkbox" name="pneuchkgrp" value="Pseudomonal Risk" > Pseudomonal Risk<br/><br/>
                
                
                <input id="ipPneumonia2" type="checkbox" name="pneuchkgrp" value="MRSA" > MRSA<br/><br/>
                
                 
                <input id="ipPneumonia3" type="checkbox" name="pneuchkgrp" value="Possible gram negative" > Possible gram negative<br/><br/>
                
                 
                <input id="ipPneumonia4" type="checkbox" name="pneuchkgrp" value="Possible Aspiration" > Possible Aspiration<br/><br/>
                
                
                <input id="None of the Above" type="checkbox" name="pneuchkgrp" value="None of the Above" > None of the Above<br/><br/>
            </div>
            </td>
        </tr>            
            
            <!--********* PSVT ******* -->
        <tr>
            <td>
            <input id="ipPsvt" type="checkbox" name="otherGrp" value="PSVT" >PSVT<br/><br/>
            
            </td>
        </tr>
        <tr></tr>
            
            <!-- *************** Seizure type************** -->
        <tr>
            <td>
            <input id="ipSeizure" type="checkbox" name="otherGrp" value="Seizure" >Seizure<br/><br/>
            </td>
        </tr>
        <tr></tr>
        
        <!-- *************** Sepsis Other ************** -->
        <tr>
            <td>
                <input id="ipSepsisOther" type="checkbox" name="otherGrp" value="SepsisOther" >Sepsis for reasons listed below<br/><br/>
                <textarea id="sepsisOtherComments" name="sepsisOtherComments" cols="40" rows="5"></textarea><br/><br/>
            </td>
        </tr>
        <tr></tr>
        
        <!-- *************** Other ************** -->
        <tr>
            <td>
                <input id="comments" type="checkbox" name="otherGrp" value="comments" >Other Non - Listed CoMorbidities:<br/><br/>
                <font size="2">Note: Please separate each comorbidity with a comma</font> <br/><br/>
                <textarea id="commentsid" name="commentsid" cols="40" rows="5" ></textarea><br/><br/>
                <!-- <textarea id="commentsid" name="commentsid" cols="40" rows="5"></textarea><br/><br/> -->
                <!-- <textarea id="commentsid" name="commentsid" cols="40" rows="5" onkeypress="onTestChange();"></textarea><br/><br/>-->
            </td>
        </tr>
        
        <!-- *************** Timer ************** -->
        <!--   <input name="timer" id="timer" > -->
        <input name="clock" id="clock" type="text" value="00:00" style="float:right;text-align:center;background-color:white;border:1px solid gray;font-weight:bold;font-size:14pt;" readonly><br>
 </table>
</div>    
</form>
</div>
</body>
</html>
