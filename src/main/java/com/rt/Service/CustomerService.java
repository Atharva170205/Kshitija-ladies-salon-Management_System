package com.rt.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rt.DAO.CustomerDAO;
import com.rt.Model.Customer;

@Service
public class CustomerService {

    @Autowired
    private CustomerDAO customerDAO;

  
    // =====================================================
    // GET ALL APPOINTMENTS
    // =====================================================

    public List<Customer> getAllAppointments() {

        return customerDAO.getAllAppointments();
    }

    // =====================================================
    // COMPLETE JOB
    // =====================================================

    public boolean completeJob(int id) {

        return customerDAO.completeJob(id);
    }

    // =====================================================
    // COLLECT PAYMENT
    // =====================================================

    public boolean collectPayment(int id) {

        return customerDAO.collectPayment(id);
    }

    // =====================================================
    // DELETE APPOINTMENT
    // =====================================================

    public boolean deleteAppointment(int id) {

        return customerDAO.deleteAppointment(id);
    }
}