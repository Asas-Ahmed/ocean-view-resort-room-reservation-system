<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Error Page Tester</title>
    <style>
        body { font-family: sans-serif; padding: 30px; line-height: 1.6; }
        .btn { padding: 10px 20px; color: white; border: none; cursor: pointer; border-radius: 5px; text-decoration: none; display: inline-block; margin: 5px; }
        .btn-404 { background-color: #6c757d; }
        .btn-403 { background-color: #ffc107; color: black; }
        .btn-500 { background-color: #dc3545; }
        .box { border: 1px solid #ddd; padding: 20px; border-radius: 10px; background: #f9f9f9; }
    </style>
</head>
<body>

    <div class="box">
        <h1>Resort System: Error Trigger Test</h1>
        <p>Use these buttons to verify that your <strong>web.xml</strong> mappings are working.</p>
        
        <hr>

        <h3>Test 404 (Not Found)</h3>
        <p>Tries to visit a page that doesn't exist.</p>
        <a href="this-page-does-not-exist.jsp" class="btn btn-404">Trigger 404</a>

        <h3>Test 403 (Forbidden)</h3>
        <p>Uses a scriptlet to tell the server "Access Denied".</p>
        <form action="" method="GET">
            <button name="error" value="403" class="btn btn-403">Trigger 403</button>
        </form>

        <h3>Test 500 (Internal Server Error)</h3>
        <p>Forces a Java Math error (Divide by zero).</p>
        <form action="" method="GET">
            <button name="error" value="500" class="btn btn-500">Trigger 500</button>
        </form>
    </div>

    <%
        // Logic to catch the button clicks and force the errors
        String errorType = request.getParameter("error");
        
        if ("403".equals(errorType)) {
            response.sendError(403);
        } 
        else if ("500".equals(errorType)) {
            // This crashes the server-side execution
            int crash = 10 / 0; 
        }
    %>

</body>
</html>