package comorb;

import javax.servlet.http.HttpServletRequest;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;

import comorb.PrintInterface.ComorbiditiesFunctor;

public class Comments implements ComorbiditiesFunctor {
	private final String spacesLevelThree_;
	private final Font font_;
	private final Font subFont_;
	private final Font errorFont_;
	private final Font fontSubHead_;
	
	/*
	 * Constructor to initialize variables
	 */
	Comments(Font font, Font subFont, Font errorFont, String spacesLevelThree,Font fontSubHead)
	{
		font_ = font;
		subFont_ = subFont;
		spacesLevelThree_ = spacesLevelThree;
		errorFont_ = errorFont;
		fontSubHead_=fontSubHead;
	}
	
	/*
	 * This simply returns the name of the class/comorbidity
	 */
	@Override
	public String getName() {
		return "comments";
	}
	
	/*
	 *This function writes to the pdf
	 */
	@Override
	public String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException {
		
		String temp="print";
		if(flag==0)
		{
		writer.beginParagraph();			
		writer.outLine("     \u2022  " + "Other Comorbidities: " + "\n",font_);
		}
		
		String comments    = null;
		String newcomments = null;
		
		comments = request.getParameter("commentsid");
		
		if(comments == null){
			if(flag==0)
			writer.outLine("     \u2022  Null values returned for Other Comorbidities \n",errorFont_);
		}
		else{
			newcomments = comments.replace(",", "\r                       ");
			if(flag==0)
			{
			writer.outLine("                      " + newcomments + "\n" ,fontSubHead_);	
			writer.currentLineInc();
			writer.currentLineInc();
			}
		}
		if(flag==0)
		writer.endParagraph();
		
	return temp;
	}

}
