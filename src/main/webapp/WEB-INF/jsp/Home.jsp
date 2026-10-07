<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Kshitija Ladies Salon</title>

    <!-- Favicon -->
    <link rel="icon"
          type="image/png"
          href="${pageContext.request.contextPath}/Web_img/Background.png">

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Google Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Poppins:wght@300;400;500;600&display=swap"
        rel="stylesheet">


    <style>

        :root {
            --pink: #ff8fb3;
            --pink-deep: #e85c8a;
            --pink-pale: #ffe3ec;
            --gold: #d4a53d;
            --gold-light: #f3cf74;
            --dark: #3a2630;
        }


        * {
            box-sizing: border-box;
        }


        html {
            scroll-behavior: smooth;
        }


        body {
            margin: 0;
            padding: 0;

            font-family: 'Poppins', sans-serif;

            color: var(--dark);

            background: #fff;

            overflow-x: hidden;
        }


        h1,
        h2,
        h3,
        .brand {
            font-family: 'Playfair Display', serif;
        }


        /* =====================================================
           NAVBAR
           ===================================================== */

        .navbar {
            position: sticky;

            top: 0;

            z-index: 9999;

            width: 100%;

            background: rgba(255, 255, 255, 0.98);

            padding: 16px 0;

            box-shadow:
                0 4px 20px rgba(58, 38, 48, 0.12);

            border-bottom:
                2px solid var(--gold-light);

            backdrop-filter: blur(10px);
        }


        .navbar-brand {
            color: var(--dark) !important;

            font-size: 24px;

            letter-spacing: 0.5px;

            font-weight: 600;
        }


        .navbar-brand i {
            color: var(--gold);

            margin-right: 8px;
        }


        .nav-link {
            color: #6b5560 !important;

            font-weight: 500;

            margin: 0 6px;
        }


        .nav-link:hover {
            color: var(--pink-deep) !important;
        }


        /* =====================================================
           BUTTONS
           ===================================================== */

        .btn-gold {
            background:
                linear-gradient(
                    135deg,
                    var(--gold-light),
                    var(--gold)
                );

            color: #3a2a0c;

            font-weight: 600;

            border: none;

            padding: 10px 28px;

            border-radius: 30px;

            box-shadow:
                0 8px 20px rgba(212, 165, 61, 0.4);

            transition: 0.25s;
        }


        .btn-gold:hover {
            color: #3a2a0c;

            transform: translateY(-2px);

            box-shadow:
                0 10px 26px rgba(212, 165, 61, 0.55);
        }


        .btn-outline-gold {
            border:
                1.5px solid var(--gold);

            color: var(--gold);

            font-weight: 600;

            padding: 9px 24px;

            border-radius: 30px;

            transition: 0.25s;
        }


        .btn-outline-gold:hover {
            background: var(--gold);

            color: #fff;
        }


        /* =====================================================
           HERO

           IMPORTANT:
           The hero content is pushed downward so the logo/name
           printed inside Background.png becomes visible.
           ===================================================== */

        .hero {
            position: relative;

            min-height: 88vh;

            display: flex;

            align-items: flex-start;

            padding-top: 145px;

            padding-bottom: 90px;

            background:
                linear-gradient(
                    135deg,
                    rgba(232, 92, 138, 0.42),
                    rgba(58, 38, 48, 0.55)
                ),
                url('${pageContext.request.contextPath}/Web_img/Background.png');

            background-position: center top;

            background-size: cover;

            background-repeat: no-repeat;

            background-attachment: scroll;

            color: #fff;

            overflow: hidden;
        }


        .hero .container {
            position: relative;

            z-index: 2;
        }


        .hero .eyebrow {
            letter-spacing: 3px;

            color: #3a2a0c;

            background:
                linear-gradient(
                    135deg,
                    var(--gold-light),
                    var(--gold)
                );

            display: inline-block;

            padding: 6px 16px;

            border-radius: 20px;

            font-size: 13px;

            font-weight: 700;

            text-transform: uppercase;
        }


        .hero h1 {
            font-size: 52px;

            line-height: 1.15;

            margin: 18px 0 22px;

            text-shadow:
                0 2px 20px rgba(0, 0, 0, 0.25);
        }


        .hero p.lead {
            color: #fff0f5;

            max-width: 520px;

            margin-bottom: 34px;

            font-size: 18px;

            line-height: 1.7;
        }


        /* =====================================================
           ABOUT
           ===================================================== */

        .about-section {
            padding: 90px 0;

            background: #fff;
        }


        .about-section .eyebrow,
        .section-heading .eyebrow {
            color: var(--gold);

            letter-spacing: 3px;

            font-weight: 700;

            font-size: 13px;

            text-transform: uppercase;
        }


        .about-img {
            border-radius: 20px;

            overflow: hidden;

            height: 420px;

            border: 4px solid var(--gold-light);

            box-shadow:
                0 25px 50px rgba(212, 165, 61, 0.25);
        }


        .about-img img {
            width: 100%;

            height: 100%;

            object-fit: cover;

            object-position: center;

            display: block;
        }


        .stat-card {
            text-align: center;

            padding: 24px 12px;

            background: var(--pink-pale);

            border-radius: 16px;

            border-bottom:
                3px solid var(--gold-light);
        }


        .stat-card h2 {
            color: var(--pink-deep);

            font-size: 38px;

            margin-bottom: 2px;
        }


        .stat-card p {
            color: #8a6f7a;

            margin: 0;

            font-size: 13px;

            text-transform: uppercase;
        }


        /* =====================================================
           SERVICES
           ===================================================== */

        .services-section {
            padding: 90px 0;

            background:
                linear-gradient(
                    180deg,
                    #fff 0%,
                    #fff8ec 100%
                );
        }


        /*
         * CATEGORY TABS
         */

        .service-tabs {
            border-bottom:
                2px solid #f1dca5;

            gap: 8px;

            justify-content: center;

            margin-bottom: 30px;
        }


        .service-tabs .nav-link {
            color: var(--dark) !important;

            background: #fff;

            border:
                1px solid #ffe3ec;

            border-radius: 30px;

            padding: 10px 20px;

            font-weight: 600;

            margin: 0;

            transition: 0.25s;
        }


        .service-tabs .nav-link:hover {
            color: var(--pink-deep) !important;

            border-color: var(--gold-light);

            transform: translateY(-2px);
        }


        .service-tabs .nav-link.active {
            color: #3a2a0c !important;

            background:
                linear-gradient(
                    135deg,
                    var(--gold-light),
                    var(--gold)
                );

            border-color: var(--gold);

            box-shadow:
                0 6px 16px rgba(212, 165, 61, 0.25);
        }


        /*
         * SERVICE CARDS
         */

        .service-list {
            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(250px, 1fr));

            gap: 18px;
        }


        .service-item {
            background: #fff;

            border:
                1px solid #ffe3ec;

            border-radius: 16px;

            padding: 20px;

            box-shadow:
                0 8px 24px rgba(232, 92, 138, 0.08);

            transition: 0.25s;

            display: flex;

            flex-direction: column;

            justify-content: space-between;
        }


        .service-item:hover {
            transform: translateY(-5px);

            border-color: var(--gold-light);

            box-shadow:
                0 15px 30px rgba(212, 165, 61, 0.22);
        }


        .service-item h5 {
            font-size: 16px;

            font-weight: 600;

            margin-bottom: 8px;

            font-family: 'Poppins', sans-serif;
        }


        .service-item h5 i {
            color: var(--pink-deep);

            margin-right: 5px;
        }


        .service-variant {
            color: #8a6f7a;

            font-size: 13px;

            margin-bottom: 10px;
        }


        .service-price {
            color: var(--gold);

            font-size: 21px;

            font-weight: 700;
        }


        .service-book-btn {
            margin-top: 15px;

            width: 100%;

            border-radius: 25px;

            font-size: 14px;

            padding: 9px 15px;
        }


        .service-count {
            color: #8a6f7a;

            font-size: 13px;

            margin-bottom: 20px;
        }


        /* =====================================================
           CTA
           ===================================================== */

        .cta-section {
            background:
                linear-gradient(
                    135deg,
                    var(--pink),
                    var(--pink-deep)
                );

            color: #fff;

            padding: 70px 0;

            text-align: center;
        }


        .cta-section p {
            color: #fff0f5;

            margin-bottom: 30px;
        }


        /* =====================================================
           FOOTER
           ===================================================== */

        footer {
            background: #fff;

            color: #8a6f7a;

            padding: 40px 0 20px;

            font-size: 14px;

            text-align: center;

            border-top:
                2px solid var(--gold-light);
        }


        footer .brand {
            color: var(--dark);

            font-size: 20px;

            display: block;

            margin-bottom: 10px;
        }


        footer i {
            color: var(--gold);
        }


        footer a {
            color: #8a6f7a;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 991px) {

            .hero {
                min-height: 80vh;

                padding-top: 120px;
            }


            .hero h1 {
                font-size: 44px;
            }


            .service-tabs {
                overflow-x: auto;

                flex-wrap: nowrap;

                justify-content: flex-start;

                padding-bottom: 12px;
            }


            .service-tabs .nav-link {
                white-space: nowrap;
            }
        }


        @media (max-width: 767px) {

            .navbar-brand {
                font-size: 20px;
            }


            .hero {
                min-height: 75vh;

                padding-top: 100px;

                padding-bottom: 70px;

                background-position: center top;
            }


            .hero h1 {
                font-size: 37px;
            }


            .hero p.lead {
                font-size: 16px;
            }


            .about-section,
            .services-section {
                padding: 65px 0;
            }


            .about-img {
                height: 320px;
            }
        }


        @media (max-width: 480px) {

            .navbar-brand {
                font-size: 18px;
            }


            .hero {
                padding-top: 85px;
            }


            .hero h1 {
                font-size: 31px;
            }


            .hero .eyebrow {
                font-size: 11px;

                letter-spacing: 2px;
            }
        }

    </style>

