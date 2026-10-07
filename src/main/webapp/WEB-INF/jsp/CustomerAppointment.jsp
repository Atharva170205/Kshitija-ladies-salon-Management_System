<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Book Appointment - Kshitija Ladies Salon</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        :root {
            --gold: #d4a53d;
            --gold-light: #f3cf74;
            --pink-deep: #e85c8a;
            --dark: #3a2630;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #3a2630, #e85c8a);
            padding: 40px 0;
            font-family: Arial, sans-serif;
        }

        .booking-card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
        }

        .card-header {
            background: var(--dark);
            padding: 25px;
            border-bottom: 3px solid var(--gold);
        }

        .form-control,
        .form-select {
            padding: 12px;
            border-radius: 10px;
        }

        .btn-book {
            padding: 14px;
            border-radius: 10px;
            font-size: 17px;
            font-weight: 700;
            background: linear-gradient(135deg, var(--gold-light), var(--gold));
            color: #3a2a0c;
            border: none;
        }

        .btn-book:hover {
            color: #3a2a0c;
            filter: brightness(1.05);
        }

        /* ---------- SEARCH ---------- */

        .service-search-wrap {
            position: relative;
            margin-bottom: 14px;
        }

        .service-search-wrap i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--pink-deep);
            z-index: 2;
        }

        .service-search-wrap input {
            padding-left: 40px;
            border-radius: 10px;
        }

        .search-hint {
            font-size: 12.5px;
            color: #8a6f7a;
            margin-top: 4px;
        }

        /* ---------- SUGGESTED ---------- */

        .suggested-wrap {
            margin-bottom: 18px;
        }

        .suggested-label {
            font-size: 13px;
            font-weight: 700;
            color: var(--pink-deep);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            display: block;
        }

        .chip-row {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .svc-chip {
            border: 1.5px solid var(--gold-light);
            background: #fff;
            border-radius: 30px;
            padding: 7px 16px;
            font-size: 13.5px;
            font-weight: 500;
            cursor: pointer;
            color: var(--dark);
            transition: 0.2s;
        }

        .svc-chip:hover {
            background: #fff8ec;
            border-color: var(--gold);
        }

        .svc-chip.chip-active {
            background: linear-gradient(135deg, var(--gold-light), var(--gold));
            color: #3a2a0c;
            border-color: var(--gold);
        }

        .svc-chip .chip-price {
            font-weight: 700;
            margin-left: 6px;
        }

        /* ---------- ACCORDION ---------- */

        .accordion-button {
            font-weight: 600;
            color: var(--dark);
        }

        .accordion-button:not(.collapsed) {
            background: #fff6e9;
            color: var(--pink-deep);
        }

        .accordion-button:focus {
            box-shadow: none;
        }

        .accordion-item {
            border-radius: 10px !important;
            overflow: hidden;
            margin-bottom: 8px;
        }

        /* ---------- SERVICE ROW ---------- */

        .svc-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            padding: 10px 4px;
            border-bottom: 1px solid #f1e7ea;
        }

        .svc-row:last-child {
            border-bottom: none;
        }

        .svc-row label {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            font-size: 14.5px;
            margin: 0;
            flex: 1;
        }

        .svc-row .svc-price {
            font-weight: 700;
            color: var(--gold);
            white-space: nowrap;
            font-size: 14.5px;
        }

        .svc-box {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .svc-box:checked {
            accent-color: var(--gold);
        }

        /* ---------- SELECTED + PAYMENT BOXES ---------- */

        .selected-services-box {
            margin-top: 15px;
            padding: 12px 15px;
            background: #fffaf2;
            border: 1px solid var(--gold-light);
            border-radius: 12px;
        }

        .selected-services-title {
            font-size: 13px;
            font-weight: 700;
            color: var(--pink-deep);
            margin-bottom: 7px;
        }

        #selectedServices {
            font-size: 13px;
            color: #6b5560;
        }

        /* ---------- BILL ---------- */

        .bill-bar {
            position: sticky;
            bottom: 0;
            background: #fff8ec;
            border: 2px solid var(--gold-light);
            border-radius: 14px;
            padding: 14px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 10px;
            z-index: 10;
        }

        .bill-label {
            font-weight: 600;
            color: var(--dark);
        }

        .bill-total {
            font-size: 22px;
            font-weight: 700;
            color: var(--pink-deep);
        }

        .row-hidden  { display: none !important; }
        .item-hidden { display: none !important; }

        @media (max-width: 576px) {

            body { padding: 15px 0; }

            .card-body { padding: 20px !important; }

            .bill-bar { padding: 12px; }

            .bill-total { font-size: 19px; }
        }

    </style>

