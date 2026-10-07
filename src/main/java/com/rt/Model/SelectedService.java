package com.rt.Model;

import java.math.BigDecimal;

public class SelectedService {

    private int id;
    private int customerId;
    private int serviceId;
    private String serviceName;   // snapshot at booking time
    private BigDecimal price;     // snapshot at booking time

    public SelectedService() {
    }

    public SelectedService(int customerId, int serviceId,
                           String serviceName, BigDecimal price) {
        this.customerId = customerId;
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.price = price;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getServiceId() { return serviceId; }
    public void setServiceId(int serviceId) { this.serviceId = serviceId; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
}