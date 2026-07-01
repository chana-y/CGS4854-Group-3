<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Confirmed</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2 class="message">Your details have been updated successfully.</h2>
    
    <table>
        <tr><th>Updated Name</th><td>${surveyData.fullName}</td></tr>
        <tr><th>Updated Proficiency</th><td>${surveyData.proficiency}</td></tr>
        <tr><th>Updated Comments</th><td>${surveyData.comments}</td></tr>
    </table>
    
    <div style="text-align: center;">
        <a href="survey.html">Return to Home</a>
    </div>
</body>
</html>