package com.rt.Model;

import java.math.BigDecimal;

public class Payment {

    private int id;
    private int customerId;
    private String paymentType;
    private BigDecimal amount;
    private String razorpayOrderId;
    private String razorpayPaymentId;
    private String status;
    private String whatsappStatus;

    public Payment() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getPaymentType() { return paymentType; }
    public void setPaymentType(String paymentType) { this.paymentType = paymentType; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public String getRazorpayOrderId() { return razorpayOrderId; }
    public void setRazorpayOrderId(String razorpayOrderId) { this.razorpayOrderId = razorpayOrderId; }

    public String getRazorpayPaymentId() { return razorpayPaymentId; }
    public void setRazorpayPaymentId(String razorpayPaymentId) { this.razorpayPaymentId = razorpayPaymentId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getWhatsappStatus() { return whatsappStatus; }
    public void setWhatsappStatus(String whatsappStatus) { this.whatsappStatus = whatsappStatus; }
}