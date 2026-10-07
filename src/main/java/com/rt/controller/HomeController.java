package com.rt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rt.Service.BookingService;

@Controller
public class HomeController {

    @Autowired
    private BookingService bookingService;

    @RequestMapping("/")
    public String starting() {
        return "redirect:/home";
    }

    // Home.jsp reads ${servicesByCategory} for its service tabs
    @RequestMapping("/home")
    public String homePage(Model model) {
        model.addAttribute("servicesByCategory",
                bookingService.getServicesByCategory());
        return "Home";
    }

    @RequestMapping("/login")
    public String loginPage() {
        return "adminLogin";
    }

    @RequestMapping("/Admin_Register")
    public String registerPage() {
        return "adminRegister";
    }
}