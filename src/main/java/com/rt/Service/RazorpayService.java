package com.rt.Service;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
@Service
public class RazorpayService {

    @Value("${razorpay.key.id}")
    private String keyId;

    @Value("${razorpay.key.secret}")
    private String keySecret;

    public String getKeyId() {
        return keyId;
    }
    /** True only if Razorpay really signed this order + payment pair. */
    public boolean verifySignature(String orderId, String paymentId, String signature) {

        if (orderId == null || paymentId == null || signature == null) {
            return false;
        }

        try {

            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(
                    keySecret.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));

            byte[] hash = mac.doFinal(
                    (orderId + "|" + paymentId).getBytes(StandardCharsets.UTF_8));

            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                hex.append(String.format("%02x", b));
            }

            // constant-time comparison
            return MessageDigest.isEqual(
                    hex.toString().getBytes(StandardCharsets.UTF_8),
                    signature.trim().getBytes(StandardCharsets.UTF_8));

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Creates an order at Razorpay and returns its id (order_xxxx). */
    public String createOrder(long amountPaise, String receipt) {

        try {

            RazorpayClient client = new RazorpayClient(keyId, keySecret);

            JSONObject req = new JSONObject();
            req.put("amount", amountPaise);
            req.put("currency", "INR");
            req.put("receipt", receipt);

            Order order = client.orders.create(req);

            return order.get("id");

        } catch (Exception e) {
            throw new IllegalStateException("Unable to create payment order", e);
        }
    }
}