</head>


<body>

<div class="container">

    <div class="row justify-content-center">

        <div class="col-lg-9 col-md-10">

            <div class="card booking-card">

                <!-- HEADER -->

                <div class="card-header text-center text-white">

                    <h2 class="mb-1">&#9986; Salon Appointment</h2>

                    <p class="mb-0" style="color:#e9d9df;">
                        Select one or multiple services and book your appointment.
                    </p>

                </div>


                <div class="card-body p-4 p-md-5">

                    <!-- SUCCESS -->

                    <c:if test="${not empty successMsg}">
                        <div class="alert alert-success">
                            <c:out value="${successMsg}"/>
                        </div>
                    </c:if>

                    <!-- ERROR -->

                    <c:if test="${not empty errMsg}">
                        <div class="alert alert-danger">
                            <c:out value="${errMsg}"/>
                        </div>
                    </c:if>


                    <!-- =============================================
                         FORM
                         ============================================= -->

                    <form
                        id="appointmentForm"
                        action="${pageContext.request.contextPath}/saveAppointment"
                        method="post">

                        <!-- NAME -->

                        <div class="mb-3">
                            <label class="form-label fw-bold">Customer Name</label>
                            <input
                                type="text"
                                name="name"
                                class="form-control"
                                placeholder="Enter your full name"
                                required>
                        </div>

                        <!-- ADDRESS -->

                        <div class="mb-3">
                            <label class="form-label fw-bold">Address</label>
                            <textarea
                                name="address"
                                class="form-control"
                                rows="3"
                                placeholder="Enter your address"
                                required></textarea>
                        </div>

                        <!-- MOBILE -->

                        <div class="mb-3">
                            <label class="form-label fw-bold">Mobile Number</label>
                            <input
                                type="tel"
                                name="mobile"
                                class="form-control"
                                placeholder="Enter 10 digit mobile number"
                                pattern="[0-9]{10}"
                                maxlength="10"
                                required>
                        </div>


                        <!-- =========================================
                             SERVICES
                             ========================================= -->

                        <div class="mb-4">

                            <label class="form-label fw-bold mb-2">
                                Select Service(s)
                                <small class="text-muted fw-normal">
                                    -- select one or multiple services
                                </small>
                            </label>


                            <!-- SUGGESTED -->

                            <c:if test="${not empty suggestedServices}">

                                <div class="suggested-wrap">

                                    <span class="suggested-label">
                                        <i class="bi bi-lightning-fill"></i>
                                        Suggested for you
                                    </span>

                                    <div class="chip-row">

                                        <c:forEach var="sugg" items="${suggestedServices}">

                                            <span class="svc-chip" data-chip-for="${sugg.id}">

                                                <c:out value="${sugg.displayLabel}"/>

                                                <span class="chip-price">
                                                    &#8377;
                                                    <fmt:formatNumber
                                                        value="${sugg.price}"
                                                        maxFractionDigits="0"/>
                                                </span>

                                            </span>

                                        </c:forEach>

                                    </div>

                                </div>

                            </c:if>


                            <!-- SEARCH -->

                            <div class="service-search-wrap">
                                <i class="bi bi-search"></i>
                                <input
                                    type="text"
                                    id="serviceSearch"
                                    class="form-control"
                                    autocomplete="off"
                                    placeholder="Search a service, e.g. facial, waxing, bridal...">
                            </div>

                            <div class="search-hint" id="searchHint"></div>


                            <!-- ACCORDION -->

                            <div class="accordion" id="serviceAccordion">

                                <c:forEach
                                    var="entry"
                                    items="${servicesByCategory}"
                                    varStatus="catStatus">

                                    <c:set var="catSlug" value="cat-${catStatus.index}" />

                                    <c:set
                                        var="isTargetCategory"
                                        value="${param.category == entry.key}" />

                                    <div class="accordion-item" data-category-item>

                                        <h2 class="accordion-header" id="heading-${catSlug}">

                                            <button
                                                class="accordion-button ${isTargetCategory ? '' : 'collapsed'}"
                                                type="button"
                                                data-bs-toggle="collapse"
                                                data-bs-target="#collapse-${catSlug}">

                                                <c:out value="${entry.key}"/>

                                                <span class="badge bg-light text-dark ms-2">
                                                    ${fn:length(entry.value)} options
                                                </span>

                                            </button>

                                        </h2>

                                        <div
                                            id="collapse-${catSlug}"
                                            class="accordion-collapse collapse ${isTargetCategory ? 'show' : ''}"
                                            data-bs-parent="#serviceAccordion">

                                            <div class="accordion-body">

                                                <c:forEach var="svc" items="${entry.value}">

                                                    <div
                                                        class="svc-row"
                                                        data-search-text="<c:out value='${fn:toLowerCase(entry.key)} ${fn:toLowerCase(svc.displayLabel)}'/>">

                                                        <label>

                                                            <input
                                                                type="checkbox"
                                                                class="form-check-input svc-box"
                                                                data-id="${svc.id}"
                                                                data-price="${svc.price}"
                                                                data-label="<c:out value='${svc.displayLabel}'/>">

                                                            <span>
                                                                <c:out value="${svc.displayLabel}"/>
                                                            </span>

                                                        </label>

                                                        <span class="svc-price">
                                                            &#8377;
                                                            <fmt:formatNumber
                                                                value="${svc.price}"
                                                                maxFractionDigits="0"/>
                                                        </span>

                                                    </div>

                                                </c:forEach>

                                            </div>

                                        </div>

                                    </div>

                                </c:forEach>

                            </div>


                            <!-- HIDDEN SERVICE IDS (filled on submit, e.g. 5,8,14) -->

                            <input type="hidden" name="service" id="serviceIdsHidden">


                            <!-- SELECTED SERVICES -->

                            <div class="selected-services-box">

                                <div class="selected-services-title">
                                    <i class="bi bi-check2-circle"></i>
                                    Selected Services
                                </div>

                                <div id="selectedServices">
                                    No service selected yet.
                                </div>

                            </div>

                            <!-- ERROR -->

                            <div class="text-danger small mt-2 d-none" id="serviceError">
                                Please select at least one service.
                            </div>


                            <!-- BILL -->

                            <div class="bill-bar">

                                <span class="bill-label">
                                    <i class="bi bi-receipt"></i>
                                    &nbsp; Estimated Bill
                                </span>

                                <span class="bill-total">
                                    &#8377;
                                    <span id="billTotal">0</span>
                                </span>

                            </div>


                            <!-- PAYMENT OPTION -->

                            <div id="payOptionBox" class="selected-services-box">

                                <div class="selected-services-title">
                                    <i class="bi bi-credit-card"></i>
                                    Pay online to confirm your booking
                                </div>

                                <!-- Bill of Rs 100 or less: full payment only -->

                                <div id="payFullOnlyMsg" class="small">
                                    Pay
                                    <strong>&#8377;<span id="payFullOnlyAmt">0</span></strong>
                                    online to confirm your booking.
                                </div>

                                <!-- Bill above Rs 100: customer chooses -->

                                <div id="payChoiceWrap" class="d-none">

                                    <div class="form-check mb-1">
                                        <input
                                            class="form-check-input"
                                            type="radio"
                                            name="paymentChoice"
                                            id="payAdvance"
                                            value="ADVANCE"
                                            checked>
                                        <label class="form-check-label" for="payAdvance">
                                            Pay <strong>&#8377;50</strong> advance now
                                            (balance
                                            <strong>&#8377;<span id="balanceAmt">0</span></strong>
                                            at the salon)
                                        </label>
                                    </div>

                                    <div class="form-check">
                                        <input
                                            class="form-check-input"
                                            type="radio"
                                            name="paymentChoice"
                                            id="payFull"
                                            value="FULL">
                                        <label class="form-check-label" for="payFull">
                                            Pay full amount
                                            <strong>&#8377;<span id="payFullAmt">0</span></strong>
                                            now
                                        </label>
                                    </div>

                                </div>

                            </div>

                        </div>


                        <!-- DATE AND TIME -->

                        <div class="mb-4">

                            <label class="form-label fw-bold">
                                Appointment Date &amp; Time
                            </label>

                            <input
                                type="datetime-local"
                                name="time"
                                class="form-control"
                                required>

                        </div>


                        <!-- BOOK BUTTON -->

                        <div class="d-grid">

                            <button type="submit" class="btn btn-book">
                                <i class="bi bi-credit-card"></i>
                                &nbsp; Proceed to Pay
                            </button>

                        </div>

                    </form>


                    <!-- BACK -->

                    <div class="text-center mt-3">
                        <a
                            href="${pageContext.request.contextPath}/home"
                            class="text-decoration-none">
                            &larr; Back to Home
                        </a>
                    </div>

                </div>

            </div>

        </div>

    </div>

