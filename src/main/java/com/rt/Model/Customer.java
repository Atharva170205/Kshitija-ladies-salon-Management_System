package com.rt.Model;

import java.math.BigDecimal;

public class Customer {

    private int id;

    private String name;

    private String address;

    private String mobile;

    private String service;

    private String time;

    private BigDecimal totalAmount;

    private String jobStatus;

    private String paymentStatus;

    public Customer() {
    }

    public Customer(
            String name,
            String address,
            String mobile,
            String service,
            String time) {

        this.name = name;
        this.address = address;
        this.mobile = mobile;
        this.service = service;
        this.time = time;
    }

    // =====================================================
    // ID
    // =====================================================

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // =====================================================
    // NAME
    // =====================================================

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // =====================================================
    // ADDRESS
    // =====================================================

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    // =====================================================
    // MOBILE
    // =====================================================

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    // =====================================================
    // SERVICE
    // =====================================================

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    // =====================================================
    // TIME
    // =====================================================

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    // =====================================================
    // TOTAL AMOUNT
    // =====================================================

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    // =====================================================
    // JOB STATUS
    // =====================================================

    public String getJobStatus() {
        return jobStatus;
    }

    public void setJobStatus(String jobStatus) {
        this.jobStatus = jobStatus;
    }

    // =====================================================
    // PAYMENT STATUS
    // =====================================================

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
}