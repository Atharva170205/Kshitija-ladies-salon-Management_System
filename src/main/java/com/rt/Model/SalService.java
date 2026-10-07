package com.rt.Model;

import java.math.BigDecimal;

public class SalService {

    private int id;
    private String category;
    private String serviceName;
    private String variant;
    private BigDecimal price;
    private boolean popular;

    public SalService() {
    }

    // ---------- getters / setters ----------

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public String getVariant() { return variant; }
    public void setVariant(String variant) { this.variant = variant; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public boolean isPopular() { return popular; }
    public void setPopular(boolean popular) { this.popular = popular; }

    // ---------- computed labels ----------

    /** Label shown in the JSP (${svc.displayLabel}). */
    public String getDisplayLabel() {
        if (variant == null || variant.trim().isEmpty()
                || "Standard".equalsIgnoreCase(variant.trim())) {
            return serviceName;
        }
        return serviceName + " (" + variant + ")";
    }

    /** Label saved with the bill, e.g. "Waxing (Face & Body) - Full Leg (Rica)". */
    public String getFullLabel() {
        return category + " - " + getDisplayLabel();
    }
}