</div>


<!-- Bootstrap -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


<script>

/* =========================================================
   PAYMENT OPTION BOX
   Bill above 100   -> customer chooses 50 advance or full
   Bill 100 or less -> full payment only
   (the server enforces the same rule again)
   ========================================================= */

function updatePayOption(total) {

    var fmt = function(n) {
        return n.toLocaleString('en-IN');
    };

    var allowAdvance = total > 100;

    var wrap     = document.getElementById('payChoiceWrap');
    var fullOnly = document.getElementById('payFullOnlyMsg');
    var amtOnly  = document.getElementById('payFullOnlyAmt');
    var amtFull  = document.getElementById('payFullAmt');
    var amtBal   = document.getElementById('balanceAmt');

    if (wrap)     { wrap.classList.toggle('d-none', !allowAdvance); }
    if (fullOnly) { fullOnly.classList.toggle('d-none', allowAdvance); }

    if (amtOnly)  { amtOnly.textContent = fmt(total); }
    if (amtFull)  { amtFull.textContent = fmt(total); }
    if (amtBal)   { amtBal.textContent  = fmt(Math.max(total - 50, 0)); }
}


/* =========================================================
   RECOMPUTE BILL
   ========================================================= */

function recomputeBill() {

    var checked = Array.prototype.slice.call(
        document.querySelectorAll('.svc-box:checked')
    );

    var total = 0;
    var selectedNames = [];

    checked.forEach(function(box) {

        total += parseFloat(box.getAttribute('data-price')) || 0;

        selectedNames.push(box.getAttribute('data-label'));

    });

    document.getElementById('billTotal').textContent =
        total.toLocaleString('en-IN');

    updatePayOption(total);

    document.getElementById('selectedServices').textContent =
        selectedNames.length === 0
            ? 'No service selected yet.'
            : selectedNames.join(' + ');

    /* chip highlight */

    document.querySelectorAll('.svc-chip').forEach(function(chip) {

        var id  = chip.getAttribute('data-chip-for');
        var box = document.querySelector('.svc-box[data-id="' + id + '"]');

        chip.classList.toggle('chip-active', !!(box && box.checked));

    });
}


