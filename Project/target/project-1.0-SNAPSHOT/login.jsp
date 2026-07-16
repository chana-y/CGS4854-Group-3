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
    <title>Login - Minimal.</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <%-- UNIVERSAL HEADER --%>
        <header>
            <h1><a href="${pageContext.request.contextPath}/home" style="text-decoration: none; color: inherit;">Minimal.</a></h1>
            <div style="display: flex; gap: 20px; align-items: center;">
                <a href="${pageContext.request.contextPath}/cart.jsp" id="cart-header-display">
                    Cart (${totalItems}) - $${cartSubtotal}
                </a>
            </div>
        </header>

        <form action="${pageContext.request.contextPath}/login" method="post" style="max-width: 400px; margin: 50px auto;">
            
            <c:if test="${not empty error}">
                <div class="alert" style="background: #ffebee; border-color: #ffcdd2; color: #c62828;">
                    ${error}
                </div>
            </c:if>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="jane@example.com" required>
            </div>
            
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            
            <button type="submit" style="margin-top: 20px;">Sign In</button>
            <p style="text-align: center; margin-top: 20px; font-size: 14px;">
                Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp" style="text-decoration: underline;">Sign Up</a>
            </p>
        </form>
    </div>
</body>
</html>