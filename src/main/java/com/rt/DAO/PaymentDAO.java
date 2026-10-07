package com.rt.DAO;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.rt.Model.CheckoutInfo;
import com.rt.Model.Payment;

@Repository
public class PaymentDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // No try/catch on purpose: errors must roll the booking back.
    public void insert(int customerId, String type,
                       BigDecimal amount, String orderId) {

        jdbcTemplate.update(
                "INSERT INTO payment " +
                "(customer_id, payment_type, amount, razorpay_order_id) " +
                "VALUES (?, ?, ?, ?)",
                customerId, type, amount, orderId);
    }

    // ---------- checkout page (unpaid orders only) ----------

    public CheckoutInfo findCheckoutByOrderId(String orderId) {

        String sql =
                "SELECT p.customer_id, p.razorpay_order_id, p.amount, " +
                "p.payment_type, c.name, c.mobile, c.total_amount " +
                "FROM payment p JOIN Customer c ON c.id = p.customer_id " +
                "WHERE p.razorpay_order_id = ? AND p.status = 'CREATED'";

        List<CheckoutInfo> list = jdbcTemplate.query(sql, (rs, i) -> {
            CheckoutInfo c = new CheckoutInfo();
            c.setCustomerId(rs.getInt("customer_id"));
            c.setOrderId(rs.getString("razorpay_order_id"));
            c.setAmount(rs.getBigDecimal("amount"));
            c.setPaymentType(rs.getString("payment_type"));
            c.setName(rs.getString("name"));
            c.setMobile(rs.getString("mobile"));
            c.setTotal(rs.getBigDecimal("total_amount"));
            return c;
        }, orderId);

        return list.isEmpty() ? null : list.get(0);
    }

    // ---------- confirmation page + WhatsApp (paid orders only) ----------

    public CheckoutInfo findPaidByOrderId(String orderId) {

        String sql =
                "SELECT p.customer_id, p.razorpay_order_id, p.amount, " +
                "p.payment_type, c.name, c.mobile, c.total_amount, c.service, " +
                "DATE_FORMAT(c.`time`, '%d %b %Y, %h:%i %p') AS appt_time " +
                "FROM payment p JOIN Customer c ON c.id = p.customer_id " +
                "WHERE p.razorpay_order_id = ? AND p.status = 'PAID'";

        List<CheckoutInfo> list = jdbcTemplate.query(sql, (rs, i) -> {
            CheckoutInfo c = new CheckoutInfo();
            c.setCustomerId(rs.getInt("customer_id"));
            c.setOrderId(rs.getString("razorpay_order_id"));
            c.setAmount(rs.getBigDecimal("amount"));
            c.setPaymentType(rs.getString("payment_type"));
            c.setName(rs.getString("name"));
            c.setMobile(rs.getString("mobile"));
            c.setTotal(rs.getBigDecimal("total_amount"));
            c.setService(rs.getString("service"));
            c.setTime(rs.getString("appt_time"));
            return c;
        }, orderId);

        return list.isEmpty() ? null : list.get(0);
    }

    // ---------- verification ----------

    public Payment getByOrderId(String orderId) {

        String sql =
                "SELECT id, customer_id AS customerId, payment_type AS paymentType, " +
                "amount, razorpay_order_id AS razorpayOrderId, " +
                "razorpay_payment_id AS razorpayPaymentId, status, " +
                "whatsapp_status AS whatsappStatus " +
                "FROM payment WHERE razorpay_order_id = ?";

        List<Payment> list = jdbcTemplate.query(
                sql, new BeanPropertyRowMapper<>(Payment.class), orderId);

        return list.isEmpty() ? null : list.get(0);
    }

    /** Returns 1 the first time, 0 if this order was already marked paid. */
    public int markPaid(String orderId, String paymentId) {

        return jdbcTemplate.update(
                "UPDATE payment SET status = 'PAID', razorpay_payment_id = ?, " +
                "paid_at = NOW() " +
                "WHERE razorpay_order_id = ? AND status = 'CREATED'",
                paymentId, orderId);
    }

    // ---------- WhatsApp bookkeeping (prevents duplicate messages) ----------

    /** True for exactly one caller, even if the page is submitted twice. */
    public boolean claimWhatsapp(String orderId) {

        return jdbcTemplate.update(
                "UPDATE payment SET whatsapp_status = 'SENDING' " +
                "WHERE razorpay_order_id = ? AND status = 'PAID' " +
                "AND whatsapp_status = 'PENDING'", orderId) > 0;
    }

    public void setWhatsappStatus(String orderId, String status) {

        jdbcTemplate.update(
                "UPDATE payment SET whatsapp_status = ? WHERE razorpay_order_id = ?",
                status, orderId);
    }
}