/* =========================================================
   CHECKBOX CHANGE
   ========================================================= */

document.querySelectorAll('.svc-box').forEach(function(box) {

    box.addEventListener('change', recomputeBill);

});


/* =========================================================
   SUGGESTED CHIP CLICK
   ========================================================= */

document.querySelectorAll('.svc-chip').forEach(function(chip) {

    chip.addEventListener('click', function() {

        var id  = chip.getAttribute('data-chip-for');
        var box = document.querySelector('.svc-box[data-id="' + id + '"]');

        if (!box) { return; }

        box.checked = !box.checked;

        var panel = box.closest('.accordion-collapse');

        if (box.checked && panel && !panel.classList.contains('show')) {

            bootstrap.Collapse
                .getOrCreateInstance(panel, { toggle: false })
                .show();
        }

        recomputeBill();

    });

});


/* =========================================================
   SEARCH
   ========================================================= */

var searchInput = document.getElementById('serviceSearch');
var searchHint  = document.getElementById('searchHint');

searchInput.addEventListener('input', function() {

    var term = searchInput.value.trim().toLowerCase();
    var totalMatches = 0;

    document.querySelectorAll('[data-category-item]').forEach(function(item) {

        var matchesInCategory = 0;

        item.querySelectorAll('.svc-row').forEach(function(row) {

            var text = row.getAttribute('data-search-text') || '';
            var isMatch = term === '' || text.indexOf(term) !== -1;

            row.classList.toggle('row-hidden', !isMatch);

            if (isMatch) { matchesInCategory++; }

        });

        totalMatches += matchesInCategory;

        item.classList.toggle('item-hidden', term !== '' && matchesInCategory === 0);

        var panel  = item.querySelector('.accordion-collapse');
        var button = item.querySelector('.accordion-button');
        var bs     = bootstrap.Collapse.getOrCreateInstance(panel, { toggle: false });

        if (term !== '' && matchesInCategory > 0) {

            bs.show();
            button.classList.remove('collapsed');

        } else if (term === '') {

            bs.hide();
            button.classList.add('collapsed');
        }

    });

    searchHint.textContent =
        term === ''
            ? ''
            : totalMatches + ' service' + (totalMatches === 1 ? '' : 's') + ' found';

});


/* =========================================================
   PRESELECT SERVICE FROM HOME PAGE
   Home sends /bookAppointment?serviceId=5
   ========================================================= */

