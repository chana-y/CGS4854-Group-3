<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- UNIVERSAL MATH BLOCK (Must be at the top of every page) --%>
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
    <title>Minimal.</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
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

        <%-- STOREFRONT GRID --%>
        <div class="grid">
            <c:forEach var="product" items="${products}">
                <div class="card" data-id="${product.id}" data-name="${product.name}" data-price="${product.price}">
                    <img src="${product.imageUrl}" alt="${product.name}">
                    <h3>${product.name}</h3>
                    <p class="description" style="font-size: 12px; color: #666; margin-bottom: 10px;">${product.description}</p> 
                    <p class="price">$${product.price}</p>
                    <button type="button" class="add-to-cart-btn">Add to Cart</button>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        document.querySelectorAll('.add-to-cart-btn').forEach(button => {
            button.addEventListener('click', async (e) => {
                const card = e.target.closest('.card');
                const productData = {
                    productId: parseInt(card.dataset.id),
                    name: card.dataset.name,
                    price: parseFloat(card.dataset.price),
                    quantity: 1
                };

                const response = await fetch('${pageContext.request.contextPath}/api/cart', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(productData)
                });

                if (response.ok) {
                    const data = await response.json();
                    
                    // FIXED: Using standard string concatenation so Tomcat ignores it!
                    document.getElementById('cart-header-display').innerText = 
                        "Cart (" + data.totalItems + ") - $" + data.cartTotal.toFixed(2);
                        
                    const originalText = e.target.innerText;
                    e.target.innerText = "Added!";
                    e.target.style.backgroundColor = "#4CAF50"; 
                    e.target.style.color = "white";
                    setTimeout(() => {
                        e.target.innerText = originalText;
                        e.target.style.backgroundColor = "";
                        e.target.style.color = "";
                    }, 1000);
                }
            });
        });
    </script>
</body>
</html>