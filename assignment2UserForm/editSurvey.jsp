<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Survey</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Edit Survey Details</h1>
    <form action="EditSurveyServlet" method="POST">
        <input type="hidden" name="email" value="${surveyData.email}"> 
        
        <fieldset>
            <legend>Personal Information</legend>
            <label>Full Name: <input type="text" name="fullName" value="${surveyData.fullName}" required></label><br>
            <label>Phone: <input type="tel" name="phone" value="${surveyData.phone}"></label><br>
        </fieldset>

        <fieldset>
            <legend>Technical Skills</legend>
            <label>Rate your coding proficiency: <input type="range" name="proficiency" min="1" max="10" value="${surveyData.proficiency}"></label>
        </fieldset>
        
        <fieldset>
            <legend>Feedback</legend>
            <label>Comments:<br><textarea name="comments" rows="4">${surveyData.comments}</textarea></label>
        </fieldset>

        <button type="submit">Update Details</button>
    </form>
</body>
</html>