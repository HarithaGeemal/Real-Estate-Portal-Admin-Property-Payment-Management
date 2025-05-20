<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.1/css/all.min.css">
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
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, var(--bg-gradient-start) 0%, var(--bg-gradient-end) 100%) fixed;
            background-size: cover;
            color: var(--dark);
            line-height: 1.6;
            position: relative;
            min-height: 100vh;
            padding-bottom: 2rem;
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

        .dashboard-container {
            max-width: 1280px;
            margin: 40px auto;
            padding: 0 20px;
            animation: fadeIn 0.6s ease-in-out;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
        }

        .dashboard-header::before {
            content: "";
            position: absolute;
            top: 0;
            left: -20px;
            width: 5px;
            height: 40px;
            background-color: var(--primary);
            border-radius: 0 4px 4px 0;
        }

        .dashboard-title {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin: 0 0 1.5rem 0;
            color: var(--dark);
            font-weight: 700;
        }

        .dashboard-title i {
            color: var(--primary);
            font-size: 1.75rem;
        }

        .dashboard-title::after {
            content: "";
            display: block;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--primary) 0%, transparent 100%);
            margin-top: 0.5rem;
        }

        .admin-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 1rem;
        }

        .admin-logo {
            width: 40px;
            height: 40px;
            background-color: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.25rem;
        }

        .nav-buttons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 1.5rem;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn i {
            font-size: 1rem;
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background-color: var(--secondary);
            border-color: var(--secondary);
            color: white;
        }

        .btn-secondary:hover {
            background-color: var(--dark);
            border-color: var(--dark);
            transform: translateY(-2px);
        }

        .btn-info {
            background-color: #3b82f6;
            border-color: #3b82f6;
            color: white;
        }

        .btn-info:hover {
            background-color: #2563eb;
            border-color: #2563eb;
            transform: translateY(-2px);
        }

        .btn-warning {
            background-color: var(--warning);
            border-color: var(--warning);
            color: white;
        }

        .btn-warning:hover {
            background-color: #d97706;
            border-color: #d97706;
        }

        .btn-danger {
            background-color: var(--danger);
            border-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background-color: #dc2626;
            border-color: #dc2626;
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
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        .table-container {
            overflow-x: auto;
        }

        .admin-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .admin-table thead th {
            background-color: rgba(248, 250, 252, 0.8);
            color: var(--secondary);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid var(--border);
            text-align: left;
        }

        .admin-table tbody tr {
            background-color: rgba(255, 255, 255, 0.7);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .admin-table tbody tr:hover {
            background-color: rgba(241, 245, 249, 0.9);
            transform: translateY(-2px);
        }

        .admin-table td {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        .admin-id {
            font-weight: 600;
            color: var(--primary);
        }

        .admin-username {
            font-weight: 500;
        }

        .admin-password {
            font-family: monospace;
            color: var(--secondary);
        }

        .admin-privileges {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
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

        .action-buttons {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .btn-sm {
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
        }

        .search-card {
            margin-top: 2rem;
        }

        .search-form {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .search-input {
            flex: 1;
            position: relative;
        }

        .search-input i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary);
        }

        .search-input input {
            padding-left: 2.5rem;
            border-radius: 0.375rem;
            border: 1px solid var(--border);
            width: 100%;
            height: 45px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            background-color: rgba(255, 255, 255, 0.9);
        }

        .search-input input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(44, 110, 73, 0.2);
            outline: none;
        }

        .search-button {
            height: 45px;
            min-width: 120px;
        }

        .animate-card {
            animation: slideIn 0.4s ease-out forwards;
            opacity: 0;
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
            .dashboard-container {
                margin: 20px auto;
            }

            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .admin-profile {
                margin-left: auto;
                margin-bottom: 1rem;
            }

            .nav-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: flex-start;
            }

            .search-form {
                flex-direction: column;
            }

            .search-button {
                width: 100%;
            }

            .action-buttons {
                flex-direction: column;
                gap: 0.5rem;
            }

            .action-buttons .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <div class="dashboard-header">
        <div class="header-left">
            <h1 class="dashboard-title">
                <i class="fas fa-tachometer-alt"></i>
                Admin Dashboard
            </h1>
            <div class="nav-buttons">
                <a href="${pageContext.request.contextPath}/admin/add" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    <span>Add New Admin</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/manage-users" class="btn btn-secondary">
                    <i class="fas fa-users"></i>
                    <span>Manage Users</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/manage-properties" class="btn btn-secondary">
                    <i class="fas fa-building"></i>
                    <span>Manage Properties</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/activity-logs" class="btn btn-info">
                    <i class="fas fa-file-alt"></i>
                    <span>View Activity Logs</span>
                </a>
            </div>
        </div>
        <div class="admin-profile">
            <c:if test="${not empty sessionScope.loggedInAdminUsername}">
                <div class="admin-logo">${fn:substring(sessionScope.loggedInAdminUsername, 0, 1)}</div>
                <span>Welcome, ${sessionScope.loggedInAdminUsername}!</span>
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger btn-sm">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </c:if>
            <c:if test="${empty sessionScope.loggedInAdminUsername}">
                <a href="${pageContext.request.contextPath}/admin/login" class="btn btn-primary btn-sm">
                    <i class="fas fa-sign-in-alt"></i>
                    <span>Login</span>
                </a>
            </c:if>
        </div>
    </div>

    <div class="card animate-card" style="animation-delay: 0.1s;">
        <div class="card-header">
            <h2 class="card-title">
                <i class="fas fa-user-shield"></i>
                All Admins
            </h2>
        </div>
        <div class="card-body">
            <div class="table-container">
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Privileges</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="admin" items="${admins}">
                        <tr>
                            <td class="admin-id">${admin.id}</td>
                            <td class="admin-username">${admin.username}</td>
                            <td class="admin-password">${admin.password}</td>
                            <td>
                                <span class="admin-privileges ${fn:toLowerCase(admin.privileges)}">${admin.privileges}</span>
                            </td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/admin/update?id=${admin.id}" class="btn btn-sm btn-warning" onclick="return confirm('Are you sure you want to update this admin?')">
                                    <i class="fas fa-edit"></i>
                                    <span>Update</span>
                                </a>
                                <form action="${pageContext.request.contextPath}/admin/delete" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this admin?')">
                                    <input type="hidden" name="id" value="${admin.id}">
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash"></i>
                                        <span>Delete</span>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="card search-card animate-card" style="animation-delay: 0.2s;">
        <div class="card-header">
            <h2 class="card-title">
                <i class="fas fa-search"></i>
                Search Admins
            </h2>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/search" method="get" class="search-form">
                <div class="search-input">
                    <i class="fas fa-search"></i>
                    <input type="text" name="searchTerm" class="form-control" placeholder="Search by ID or Username" required>
                </div>
                <button type="submit" class="btn btn-primary search-button">
                    <i class="fas fa-search"></i>
                    <span>Search</span>
                </button>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.admin-privileges').forEach(badge => {
            const privilege = badge.textContent.trim().toLowerCase();
            if (privilege.includes('full')) {
                badge.classList.add('full');
            } else if (privilege.includes('moderate')) {
                badge.classList.add('moderate');
            }
        });
    });
</script>
</body>
</html>