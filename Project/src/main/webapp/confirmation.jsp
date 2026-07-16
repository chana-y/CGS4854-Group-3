<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Order Confirmed - Minimal.</title>
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

        <div style="text-align: center; margin-top: 80px; max-width: 600px; margin-left: auto; margin-right: auto;">
            <div style="font-size: 48px; color: #4CAF50; margin-bottom: 20px;">✓</div>
            <h1 style="margin-bottom: 10px;">Order Confirmed!</h1>
            <p style="color: #666; font-size: 16px; line-height: 1.6;">
                Thank you for shopping with Minimal. Your order has been successfully placed and is now being processed.
            </p>
            
            <div style="background-color: #f9f9f9; border: 1px solid #e0e0e0; padding: 30px; margin-top: 30px; text-align: left;">
                <h3 style="margin-top: 0; border-bottom: 1px solid #ddd; padding-bottom: 10px;">Order Details</h3>
                
                <p style="margin: 15px 0 5px 0; font-size: 14px; color: #666;">Tracking Number:</p>
                <p style="font-size: 18px; font-weight: bold; font-family: monospace; letter-spacing: 1px;">
                    ${param.tracking != null ? param.tracking : 'Processing...'}
                </p>

                <p style="margin: 20px 0 5px 0; font-size: 14px; color: #666;">Confirmation sent to:</p>
                <p style="font-size: 16px; font-weight: bold;">
                    <c:choose>
                        <%-- 1. If logged in, show the session email --%>
                        <c:when test="${not empty sessionScope.userEmail}">
                            ${sessionScope.userEmail}
                        </c:when>
                        <%-- 2. Otherwise, fall back to the tracking URL parameter (for guest checkout) --%>
                        <c:when test="${not empty param.email}">
                            ${param.email}
                        </c:when>
                        <%-- 3. Final fallback --%>
                        <c:otherwise>
                            Your Email
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <a href="${pageContext.request.contextPath}/home">
                <button style="margin-top: 40px;">Continue Shopping</button>
            </a>
        </div>
    </div>
</body>
</html>