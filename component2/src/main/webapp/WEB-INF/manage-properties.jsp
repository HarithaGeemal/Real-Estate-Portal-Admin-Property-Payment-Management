<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
  <title>Manage Properties</title>
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
      max-width: 1280px;
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
      padding: 0;
    }

    .table-container {
      overflow-x: auto;
    }

    .property-table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
      margin-bottom: 0;
    }

    .property-table thead th {
      background-color: rgba(248, 250, 252, 0.8);
      color: var(--secondary);
      font-weight: 600;
      text-transform: uppercase;
      font-size: 0.75rem;
      letter-spacing: 0.05em;
      padding: 1rem 1.5rem;
      border-bottom: 1px solid var(--border);
      text-align: left;
      white-space: nowrap;
    }

    .property-table tbody tr {
      background-color: rgba(255, 255, 255, 0.7);
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .property-table tbody tr:hover {
      background-color: rgba(241, 245, 249, 0.9);
      transform: translateY(-2px);
    }

    .property-table td {
      padding: 1rem 1.5rem;
      border-bottom: 1px solid var(--border);
      vertical-align: middle;
    }

    .property-id {
      font-weight: 600;
      color: var(--primary);
    }

    .property-title {
      font-weight: 500;
      color: var(--dark);
    }

    .property-description {
      color: var(--secondary);
      max-width: 300px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .property-price {
      font-weight: 600;
      color: var(--dark);
    }

    .property-status {
      display: inline-block;
      padding: 0.25rem 0.75rem;
      border-radius: 9999px;
      font-size: 0.75rem;
      font-weight: 500;
      text-transform: capitalize;
    }

    .property-status.pending {
      background-color: rgba(245, 158, 11, 0.1);
      color: var(--warning);
    }

    .property-status.approved {
      background-color: rgba(16, 185, 129, 0.1);
      color: var(--success);
    }

    .property-status.rejected {
      background-color: rgba(239, 68, 68, 0.1);
      color: var(--danger);
    }

    .action-buttons {
      display: flex;
      gap: 0.5rem;
      align-items: center;
      flex-wrap: wrap;
    }

    .btn {
      padding: 0.5rem 1rem;
      border-radius: 0.375rem;
      font-weight: 500;
      transition: all 0.3s ease;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
    }

    .btn-sm {
      padding: 0.375rem 0.75rem;
      font-size: 0.875rem;
    }

    .btn-success {
      background-color: var(--success);
      border-color: var(--success);
      color: white;
    }

    .btn-success:hover {
      background-color: #0d9488;
      border-color: #0d9488;
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
      transform: translateY(-2px);
    }

    .btn-danger {
      background-color: var(--danger);
      border-color: var(--danger);
      color: white;
    }

    .btn-danger:hover {
      background-color: #dc2626;
      border-color: #dc2626;
      transform: translateY(-2px);
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
    @media (max-width: 992px) {
      .property-description {
        max-width: 200px;
      }
    }

    @media (max-width: 768px) {
      .header-section {
        flex-direction: column;
        align-items: flex-start;
        gap: 1rem;
      }

      .property-description {
        max-width: 150px;
      }

      .action-buttons {
        flex-direction: column;
        align-items: flex-start;
      }

      .action-buttons .btn,
      .action-buttons form {
        width: 100%;
      }
    }

    @media (max-width: 576px) {
      .property-table {
        display: block;
      }

      .property-table thead {
        display: none;
      }

      .property-table tbody,
      .property-table tr,
      .property-table td {
        display: block;
        width: 100%;
      }

      .property-table tr {
        margin-bottom: 1rem;
        border: 1px solid var(--border);
        border-radius: 0.5rem;
        overflow: hidden;
      }

      .property-table td {
        position: relative;
        padding-left: 50%;
        text-align: right;
        border-bottom: 1px solid var(--border);
      }

      .property-table td:before {
        content: attr(data-label);
        position: absolute;
        left: 1rem;
        width: 45%;
        white-space: nowrap;
        font-weight: 600;
        text-align: left;
      }

      .property-description {
        max-width: none;
      }

      .action-buttons {
        justify-content: flex-end;
      }
    }
  </style>
</head>
<body>
<div class="page-container">
  <div class="header-section">
    <h1 class="page-title">
      <i class="fas fa-building"></i>
      Manage Properties
    </h1>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-button">
      <i class="fas fa-arrow-left"></i>
      Back to Dashboard
    </a>
  </div>

  <div class="card animate-card">
    <div class="card-header">
      <h2 class="card-title">
        <i class="fas fa-home"></i>
        Property Listings
      </h2>
    </div>
    <div class="card-body">
      <div class="table-container">
        <table class="property-table">
          <thead>
          <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Price</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="property" items="${properties}">
            <tr>
              <td data-label="ID" class="property-id">${property.id}</td>
              <td data-label="Title" class="property-title">${property.title}</td>
              <td data-label="Description" class="property-description">${property.description}</td>
              <td data-label="Price" class="property-price">$${property.price}</td>
              <td data-label="Status">
                <span class="property-status ${fn:toLowerCase(property.status)}">${property.status}</span>
              </td>
              <td data-label="Actions" class="action-buttons">
                <c:if test="${property.status != 'approved'}">
                  <form action="${pageContext.request.contextPath}/admin/property/approve" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to approve this property?')">
                    <input type="hidden" name="id" value="${property.id}">
                    <button type="submit" class="btn btn-sm btn-success">
                      <i class="fas fa-check"></i>
                      <span>Approve</span>
                    </button>
                  </form>
                </c:if>
                <a href="${pageContext.request.contextPath}/admin/property/edit?id=${property.id}" class="btn btn-sm btn-warning">
                  <i class="fas fa-edit"></i>
                  <span>Edit</span>
                </a>
                <form action="${pageContext.request.contextPath}/admin/property/delete" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this property?')">
                  <input type="hidden" name="id" value="${property.id}">
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
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Add status badge classes based on content
    document.querySelectorAll('.property-status').forEach(badge => {
      const status = badge.textContent.trim().toLowerCase();
      if (status.includes('approved')) {
        badge.classList.add('approved');
      } else if (status.includes('pending')) {
        badge.classList.add('pending');
      } else if (status.includes('rejected')) {
        badge.classList.add('rejected');
      }
    });

    // Add responsive data labels for mobile view
    if (window.innerWidth <= 576) {
      const table = document.querySelector('.property-table');
      if (table) {
        const headers = Array.from(table.querySelectorAll('thead th')).map(th => th.textContent.trim());

        table.querySelectorAll('tbody tr').forEach(row => {
          Array.from(row.querySelectorAll('td')).forEach((cell, index) => {
            if (headers[index]) {
              cell.setAttribute('data-label', headers[index]);
            }
          });
        });
      }
    }
  });
</script>
</body>
</html>