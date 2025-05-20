<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <title>Edit Property</title>
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
            max-width: 900px;
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

        .property-id-display {
            display: inline-block;
            padding: 0.5rem 1rem;
            background-color: rgba(44, 110, 73, 0.1);
            color: var(--primary);
            border-radius: 0.375rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 500;
            color: var(--secondary);
            margin-bottom: 0.5rem;
            display: block;
        }

        .form-control {
            border-radius: 0.375rem;
            border: 1px solid var(--border);
            padding: 0.625rem 1rem;
            font-size: 0.95rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            background-color: rgba(255, 255, 255, 0.9);
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(44, 110, 73, 0.2);
            outline: none;
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
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
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
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

        .form-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .form-text {
            color: var(--secondary);
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: capitalize;
            margin-left: 0.5rem;
        }

        .status-badge.pending {
            background-color: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        .status-badge.approved {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .status-badge.rejected {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }

        .price-input {
            position: relative;
        }

        .price-input::before {
            content: "$";
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary);
            z-index: 10;
        }

        .price-input input {
            padding-left: 2rem;
        }

        .animate-form-field {
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
            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="page-container">
    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-edit"></i>
            Edit Property
        </h1>
    </div>

    <div class="card">
        <div class="card-body">
            <div class="property-id-display">
                <i class="fas fa-home me-2"></i>Property ID: ${property.id}
            </div>

            <form action="${pageContext.request.contextPath}/admin/property/edit" method="post" id="editPropertyForm">
                <input type="hidden" name="id" value="${property.id}">

                <div class="mb-4 animate-form-field" style="animation-delay: 0.1s;">
                    <label for="title" class="form-label">Property Title</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-heading"></i></span>
                        <input type="text" class="form-control" id="title" name="title" value="${property.title}" required placeholder="Enter property title">
                    </div>
                    <div class="form-text">The main title of the property listing</div>
                </div>

                <div class="mb-4 animate-form-field" style="animation-delay: 0.2s;">
                    <label for="description" class="form-label">Property Description</label>
                    <textarea class="form-control" id="description" name="description" required placeholder="Enter detailed property description">${property.description}</textarea>
                    <div class="form-text">Detailed description of the property features and amenities</div>
                </div>

                <div class="mb-4 animate-form-field" style="animation-delay: 0.3s;">
                    <label for="price" class="form-label">Property Price</label>
                    <div class="price-input">
                        <input type="number" step="0.01" class="form-control" id="price" name="price" value="${property.price}" required placeholder="0.00">
                    </div>
                    <div class="form-text">The listing price of the property</div>
                </div>

                <div class="mb-4 animate-form-field" style="animation-delay: 0.4s;">
                    <label for="status" class="form-label">
                        Property Status
                        <span class="status-badge ${property.status}" id="statusBadge">${property.status}</span>
                    </label>
                    <select class="form-control" id="status" name="status" required>
                        <option value="pending" ${property.status == 'pending' ? 'selected' : ''}>Pending</option>
                        <option value="approved" ${property.status == 'approved' ? 'selected' : ''}>Approved</option>
                        <option value="rejected" ${property.status == 'rejected' ? 'selected' : ''}>Rejected</option>
                    </select>
                    <div class="form-text">Current approval status of the property listing</div>
                </div>

                <div class="form-actions animate-form-field" style="animation-delay: 0.5s;">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/manage-properties" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Update status badge when status changes
        const statusSelect = document.getElementById('status');
        const statusBadge = document.getElementById('statusBadge');

        if (statusSelect && statusBadge) {
            statusSelect.addEventListener('change', function() {
                // Update badge text
                statusBadge.textContent = this.value;

                // Remove all status classes
                statusBadge.classList.remove('pending', 'approved', 'rejected');

                // Add the appropriate class
                statusBadge.classList.add(this.value);
            });
        }

        // Form validation enhancement
        const editPropertyForm = document.getElementById('editPropertyForm');

        if (editPropertyForm) {
            editPropertyForm.addEventListener('submit', function(event) {
                const titleField = document.getElementById('title');
                const descriptionField = document.getElementById('description');
                const priceField = document.getElementById('price');

                let isValid = true;

                // Simple validation - this doesn't change functionality, just enhances UX
                if (titleField && titleField.value.trim() === '') {
                    isValid = false;
                    highlightField(titleField);
                }

                if (descriptionField && descriptionField.value.trim() === '') {
                    isValid = false;
                    highlightField(descriptionField);
                }

                if (priceField && (priceField.value.trim() === '' || parseFloat(priceField.value) <= 0)) {
                    isValid = false;
                    highlightField(priceField);
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