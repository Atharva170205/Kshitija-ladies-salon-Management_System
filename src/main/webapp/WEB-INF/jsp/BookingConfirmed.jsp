<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Booking Confirmed - Kshitija Ladies Salon</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body { min-height: 100vh; background: linear-gradient(135deg, #3a2630, #e85c8a);
               padding: 40px 0; font-family: Arial, sans-serif; }
        .ok-card { border: none; border-radius: 20px; overflow: hidden;
                   box-shadow: 0 15px 40px rgba(0,0,0,0.25); }
        .ok-head { background: #3a2630; border-bottom: 3px solid #d4a53d; }
        .tick { font-size: 54px; color: #2e9e5b; }
        .row-line { display: flex; justify-content: space-between; gap: 16px;
                    padding: 9px 0; border-bottom: 1px solid #f1e7ea; }
        .row-line:last-child { border-bottom: none; }
        .row-line span:first-child { color: #8a6f7a; }
        .row-line span:last-child { font-weight: 600; text-align: right; }
    </style>
</head>

<body>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-lg-6 col-md-8">

      <div class="card ok-card">

        <div class="ok-head text-center text-white p-4">
            <h3 class="mb-1">Booking Confirmed</h3>
            <p class="mb-0" style="color:#e9d9df;">Kshitija Ladies Salon</p>
        </div>

        <div class="card-body p-4">

            <div class="text-center mb-3">
                <i class="bi bi-check-circle-fill tick"></i>
                <p class="mt-2 mb-0">
                    Thank you, <strong><c:out value="${co.name}"/></strong>.
                    Your payment was received.
                </p>
            </div>

            <div class="row-line">
                <span>Services</span>
                <span><c:out value="${co.service}"/></span>
            </div>

            <div class="row-line">
                <span>Appointment</span>
                <span><c:out value="${co.time}"/></span>
            </div>

            <div class="row-line">
                <span>Bill total</span>
                <span>&#8377;<fmt:formatNumber value="${co.total}" maxFractionDigits="0"/></span>
            </div>

            <div class="row-line">
                <span>Paid online</span>
                <span>&#8377;<fmt:formatNumber value="${co.amount}" maxFractionDigits="0"/></span>
            </div>

            <c:if test="${co.balance.signum() > 0}">
                <div class="row-line">
                    <span>Balance at the salon</span>
                    <span>&#8377;<fmt:formatNumber value="${co.balance}" maxFractionDigits="0"/></span>
                </div>
            </c:if>

            <p class="text-muted small text-center mt-3 mb-0">
                A confirmation is being sent on WhatsApp to
                <c:out value="${co.maskedMobile}"/>.
            </p>

            <div class="d-grid mt-4">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-dark">
                    Back to Home
                </a>
            </div>

        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>