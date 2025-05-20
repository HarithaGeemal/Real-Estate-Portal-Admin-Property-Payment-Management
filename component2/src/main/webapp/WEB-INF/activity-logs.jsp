<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <title>Activity Logs</title>
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
            max-width: 1200px;
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

        .back-button {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background-color: var(--secondary);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .back-button:hover {
            background-color: var(--dark);
            transform: translateX(-3px);
            color: white;
        }

        .card {
            border: none;
            border-radius: 0.75rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background-color: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }

        .card:hover {
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            transform: translateY(-3px);
        }

        .card-header {
            background-color: rgba(255, 255, 255, 0.8);
            border-bottom: 1px solid var(--border);
            padding: 1rem 1.5rem;
        }

        .search-filter {
            display: flex;
            gap: 1rem;
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
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .search-input input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.2);
            outline: none;
        }

        .table-container {
            overflow-x: auto;
        }

        .activity-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .activity-table th {
            background-color: rgba(248, 250, 252, 0.8);
            color: var(--secondary);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid var(--border);
        }

        .activity-table td {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        .activity-table tbody tr {
            background-color: rgba(255, 255, 255, 0.7);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .activity-table tbody tr:hover {
            background-color: rgba(241, 245, 249, 0.9);
            transform: translateY(-2px);
        }

        .admin-id {
            font-weight: 600;
            color: var(--primary);
        }

        .action-cell {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .action-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .action-badge.create {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .action-badge.update {
            background-color: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        .action-badge.delete {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }

        .action-badge.login {
            background-color: rgba(79, 70, 229, 0.1);
            color: var(--primary);
        }

        .timestamp {
            color: var(--secondary);
            font-size: 0.875rem;
        }

        .card-footer {
            background-color: rgba(255, 255, 255, 0.8);
            border-top: 1px solid var(--border);
            padding: 1rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .pagination {
            display: flex;
            gap: 0.25rem;
            margin: 0;
        }

        .pagination .page-item .page-link {
            border: 1px solid var(--border);
            color: var(--dark);
            padding: 0.375rem 0.75rem;
            transition: all 0.3s ease;
        }

        .pagination .page-item.active .page-link {
            background-color: var(--primary);
            border-color: var(--primary);
            color: white;
        }

        .pagination .page-item .page-link:hover:not(.active) {
            background-color: #f1f5f9;
            color: var(--primary);
        }

        .page-info {
            color: var(--secondary);
            font-size: 0.875rem;
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

        .animate-row {
            animation: slideIn 0.3s ease-out forwards;
            opacity: 0;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .header-section {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .search-filter {
                width: 100%;
                flex-direction: column;
            }

            .card-footer {
                flex-direction: column;
                gap: 1rem;
            }
        }

        .page-title::after {
            content: "";
            display: block;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--primary) 0%, transparent 100%);
            margin-top: 0.5rem;
        }
    </style>
</head>
<body>
<div class="page-container">
    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-history"></i>
            Activity Logs
        </h1>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-button">
            <i class="fas fa-arrow-left"></i>
            Back to Dashboard
        </a>
    </div>

    <div class="card">
        <div class="card-header">
            <div class="search-filter">
                <div class="search-input">
                    <i class="fas fa-search"></i>
                    <label for="searchInput"></label><input type="text" class="form-control" placeholder="Search logs..." id="searchInput">
                </div>
                <label for="actionFilter"></label><select class="form-select" style="max-width: 200px;" id="actionFilter">
                <option value="">All Actions</option>
                <option value="login">Login</option>
                <option value="create">Create</option>
                <option value="update">Update</option>
                <option value="delete">Delete</option>
            </select>
            </div>
        </div>

        <div class="table-container">
            <table class="activity-table">
                <thead>
                <tr>
                    <th>Admin ID</th>
                    <th>Action</th>
                    <th>Timestamp</th>
                </tr>
                </thead>
                <tbody id="logsTableBody">
                <c:forEach var="log" items="${logs}" varStatus="status">
                    <tr class="animate-row" style="animation-delay: ${status.index * 0.05}s">
                        <td class="admin-id">${log.adminId}</td>
                        <td>
                            <div class="action-cell">
                                        <span class="action-badge ${fn:toLowerCase(fn:substring(log.action, 0, 6))}">
                                                ${log.action}
                                        </span>
                            </div>
                        </td>
                        <td class="timestamp">${log.formattedTimestamp}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="card-footer">
            <div class="page-info">
                Showing <span id="startRecord">1</span> to <span id="endRecord">10</span> of <span id="totalRecords">100</span> entries
            </div>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<script>
    // Animation for table rows
    document.addEventListener('DOMContentLoaded', function() {
        // Search functionality
        const searchInput = document.getElementById('searchInput');
        const actionFilter = document.getElementById('actionFilter');
        const tableRows = document.querySelectorAll('#logsTableBody tr');

        function filterTable() {
            const searchTerm = searchInput.value.toLowerCase();
            const actionTerm = actionFilter.value.toLowerCase();

            tableRows.forEach(row => {
                const adminId = row.querySelector('.admin-id').textContent.toLowerCase();
                const action = row.querySelector('.action-badge').textContent.toLowerCase();
                const timestamp = row.querySelector('.timestamp').textContent.toLowerCase();

                const matchesSearch = adminId.includes(searchTerm) ||
                    action.includes(searchTerm) ||
                    timestamp.includes(searchTerm);

                const matchesAction = actionTerm === '' || action.includes(actionTerm);

                if (matchesSearch && matchesAction) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });

            updatePaginationInfo();
        }

        function updatePaginationInfo() {
            const visibleRows = document.querySelectorAll('#logsTableBody tr:not([style*="display: none"])');
            document.getElementById('startRecord').textContent = visibleRows.length > 0 ? '1' : '0';
            document.getElementById('endRecord').textContent = visibleRows.length;
            document.getElementById('totalRecords').textContent = tableRows.length;
        }

        if (searchInput) {
            searchInput.addEventListener('input', filterTable);
        }

        if (actionFilter) {
            actionFilter.addEventListener('change', filterTable);
        }

        // Initialize pagination info
        updatePaginationInfo();

        // Add action badge classes based on content
        document.querySelectorAll('.action-badge').forEach(badge => {
            const action = badge.textContent.trim().toLowerCase();
            if (action.includes('login')) {
                badge.classList.add('login');
            } else if (action.includes('creat')) {
                badge.classList.add('create');
            } else if (action.includes('updat')) {
                badge.classList.add('update');
            } else if (action.includes('delet')) {
                badge.classList.add('delete');
            }
        });
    });
</script>
</body>
</html>