</head>


<body>


    <!-- =====================================================
         NAVBAR
         ===================================================== -->

    <nav class="navbar navbar-expand-lg">

        <div class="container">

            <a class="navbar-brand brand"
               href="${pageContext.request.contextPath}/home">

                <i class="bi bi-flower2"></i>
                Kshitija Ladies Salon

            </a>


            <div class="d-flex align-items-center">

                <a class="nav-link d-none d-md-inline"
                   href="${pageContext.request.contextPath}/Admin_Register">

                    Admin Register

                </a>


                <a href="${pageContext.request.contextPath}/login"
                   class="btn btn-outline-gold ms-3">

                    Admin Login

                </a>

            </div>

        </div>

    </nav>



<!-- =====================================================
     HERO
     ===================================================== -->
<section class="hero">
    <div class="container">
        <div class="row justify-content-end">
            <div class="col-lg-7 text-lg-end">

                <div class="eyebrow">
                    Style &middot; Care &middot; Confidence
                </div>

                <h1>
                    Look Beautiful. Feel Radiant.
                    <br>
                    Every Single Visit.
                </h1>

                <p class="lead ms-auto">
                    Kshitija Ladies Salon brings expert stylists,
                    premium products, and a relaxing space designed
                    just for women &mdash; from a quick haircut to
                    a full bridal makeover.
                </p>

                <a href="${pageContext.request.contextPath}/bookAppointment"
                   class="btn btn-gold btn-lg">
                    <i class="bi bi-calendar-check"></i>
                    &nbsp; Book an Appointment
                </a>

            </div>
        </div>
    </div>
