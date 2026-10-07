package com.rt.DAO;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.rt.Model.SalService;

@Repository
public class SalServiceDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static final String SELECT_COLUMNS =
            "SELECT id, category, service_name AS serviceName, variant, " +
            "price, is_popular AS popular FROM salon_service ";

    private final BeanPropertyRowMapper<SalService> rowMapper =
            new BeanPropertyRowMapper<>(SalService.class);

    // ALL SERVICES (ordered by id so categories stay in price-list order)
    public List<SalService> getAllServices() {
        return jdbcTemplate.query(SELECT_COLUMNS + "ORDER BY id", rowMapper);
    }

    // POPULAR SERVICES ("Suggested for you" chips)
    public List<SalService> getPopularServices() {
        return jdbcTemplate.query(
                SELECT_COLUMNS + "WHERE is_popular = 1 ORDER BY id", rowMapper);
    }

    // SINGLE SERVICE
    public SalService getServiceById(int id) {
        List<SalService> list = jdbcTemplate.query(
                SELECT_COLUMNS + "WHERE id = ?", rowMapper, id);
        return list.isEmpty() ? null : list.get(0);
    }

    // MANY SERVICES BY ID (prices always come from the DB, not the browser)
    public List<SalService> getServicesByIds(List<Integer> ids) {

        if (ids == null || ids.isEmpty()) {
            return Collections.emptyList();
        }

        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < ids.size(); i++) {
            placeholders.append(i == 0 ? "?" : ",?");
        }

        String sql = SELECT_COLUMNS +
                "WHERE id IN (" + placeholders + ") ORDER BY id";

        return jdbcTemplate.query(sql, rowMapper, ids.toArray());
    }
}