package mypack;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*; // This imports BufferedReader and InputStreamReader

@WebServlet("/SurveyServlet")
@MultipartConfig
public class SurveyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SurveyBean bean = new SurveyBean();
        
        // This now calls the method defined below, outside of doPost
        bean.setFullName(getPartValue(request.getPart("fullName")));
        bean.setEmail(getPartValue(request.getPart("email")));
        bean.setPhone(getPartValue(request.getPart("phone")));
        String ageStr = getPartValue(request.getPart("age"));
bean.setAge(!ageStr.isEmpty() ? Integer.parseInt(ageStr) : 0);
        bean.setGender(getPartValue(request.getPart("gender")));
        bean.setQualification(getPartValue(request.getPart("qualification")));
        bean.setEmployment(getPartValue(request.getPart("employment")));
        
        String[] skillsArr = request.getParameterValues("skills");
        bean.setSkills(skillsArr != null ? String.join(",", skillsArr) : "");
        
        String prof = getPartValue(request.getPart("proficiency"));
        bean.setProficiency(!prof.isEmpty() ? Integer.parseInt(prof) : 0);
        bean.setComments(getPartValue(request.getPart("comments")));

        Part filePart = request.getPart("resume");
String fileName = (filePart != null && filePart.getSize() > 0) ? filePart.getSubmittedFileName() : "";
bean.setResume(fileName);


        if (bean.saveSurvey()) {
            request.setAttribute("surveyData", bean);
            request.getRequestDispatcher("display.jsp").forward(request, response);         
        } else {
    // Grab the specific error from the bean and attach it to the request
    request.setAttribute("dbError", bean.getErrorMessage());

    // Forward the request directly to error.jsp so it doesn't lose the data
    request.getRequestDispatcher("error.jsp").forward(request, response);
}
    }

    // THIS IS THE KEY: This method is now a "sibling" of doPost, not inside it.
    private String getPartValue(Part part) throws IOException {
    if (part == null) return "";
    try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"))) {
        String value = reader.readLine();
        return value == null ? "" : value; // Prevents the crash if the field is completely empty
    }
}
}