</section>



    <!-- =====================================================
         ABOUT
         ===================================================== -->

    <section class="about-section">

        <div class="container">

            <div class="row align-items-center g-5">

                <div class="col-lg-6">

                    <div class="about-img">

                        <img
                            src="${pageContext.request.contextPath}/Web_img/img3.jpeg"
                            alt="Kshitija Ladies Salon interior">

                    </div>

                </div>


                <div class="col-lg-6">

                    <div class="eyebrow">
                        About Us
                    </div>


                    <h2 class="mb-3">
                        Years of Craft, Thousands of Happy Clients
                    </h2>


                    <p class="text-muted mb-4">

                        What started as a small neighbourhood salon has
                        grown into a trusted destination for women's
                        grooming and beauty. Our stylists are trained
                        in the latest techniques and our products are
                        chosen with the same care we'd want for our
                        own family.

                    </p>


                    <div class="row text-start g-3">

                        <div class="col-6 col-md-3 stat-card">

                            <h2>8+</h2>

                            <p>Years Running</p>

                        </div>


                        <div class="col-6 col-md-3 stat-card">

                            <h2>10k+</h2>

                            <p>Happy Clients</p>

                        </div>


                        <div class="col-6 col-md-3 stat-card">

                            <h2>15+</h2>

                            <p>Expert Stylists</p>

                        </div>


                        <div class="col-6 col-md-3 stat-card">

                            <h2>4.8</h2>

                            <p>Average Rating</p>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </section>



    <!-- =====================================================
         SERVICES & PRICING
         
         Each category is a Bootstrap tab.
         Each service has its own Select & Book button.
         ===================================================== -->

    <section class="services-section"
             id="services">

        <div class="container">


            <div class="section-heading text-center mb-4">

                <div class="eyebrow">
                    What We Offer
                </div>


                <h2>
                    Our Services &amp; Pricing
                </h2>


                <p class="text-muted">

                    Select a category and choose the service you want.
                    You can select multiple services on the appointment page.

                </p>

            </div>


            <!-- CATEGORY TABS -->

            <ul class="nav nav-pills service-tabs"
                id="serviceTabs"
                role="tablist">


                <c:forEach
                    var="entry"
                    items="${servicesByCategory}"
                    varStatus="status">

                    <li class="nav-item"
                        role="presentation">

                        <button
                            class="nav-link ${status.first ? 'active' : ''}"
                            id="tab-${status.index}"
                            data-bs-toggle="pill"
                            data-bs-target="#category-${status.index}"
                            type="button"
                            role="tab">

                            <c:out value="${entry.key}" />

                        </button>

                    </li>

                </c:forEach>


            </ul>



            <!-- TAB CONTENT -->

            <div class="tab-content"
                 id="serviceTabContent">


                <c:forEach
                    var="entry"
                    items="${servicesByCategory}"
                    varStatus="status">


                    <div
                        class="tab-pane fade ${status.first ? 'show active' : ''}"
                        id="category-${status.index}"
                        role="tabpanel">


                        <div class="d-flex justify-content-between align-items-center mb-3">

                            <h4 class="mb-0">

                                <c:out value="${entry.key}" />

                            </h4>


                            <span class="service-count">

                                ${entry.value.size()} services

                            </span>

                        </div>



                        <div class="service-list">


                            <c:forEach
                                var="svc"
                                items="${entry.value}">


                                <c:url
                                    value="/bookAppointment"
                                    var="serviceBookUrl">

                                    <c:param
                                        name="serviceId"
                                        value="${svc.id}" />

                                </c:url>


                                <div class="service-item">


                                    <div>

                                        <h5>

                                            <i class="bi bi-stars"></i>

                                            <c:out
                                                value="${svc.serviceName}" />

                                        </h5>


                                        <div class="service-variant">

                                            <c:out
                                                value="${svc.variant}" />

                                        </div>


                                        <div class="service-price">

                                            &#8377;
                                            <fmt:formatNumber
                                                value="${svc.price}"
                                                maxFractionDigits="0" />

                                        </div>

                                    </div>



                                    <a
                                        href="${serviceBookUrl}"
                                        class="btn btn-gold service-book-btn">

                                        <i class="bi bi-calendar-check"></i>

                                        Select &amp; Book

                                    </a>


                                </div>


                            </c:forEach>


                        </div>

                    </div>


                </c:forEach>


            </div>


        </div>

    </section>



    <!-- =====================================================
         CTA
         ===================================================== -->

    <section class="cta-section">

        <div class="container">

            <h2>
                Ready for your next appointment?
            </h2>


            <p>
                Pick a service, choose a time, and we'll take care of the rest.
            </p>


            <a
                href="${pageContext.request.contextPath}/bookAppointment"
                class="btn btn-gold btn-lg">

                <i class="bi bi-calendar-check"></i>
                &nbsp; Book Now

            </a>

        </div>

    </section>



    <!-- =====================================================
         FOOTER
         ===================================================== -->

    <footer>

        <div class="container">

            <span class="brand">

                <i class="bi bi-flower2"></i>
                Kshitija Ladies Salon

            </span>


            <p class="mb-1">

                &copy; <%= java.time.Year.now() %>
                Kshitija Ladies Salon.
                All rights reserved.

            </p>


            <p class="mb-0">

                <a
                    href="${pageContext.request.contextPath}/login"
                    style="text-decoration: underline;">

                    Admin Login

                </a>

                &nbsp;&middot;&nbsp;

                <a
                    href="${pageContext.request.contextPath}/Admin_Register"
                    style="text-decoration: underline;">

                    Admin Register

                </a>

            </p>

        </div>

    </footer>



    <!-- Bootstrap JS -->

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
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
        <div style="margin-bottom:8px;"><strong>Assistant:</strong> Hi! I am Kshitija your personal assistant . What is your name ?</div>
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

// Auto-open the chatbot once when the page loads
window.addEventListener('load', function () {
    document.getElementById('chatbotWindow').style.display = 'flex';
});
</script>
</body>

</html>