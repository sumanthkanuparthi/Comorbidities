package comorb;

import javax.servlet.http.HttpServletRequest;

import com.itextpdf.text.DocumentException;

public class PrintInterface {
	
	/*
	 * This interface is used to create objects of comorbidities' class, which in turn implement
	 * the functions of this interface.
	 */
	interface ComorbiditiesFunctor
	{
		String getName();
		String writeToDocument(HttpServletRequest request, WriteHelper writer,int flag) throws DocumentException;
	}

}
