<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Reservation - Ocean View</title>
    <style> 
    	:root { --fey-blue: #0052cc; --fey-purple: #6c5ce7; --fey-gradient: linear-gradient(135deg, #0052cc 0%, #6c5ce7 100%); --bg-light: #f4f7fa; --text-dark: #1e293b; } 
    	body { font-family: 'Segoe UI', Arial, sans-serif; background-color: var(--bg-light); margin: 0; padding: 40px 20px; color: var(--text-dark); } 
    	.form-box { background: white; padding: 35px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); max-width: 500px; margin: auto; border-top: 6px solid var(--fey-purple); } h2 { color: var(--fey-blue); text-align: center; margin-top: 0; margin-bottom: 25px; font-size: 1.5rem; } 
    	form { display: flex; flex-direction: column; gap: 5px; font-weight: 600; font-size: 0.9rem; color: #475569; } 
    	input, select { width: 100%; padding: 12px; margin: 8px 0 18px 0; border: 2px solid #e2e8f0; border-radius: 8px; box-sizing: border-box; font-size: 14px; transition: all 0.3s ease; font-family: inherit; } 
    	input:focus, select:focus { border-color: var(--fey-purple); outline: none; box-shadow: 0 0 0 4px rgba(108, 92, 231, 0.1); } 
    	button { width: 100%; padding: 14px; background: var(--fey-gradient); border: none; color: white; border-radius: 8px; cursor: pointer; font-size: 16px; font-weight: bold; transition: transform 0.2s, opacity 0.3s; margin-top: 10px; } 
    	button:hover { opacity: 0.9; transform: translateY(-1px); } 
    	a { display: block; text-align: center; margin-top: 20px; text-decoration: none; color: var(--fey-blue); font-weight: 600; font-size: 0.9rem; } 
    	a:hover { text-decoration: underline; } 
    </style>
</head>
<body>
<div class="form-box">
    <h2>✏️ Edit Reservation #${res.reservationId}</h2>
    <form action="reservation" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="reservationId" value="${res.reservationId}">
        
        Guest Name: <input type="text" name="guestName" value="${res.guestName}" required>
        Address: <input type="text" name="address" value="${res.address}" required>
        Contact: <input type="text" name="contactNumber" value="${res.contactNumber}" required>
        
        Room: 
        <select name="roomType">
            <option value="Standard" ${res.roomType == 'Standard' ? 'selected' : ''}>Standard</option>
            <option value="Deluxe" ${res.roomType == 'Deluxe' ? 'selected' : ''}>Deluxe</option>
            <option value="Suite" ${res.roomType == 'Suite' ? 'selected' : ''}>Suite</option>
        </select>
        
        Check-In: <input type="date" name="checkInDate" value="${res.checkInDate}" required>
        Check-Out: <input type="date" name="checkOutDate" value="${res.checkOutDate}" required>
        
        <button type="submit">Update Changes</button>
    </form>
    <a href="reservation">Cancel and Go Back</a>
</div>
</body>
</html>