package comorb;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;

public class WriteHelper {
	private static final long maxLinesInPage = 50;
	
	final private Document doc_;
	final private Image image_;
	
	public int currentLine = 0;
	
	public WriteHelper(Document doc, Image image)
	{
		doc_ = doc;
		image_ = image;
	}
	
	public void setPageTemplate() throws DocumentException{
		 
		if(currentLine >= maxLinesInPage){
			Font font = FontFactory.getFont("Times-Roman",14, Font.BOLD);
			PdfPTable table = new PdfPTable(1);
			PdfPCell cell = new PdfPCell();

			Paragraph paragraph = new Paragraph("\n");
			cell = new PdfPCell(paragraph);
			cell.setBorderWidthBottom(0);
			cell.setBorderWidthRight(0);
			cell.setBorderWidthLeft(0);
			table.addCell(cell);
			table.setWidthPercentage(100);
			doc_.add(table);

			doc_.newPage();
			doc_.add(image_);
			doc_.add(new Paragraph("\n"));
			
			paragraph = new Paragraph("  CO-MORBIDITIES",font);
			doc_.add(paragraph);

			doc_.add(new Paragraph("\n"));
			doc_.add(table);
			
        	currentLine = 0;			
		}
	}

	private Paragraph paragraph = null; 
	
	public void currentLineInc() {
		currentLine++;
	}
	
	public void cancelParagraph()
	{
		paragraph = null;
	}
	
	public void beginParagraph()
	{
		if(paragraph!=null)
			throw new RuntimeException("call beginParagraph() before closing previous paragraph");
		paragraph = new Paragraph();
	}
	
	public void outLine(String text, Font font)
	{
		paragraph.add(new Chunk(text, font));
		currentLineInc();
	}
	
	public void endParagraph() throws DocumentException
	{
		setPageTemplate();
		//setPageTemplate();
		doc_.add(paragraph);
		paragraph = null;
	}
}