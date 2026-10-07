package com.rt.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rt.DAO.PaymentDAO;
import com.rt.Model.CheckoutInfo;

@Service
public class NotificationService {

    @Autowired
    private PaymentDAO paymentDAO;

    @Autowired
    private WhatsAppService whatsAppService;

    /**
     * Sends the confirmation once per payment. Never throws: a WhatsApp
     * problem must not undo a successful payment.
     */
    public void sendConfirmationOnce(String orderId) {

        if (!paymentDAO.claimWhatsapp(orderId)) {
            return;   // already sent, or being sent
        }

        boolean ok = false;

        try {

            CheckoutInfo info = paymentDAO.findPaidByOrderId(orderId);

            if (info != null) {
                ok = whatsAppService.sendBookingConfirmation(info);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        paymentDAO.setWhatsappStatus(orderId, ok ? "SENT" : "FAILED");
    }
}