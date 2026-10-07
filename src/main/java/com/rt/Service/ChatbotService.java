package com.rt.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.List;
import java.util.Map;

@Service
public class ChatbotService {

    @Value("${groq.api.url}")
    private String apiUrl;

    @Value("${groq.api.key}")
    private String apiKey;

    @Value("${groq.model}")
    private String model;

    private final HttpClient httpClient = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10))
            .build();

    private final ObjectMapper mapper = new ObjectMapper();

    private static final String SYSTEM_PROMPT =
            "You are the virtual assistant for Kshitija Ladies Salon, a women's beauty salon in India. " +
            "You help customers understand which salon services suit their needs, when to use them, " +
            "how often to get them done, and roughly what they involve.\n\n" +
            "At Starting they will provide their name "+
            
           
            "The salon offers these service categories: Threading, Waxing (Face & Body), Massage with Steam, " +
            "Manicure & Pedicure, Bleach, Facials & Skin Treatments, Haircuts, Hair Spa & Hair Treatments, " +
            "Hair Colors & Chemical Treatments, Hair Styles, Makeup & Styling, Relaxing Full Body Packages, " +
            "and Skin Brightening & Tightening.\n\n" +
            "Answer customer questions clearly and briefly (2-5 sentences). Recommend specific services by " +
            "name from the list above when relevant. If asked about exact prices, tell them to check the " +
            "\"Book Appointment\" page for current pricing since prices can change. Do not invent services that " +
            "aren't in the list above. If a question is unrelated to salon services, politely redirect the " +
            "customer back to salon-related topics.";
    public String askChatbot(String userMessage) {
        try {
            Map<String, Object> payload = Map.of(
                "model", model,
                "messages", List.of(
                    Map.of("role", "system", "content", SYSTEM_PROMPT),
                    Map.of("role", "user", "content", userMessage)
                ),
                "temperature", 0.4,
                "max_tokens", 300
            );

            String requestBody = mapper.writeValueAsString(payload);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(apiUrl))
                    .header("Authorization", "Bearer " + apiKey)
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                System.err.println("Groq API error (" + response.statusCode() + "): " + response.body());
                return "Sorry, I'm having trouble answering right now. Please try again in a moment.";
            }

            JsonNode root = mapper.readTree(response.body());
            return root.path("choices").get(0).path("message").path("content").asText().trim();

        } catch (Exception e) {
            System.err.println("Chatbot error: " + e.getMessage());
            e.printStackTrace();
            return "Sorry, something went wrong. Please try again.";
        }
    }
}