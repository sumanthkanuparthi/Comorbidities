/**
 * 
 */

var flagclock = 0;
	var flagstop = 1;
	var stoptime = 0;
	var currenttime;
	var splitdate = '';
	var output;
	var clock;

	function startstop()
		{
		var startdate = new Date();
		var starttime = startdate.getTime();
		if(flagclock==0)
			{
			flagclock = 1;
			counter(starttime);
			}
		else
			{
			flagclock = 0;
			flagstop = 1;
			splitdate = '';
			}
		}

	function counter(starttime)
		{
		output = document.getElementById('output');
		clock = document.getElementById('clock');
		currenttime = new Date();
		var timediff = currenttime.getTime() - starttime;
		if(flagstop == 1)
			{
			timediff = timediff + stoptime
			}
		if(flagclock == 1)
			{
			clock.value = formattime(timediff,'');
			refresh = setTimeout('counter(' + starttime + ');',10);
			}
		else
			{
			window.clearTimeout(refresh);
			stoptime = timediff;
			}
		}

	function formattime(rawtime,roundtype)
		{
		if(roundtype == 'round')
			{
			var ds = Math.round(rawtime/100) + '';
			}
		else
			{
			var ds = Math.floor(rawtime/100) + '';		
			}
		var sec = Math.floor(rawtime/1000);
		var min = Math.floor(rawtime/60000);
		ds = ds.charAt(ds.length - 1);
		if(min >= 60)
			{
			startstop();
			}
		sec = sec - 60 * min + '';
		if(sec.charAt(sec.length - 2) != '')
			{
			sec = sec.charAt(sec.length - 2) + sec.charAt(sec.length - 1);
			}
		else
			{
			sec = 0 + sec.charAt(sec.length - 1);
			}	
		min = min + '';
		if(min.charAt(min.length - 2) != '')
			{
			min = min.charAt(min.length - 2)+min.charAt(min.length - 1);
			}
		else
			{
			min = 0 + min.charAt(min.length - 1);
			}
		return min + ':' + sec;
		}


	function checkMain(checkBoxMain){
		
		if(checkBoxMain == "anemia"){
			var i = 0,j = 0;
			for (i = 0; i < document.getElementsByName("anemiaChkGrp").length; i++){
				if(document.getElementsByName("anemiaChkGrp")[i].checked){
						j = 1;		
					}
			}
		   if(j == 1){
				
				document.getElementById(checkBoxMain).checked = true;
				
				}
			else{
				
				document.getElementById(checkBoxMain).checked = false;
				
				}
			} 
		
		
		if(checkBoxMain == "UrinTI"){
			var i = 0,j = 0;
			for (i = 0; i < document.getElementsByName("catheterAssoc").length; i++){
				if(document.getElementsByName("catheterAssoc")[i].checked){
						j = 1;		
					}
			}
			
		   if(j == 1){
				
				document.getElementById(checkBoxMain).checked = true;
				
				}
			else{
				
				document.getElementById(checkBoxMain).checked = false;
				
				}
		}
		
		
		if(checkBoxMain == "Ea"){
			var i = 0,j = 0;
			for (i = 0; i < document.getElementsByName("EaChkGrp").length; i++){
				if(document.getElementsByName("EaChkGrp")[i].checked){
						j = 1;		
					}
			}
		   if(j == 1){
				
				document.getElementById(checkBoxMain).checked = true;
				
				}
			else{
				
				document.getElementById(checkBoxMain).checked = false;
				
				}
			}
			
		if(checkBoxMain == "ckd"){
			var i = 0,j = 0;
			for (i = 0; i < document.getElementsByName("ckdChkGrp").length; i++){
				if(document.getElementsByName("ckdChkGrp")[i].checked){
						j = 1;		
					}
			}
		   if(j == 1){
				
				document.getElementById(checkBoxMain).checked = true;
				
				}
			else{
				
				document.getElementById(checkBoxMain).checked = false;
				
				}
			}
		if(checkBoxMain == "aki"){
			var i = 0,j = 0;
			for (i = 0; i < document.getElementsByName("akiChkGrp").length; i++){
				if(document.getElementsByName("akiChkGrp")[i].checked){
						j = 1;		
					}
			}
		   if(j == 1){
				
				document.getElementById(checkBoxMain).checked = true;
				
				}
			else{
				
				document.getElementById(checkBoxMain).checked = false;
				
				}
			}
		if(checkBoxMain == "ht"){
			var i = 0,j = 0;
			for (i = 0; i < document.getElementsByName("htChkGrp").length; i++){
				if(document.getElementsByName("htChkGrp")[i].checked){
						j = 1;		
					}
			}
		   if(j == 1){
				
				document.getElementById(checkBoxMain).checked = true;
				
				}
			else{
				
				document.getElementById(checkBoxMain).checked = false;
				
				}
			}
		if(checkBoxMain == "Ebg"){
			var i = 0,j = 0;
			for (i = 0; i < document.getElementsByName("EbgChkGrp").length; i++){
				if(document.getElementsByName("EbgChkGrp")[i].checked){
						j = 1;		
					}
			}
		   if(j == 1){
				
				document.getElementById(checkBoxMain).checked = true;
				
				}
			else{
				
				document.getElementById(checkBoxMain).checked = false;
				
				}
			}
		if(checkBoxMain == "respFail"){
			
			var i = 0,j = 0;
			for (i = 0; i < document.getElementsByName("respFailChkGrp").length; i++){
				if(document.getElementsByName("respFailChkGrp")[i].checked){
						j = 1;		
					}
			}
		   if(j == 1){
				
				document.getElementById(checkBoxMain).checked = true;
				
				}
			else{
				
				document.getElementById(checkBoxMain).checked = false;
				
				}
			}
		
		if(checkBoxMain == "shock"){
			var i = 0,j = 0;
			for (i = 0; i < document.getElementsByName("shockChkGrp").length; i++){
				if(document.getElementsByName("shockChkGrp")[i].checked){
						j = 1;		
					}
			}
		   if(j == 1){
				
				document.getElementById(checkBoxMain).checked = true;
				
				}
			else{
				
				document.getElementById(checkBoxMain).checked = false;
				
				}
			}	
		
		if(checkBoxMain == "cshock"){
			var i = 0,j = 0;
			for (i = 0; i < document.getElementsByName("cshockChkGrp").length; i++){
				if(document.getElementsByName("cshockChkGrp")[i].checked){
						j = 1;		
					}
			}
		   if(j == 1){
				
				document.getElementById(checkBoxMain).checked = true;
				
				}
			else{
				
				document.getElementById(checkBoxMain).checked = false;
				
				}
			}	
	}
	
	function unCheck(checkBoxMain,subGrp){
		
		if(document.getElementById(checkBoxMain).checked == false){
			var i = 0;
			for (i = 0; i < document.getElementsByName(subGrp).length; i++){
				document.getElementsByName(subGrp)[i].checked = false;
			}
		}
		
		
	}
	
	/*function onTestChange() {
	    var key = window.event.keyCode;

	    // If the user has pressed enter
	    if (key == 13) {
	    
	    	var comments = document.getElementById('commentsid');
	        
	        var text = comments.value;
			text = text.replace(/\n\r?/g, ',');
			
			var newTextbox = document.getElementsByName('commentsid')[0];
            newTextbox.value = text; 
	        //document.getElementById("commentsid").value =document.getElementById("commentsid").value + "\n";
	        //return false;
	    }
	    //else {
	      //  return true;
	    //}
	}*/

	
	
	
	function otherForm(comorbId,input){
		
		if(document.getElementById(input).checked == 1){
			
			document.getElementById(comorbId).style.display = "block";
			}
		else{
		
			document.getElementById(comorbId).style.display = "none";
		}
	}
	function computedCoMorb()
	{	
		if(document.getElementById("computedCoMorb").style.display == "none")
		{
			document.getElementById("computedCoMorb").style.display = "block";
			document.getElementById("arrow-computed").src = "images/arrow-up.gif";
		}
		else
		{
			document.getElementById("computedCoMorb").style.display = "none";
			document.getElementById("arrow-computed").src = "images/arrow-down.gif";
		}
	}
