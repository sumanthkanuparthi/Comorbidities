/**
 * 
 */

function printPage() 
{
		try
		{
			var doc = document.getElementById('mainPageID').contentWindow.document;
			
	        var checkboxes 		= doc.getElementsByName('mainGrp');
	        var anemiaChkGrp 	= doc.getElementsByName('anemiaChkGrp');
	        var ckdChkGrp 		= doc.getElementsByName('ckdChkGrp');
	        var EaChkGrp 		= doc.getElementsByName('EaChkGrp');
	        var respFailChkGrp 	= doc.getElementsByName('respFailChkGrp');
	        var duChkgrp 		= doc.getElementsByName('duChkgrp');
	        var delichkgrp 		= doc.getElementsByName('delichkgrp');
	        var pneuchkgrp 		= doc.getElementsByName('pneuchkgrp');
	        var akdChkGrp 		= doc.getElementsByName('akdChkGrp');
	        var htChkGrp 		= doc.getElementsByName('htChkGrp');
	      
	        //var comments = doc.getElementById('commentsid');
	        
	        function CheckGroup(group, prev)
	        {
	        	if(group.length==0)
	        		return prev;
	        	
	        	for(var i=0; i<group.length; i++)
	        		if(group[i].checked)
	        			return false;
	        	
	        	return true;
	        }
	        
	        function CheckGroup2(group, s, maingrp, prev)
	        {
	        	for (var i=0; i<group.length; i++)
	            	if(group[i].checked)
	            	{
	            		 for (var j=0; j < maingrp.length; j++)
	            		 {
	            			 if(maingrp[j].value == s)
	            			 {
	            				 if(!maingrp[j].checked)
	            					 prev = true;
	            				 break;
	            			 }
	            		 }
	            	}
	        	return prev;
	        }
	        
	        var flag = false;
	             
	        for (var i = 0; i < checkboxes.length; i++)
	        	if(checkboxes[i].checked)
	        	{
	        		if(checkboxes[i].value == 'Anemia :')		// if group is not empty, and has at least one selected item, return false. otherwise return true.
	        			flag = CheckGroup(anemiaChkGrp, flag);
	        		if(checkboxes[i].value == 'Chronic Kidney Disease')
	        			flag = CheckGroup(ckdChkGrp, flag);
	        		if(checkboxes[i].value == 'Electrolyte Abnormality')
	        			flag = CheckGroup(EaChkGrp, flag);
	        		if(checkboxes[i].value == 'Respiratory Failure :')
	        			flag = CheckGroup(respFailChkGrp, flag);
	        		if(checkboxes[i].value == 'Decubitis Ulcer')
	        			flag = CheckGroup(duChkgrp, flag);
	        		if(checkboxes[i].value == 'Delirium')
	        			flag = CheckGroup(delichkgrp, flag);
	        		if(checkboxes[i].value == 'Pneumonia')
	        			flag = CheckGroup(pneuchkgrp, flag);
	        		if(checkboxes[i].value == 'Acute Kidney Injury: NOS')
	        			flag = CheckGroup(akdChkGrp, flag);
	        		if(checkboxes[i].value == 'Hypertension')
	        			flag = CheckGroup(htChkGrp, flag);
	        	}
	
	        flag = CheckGroup2(anemiaChkGrp, 	'Anemia :', checkboxes, flag);
	        flag = CheckGroup2(ckdChkGrp, 		'Chronic Kidney Disease', checkboxes, flag);
	        flag = CheckGroup2(EaChkGrp, 		'Electrolyte Abnormality', checkboxes, flag);
	        flag = CheckGroup2(respFailChkGrp, 	'Respiratory Failure :', checkboxes, flag);
	        flag = CheckGroup2(duChkgrp, 		'Decubitis Ulcer', checkboxes, flag);
	        flag = CheckGroup2(delichkgrp, 		'Delirium', checkboxes, flag);
	        flag = CheckGroup2(pneuchkgrp, 		'Pneumonia', checkboxes, flag);
	        flag = CheckGroup2(akdChkGrp, 		'Acute Kidney Injury: NOS', checkboxes, flag);
	
	        if(flag)
	        	alert('Please select a CoMorbidity as well as it\'s Subtype.');
	        else
	        {
	        	var anotherFlag = false;
	        	for (var i=0; i<checkboxes.length; i++)
	        		if(checkboxes[i].checked)
	        		{
	        			anotherFlag = true;
	        			break;
	        		}

	        	if(anotherFlag)
	        		{
	        		 
	        		
	        		SetCookie("print","print",1);
	        		//alert(document.getElementById("printer").value);
	        		mainPage.document.forms.form1.submit();
	        		}
	        	else
	        		alert('Please select atleast one CoMorbidity.');
	        }
	       
		}
		catch(ex)
		{
			alert(ex.message);
		}
	}
function SetCookie(cookieName,cookieValue,nDays) {
	 var today = new Date();
	 var expire = new Date();
	 if (nDays==null || nDays==0) nDays=1;
	 expire.setTime(today.getTime() + 3600000*24*nDays);
	 document.cookie = cookieName+"="+escape(cookieValue)
	                 + ";expires="+expire.toGMTString();
	}



