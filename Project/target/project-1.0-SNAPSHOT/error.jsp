<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- UNIVERSAL MATH BLOCK --%>
<c:set var="totalItems" value="0" />
<c:set var="cartSubtotal" value="0.00" />
<c:if test="${not empty sessionScope.cart}">
    <c:forEach var="item" items="${sessionScope.cart}">
        <c:set var="totalItems" value="${totalItems + item.quantity}" />
        <c:set var="cartSubtotal" value="${cartSubtotal + item.total}" />
    </c:forEach>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Oops - Minimal.</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <%-- UNIVERSAL HEADER --%>
        <header>
            <h1><a href="${pageContext.request.contextPath}/home" style="text-decoration: none; color: inherit;">Minimal.</a></h1>
            <div style="display: flex; gap: 20px; align-items: center;">
                <c:choose>
                    <c:when test="${not empty sessionScope.userEmail}">
                        <span style="font-size: 14px; color: #666;">Hi, ${sessionScope.userEmail}</span>
                        <a href="${pageContext.request.contextPath}/logout" style="font-size: 12px; color: #d9534f; text-decoration: underline; margin-left: 10px;">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" style="font-size: 14px; text-decoration: underline;">Login</a>
                    </c:otherwise>
                </c:choose>
                <a href="${pageContext.request.contextPath}/cart.jsp" id="cart-header-display">
                    Cart (${totalItems}) - $${cartSubtotal}
                </a>
            </div>
        </header>

        <div style="text-align: center; margin-top: 100px;">
            <h1>Something went wrong.</h1>
            <p>We are experiencing a temporary technical issue processing your request.</p>
            
            <p style="color: #666; font-size: 12px; margin-top: 20px;">
                Error Details: ${pageContext.exception != null ? pageContext.exception.message : requestScope['jakarta.servlet.error.message']}
            </p>

            <a href="${pageContext.request.contextPath}/home">
                <button style="margin-top: 30px;">Return to Storefront</button>
            </a>
        </div>
    </div>
</body>
</html>