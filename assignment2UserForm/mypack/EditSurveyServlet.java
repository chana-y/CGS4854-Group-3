package mypack;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/EditSurveyServlet")
public class EditSurveyServlet extends HttpServlet {
    // Loads existing data [cite: 114]
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        SurveyBean bean = new SurveyBean();
        
        if (bean.retrieveSurvey(email)) {
            request.setAttribute("surveyData", bean);
            RequestDispatcher rd = request.getRequestDispatcher("editSurvey.jsp"); // Forward to edit form [cite: 115]
            rd.forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    // Handles form submission [cite: 116]
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SurveyBean bean = new SurveyBean();
        bean.setEmail(request.getParameter("email")); // Email acts as identifier
        bean.setFullName(request.getParameter("fullName"));
        bean.setPhone(request.getParameter("phone"));
        bean.setGender(request.getParameter("gender"));
        bean.setQualification(request.getParameter("qualification"));
        bean.setEmployment(request.getParameter("employment"));
        
        String[] skillsArr = request.getParameterValues("skills");
        bean.setSkills(skillsArr != null ? String.join(",", skillsArr) : "");
        
        bean.setProficiency(Integer.parseInt(request.getParameter("proficiency")));
        bean.setComments(request.getParameter("comments"));

        if (bean.updateSurvey()) { // Call update method [cite: 116]
            request.setAttribute("surveyData", bean);
            RequestDispatcher rd = request.getRequestDispatcher("confirmation.jsp"); // Redirect to confirmation [cite: 116, 117]
            rd.forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}