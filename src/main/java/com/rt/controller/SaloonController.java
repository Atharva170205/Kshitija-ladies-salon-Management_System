package com.rt.controller;

import java.util.List;
import org.springframework.web.bind.annotation.RequestMethod;
import com.rt.Service.BookingService;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.rt.Model.Customer;
import com.rt.Model.Owner;
import com.rt.Service.CustomerService;
import com.rt.Service.SaloonService;

@Controller
public class SaloonController {


@Autowired
private SaloonService ss;

@Autowired
private com.rt.Service.NotificationService notificationService;

@Autowired
private CustomerService customerService;

@Autowired
private BookingService bookingService;

//================= PAYMENT SUCCESS (Razorpay posts here) =================

@RequestMapping(value = "/paymentSuccess", method = RequestMethod.POST)
public String paymentSuccess(

     @RequestParam("razorpay_payment_id") String paymentId,
     @RequestParam("razorpay_order_id")   String orderId,
     @RequestParam("razorpay_signature")  String signature,

     RedirectAttributes ra) {

 try {

     bookingService.confirmPayment(orderId, paymentId, signature);

     // after the transaction has committed
     notificationService.sendConfirmationOnce(orderId);

     return "redirect:/bookingConfirmed?orderId=" + orderId;

 } catch (IllegalArgumentException e) {

     ra.addFlashAttribute("errMsg", e.getMessage());

 } catch (Exception e) {

     e.printStackTrace();
     ra.addFlashAttribute("errMsg",
             "Something went wrong while confirming your payment. Please contact the salon.");
 }

 return "redirect:/bookAppointment";
}


//================= BOOKING CONFIRMED PAGE =================

//================= BOOKING CONFIRMED PAGE =================

@RequestMapping("/bookingConfirmed")
public String bookingConfirmed(

     @RequestParam("orderId") String orderId,

     Model model) {

 com.rt.Model.CheckoutInfo info = bookingService.getConfirmation(orderId);

 if (info == null) {
     return "redirect:/home";
 }

 model.addAttribute("co", info);

 return "BookingConfirmed";
}
// ================= LOGIN =================

@RequestMapping("/doLogin")
public String doLogin(

        @ModelAttribute Owner o,

        RedirectAttributes ra,

        HttpSession hs) {


    Owner isValidate =
            ss.login(
                    o.getUsername(),
                    o.getPassword()
            );


    if (isValidate != null) {


        hs.setAttribute(
                "loggedInUser",
                isValidate.getUsername()
        );


        ra.addFlashAttribute(
                "successMsg",
                "Logged in Successfully..."
        );


        return "redirect:/dashboard";


    } else {


        ra.addFlashAttribute(
                "errMsg",
                "Invalid username or password"
        );


        return "redirect:/login";

    }

}



// ================= DASHBOARD =================

@RequestMapping("/dashboard")
public String dashboard(

        HttpSession hs,

        Model model) {


    // CHECK LOGIN

    if (hs.getAttribute("loggedInUser") == null) {

        return "redirect:/login";

    }


    // GET ALL APPOINTMENTS

    List<Customer> appointmentList =
            customerService.getAllAppointments();


    // SEND DATA TO JSP

    model.addAttribute(
            "appointmentList",
            appointmentList
    );


    return "Dashboard";

}



// ================= COMPLETE JOB =================

@RequestMapping("/completeJob")
public String completeJob(

        @RequestParam("id") int id,

        HttpSession hs,

        RedirectAttributes ra) {


    // CHECK LOGIN

    if (hs.getAttribute("loggedInUser") == null) {

        return "redirect:/login";

    }


    boolean isCompleted =
            customerService.completeJob(id);


    if (isCompleted) {

        ra.addFlashAttribute(
                "successMsg",
                "Job marked as Completed Successfully!"
        );

    } else {

        ra.addFlashAttribute(
                "errMsg",
                "Unable to update Job Status!"
        );

    }


    return "redirect:/dashboard";

}



// ================= COLLECT PAYMENT =================

@RequestMapping("/collectPayment")
public String collectPayment(

        @RequestParam("id") int id,

        HttpSession hs,

        RedirectAttributes ra) {


    // CHECK LOGIN

    if (hs.getAttribute("loggedInUser") == null) {

        return "redirect:/login";

    }


    boolean isCollected =
            customerService.collectPayment(id);


    if (isCollected) {

        ra.addFlashAttribute(
                "successMsg",
                "Payment marked as Collected Successfully!"
        );

    } else {

        ra.addFlashAttribute(
                "errMsg",
                "Unable to update Payment Status!"
        );

    }


    return "redirect:/dashboard";

}
//================= DELETE APPOINTMENT =================

@RequestMapping(value = "/deleteAppointment", method = RequestMethod.POST)
public String deleteAppointment(

     @RequestParam("id") int id,

     HttpSession hs,

     RedirectAttributes ra) {

 // CHECK LOGIN
 if (hs.getAttribute("loggedInUser") == null) {
     return "redirect:/login";
 }

 boolean isDeleted = customerService.deleteAppointment(id);

 if (isDeleted) {
     ra.addFlashAttribute("successMsg", "Appointment deleted successfully!");
 } else {
     ra.addFlashAttribute("errMsg", "Unable to delete appointment!");
 }

 return "redirect:/dashboard";
}



// ================= LOGOUT =================

@RequestMapping("/logout")
public String logout(

        HttpSession hs,

        RedirectAttributes ra) {


    hs.invalidate();


    ra.addFlashAttribute(
            "successMsg",
            "Logged out Successfully..."
    );


    return "redirect:/home";

}



// ================= ADMIN REGISTER =================

@RequestMapping("/doRegister")
public String doRegister(

        @ModelAttribute Owner o,

        RedirectAttributes ra) {


    boolean isRegistered =
            ss.register(
                    o.getName(),
                    o.getUsername(),
                    o.getPassword()
            );


    if (isRegistered) {


        ra.addFlashAttribute(
                "successMsg",
                "Registered Successfully. Please Login."
        );


        return "redirect:/login";


    } else {


        ra.addFlashAttribute(
                "errMsg",
                "Unable to Register"
        );


        return "redirect:/Admin_Register";

    }

}


//================= OPEN APPOINTMENT PAGE =================

@RequestMapping("/bookAppointment")
public String appointmentPage(Model model) {

 // Services grouped by category -> accordion + search
 model.addAttribute("servicesByCategory",
         bookingService.getServicesByCategory());

 // Popular services -> "Suggested for you" chips
 model.addAttribute("suggestedServices",
         bookingService.getSuggestedServices());

 return "CustomerAppointment";
}


//================= SAVE APPOINTMENT =================

//================= SAVE APPOINTMENT -> GO TO PAYMENT =================

@RequestMapping(value = "/saveAppointment", method = RequestMethod.POST)
public String saveAppointment(

     @ModelAttribute Customer customer,

     @RequestParam("service") String serviceIds,

     @RequestParam(value = "paymentChoice", required = false)
     String paymentChoice,

     RedirectAttributes ra) {

 try {

     String orderId =
             bookingService.startBooking(customer, serviceIds, paymentChoice);

     return "redirect:/checkout?orderId=" + orderId;

 } catch (IllegalArgumentException e) {

     ra.addFlashAttribute("errMsg", e.getMessage());

 } catch (Exception e) {

     e.printStackTrace();
     ra.addFlashAttribute("errMsg", "Unable to start payment. Please try again.");
 }

 return "redirect:/bookAppointment";
}


//================= CHECKOUT PAGE =================

@RequestMapping("/checkout")
public String checkout(

     @RequestParam("orderId") String orderId,

     Model model,

     RedirectAttributes ra) {

 com.rt.Model.CheckoutInfo info = bookingService.getCheckoutInfo(orderId);

 if (info == null) {
     ra.addFlashAttribute("errMsg", "This payment link is no longer valid.");
     return "redirect:/bookAppointment";
 }

 model.addAttribute("co", info);

 return "Checkout";
}
@Autowired
private com.rt.DAO.SalServiceDAO salServiceDAO;

@RequestMapping("/testServices")
@org.springframework.web.bind.annotation.ResponseBody
public String testServices() {
    return salServiceDAO.getAllServices().size() + " services, "
         + salServiceDAO.getPopularServices().size() + " popular";
}
}