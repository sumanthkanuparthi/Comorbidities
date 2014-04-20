package comorb;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PdfTest
 */
@WebServlet("/PdfTest")
public class PdfTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PdfTest() 
    {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		final PrintWriter out = response.getWriter();
		for(int i=0; i<100000; i++)
			out.println(i+"; <font color=\"blue\">Hello World,</font> time = "+new Date()+"<br>");
    }
}
