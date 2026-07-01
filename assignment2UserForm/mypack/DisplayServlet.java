package mypack;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/DisplayServlet")
public class DisplayServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email"); // Retrieve email from request [cite: 121]
        SurveyBean bean = new SurveyBean();
        
        if (bean.retrieveSurvey(email)) { // Fetch saved data [cite: 122]
            request.setAttribute("surveyData", bean); // Store in request scope [cite: 123]
            RequestDispatcher rd = request.getRequestDispatcher("display.jsp"); // Forward to display.jsp [cite: 124]
            rd.forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}