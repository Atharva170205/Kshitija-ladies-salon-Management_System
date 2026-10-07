package com.rt.controller;

import com.rt.Service.ChatbotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class ChatbotController {

    @Autowired
    private ChatbotService chatbotService;

    @RequestMapping(value = "/chatbot/ask", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> ask(@RequestBody Map<String, String> body) {
        String userMessage = body.getOrDefault("message", "").trim();

        if (userMessage.isEmpty()) {
            return Map.of("reply", "Please type a question first.");
        }
        if (userMessage.length() > 500) {
            return Map.of("reply", "That question's a bit long — please keep it under 500 characters.");
        }

        String reply = chatbotService.askChatbot(userMessage);
        return Map.of("reply", reply);
    }
}