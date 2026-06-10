<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Uses <jsp:useBean> to create/locate the bean object [cite: 139] --%>
<jsp:useBean id="surveyData" class="mypack.SurveyBean" scope="request" />

<%-- Uses <jsp:setProperty property="*"> to automatically map form fields to bean properties [cite: 140] --%>
<jsp:setProperty name="surveyData" property="*" />

<%-- Forwards the request to DisplaySurvey.jsp using <jsp:forward> [cite: 141] --%>
<jsp:forward page="DisplaySurvey.jsp" />