package com.rt.DAO;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.rt.Model.Owner;

@Repository
public class SaloonDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // =====================================================
    // LOGIN VALIDATION
    // =====================================================

    public Owner validateOwner(
            String username,
            String password) {

        String sql =
                "SELECT name, username, password " +
                "FROM Owner " +
                "WHERE username = ? AND password = ?";

        List<Owner> ownerList =
                jdbcTemplate.query(
                        sql,
                        new BeanPropertyRowMapper<>(Owner.class),
                        username,
                        password
                );

        return ownerList.isEmpty()
                ? null
                : ownerList.get(0);
    }

    // =====================================================
    // REGISTER OWNER
    // =====================================================

    public boolean register(
            String name,
            String username,
            String password) {

        try {

            String sql =
                    "INSERT INTO Owner " +
                    "(name, username, password) " +
                    "VALUES (?, ?, ?)";

            int rows = jdbcTemplate.update(
                    sql,
                    name,
                    username,
                    password
            );

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }
}