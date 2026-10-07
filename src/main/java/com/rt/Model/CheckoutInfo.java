package com.rt.Model;

import java.math.BigDecimal;

public class CheckoutInfo {

    private int customerId;
    private String orderId;
    private BigDecimal amount;      // rupees paid / to pay now
    private String paymentType;     // ADVANCE or FULL
    private String name;
    private String mobile;
    private BigDecimal total;       // full bill
    private String keyId;           // Razorpay public key
    private String service;         // e.g. "Eyebrows + Straight (Medium)"
    private String time;            // formatted appointment time

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public String getPaymentType() { return paymentType; }
    public void setPaymentType(String paymentType) { this.paymentType = paymentType; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }

    public BigDecimal getTotal() { return total; }
    public void setTotal(BigDecimal total) { this.total = total; }

    public String getKeyId() { return keyId; }
    public void setKeyId(String keyId) { this.keyId = keyId; }

    public String getService() { return service; }
    public void setService(String service) { this.service = service; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }

    /** Razorpay needs paise: 50.00 -> 5000 */
    public long getAmountPaise() {
        return amount.movePointRight(2).longValueExact();
    }

    /** Amount left to pay at the salon */
    public BigDecimal getBalance() {
        return total.subtract(amount);
    }

    /** Shown on the success page, e.g. ******4321 */
    public String getMaskedMobile() {
        if (mobile == null || mobile.length() < 4) { return ""; }
        return "******" + mobile.substring(mobile.length() - 4);
    }
}