package com.rt.DAO;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.rt.Model.Customer;

@Repository
public class CustomerDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;
 // import java.math.BigDecimal;  (add at the top if missing)

    public void confirmBooking(int customerId, BigDecimal advancePaid, boolean fullyPaid) {

        jdbcTemplate.update(
                "UPDATE Customer SET booking_status = 'Confirmed', advance_paid = ?, " +
                "payment_status = IF(?, 'Collected', payment_status) " +
                "WHERE id = ?",
                advancePaid, fullyPaid, customerId);
    }

    // =====================================================
    // BOOK APPOINTMENT
    // =====================================================

    public int insertAppointment(Customer customer) {

    	String sql =
    	        "INSERT INTO Customer " +
    	        "(name, address, mobile, service, time, total_amount, booking_status) " +
    	        "VALUES (?, ?, ?, ?, ?, ?, 'Awaiting Payment')";

        String time = customer.getTime();

        if (time == null || time.trim().isEmpty()) {
            throw new IllegalArgumentException("Appointment time is required");
        }

        time = time.trim().replace("T", " ");

        if (time.length() == 16) {
            time = time + ":00";
        }

        final Timestamp appointmentTime = Timestamp.valueOf(time);

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(con -> {
            PreparedStatement ps =
                    con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getAddress());
            ps.setString(3, customer.getMobile());
            ps.setString(4, customer.getService());
            ps.setTimestamp(5, appointmentTime);
            ps.setBigDecimal(6, customer.getTotalAmount());
            return ps;
        }, keyHolder);

        return keyHolder.getKey().intValue();
    }
    // =====================================================
    // GET ALL APPOINTMENTS
    // =====================================================

    public List<Customer> getAllAppointments() {

        String sql =
                "SELECT " +
                "id, " +
                "name, " +
                "address, " +
                "mobile, " +
                "service, " +
                "DATE_FORMAT(`time`, '%Y-%m-%dT%H:%i') AS time, " +
                "total_amount AS totalAmount, " +
                "job_status AS jobStatus, " +
                "payment_status AS paymentStatus " +
                "FROM Customer " +
                "WHERE booking_status = 'Confirmed' " +
                "ORDER BY `time` ASC";

        return jdbcTemplate.query(
                sql,
                new BeanPropertyRowMapper<>(Customer.class)
        );
    }

    // =====================================================
    // COMPLETE JOB
    // =====================================================

    public boolean completeJob(int id) {

        try {

            String sql =
                    "UPDATE Customer " +
                    "SET job_status = 'Completed' " +
                    "WHERE id = ?";

            int rows = jdbcTemplate.update(sql, id);

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    // =====================================================
    // PAYMENT COLLECTED
    // =====================================================

    public boolean collectPayment(int id) {

        try {

            String sql =
                    "UPDATE Customer " +
                    "SET payment_status = 'Collected' " +
                    "WHERE id = ?";

            int rows = jdbcTemplate.update(sql, id);

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    // =====================================================
    // DELETE APPOINTMENT
    // =====================================================

    public boolean deleteAppointment(int id) {

        try {

            String sql =
                    "DELETE FROM Customer " +
                    "WHERE id = ?";

            int rows = jdbcTemplate.update(sql, id);

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }
}