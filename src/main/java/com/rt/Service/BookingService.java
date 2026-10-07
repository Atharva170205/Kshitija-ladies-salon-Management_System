package com.rt.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rt.DAO.CustomerDAO;
import com.rt.DAO.PaymentDAO;
import com.rt.DAO.SalServiceDAO;
import com.rt.DAO.SelectedServiceDAO;
import com.rt.Model.CheckoutInfo;
import com.rt.Model.Customer;
import com.rt.Model.Payment;
import com.rt.Model.SalService;
import com.rt.Model.SelectedService;

@Service
public class BookingService {

    @Autowired
    private SalServiceDAO salServiceDAO;

    @Autowired
    private SelectedServiceDAO selectedServiceDAO;

    @Autowired
    private CustomerDAO customerDAO;

    @Autowired
    private PaymentDAO paymentDAO;

    @Autowired
    private RazorpayService razorpayService;

    // =====================================================
    // CATALOG (CustomerAppointment.jsp and Home.jsp)
    // =====================================================

    public Map<String, List<SalService>> getServicesByCategory() {

        Map<String, List<SalService>> map = new LinkedHashMap<>();

        for (SalService s : salServiceDAO.getAllServices()) {
            map.computeIfAbsent(s.getCategory(), k -> new ArrayList<>()).add(s);
        }
        return map;
    }

    public List<SalService> getSuggestedServices() {
        return salServiceDAO.getPopularServices();
    }

    // =====================================================
    // START BOOKING: save as 'Awaiting Payment' + Razorpay order
    // =====================================================

    @Transactional(rollbackFor = Exception.class)
    public String startBooking(Customer customer, String serviceIds,
                               String paymentChoice) {

        // 1. Parse ids
        Set<Integer> idSet = new LinkedHashSet<>();

        if (serviceIds != null) {
            for (String part : serviceIds.split(",")) {
                try {
                    idSet.add(Integer.parseInt(part.trim()));
                } catch (NumberFormatException ignored) {
                }
            }
        }

        if (idSet.isEmpty()) {
            throw new IllegalArgumentException("Please select at least one service.");
        }

        // 2. Real services and prices from the DB
        List<SalService> services =
                salServiceDAO.getServicesByIds(new ArrayList<>(idSet));

        if (services.isEmpty()) {
            throw new IllegalArgumentException("Selected services were not found.");
        }

        // 3. Bill and summary
        BigDecimal total = BigDecimal.ZERO;
        StringBuilder summary = new StringBuilder();

        for (SalService s : services) {
            total = total.add(s.getPrice());
            if (summary.length() > 0) {
                summary.append(" + ");
            }
            summary.append(s.getDisplayLabel());
        }

        customer.setService(summary.toString());
        customer.setTotalAmount(total);

        // 4. Customer row + service rows
        int customerId = customerDAO.insertAppointment(customer);

        List<SelectedService> rows = new ArrayList<>();
        for (SalService s : services) {
            rows.add(new SelectedService(
                    customerId, s.getId(), s.getFullLabel(), s.getPrice()));
        }
        selectedServiceDAO.insertAll(rows);

        // 5. Payment rule (server decides, not the browser)
        String type = PaymentPolicy.resolveType(total, paymentChoice);
        BigDecimal payNow = PaymentPolicy.amountToPayNow(total, type);

        // 6. Razorpay order + payment row
        String orderId = razorpayService.createOrder(
                PaymentPolicy.toPaise(payNow), "cust_" + customerId);

        paymentDAO.insert(customerId, type, payNow, orderId);

        return orderId;
    }

    // =====================================================
    // CHECKOUT PAGE
    // =====================================================

    public CheckoutInfo getCheckoutInfo(String orderId) {

        CheckoutInfo info = paymentDAO.findCheckoutByOrderId(orderId);

        if (info != null) {
            info.setKeyId(razorpayService.getKeyId());
        }
        return info;
    }

    // =====================================================
    // CONFIRM PAYMENT (called after Razorpay succeeds)
    // Safe to call twice: the second call changes nothing.
    // =====================================================

    @Transactional(rollbackFor = Exception.class)
    public int confirmPayment(String orderId, String paymentId, String signature) {

        if (!razorpayService.verifySignature(orderId, paymentId, signature)) {
            throw new IllegalArgumentException(
                    "Payment could not be verified. If money was deducted, please contact the salon.");
        }

        Payment p = paymentDAO.getByOrderId(orderId);

        if (p == null) {
            throw new IllegalArgumentException("Payment record not found.");
        }

        int rows = paymentDAO.markPaid(orderId, paymentId);

        if (rows == 1) {
            customerDAO.confirmBooking(
                    p.getCustomerId(),
                    p.getAmount(),
                    PaymentPolicy.TYPE_FULL.equals(p.getPaymentType()));
        }

        return p.getCustomerId();
    }

    // =====================================================
    // BOOKING CONFIRMED PAGE
    // =====================================================

    public CheckoutInfo getConfirmation(String orderId) {
        return paymentDAO.findPaidByOrderId(orderId);
    }
}