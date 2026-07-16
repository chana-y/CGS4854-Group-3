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
    <title>Cart - Minimal.</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .address-section { margin-bottom: 25px; padding: 15px; border: 1px solid #eee; background-color: #fafafa; }
        .form-label { display: block; font-size: 12px; font-weight: 600; color: #555; margin-bottom: 5px; margin-top: 10px; }
        .form-row { display: flex; gap: 10px; }
        .form-col { flex: 1; }
        input[type="text"], input[type="email"] { width: 100%; padding: 8px; box-sizing: border-box; border: 1px solid #ccc; }
        .clear-cart-btn { background: transparent; color: #d9534f; border: 1px solid #d9534f; padding: 6px 12px; font-size: 12px; cursor: pointer; text-transform: uppercase; }
        .clear-cart-btn:hover { background: #d9534f; color: white; }
    </style>
</head>
<body>
    <div class="container" style="max-width: 800px; margin: 0 auto; padding: 20px;">
        <header style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 30px;">
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
                <a href="${pageContext.request.contextPath}/cart.jsp" id="cart-header-display" style="font-weight: bold; text-decoration: none; color: #333;">
                    Cart (${totalItems}) - $${cartSubtotal}
                </a>
            </div>
        </header>

        <c:choose>
            <c:when test="${empty sessionScope.cart}">
                <p>Your cart is empty. <a href="${pageContext.request.contextPath}/home" style="text-decoration: underline;">Go shopping.</a></p>
            </c:when>
            
            <c:otherwise>
                <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 15px;">
                    <h2 style="margin: 0;">Review Your Order</h2>
                    <button type="button" id="clear-cart-btn" class="clear-cart-btn">Clear Cart</button>
                </div>
                
                <table class="cart-table" id="cart-table" style="width: 100%; text-align: left; border-collapse: collapse; margin-bottom: 40px;">
                    <tr style="border-bottom: 2px solid #333;">
                        <th style="padding: 10px 0;">Product</th>
                        <th>Qty</th>
                        <th>Total</th>
                        <th></th>
                    </tr>
                    <c:forEach var="item" items="${sessionScope.cart}">
                        <tr data-item-id="${item.product.id}" style="border-bottom: 1px solid #eee;">
                            <td style="padding: 15px 0;">${item.product.name}</td>
                            <td>${item.quantity}</td>
                            <td>$${item.total}</td>
                            <td style="text-align: right;">
                                <button type="button" class="remove-item-btn" data-id="${item.product.id}" style="background: transparent; color: #d9534f; border: none; padding: 0; font-size: 16px; cursor: pointer;">✕</button>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <th colspan="2" style="padding: 15px 0;">Order Total:</th>
                        <th colspan="2" id="order-total-display" style="font-size: 18px;">$${cartSubtotal}</th>
                    </tr>
                </table>

                <form id="checkout-form" style="max-width: 600px;">
                    <h3>Customer Information</h3>
                    <div class="address-section">
                        <label class="form-label" for="cust_name">Full Name</label>
                        <input type="text" name="name" id="cust_name" placeholder="e.g. Chanel Young" required>
                        
                        <label class="form-label" for="cust_email">Email Address</label>
                        <input type="email" name="email" id="cust_email" placeholder="e.g. chanelparisyoung@gmail.com" required>
                    </div>

                    <h3>Shipping Address</h3>
                    <div class="address-section">
                        <label class="form-label" for="ship_address">Street Address</label>
                        <input type="text" name="ship_address" id="ship_address" placeholder="123 Main St" required>
                        
                        <div class="form-row">
                            <div class="form-col">
                                <label class="form-label" for="ship_city">City</label>
                                <input type="text" name="ship_city" id="ship_city" placeholder="Miami" required>
                            </div>
                            <div class="form-col">
                                <label class="form-label" for="ship_state">State</label>
                                <input type="text" name="ship_state" id="ship_state" placeholder="FL" required>
                            </div>
                            <div class="form-col">
                                <label class="form-label" for="ship_zip">Zip Code</label>
                                <input type="text" name="ship_zip" id="ship_zip" placeholder="33174" required>
                            </div>
                        </div>
                    </div>

                    <h3>Billing Address 
                        <label style="font-size:12px; font-weight:normal; margin-left: 10px; cursor: pointer;">
                            <input type="checkbox" id="same-address"> Same as Shipping
                        </label>
                    </h3>
                    <div class="address-section">
                        <label class="form-label" for="bill_address">Street Address</label>
                        <input type="text" name="bill_address" id="bill_address" placeholder="123 Main St" required>
                        
                        <div class="form-row">
                            <div class="form-col">
                                <label class="form-label" for="bill_city">City</label>
                                <input type="text" name="bill_city" id="bill_city" placeholder="Miami" required>
                            </div>
                            <div class="form-col">
                                <label class="form-label" for="bill_state">State</label>
                                <input type="text" name="bill_state" id="bill_state" placeholder="FL" required>
                            </div>
                            <div class="form-col">
                                <label class="form-label" for="bill_zip">Zip Code</label>
                                <input type="text" name="bill_zip" id="bill_zip" placeholder="33174" required>
                            </div>
                        </div>
                    </div>

                    <h3>Payment Details</h3>
                    <div class="address-section">
                        <label class="form-label" for="cc_number">Card Number</label>
                        <input type="text" name="cc" id="cc_number" pattern="\d{16}" placeholder="1234567890123456" required>
                        
                        <div class="form-row">
                            <div class="form-col">
                                <label class="form-label" for="cc_exp">Expiration Date</label>
                                <input type="text" name="exp" id="cc_exp" placeholder="MM/YY" required>
                            </div>
                            <div class="form-col">
                                <label class="form-label" for="cc_cvc">Security Code (CVC)</label>
                                <input type="text" name="cvc" id="cc_cvc" placeholder="123" required>
                            </div>
                        </div>
                    </div>

                    <button type="submit" style="margin-top: 10px; width: 100%; padding: 15px; background: #222; color: #fff; border: none; font-size: 16px; cursor: pointer; text-transform: uppercase; font-weight: bold;">Complete Checkout</button>
                </form>

                <script>
                    const headers = { 'Content-Type': 'application/json' };

                    // 1. FIXED: Handle Removing Single Items ("X" buttons)
                    document.querySelectorAll('.remove-item-btn').forEach(button => {
                        button.addEventListener('click', async (e) => {
                            const productId = e.target.dataset.id;
                            try {
                                const response = await fetch(`${pageContext.request.contextPath}/api/cart/` + productId, { 
                                    method: 'DELETE', 
                                    headers: headers
                                });
                                if (response.ok) {
                                    window.location.reload(); 
                                }
                            } catch(err) {
                                console.error('Error removing item:', err);
                            }
                        });
                    });

                    // 2. FIXED: Clear Cart logic (Matching the Servlet's doDelete method)
                    document.getElementById('clear-cart-btn')?.addEventListener('click', async () => {
                        if (confirm('Are you sure you want to clear your entire cart?')) {
                            try {
                                const response = await fetch('${pageContext.request.contextPath}/api/cart', {
                                    method: 'DELETE', 
                                    headers: headers
                                });
                                if (response.ok) {
                                    window.location.reload();
                                } else {
                                    alert('Failed to clear cart. Please try again.');
                                }
                            } catch (err) {
                                console.error('Error clearing cart:', err);
                            }
                        }
                    });

                    // 3. Copy Shipping to Billing logic
                    document.getElementById('same-address').addEventListener('change', function() {
                        const fields = ['address', 'city', 'state', 'zip'];
                        if(this.checked) {
                            fields.forEach(f => {
                                document.getElementById('bill_' + f).value = document.getElementById('ship_' + f).value;
                                document.getElementById('bill_' + f).readOnly = true;
                                document.getElementById('bill_' + f).style.backgroundColor = '#f0f0f0';
                            });
                        } else {
                            fields.forEach(f => {
                                document.getElementById('bill_' + f).readOnly = false;
                                document.getElementById('bill_' + f).style.backgroundColor = '';
                            });
                        }
                    });

                    // 4. Checkout submission
                    document.getElementById('checkout-form').addEventListener('submit', async (e) => {
                        e.preventDefault();
                        const formData = new FormData(e.target);
                        const jsonPayload = Object.fromEntries(formData.entries());

                        try {
                            const response = await fetch('${pageContext.request.contextPath}/api/checkout', {
                                method: 'POST',
                                headers: headers,
                                body: JSON.stringify(jsonPayload)
                            });

                            if (response.ok) {
                                const data = await response.json();
                                window.location.href = '${pageContext.request.contextPath}/confirmation.jsp?tracking=' + data.tracking + '&email=' + data.email;
                            } else {
                                alert('Checkout failed. Please check your payment details.');
                            }
                        } catch(err) {
                            console.error('Checkout error:', err);
                            alert('An error occurred during checkout.');
                        }
                    });
                </script>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>