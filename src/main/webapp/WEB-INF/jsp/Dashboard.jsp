<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin Dashboard - Salon Management</title>

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
body {
    background-color: #f5f6fa;
}
.navbar-brand {
    font-size: 24px;
    font-weight: bold;
}
.dashboard-card {
    border: none;
    border-radius: 12px;
    transition: 0.3s;
}
.dashboard-card:hover {
    transform: translateY(-5px);
}
.table th {
    white-space: nowrap;
}
.table td {
    vertical-align: middle;
}
.empty-box {
    padding: 50px;
    text-align: center;
}
.action-btn {
    margin-bottom: 5px;
    min-width: 150px;
}
.status-badge {
    font-size: 14px;
    padding: 8px 12px;
}
</style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
<div class="container">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
        <i class="bi bi-scissors"></i>
        Salon Admin Panel
    </a>

    <div class="d-flex align-items-center">
        <span class="text-white me-3">
            <i class="bi bi-person-circle"></i>
            ${sessionScope.loggedInUser}
        </span>

        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
            <i class="bi bi-box-arrow-right"></i>
            Logout
        </a>
    </div>
</div>
</nav>

<div class="container mt-5">
<div class="row mb-4">
    <div class="col-md-12">
        <h2>Welcome, ${sessionScope.loggedInUser}</h2>
        <p class="text-muted">Manage customer appointments from your dashboard.</p>
    </div>
</div>

<c:if test="${not empty successMsg}">
    <div class="alert alert-success alert-dismissible fade show">
        ${successMsg}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${not empty errMsg}">
    <div class="alert alert-danger alert-dismissible fade show">
        ${errMsg}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="row mb-5">

    <div class="col-md-4 mb-3">
        <div class="card dashboard-card shadow-sm bg-primary text-white">
            <div class="card-body">
                <h5><i class="bi bi-calendar-check"></i> Total Appointments</h5>
                <h2>${appointmentList.size()}</h2>
            </div>
        </div>
    </div>

    <div class="col-md-4 mb-3">
        <div class="card dashboard-card shadow-sm bg-success text-white">
            <div class="card-body">
                <h5><i class="bi bi-check-circle"></i> Dashboard Status</h5>
                <h4>Active</h4>
            </div>
        </div>
    </div>

    <div class="col-md-4 mb-3">
        <div class="card dashboard-card shadow-sm bg-dark text-white">
            <div class="card-body">
                <h5><i class="bi bi-person"></i> Logged In As</h5>
                <h4>${sessionScope.loggedInUser}</h4>
            </div>
        </div>
    </div>

</div>

<div class="card shadow dashboard-card">

    <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
        <h4 class="mb-0"><i class="bi bi-calendar-check"></i> Customer Appointments</h4>
        <span class="badge bg-light text-dark">${appointmentList.size()} Appointments</span>
    </div>

    <div class="card-body">

        <c:choose>
            <c:when test="${not empty appointmentList}">

                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Customer Name</th>
                                <th>Address</th>
                                <th>Mobile</th>
                                <th>Service</th>
                                <th>Bill</th>
                                <th>Appointment Time</th>
                                <th>Job Status</th>
                                <th>Payment Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="customer" items="${appointmentList}" varStatus="status">
                                <tr>

                                    <td>${status.count}</td>

                                    <td><strong>${customer.name}</strong></td>

                                    <td>${customer.address}</td>

                                    <td>${customer.mobile}</td>

                                    <td>
                                        <span class="badge bg-primary">${customer.service}</span>
                                    </td>

                                    <td>
                                        <strong class="text-success">&#8377;${customer.totalAmount}</strong>
                                    </td>

                                    <td>
                                        <i class="bi bi-clock"></i> ${customer.time}
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${customer.jobStatus == 'Completed'}">
                                                <span class="badge bg-success status-badge">
                                                    <i class="bi bi-check-circle"></i> Completed
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark status-badge">
                                                    <i class="bi bi-hourglass-split"></i> Pending
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${customer.paymentStatus == 'Collected'}">
                                                <span class="badge bg-success status-badge">
                                                    <i class="bi bi-cash-coin"></i> Collected
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark status-badge">
                                                    <i class="bi bi-cash"></i> Pending
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>

                                        <c:if test="${customer.jobStatus != 'Completed'}">
                                            <a href="${pageContext.request.contextPath}/completeJob?id=${customer.id}"
                                               class="btn btn-success btn-sm action-btn">
                                                <i class="bi bi-check-circle"></i> Job Complete
                                            </a>
                                        </c:if>

                                        <c:if test="${customer.paymentStatus != 'Collected'}">
                                            <a href="${pageContext.request.contextPath}/collectPayment?id=${customer.id}"
                                               class="btn btn-primary btn-sm action-btn">
                                                <i class="bi bi-cash-coin"></i> Payment Collected
                                            </a>
                                        </c:if>

                                        <c:if test="${customer.jobStatus == 'Completed' && customer.paymentStatus == 'Collected'}">
                                            <span class="badge bg-success p-2">
                                                <i class="bi bi-check-all"></i> Completed
                                            </span>
                                        </c:if>

                                        <form action="${pageContext.request.contextPath}/deleteAppointment"
                                              method="post"
                                              style="display:inline;"
                                              onsubmit="return confirm('Delete this appointment for ${customer.name}? This cannot be undone.');">
                                            <input type="hidden" name="id" value="${customer.id}" />
                                            <button type="submit" class="btn btn-outline-danger btn-sm action-btn">
                                                <i class="bi bi-trash"></i> Delete
                                            </button>
                                        </form>

                                    </td>

                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

            </c:when>

            <c:otherwise>
                <div class="empty-box">
                    <i class="bi bi-calendar-x" style="font-size: 60px;"></i>
                    <h4 class="mt-3">No Appointments Found</h4>
                    <p class="text-muted">Customers have not booked any appointments yet.</p>
                </div>
            </c:otherwise>

        </c:choose>

    </div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>