function prevComputedCoMorb(){
		
		if(document.getElementById("prevComputedCoMorb").style.display == "none"){
			document.getElementById("prevComputedCoMorb").style.display = "block";
			document.getElementById("arrow-top").src = "images/arrow-up.gif";
			}
		else{
			document.getElementById("prevComputedCoMorb").style.display = "none";
			document.getElementById("arrow-top").src = "images/arrow-down.gif";
		}
	}
function prevComputedCoMorb1(){
	
	if(document.getElementById("ComputedCoMorb1").style.display == "none"){
		document.getElementById("ComputedCoMorb1").style.display = "block";
		document.getElementById("lbComputed").innerHTML = "- Computed comorbidities"
		}
	else{
		document.getElementById("ComputedCoMorb1").style.display = "none";
		document.getElementById("lbComputed").innerHTML = "+ Computed comorbidities"
	}
}
function prevComputedCoMorb2(){
	
	if(document.getElementById("ManualCoMorb").style.display == "none"){
		document.getElementById("ManualCoMorb").style.display = "block";
		document.getElementById("lbManual").innerHTML = "- other comorbidities"
		}
	else{
		document.getElementById("ManualCoMorb").style.display = "none";
		document.getElementById("lbManual").innerHTML = "+ other comorbidities"
	}
}
	function otherCoMorb(){
		
		if(document.getElementById("hidden").style.display == "none"){
			document.getElementById("hidden").style.display = "block";
			document.getElementById("arrow-bottom").src = "images/arrow-up.gif";
			}
		else{
			document.getElementById("hidden").style.display = "none";
			document.getElementById("arrow-bottom").src = "images/arrow-down.gif";
		}
	}
	
	function mouseOverPara(imageID,col1){

		document.getElementById(imageID).style.visibility = "visible";
		document.getElementById(col1).style.background = "#DEDFFA";
	}
	
	function mouseOutPara(imageID,col1){
		
		document.getElementById(imageID).style.visibility = "hidden";
		document.getElementById(col1).style.background = "white";
	}
	
	function makeDivVisible(divId){
		document.getElementById(divId).style.display = "block";
	}
	
	function makeDivHidden(divId){
		
		document.getElementById(divId).style.display = "none"; 
		
	}
