package com.rt.DAO;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.rt.Model.SelectedService;

@Repository
public class SelectedServiceDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static final String SELECT_COLUMNS =
            "SELECT id, customer_id AS customerId, service_id AS serviceId, " +
            "service_name AS serviceName, price FROM appointment_services ";

    private final BeanPropertyRowMapper<SelectedService> rowMapper =
            new BeanPropertyRowMapper<>(SelectedService.class);

    // Insert every selected service of one appointment in a single batch.
    // No try/catch here on purpose: an error must reach the transaction
    // so the whole booking rolls back.
    public void insertAll(List<SelectedService> list) {

        String sql = "INSERT INTO appointment_services " +
                     "(customer_id, service_id, service_name, price) " +
                     "VALUES (?, ?, ?, ?)";

        jdbcTemplate.batchUpdate(sql, list, list.size(), (ps, s) -> {
            ps.setInt(1, s.getCustomerId());
            ps.setInt(2, s.getServiceId());
            ps.setString(3, s.getServiceName());
            ps.setBigDecimal(4, s.getPrice());
        });
    }

    // Services of one appointment
    public List<SelectedService> getByCustomerId(int customerId) {
        return jdbcTemplate.query(
                SELECT_COLUMNS + "WHERE customer_id = ? ORDER BY id",
                rowMapper, customerId);
    }

    // Services of all appointments, grouped by customer id (for the dashboard)
    public Map<Integer, List<SelectedService>> getAllGroupedByCustomer() {

        List<SelectedService> all =
                jdbcTemplate.query(SELECT_COLUMNS + "ORDER BY customer_id, id", rowMapper);

        Map<Integer, List<SelectedService>> map = new LinkedHashMap<>();
        for (SelectedService s : all) {
            map.computeIfAbsent(s.getCustomerId(), k -> new ArrayList<>()).add(s);
        }
        return map;
    }
}