<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 5/7/2025
  Time: 9:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <title>Search Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2c6e49;
            --primary-hover: #1e5631;
            --secondary: #4d6a6d;
            --light: #f8fafc;
            --dark: #1e293b;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --border: #e2e8f0;
            --bg-gradient-start: #f8f9fa;
            --bg-gradient-end: #e9ecef;
        }

        body {
            background: linear-gradient(135deg, var(--bg-gradient-start) 0%, var(--bg-gradient-end) 100%);
            background-attachment: fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--dark);
            padding-bottom: 2rem;
            position: relative;
            min-height: 100vh;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23000000' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            z-index: -1;
        }

        .page-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem 1rem;
            animation: fadeIn 0.6s ease-in-out;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
            position: relative;
        }

        .header-section::before {
            content: "";
            position: absolute;
            top: 0;
            left: -20px;
            width: 5px;
            height: 40px;
            background-color: var(--primary);
            border-radius: 0 4px 4px 0;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin: 0;
            color: var(--dark);
            font-weight: 600;
        }

        .page-title i {
            color: var(--primary);
            font-size: 1.75rem;
        }

        .page-title::after {
            content: "";
            display: block;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--primary) 0%, transparent 100%);
            margin-top: 0.5rem;
        }

        .card {
            border: none;
            border-radius: 0.75rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background-color: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            margin-bottom: 2rem;
        }

        .card:hover {
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        .card-header {
            background-color: rgba(255, 255, 255, 0.8);
            border-bottom: 1px solid var(--border);
            padding: 1.25rem 1.5rem;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        .result-item {
            display: flex;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
        }

        .result-item:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .result-label {
            width: 120px;
            font-weight: 600;
            color: var(--secondary);
        }

        .result-value {
            flex: 1;
            font-weight: 500;
        }

        .admin-id {
            color: var(--primary);
            font-weight: 600;
        }

        .admin-username {
            color: var(--dark);
        }

        .admin-privileges {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
            background-color: rgba(44, 110, 73, 0.1);
            color: var(--primary);
        }

        .admin-privileges.full {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .admin-privileges.moderate {
            background-color: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        .no-result {
            padding: 2rem;
            text-align: center;
            color: var(--secondary);
            font-size: 1.1rem;
        }

        .no-result i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--border);
        }

        .back-button {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background-color: var(--secondary);
            color: white;
            border: none;
            padding: 0.625rem 1.25rem;
            border-radius: 0.375rem;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            width: fit-content;
        }

        .back-button:hover {
            background-color: var(--dark);
            transform: translateX(-3px);
            color: white;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-card {
            animation: slideIn 0.4s ease-out forwards;
            opacity: 0;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .result-item {
                flex-direction: column;
                gap: 0.5rem;
            }

            .result-label {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="page-container">
    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-search"></i>
            Search Result
        </h1>
    </div>

    <div class="card animate-card">
        <div class="card-header">
            <h2 class="card-title">
                <i class="fas fa-user-shield"></i>
                Admin Information
            </h2>
        </div>
        <div class="card-body">
            <c:if test="${admin != null}">
                <div class="result-item">
                    <div class="result-label">ID:</div>
                    <div class="result-value admin-id">${admin.id}</div>
                </div>
                <div class="result-item">
                    <div class="result-label">Username:</div>
                    <div class="result-value admin-username">${admin.username}</div>
                </div>
                <div class="result-item">
                    <div class="result-label">Privileges:</div>
                    <div class="result-value">
                        <span class="admin-privileges ${fn:toLowerCase(admin.privileges)}">${admin.privileges}</span>
                    </div>
                </div>
            </c:if>
            <c:if test="${admin == null}">
                <div class="no-result">
                    <i class="fas fa-search"></i>
                    <p>No admin found with the specified criteria.</p>
                </div>
            </c:if>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-button">
        <i class="fas fa-arrow-left"></i>
        Back to Dashboard
    </a>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add privilege badge classes based on content
        const privilegeBadge = document.querySelector('.admin-privileges');
        if (privilegeBadge) {
            const privilege = privilegeBadge.textContent.trim().toLowerCase();
            if (privilege.includes('full')) {
                privilegeBadge.classList.add('full');
            } else if (privilege.includes('moderate')) {
                privilegeBadge.classList.add('moderate');
            }
        }
    });
</script>
</body>
</html>
