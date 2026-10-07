package com.rt.Service;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.rt.Model.CheckoutInfo;

@Service
public class WhatsAppService {

    @Value("${whatsapp.enabled:false}")
    private boolean enabled;

    @Value("${whatsapp.phone.number.id:}")
    private String phoneNumberId;

    @Value("${whatsapp.access.token:}")
    private String accessToken;

    @Value("${whatsapp.api.version:v21.0}")
    private String apiVersion;

    @Value("${whatsapp.country.code:91}")
    private String countryCode;

    @Value("${whatsapp.template.name:hello_world}")
    private String templateName;

    @Value("${whatsapp.template.lang:en_US}")
    private String templateLang;

    // ------------------------------------------------------------
    // Plain-text version (used for logs / future fallback)
    // ------------------------------------------------------------

    public String buildMessage(CheckoutInfo c) {

        BigDecimal balance = c.getBalance();

        StringBuilder m = new StringBuilder();
        m.append("Hello ").append(c.getName()).append(",\n");
        m.append("Your booking at Kshitija Ladies Salon is confirmed.\n\n");
        m.append("Services: ").append(c.getService()).append("\n");
        m.append("Date & time: ").append(c.getTime()).append("\n");
        m.append("Paid now: Rs ").append(money(c.getAmount())).append("\n");

        if (balance.signum() > 0) {
            m.append("Balance to pay at the salon: Rs ")
             .append(money(balance)).append("\n");
        }

        m.append("\nThank you!");
        return m.toString();
    }

    // ------------------------------------------------------------
    // Send through the WhatsApp Cloud API
    // ------------------------------------------------------------

    public boolean sendBookingConfirmation(CheckoutInfo c) {

        if (!enabled) {
            System.out.println("[WhatsApp] disabled (whatsapp.enabled=false). Message was:\n"
                    + buildMessage(c));
            return false;
        }

        try {

            String to = countryCode + c.getMobile().trim();

            JSONObject template = new JSONObject();
            template.put("name", templateName);
            template.put("language", new JSONObject().put("code", templateLang));

            // hello_world has no variables; our own template has 5
            if (!"hello_world".equals(templateName)) {

                JSONArray params = new JSONArray();
                params.put(text(c.getName()));                    // {{1}}
                params.put(text(c.getService()));                 // {{2}}
                params.put(text(c.getTime()));                    // {{3}}
                params.put(text(money(c.getAmount())));           // {{4}}
                params.put(text(money(c.getBalance())));          // {{5}}

                template.put("components", new JSONArray().put(
                        new JSONObject()
                                .put("type", "body")
                                .put("parameters", params)));
            }

            JSONObject body = new JSONObject();
            body.put("messaging_product", "whatsapp");
            body.put("to", to);
            body.put("type", "template");
            body.put("template", template);

            return post(body.toString());

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ------------------------------------------------------------
    // helpers
    // ------------------------------------------------------------

    private boolean post(String json) throws Exception {

        URL url = new URL("https://graph.facebook.com/" + apiVersion
                + "/" + phoneNumberId + "/messages");

        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setConnectTimeout(8000);
        con.setReadTimeout(10000);
        con.setDoOutput(true);
        con.setRequestProperty("Authorization", "Bearer " + accessToken);
        con.setRequestProperty("Content-Type", "application/json");

        try (OutputStream os = con.getOutputStream()) {
            os.write(json.getBytes(StandardCharsets.UTF_8));
        }

        int code = con.getResponseCode();

        InputStream is = (code >= 200 && code < 300)
                ? con.getInputStream() : con.getErrorStream();

        StringBuilder resp = new StringBuilder();

        if (is != null) {
            try (BufferedReader br = new BufferedReader(
                    new InputStreamReader(is, StandardCharsets.UTF_8))) {
                String line;
                while ((line = br.readLine()) != null) {
                    resp.append(line);
                }
            }
        }

        System.out.println("[WhatsApp] HTTP " + code + " -> " + resp);

        return code >= 200 && code < 300;
    }

    /** Template variables cannot contain new lines, tabs or long runs of spaces. */
    private JSONObject text(String value) {

        String v = (value == null) ? "" : value.replaceAll("[\\r\\n\\t]+", " ")
                                               .replaceAll(" {2,}", " ")
                                               .trim();
        if (v.isEmpty()) {
            v = "-";
        }
        return new JSONObject().put("type", "text").put("text", v);
    }

    private String money(BigDecimal v) {
        return v.stripTrailingZeros().toPlainString();
    }
}