package com.oceanview.service;

import java.util.Properties;
import jakarta.mail.*; 
import jakarta.mail.internet.*;

public class EmailService {

    private final String username = "oceanview.resort.reservations@gmail.com";
    private final String password = "tkncotjlsbnofuqt"; 

    public void sendBookingConfirmation(String recipientEmail, String guestName, String reservationNo) {
        
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username, "Ocean View Resort"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Booking Confirmation - " + reservationNo);
            
            String htmlContent = 
            	    "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: auto; border: 1px solid #ddd; border-radius: 10px; overflow: hidden;'>" +
            	        "<div style='background-color: #003580; color: white; padding: 20px; text-align: center;'>" +
            	            "<h1>Ocean View Resort</h1>" +
            	            "<p>Your Paradise Awaits</p>" +
            	        "</div>" +
            	        "<div style='padding: 20px; color: #333;'>" +
            	            "<h2>Booking Confirmed!</h2>" +
            	            "<p>Dear <strong>" + guestName + "</strong>,</p>" +
            	            "<p>We are delighted to confirm your stay with us. Below are your reservation details:</p>" +
            	            "<table style='width: 100%; border-collapse: collapse; margin-top: 10px;'>" +
            	                "<tr style='background-color: #f9f9f9;'><td style='padding: 10px; border: 1px solid #eee;'><strong>Reservation ID:</strong></td><td style='padding: 10px; border: 1px solid #eee;'>" + reservationNo + "</td></tr>" +
            	                "<tr><td style='padding: 10px; border: 1px solid #eee;'><strong>Status:</strong></td><td style='padding: 10px; border: 1px solid #eee;'><span style='color: green;'>● Confirmed</span></td></tr>" +
            	            "</table>" +
            	            "<p style='margin-top: 20px;'>Please have this confirmation ready upon check-in.</p>" +
            	        "</div>" +
            	        "<div style='background-color: #f1f1f1; padding: 15px; text-align: center; font-size: 12px; color: #777;'>" +
            	            "<p>Ocean View Resort, Kandy, Sri Lanka<br>Contact: +94 81 234 5678</p>" +
            	        "</div>" +
            	    "</div>";
            
            message.setContent(htmlContent, "text/html; charset=utf-8");

            new Thread(() -> {
                try {
                    Transport.send(message);
                    System.out.println("✅ Email sent to: " + recipientEmail);
                } catch (MessagingException e) {
                    System.err.println("❌ Mail Error: " + e.getMessage());
                }
            }).start();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}