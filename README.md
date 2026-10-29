# Kshitija Ladies Salon — Management System

Online appointment booking and management system for Kshitija Ladies Salon.

## 🎬 Demo Video

[![Watch the demo](https://img.youtube.com/vi/H9_rMp8lyBQ/0.jpg)](https://www.youtube.com/watch?v=H9_rMp8lyBQ)

## ✨ Features

- **Service catalog** — 277+ services organized by category, with live search
- **Live bill** — bill is calculated server-side from database prices as services are selected
- **Online payments** — Razorpay integration; pay in full, or ₹50 advance for bills above ₹100 (server-side validation of the payment policy)
- **Booking confirmation** — signature-verified payment flow with a booking confirmation page
- **AI chatbot** — answers customer queries (Groq API)
- **Owner dashboard** — view and manage confirmed bookings, delete appointments
- **WhatsApp confirmation** — booking notifications via Meta Cloud API (in progress)

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Backend | Java, Spring MVC 5.3 (XML config), Spring JDBC |
| Frontend | JSP, JSTL, Bootstrap 5 |
| Database | MySQL |
| Payments | Razorpay |
| Chatbot | Groq API |
| Server | Apache Tomcat 9 |
| Build | Maven (WAR packaging) |

## 🚀 Running Locally

1. **Clone the repo**
   ```bash
   git clone https://github.com/Atharva170205/Kshitija-ladies-salon-Management_System.git