function preselectServiceFromHome() {

    var serviceId = new URLSearchParams(window.location.search).get('serviceId');

    if (!serviceId) { return; }

    var box = document.querySelector('.svc-box[data-id="' + serviceId + '"]');

    if (!box) { return; }

    box.checked = true;

    var panel = box.closest('.accordion-collapse');

    if (panel) {

        bootstrap.Collapse
            .getOrCreateInstance(panel, { toggle: false })
            .show();
    }

    setTimeout(function() {

        box.closest('.svc-row').scrollIntoView({
            behavior: 'smooth',
            block: 'center'
        });

    }, 400);

    recomputeBill();
}


/* =========================================================
   FORM SUBMIT
   ========================================================= */

document.getElementById('appointmentForm').addEventListener('submit', function(e) {

    var checked = Array.prototype.slice.call(
        document.querySelectorAll('.svc-box:checked')
    );

    var err = document.getElementById('serviceError');

    if (checked.length === 0) {

        e.preventDefault();
        err.classList.remove('d-none');
        return;
    }

    err.classList.add('d-none');

    /* e.g. "5,8,14" */

    document.getElementById('serviceIdsHidden').value =
        checked.map(function(box) {
            return box.getAttribute('data-id');
        }).join(',');

});


/* =========================================================
   INITIALIZATION
   ========================================================= */

recomputeBill();

window.addEventListener('load', preselectServiceFromHome);

</script>
<!-- Chatbot widget -->
<div id="chatbotToggle" style="position:fixed; bottom:20px; right:20px; z-index:1050;
     background:#d63384; color:#fff; width:56px; height:56px; border-radius:50%;
     display:flex; align-items:center; justify-content:center; cursor:pointer;
     box-shadow:0 4px 12px rgba(0,0,0,0.3); font-size:24px;">
    <i class="bi bi-chat-dots-fill"></i>
</div>

<div id="chatbotWindow" style="position:fixed; bottom:90px; right:20px; width:320px; height:420px;
     background:#fff; border-radius:12px; box-shadow:0 8px 24px rgba(0,0,0,0.25);
     display:none; flex-direction:column; z-index:1050; overflow:hidden;">

    <div style="background:#d63384; color:#fff; padding:12px 16px; font-weight:bold;">
        <i class="bi bi-stars"></i> Ask about our services
    </div>

    <div id="chatbotMessages" style="flex:1; padding:12px; overflow-y:auto; font-size:14px; background:#fdf2f8;">
        <div style="margin-bottom:8px;"><strong>Assistant:</strong> Hi! Ask me which service suits you, or when to get something done.</div>
    </div>

    <div style="display:flex; border-top:1px solid #eee;">
        <input type="text" id="chatbotInput" placeholder="Type your question..."
               style="flex:1; border:none; padding:10px; font-size:14px; outline:none;">
        <button id="chatbotSend" style="background:#d63384; color:#fff; border:none; padding:0 16px;">
            <i class="bi bi-send-fill"></i>
        </button>
    </div>
</div>

<script>
document.getElementById('chatbotToggle').addEventListener('click', function () {
    var win = document.getElementById('chatbotWindow');
    win.style.display = (win.style.display === 'flex') ? 'none' : 'flex';
});

function appendMessage(sender, text) {
    var box = document.getElementById('chatbotMessages');
    var div = document.createElement('div');
    div.style.marginBottom = '8px';
    div.innerHTML = '<strong>' + sender + ':</strong> ' + text;
    box.appendChild(div);
    box.scrollTop = box.scrollHeight;
}

function sendChatMessage() {
    var input = document.getElementById('chatbotInput');
    var message = input.value.trim();
    if (!message) return;

    appendMessage('You', message);
    input.value = '';
    appendMessage('Assistant', '<em>Typing...</em>');

    fetch('${pageContext.request.contextPath}/chatbot/ask', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ message: message })
    })
    .then(function (res) { return res.json(); })
    .then(function (data) {
        var box = document.getElementById('chatbotMessages');
        box.removeChild(box.lastChild);
        appendMessage('Assistant', data.reply);
    })
    .catch(function () {
        var box = document.getElementById('chatbotMessages');
        box.removeChild(box.lastChild);
        appendMessage('Assistant', 'Sorry, something went wrong. Please try again.');
    });
}

document.getElementById('chatbotSend').addEventListener('click', sendChatMessage);
document.getElementById('chatbotInput').addEventListener('keypress', function (e) {
    if (e.key === 'Enter') sendChatMessage();
});
</script>
</body>

</html>
