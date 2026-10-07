<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Pay &amp; Confirm - Kshitija Ladies Salon</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #3a2630, #e85c8a);
            padding: 40px 0;
            font-family: Arial, sans-serif;
        }
        .pay-card { border: none; border-radius: 20px; overflow: hidden;
                    box-shadow: 0 15px 40px rgba(0,0,0,0.25); }
        .pay-head { background: #3a2630; border-bottom: 3px solid #d4a53d; }
        .btn-pay { padding: 14px; border-radius: 10px; font-size: 17px;
                   font-weight: 700; border: none; color: #3a2a0c;
                   background: linear-gradient(135deg, #f3cf74, #d4a53d); }
        .amount { font-size: 34px; font-weight: 700; color: #e85c8a; }
    </style>
</head>

<body
    data-name="<c:out value='${co.name}'/>"
    data-mobile="<c:out value='${co.mobile}'/>">

<div class="container">
  <div class="row justify-content-center">
    <div class="col-lg-6 col-md-8">

      <div class="card pay-card">

        <div class="pay-head text-center text-white p-4">
            <h3 class="mb-1">Confirm Your Booking</h3>
            <p class="mb-0" style="color:#e9d9df;">Pay online to reserve your slot</p>
        </div>

        <div class="card-body p-4 text-center">

            <p class="mb-1">Hello, <strong><c:out value="${co.name}"/></strong></p>

            <p class="text-muted mb-1">
                Bill total: &#8377;<fmt:formatNumber value="${co.total}" maxFractionDigits="0"/>
            </p>

            <c:choose>
                <c:when test="${co.paymentType == 'ADVANCE'}">
                    <p class="text-muted">
                        Advance to pay now &middot; balance
                        &#8377;<fmt:formatNumber value="${co.balance}" maxFractionDigits="0"/>
                        at the salon
                    </p>
                </c:when>
                <c:otherwise>
                    <p class="text-muted">Full payment</p>
                </c:otherwise>
            </c:choose>

            <div class="amount mb-4">
                &#8377;<fmt:formatNumber value="${co.amount}" maxFractionDigits="0"/>
            </div>

            <div id="payMsg" class="text-danger small mb-2 d-none"></div>

            <div class="d-grid">
                <button type="button" id="payBtn" class="btn btn-pay">
                    Pay &#8377;<fmt:formatNumber value="${co.amount}" maxFractionDigits="0"/> Securely
                </button>
            </div>

            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/bookAppointment"
                   class="text-decoration-none">&larr; Change booking</a>
            </div>

        </div>
      </div>
    </div>
  </div>
</div>

<!-- Posted to the server after a successful payment (handled in Step P3) -->
<form id="verifyForm"
      action="${pageContext.request.contextPath}/paymentSuccess"
      method="post">
    <input type="hidden" name="razorpay_payment_id" id="rzpPaymentId">
    <input type="hidden" name="razorpay_order_id"   id="rzpOrderId">
    <input type="hidden" name="razorpay_signature"  id="rzpSignature">
</form>

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<script>
    var options = {
        key: "${co.keyId}",
        amount: ${co.amountPaise},
        currency: "INR",
        name: "Kshitija Ladies Salon",
        description: "Appointment booking",
        order_id: "${co.orderId}",
        prefill: {
            name: document.body.dataset.name,
            contact: document.body.dataset.mobile
        },
        theme: { color: "#e85c8a" },

        handler: function (resp) {
            document.getElementById('rzpPaymentId').value = resp.razorpay_payment_id;
            document.getElementById('rzpOrderId').value   = resp.razorpay_order_id;
            document.getElementById('rzpSignature').value = resp.razorpay_signature;
            document.getElementById('verifyForm').submit();
        },

        modal: {
            ondismiss: function () {
                var m = document.getElementById('payMsg');
                m.textContent = 'Payment was not completed. Click Pay to try again.';
                m.classList.remove('d-none');
            }
        }
    };

    var rzp = new Razorpay(options);

    rzp.on('payment.failed', function (r) {
        var m = document.getElementById('payMsg');
        m.textContent = 'Payment failed: ' + r.error.description + '. Please try again.';
        m.classList.remove('d-none');
    });

    document.getElementById('payBtn').addEventListener('click', function () {
        rzp.open();
    });
</script>

</body>
</html>