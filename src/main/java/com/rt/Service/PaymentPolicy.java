package com.rt.Service;

import java.math.BigDecimal;

public final class PaymentPolicy {

    /** Bills above this amount may pay only the advance. */
    public static final BigDecimal ADVANCE_ALLOWED_ABOVE = new BigDecimal("100");

    /** Minimum advance for pre-booking. */
    public static final BigDecimal ADVANCE = new BigDecimal("50");

    public static final String TYPE_ADVANCE = "ADVANCE";
    public static final String TYPE_FULL    = "FULL";

    private PaymentPolicy() {
    }

    public static boolean advanceAllowed(BigDecimal total) {
        return total.compareTo(ADVANCE_ALLOWED_ABOVE) > 0;
    }

    /**
     * @param total  bill total calculated from DB prices
     * @param choice what the customer picked: "ADVANCE" or "FULL" (may be null)
     * @return the payment type that will really be charged
     */
    public static String resolveType(BigDecimal total, String choice) {

        if (advanceAllowed(total) && TYPE_ADVANCE.equalsIgnoreCase(choice)) {
            return TYPE_ADVANCE;
        }
        return TYPE_FULL;
    }

    public static BigDecimal amountToPayNow(BigDecimal total, String type) {
        return TYPE_ADVANCE.equals(type) ? ADVANCE : total;
    }

    /** Razorpay works in paise: Rs 50 -> 5000 */
    public static long toPaise(BigDecimal rupees) {
        return rupees.movePointRight(2).longValueExact();
    }
}