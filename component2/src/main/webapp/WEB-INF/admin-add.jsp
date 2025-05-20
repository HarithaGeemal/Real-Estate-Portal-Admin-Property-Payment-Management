<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <title>Add Admin</title>
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
            background: linear-gradient(135deg, var(--bg-gradient-start) 0%, var(--bg-gradient-end) 100%) fixed;
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

        .card-body {
            padding: 2rem;
        }

        .form-label {
            font-weight: 500;
            color: var(--secondary);
            margin-bottom: 0.5rem;
            display: block;
        }

        .form-control, .form-select {
            border-radius: 0.375rem;
            border: 1px solid var(--border);
            padding: 0.625rem 1rem;
            font-size: 0.95rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            background-color: rgba(255, 255, 255, 0.9);
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(44, 110, 73, 0.2);
            outline: none;
        }

        .input-group {
            position: relative;
        }

        .input-group-text {
            background-color: rgba(248, 250, 252, 0.8);
            border: 1px solid var(--border);
            border-right: none;
            color: var(--secondary);
        }

        .btn {
            padding: 0.625rem 1.25rem;
            font-weight: 500;
            border-radius: 0.375rem;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background-color: var(--secondary);
            border-color: var(--secondary);
        }

        .btn-secondary:hover {
            background-color: var(--dark);
            border-color: var(--dark);
            transform: translateY(-2px);
        }

        .form-floating {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .form-floating label {
            position: absolute;
            top: 0;
            left: 0;
            height: 100%;
            padding: 1rem 0.75rem;
            pointer-events: none;
            border: 1px solid transparent;
            transform-origin: 0 0;
            transition: opacity .1s ease-in-out,transform .1s ease-in-out;
            color: var(--secondary);
        }

        .form-floating > .form-control, .form-floating > .form-select {
            height: calc(3.5rem + 2px);
            padding: 1rem 0.75rem;
        }

        .form-floating > .form-control:focus ~ label,
        .form-floating > .form-control:not(:placeholder-shown) ~ label,
        .form-floating > .form-select ~ label {
            opacity: .65;
            transform: scale(.85) translateY(-0.5rem) translateX(0.15rem);
            background-color: white;
            padding: 0 0.5rem;
            height: auto;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
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

        .animate-form-field {
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
            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        .form-text {
            color: var(--secondary);
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--secondary);
            cursor: pointer;
            z-index: 10;
        }

        .password-field-wrapper {
            position: relative;
        }
    </style>
</head>
<body>
<div class="page-container">
    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-user-plus"></i>
            Add New Admin
        </h1>
    </div>

    <div class="card">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/add" method="post" id="adminForm">
                <div class="mb-4 animate-form-field" style="animation-delay: 0.1s;">
                    <label for="id" class="form-label">Admin ID</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                        <input type="text" class="form-control" id="id" name="id" required placeholder="Enter admin ID">
                    </div>
                    <div class="form-text">Unique identifier for the admin account</div>
                </div>

                <div class="mb-4 animate-form-field" style="animation-delay: 0.2s;">
                    <label for="username" class="form-label">Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" id="username" name="username" required placeholder="Enter username">
                    </div>
                    <div class="form-text">Username for login purposes</div>
                </div>

                <div class="mb-4 animate-form-field" style="animation-delay: 0.3s;">
                    <label for="password" class="form-label">Password</label>
                    <div class="password-field-wrapper">
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" required placeholder="Enter password">
                        </div>
                        <button type="button" class="password-toggle" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="form-text">Secure password for the admin account</div>
                </div>

                <div class="mb-4 animate-form-field" style="animation-delay: 0.4s;">
                    <label for="privileges" class="form-label">Privileges</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-shield-alt"></i></span>
                        <select class="form-select" id="privileges" name="privileges" required>
                            <option value="" disabled selected>Select privilege level</option>
                            <option value="full">Full Access</option>
                            <option value="moderate">Moderate Access</option>
                        </select>
                    </div>
                    <div class="form-text">Access level for the admin account</div>
                </div>

                <div class="form-actions animate-form-field" style="animation-delay: 0.5s;">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus-circle me-2"></i>Add Admin
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Password visibility toggle
        const togglePassword = document.getElementById('togglePassword');
        const passwordField = document.getElementById('password');

        if (togglePassword && passwordField) {
            togglePassword.addEventListener('click', function() {
                const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordField.setAttribute('type', type);

                // Toggle the eye icon
                this.querySelector('i').classList.toggle('fa-eye');
                this.querySelector('i').classList.toggle('fa-eye-slash');
            });
        }

        // Form validation enhancement
        const adminForm = document.getElementById('adminForm');

        if (adminForm) {
            adminForm.addEventListener('submit', function(event) {
                const idField = document.getElementById('id');
                const usernameField = document.getElementById('username');
                const passwordField = document.getElementById('password');
                const privilegesField = document.getElementById('privileges');

                let isValid = true;

                // Simple validation - this doesn't change functionality, just enhances UX
                if (idField && idField.value.trim() === '') {
                    isValid = false;
                    highlightField(idField);
                }

                if (usernameField && usernameField.value.trim() === '') {
                    isValid = false;
                    highlightField(usernameField);
                }

                if (passwordField && passwordField.value.trim() === '') {
                    isValid = false;
                    highlightField(passwordField);
                }

                if (privilegesField && privilegesField.value === '') {
                    isValid = false;
                    highlightField(privilegesField);
                }

                // The form will still submit normally if valid
                // This just provides visual feedback
            });
        }

        function highlightField(field) {
            field.style.borderColor = 'var(--danger)';
            field.style.boxShadow = '0 0 0 3px rgba(239, 68, 68, 0.2)';

            field.addEventListener('input', function() {
                if (field.value.trim() !== '') {
                    field.style.borderColor = 'var(--primary)';
                    field.style.boxShadow = '0 0 0 3px rgba(44, 110, 73, 0.2)';
                }
            });
        }
    });
</script>
</body>
</html>