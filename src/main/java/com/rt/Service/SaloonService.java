package com.rt.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rt.DAO.SaloonDAO;
import com.rt.Model.Owner;

@Service
public class SaloonService {

    @Autowired
    private SaloonDAO sd;

    // =====================================================
    // LOGIN
    // =====================================================

    public Owner login(
            String username,
            String password) {

        return sd.validateOwner(
                username,
                password
        );
    }

    // =====================================================
    // REGISTER
    // =====================================================

    public boolean register(
            String name,
            String username,
            String password) {

        return sd.register(
                name,
                username,
                password
        );
    }
}