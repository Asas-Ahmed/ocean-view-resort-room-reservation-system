<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice_${reservation.formattedReservationId}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    
    <script>
        (function() {
            const savedTheme = localStorage.getItem('theme');
            if (savedTheme === 'dark') {
                document.documentElement.setAttribute('data-theme', 'dark');
            }
        })();
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/script.js" defer></script>

    <style>
        /* --- Print Specifics --- */
        @media print {
            @page { size: A4; margin: 0; }
            body { background: white !important; color: black !important; margin: 1.5cm; padding: 0; }
            .no-print, #theme-toggle, .theme-toggle-container, .loader-spinner, #page-loader { display: none !important; }
            .main-content { margin: 0 !important; padding: 0 !important; }
            .invoice-card { box-shadow: none !important; border: none !important; width: 100% !important; background: white !important; color: black !important; }
            .invoice-table thead th { background-color: #f8fafc !important; color: black !important; border-bottom: 2px solid #000 !important; -webkit-print-color-adjust: exact; }
            .total-row { border-top: 2px solid #000 !important; }
            a { text-decoration: none; color: black; }
        }

        .invoice-card {
            max-width: 850px;
            margin: 40px auto;
            padding: 40px;
            background-color: var(--bg-card);
            border: 1px solid var(--border-soft);
            border-radius: 12px;
        }

        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 30px;
        }

        .brand-logo h1 { font-size: 2rem; margin: 0; color: var(--text-heading); }

        .invoice-details-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin: 30px 0;
            color: var(--text-body);
        }

        .info-group p { margin: 4px 0; font-size: 0.95rem; }

        /* --- Table Styling --- */
        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin: 30px 0;
        }

        .invoice-table th {
            text-align: left;
            padding: 12px;
            background: #f1f5f9;
            color: #475569;
            font-weight: 700;
        }

        [data-theme="dark"] .invoice-table th {
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-heading);
        }

        .invoice-table td {
            padding: 15px 12px;
            border-bottom: 1px solid var(--border-soft);
            color: var(--text-body);
        }

        /* --- Total Section --- */
        .total-container {
            display: flex; 
            justify-content: flex-end;
            color: var(--text-heading);
        }

        .total-row {
            display: flex; 
            justify-content: space-between; 
            padding: 10px 0; 
            border-top: 2px solid #000;
            font-weight: 800; 
            font-size: 1.2rem;
        }

        [data-theme="dark"] .total-row {
            border-top: 2px solid var(--brand-primary);
        }

        /* --- Signature Section --- */
        .signature-section {
            margin-top: 50px;
            display: flex;
            justify-content: space-between;
        }

        .sig-box {
            border-top: 1px solid var(--border-soft);
            width: 200px;
            text-align: center;
            padding-top: 10px;
            font-size: 0.8rem;
            color: var(--text-muted);
        }
    </style>
</head>
<body>

<div id="page-loader" class="no-print">
    <span class="loader-spinner"></span>
</div>

<div class="main-content">
    <div class="invoice-card">
        <div class="invoice-header">
            <div class="brand-logo">
                <h1>🌊 Ocean View Resort</h1>
                <p style="color: var(--brand-primary); font-weight: 600; letter-spacing: 1px;">OFFICIAL BILLING STATEMENT</p>
            </div>
            <div style="text-align: right; font-size: 0.85rem; color: #64748b;">
                <p><strong>Ocean View Resort (Pvt) Ltd.</strong></p>
                <p>123 Beachside Avenue, Galle, Sri Lanka</p>
                <p>VAT Reg: 987654321-000</p>
                <p>Phone: +94 91 123 4567</p>
            </div>
        </div>

        <hr style="border: 0; border-top: 2px solid #f1f5f9;">

        <div class="invoice-details-grid">
            <div class="info-group">
                <p style="color: #64748b; font-size: 0.8rem; text-transform: uppercase;">Bill To:</p>
                <p><strong><c:out value="${reservation.guestName}"/></strong></p>
                <p><c:out value="${reservation.contactNumber}"/></p>
            </div>
            <div class="info-group" style="text-align: right;">
                <p><strong>Invoice No:</strong> <c:out value="${reservation.formattedReservationId}"/></p>
                <p><strong>Date Issued:</strong> <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/></p>
                <p><strong>Period:</strong> <fmt:formatDate value="${reservation.checkInDate}" pattern="MMM dd"/> - <fmt:formatDate value="${reservation.checkOutDate}" pattern="MMM dd, yyyy"/></p>
            </div>
        </div>

        <table class="invoice-table">
            <thead>
                <tr>
                    <th>Description</th>
                    <th>Room Type</th>
                    <th style="text-align: right;">Amount (LKR)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Accommodation & Services</td>
                    <td><c:out value="${reservation.roomType}"/></td>
                    <td style="text-align: right; font-weight: 600;">
                        Rs. <fmt:formatNumber value="${totalBill}" minFractionDigits="2" maxFractionDigits="2"/>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <div style="display: flex; justify-content: flex-end;">
            <div style="width: 250px;">
                <div style="display: flex; justify-content: space-between; padding: 10px 0;">
                    <span>Subtotal:</span>
                    <span>Rs. <fmt:formatNumber value="${totalBill}" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
                <div class="total-row"> 
				    <span>Total Due:</span>
				    <span>Rs. <fmt:formatNumber value="${totalBill}" minFractionDigits="2" maxFractionDigits="2"/></span>
				</div>
            </div>
        </div>

        <div class="signature-section">
            <div class="sig-box">Guest Signature</div>
            <div class="sig-box">Authorized Signature</div>
        </div>

        <div style="margin-top: 40px; text-align: center; color: #94a3b8; font-size: 0.8rem;">
            <p>Thank you for choosing Ocean View Resort. We hope to see you again!</p>
        </div>

        <div class="invoice-actions no-print" style="margin-top: 40px; text-align: center; display: flex; gap: 10px; justify-content: center;">
            <button class="btn btn-primary" onclick="window.print()">🖨️ Print Official Invoice</button>
            <button class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/system/dashboard'">Dashboard</button>
            <a href="${pageContext.request.contextPath}/reservation" class="btn btn-discard" style="width: auto;">Back to Registry</a>
        </div>
    </div>
</div>

<div class="no-print">
    <jsp:include page="/WEB-INF/includes/theme-toggle.jsp" />
</div>

</body>
</html>