function commitPage() 
{
		try
		{
			var doc = document.getElementById('mainPageID').contentWindow.document;
			
	        var checkboxes 		= doc.getElementsByName('mainGrp');
	       // var otherBoxes 		= doc.getElementsByName('otherGrp');
	        
	        
	        var anemiaChkGrp 	= doc.getElementsByName('anemiaChkGrp');
	        var ckdChkGrp 		= doc.getElementsByName('ckdChkGrp');
	        var EaChkGrp 		= doc.getElementsByName('EaChkGrp');
	        var respFailChkGrp 	= doc.getElementsByName('respFailChkGrp');
	        var duChkgrp 		= doc.getElementsByName('duChkgrp');
	        var delichkgrp 		= doc.getElementsByName('delichkgrp');
	        var pneuchkgrp 		= doc.getElementsByName('pneuchkgrp');
	        var akdChkGrp 		= doc.getElementsByName('akdChkGrp');
	        var htChkGrp 		= doc.getElementsByName('htChkGrp');
	        //var comments = doc.getElementById('commentsid');
	        
	        function CheckGroup(group, prev)
	        {
	        	if(group.length==0)
	        		return prev;
	        	
	        	for(var i=0; i<group.length; i++)
	        		if(group[i].checked)
	        			return false;
	        	
	        	return true;
	        }
	        
	        function CheckGroup2(group, s, maingrp, prev)
	        {
	        	for (var i=0; i<group.length; i++)
	            	if(group[i].checked)
	            	{
	            		 for (var j=0; j < maingrp.length; j++)
	            		 {
	            			 if(maingrp[j].value == s)
	            			 {
	            				 if(!maingrp[j].checked)
	            					 prev = true;
	            				 break;
	            			 }
	            		 }
	            	}
	        	return prev;
	        }
	        
	        var flag = false;
	             
	        for (var i = 0; i < checkboxes.length; i++)
	        	if(checkboxes[i].checked)
	        	{
	        		if(checkboxes[i].value == 'Anemia :')		// if group is not empty, and has at least one selected item, return false. otherwise return true.
	        			flag = CheckGroup(anemiaChkGrp, flag);
	        		if(checkboxes[i].value == 'Chronic Kidney Disease')
	        			flag = CheckGroup(ckdChkGrp, flag);
	        		if(checkboxes[i].value == 'Electrolyte Abnormality')
	        			flag = CheckGroup(EaChkGrp, flag);
	        		if(checkboxes[i].value == 'Respiratory Failure :')
	        			flag = CheckGroup(respFailChkGrp, flag);
	        		if(checkboxes[i].value == 'Decubitis Ulcer')
	        			flag = CheckGroup(duChkgrp, flag);
	        		if(checkboxes[i].value == 'Delirium')
	        			flag = CheckGroup(delichkgrp, flag);
	        		if(checkboxes[i].value == 'Pneumonia')
	        			flag = CheckGroup(pneuchkgrp, flag);
	        		if(checkboxes[i].value == 'Acute Kidney Injury: NOS')
	        			flag = CheckGroup(akdChkGrp, flag);
	        		if(checkboxes[i].value == 'Hypertension')
	        			flag = CheckGroup(htChkGrp, flag);
	        	}
	
	        flag = CheckGroup2(anemiaChkGrp, 	'Anemia :', checkboxes, flag);
	        flag = CheckGroup2(ckdChkGrp, 		'Chronic Kidney Disease', checkboxes, flag);
	        flag = CheckGroup2(EaChkGrp, 		'Electrolyte Abnormality', checkboxes, flag);
	        flag = CheckGroup2(respFailChkGrp, 	'Respiratory Failure :', checkboxes, flag);
	        flag = CheckGroup2(duChkgrp, 		'Decubitis Ulcer', checkboxes, flag);
	        flag = CheckGroup2(delichkgrp, 		'Delirium', checkboxes, flag);
	        flag = CheckGroup2(pneuchkgrp, 		'Pneumonia', checkboxes, flag);
	        flag = CheckGroup2(akdChkGrp, 		'Acute Kidney Injury: NOS', checkboxes, flag);
	
	        if(flag)
	        	alert('Please select a CoMorbidity as well as it\'s Subtype.');
	        else
	        {
	        	var anotherFlag = false;
	        	for (var i=0; i<checkboxes.length; i++)
	        		if(checkboxes[i].checked)
	        		{
	        			anotherFlag = true;
	        			break;
	        		}
	        	/*for (var i=0; i<otherBoxes.length; i++)
	        		if(otherBoxes[i].checked)
	        		{
	        			anotherFlag = true;
	        			break;
	        		}*/


	        	if(anotherFlag)
	        		{
	        		 
	        		
	        		SetCookie("print","commit",1);
	        		//alert(document.getElementById("printer").value);
	        		mainPage.document.forms.form1.submit();
	        		}
	        	else
	        		alert('Please select atleast one CoMorbidity.');
	        }
	       
		}
		catch(ex)
		{
			alert(ex.message);
		}
	}