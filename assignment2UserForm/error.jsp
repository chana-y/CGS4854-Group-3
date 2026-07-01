<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2 style="color: red; text-align: center;">An Error Occurred</h2>
    <p style="text-align: center;">We encountered a problem processing your request or connecting to the database. Please check your inputs and try again.</p>
    <p style="text-align: center;">We encountered a problem processing your request:</p>

<p style="color: red; text-align: center; font-weight: bold;">
    Error Details: ${dbError}
</p>
    <div style="text-align: center;">
        <a href="survey.html">Return to Form</a>
    </div>
</body>
</html>