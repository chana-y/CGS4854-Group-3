<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Survey Details</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2 class="message">Your survey details have been successfully saved.</h2> 
    
    <table>
        <tr><th>Field</th><th>Value</th></tr>
        <tr><td>Name</td><td>${surveyData.fullName}</td></tr>
        <tr><td>Email</td><td>${surveyData.email}</td></tr>
        <tr><td>Phone</td><td>${surveyData.phone}</td></tr>
        <tr><td>Gender</td><td>${surveyData.gender}</td></tr>
        <tr><td>Qualification</td><td>${surveyData.qualification}</td></tr>
        <tr><td>Employment</td><td>${surveyData.employment}</td></tr>
        <tr><td>Skills</td><td>${surveyData.skills}</td></tr>
        <tr><td>Proficiency</td><td>${surveyData.proficiency} / 10</td></tr>
        <tr><td>Comments</td><td>${surveyData.comments}</td></tr>
    </table>

    <div style="text-align: center;">
        <a href="EditSurveyServlet?email=${surveyData.email}"><button>Edit Details</button></a>
    </div>
</body>
</html>