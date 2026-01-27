<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New Reservation - Ocean View</title>
    <style> 
    	:root { --fey-blue: #0052cc; --fey-purple: #6c5ce7; --fey-gradient: linear-gradient(135deg, #0052cc 0%, #6c5ce7 100%); --bg-light: #f4f7fa; --text-dark: #1e293b; } 
    	body { font-family: 'Segoe UI', Arial, sans-serif; background-color: var(--bg-light); margin: 0; padding: 40px 20px; color: var(--text-dark); } 
    	.form-container { background: white; padding: 35px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); max-width: 500px; margin: auto; border-top: 6px solid var(--fey-blue); } 
    	h2 { color: var(--fey-blue); text-align: center; margin-top: 0; margin-bottom: 25px; font-size: 1.6rem; } 
    	.form-group { margin-bottom: 18px; } 
    	label { display: block; margin-bottom: 7px; font-weight: 600; color: #475569; font-size: 0.9rem; } 
    	input, select { width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; box-sizing: border-box; font-size: 14px; transition: all 0.3s ease; } 
    	input:focus, select:focus { border-color: var(--fey-purple); outline: none; box-shadow: 0 0 0 4px rgba(108, 92, 231, 0.1); } 
    	button { width: 100%; padding: 14px; background: var(--fey-gradient); border: none; color: white; border-radius: 8px; cursor: pointer; font-size: 16px; font-weight: bold; transition: transform 0.2s, opacity 0.3s; margin-top: 10px; } 
    	button:hover { opacity: 0.9; transform: translateY(-1px); } 
    	.back-link { display: block; text-align: center; margin-top: 20px; text-decoration: none; color: var(--fey-blue); font-weight: 600; font-size: 0.9rem; } 
    	.back-link:hover { text-decoration: underline; } 
    	p[style*="color: red"] { background: #fee2e2; padding: 10px; border-radius: 6px; border: 1px solid #fecaca; font-size: 0.85rem; font-weight: 600; } 
    </style>
    
    <script>
    function validateForm() {
        // Access form fields
        const checkInInput = document.getElementsByName("checkInDate")[0].value;
        const checkOutInput = document.getElementsByName("checkOutDate")[0].value;
        const contact = document.getElementsByName("contactNumber")[0].value;

        const checkIn = new Date(checkInInput);
        const checkOut = new Date(checkOutInput);

        // Date Validation
        if (checkOut <= checkIn) {
            alert("Check-out date must be after check-in date!");
            return false;
        }

        // Contact Number Validation (10 digits)
        if (!/^\d{10}$/.test(contact)) {
            alert("Contact number must be exactly 10 digits!");
            return false;
        }

        return true; // Form is valid
    }
    </script>
</head>
<body>

<div class="form-container">
    <h2>➕ New Reservation</h2>
    
    <%-- Display error messages if redirected back from servlet --%>
    <% if(request.getAttribute("error") != null) { %>
        <p style="color: red; text-align: center;"><%= request.getAttribute("error") %></p>
    <% } %>

    <form action="../reservation" method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <label>Guest Name</label>
            <input type="text" name="guestName" placeholder="Full Name" required>
        </div>
        
        <div class="form-group">
            <label>Address</label>
            <input type="text" name="address" placeholder="Residential Address" required>
        </div>
        
        <div class="form-group">
            <label>Contact Number</label>
            <input type="text" name="contactNumber" placeholder="e.g. 0771234567" required>
        </div>
        
        <div class="form-group">
            <label>Room Type</label>
            <select name="roomType">
                <option value="Standard">Standard ($100/night)</option>
                <option value="Deluxe">Deluxe ($150/night)</option>
                <option value="Suite">Suite ($200/night)</option>
            </select>
        </div>
        
        <div class="form-group">
            <label>Check-In Date</label>
            <input type="date" name="checkInDate" required>
        </div>
        
        <div class="form-group">
            <label>Check-Out Date</label>
            <input type="date" name="checkOutDate" required>
        </div>
        
        <button type="submit">💾 Save Reservation</button>
    </form>
    
    <a href="../system/dashboard.jsp" class="back-link">Return to Dashboard</a>
</div>

</body>
</html>