
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trading Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .report-card {
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .report-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }
        .card-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .download-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .btn-download {
            background: rgba(255,255,255,0.2);
            border: 2px solid rgba(255,255,255,0.3);
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        .btn-download:hover {
            background: rgba(255,255,255,0.3);
            border-color: rgba(255,255,255,0.5);
            color: white;
            transform: translateY(-2px);
        }
        .report-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        .page-header {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-5 fw-bold mb-0">
                        <i class="fas fa-chart-line me-3"></i>Trading Reports
                    </h1>
                    <p class="lead mb-0">Generate and download comprehensive trading reports</p>
                </div>
                <div class="col-md-4 text-end">
                    <i class="fas fa-file-chart-line" style="font-size: 4rem; opacity: 0.3;"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- PDF Download Section -->
        <div class="download-section text-center">
            <h3 class="mb-3">
                <i class="fas fa-file-pdf me-2"></i>Download Complete Trading Report
            </h3>
            <p class="mb-4">Generate a comprehensive PDF report of all your trading activities</p>
            <button class="btn btn-download btn-lg" onclick="downloadPdf()">
                <i class="fas fa-download me-2"></i>Download PDF Report
            </button>
        </div>

        <!-- Report Cards Section -->
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="mb-4">
                    <i class="fas fa-th-large me-2"></i>Report Categories
                </h2>
            </div>
        </div>

        <div class="report-grid">
            <!-- Order History Report Card -->
            <div class="card report-card h-100">
                <div class="card-body text-center">
                    <div class="card-icon text-primary">
                        <i class="fas fa-history"></i>
                    </div>
                    <h5 class="card-title">Order History Report</h5>
                    <p class="card-text">
                        Comprehensive view of all your trading orders including buy/sell transactions, 
                        order status, timestamps, and execution details.
                    </p>
                    <div class="mt-auto">
                        <button class="btn btn-primary" onclick="generateOrderHistoryReport()">
                            <i class="fas fa-chart-bar me-2"></i>Generate Report
                        </button>
                        <button class="btn btn-outline-primary ms-2" onclick="downloadOrderHistoryPdf()">
                            <i class="fas fa-file-pdf me-2"></i>PDF
                        </button>
                    </div>
                </div>
            </div>

            <!-- Profit & Loss Report Card -->
            <div class="card report-card h-100">
                <div class="card-body text-center">
                    <div class="card-icon text-success">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h5 class="card-title">Profit & Loss Report</h5>
                    <p class="card-text">
                        Detailed analysis of your trading performance including realized/unrealized gains, 
                        losses, profit margins, and overall portfolio performance metrics.
                    </p>
                    <div class="mt-auto">
                        <button class="btn btn-success" onclick="generateProfitLossReport()">
                            <i class="fas fa-chart-pie me-2"></i>Generate Report
                        </button>
                        <button class="btn btn-outline-success ms-2" onclick="downloadProfitLossPdf()">
                            <i class="fas fa-file-pdf me-2"></i>PDF
                        </button>
                    </div>
                </div>
            </div>

            <!-- Portfolio Summary Report Card -->
            <div class="card report-card h-100">
                <div class="card-body text-center">
                    <div class="card-icon text-info">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h5 class="card-title">Portfolio Summary</h5>
                    <p class="card-text">
                        Overview of your current portfolio holdings, asset allocation, 
                        market values, and diversification analysis across different sectors.
                    </p>
                    <div class="mt-auto">
                        <button class="btn btn-info" onclick="generatePortfolioReport()">
                            <i class="fas fa-pie-chart me-2"></i>Generate Report
                        </button>
                        <button class="btn btn-outline-info ms-2" onclick="downloadPortfolioPdf()">
                            <i class="fas fa-file-pdf me-2"></i>PDF
                        </button>
                    </div>
                </div>
            </div>

            <!-- Performance Analytics Card -->
            <div class="card report-card h-100">
                <div class="card-body text-center">
                    <div class="card-icon text-warning">
                        <i class="fas fa-analytics"></i>
                    </div>
                    <h5 class="card-title">Performance Analytics</h5>
                    <p class="card-text">
                        Advanced trading analytics including risk metrics, volatility analysis, 
                        Sharpe ratio, maximum drawdown, and performance benchmarking.
                    </p>
                    <div class="mt-auto">
                        <button class="btn btn-warning" onclick="generatePerformanceReport()">
                            <i class="fas fa-chart-area me-2"></i>Generate Report
                        </button>
                        <button class="btn btn-outline-warning ms-2" onclick="downloadPerformancePdf()">
                            <i class="fas fa-file-pdf me-2"></i>PDF
                        </button>
                    </div>
                </div>
            </div>

            <!-- Tax Report Card -->
            <div class="card report-card h-100">
                <div class="card-body text-center">
                    <div class="card-icon text-danger">
                        <i class="fas fa-receipt"></i>
                    </div>
                    <h5 class="card-title">Tax Report</h5>
                    <p class="card-text">
                        Tax-ready reports for capital gains/losses, dividend income, 
                        and other taxable events to simplify your tax filing process.
                    </p>
                    <div class="mt-auto">
                        <button class="btn btn-danger" onclick="generateTaxReport()">
                            <i class="fas fa-file-invoice-dollar me-2"></i>Generate Report
                        </button>
                        <button class="btn btn-outline-danger ms-2" onclick="downloadTaxPdf()">
                            <i class="fas fa-file-pdf me-2"></i>PDF
                        </button>
                    </div>
                </div>
            </div>

            <!-- Transaction Summary Card -->
            <div class="card report-card h-100">
                <div class="card-body text-center">
                    <div class="card-icon text-secondary">
                        <i class="fas fa-exchange-alt"></i>
                    </div>
                    <h5 class="card-title">Transaction Summary</h5>
                    <p class="card-text">
                        Summary of all transactions including deposits, withdrawals, 
                        fees, commissions, and account balance changes over time.
                    </p>
                    <div class="mt-auto">
                        <button class="btn btn-secondary" onclick="generateTransactionReport()">
                            <i class="fas fa-list me-2"></i>Generate Report
                        </button>
                        <button class="btn btn-outline-secondary ms-2" onclick="downloadTransactionPdf()">
                            <i class="fas fa-file-pdf me-2"></i>PDF
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Date Range Filter Section -->
        <div class="card mt-4">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-filter me-2"></i>Report Filters
                </h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <label for="startDate" class="form-label">Start Date</label>
                        <input type="date" class="form-control" id="startDate">
                    </div>
                    <div class="col-md-4">
                        <label for="endDate" class="form-label">End Date</label>
                        <input type="date" class="form-control" id="endDate">
                    </div>
                    <div class="col-md-4">
                        <label for="reportFormat" class="form-label">Format</label>
                        <select class="form-select" id="reportFormat">
                            <option value="pdf">PDF</option>
                            <option value="excel">Excel</option>
                            <option value="csv">CSV</option>
                        </select>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <button class="btn btn-primary" onclick="applyFilters()">
                            <i class="fas fa-filter me-2"></i>Apply Filters
                        </button>
                        <button class="btn btn-outline-secondary ms-2" onclick="resetFilters()">
                            <i class="fas fa-undo me-2"></i>Reset
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Loading Modal -->
    <div class="modal fade" id="loadingModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body text-center py-4">
                    <div class="spinner-border text-primary mb-3" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <h5>Generating Report...</h5>
                    <p class="mb-0">Please wait while we prepare your report.</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Main PDF download function (existing endpoint)
        function downloadPdf() {
            showLoadingModal();
            window.location.href = '/pdf/download';
            window.location.href = '/download/csv';
            setTimeout(hideLoadingModal, 2000);
        }

        // Placeholder functions for different report types
        // You can replace these with actual endpoint calls later
        
        function generateOrderHistoryReport() {
            showLoadingModal();
            // TODO: Replace with actual endpoint call
            console.log('Generating Order History Report...');
            setTimeout(() => {
                hideLoadingModal();
                alert('Order History Report generated successfully!');
            }, 2000);
        }

        function downloadOrderHistoryPdf() {
            showLoadingModal();
            window.location.href = '/pdf/download';
            console.log('Downloading Order History PDF...');
            setTimeout(hideLoadingModal, 2000);
        }

        function generateProfitLossReport() {
            showLoadingModal();
            // TODO: Replace with actual endpoint call
            console.log('Generating Profit & Loss Report...');
            setTimeout(() => {
                hideLoadingModal();
                alert('Profit & Loss Report generated successfully!');
            }, 2000);
        }

        function downloadProfitLossPdf() {
            showLoadingModal();
            // TODO: Replace with actual PDF endpoint
            console.log('Downloading Profit & Loss PDF...');
            setTimeout(hideLoadingModal, 2000);
        }

        function generatePortfolioReport() {
            showLoadingModal();
            console.log('Generating Portfolio Summary...');
            setTimeout(() => {
                hideLoadingModal();
                alert('Portfolio Summary generated successfully!');
            }, 2000);
        }

        function downloadPortfolioPdf() {
            showLoadingModal();
            console.log('Downloading Portfolio PDF...');
            setTimeout(hideLoadingModal, 2000);
        }

        function generatePerformanceReport() {
            showLoadingModal();
            console.log('Generating Performance Analytics...');
            setTimeout(() => {
                hideLoadingModal();
                alert('Performance Analytics generated successfully!');
            }, 2000);
        }

        function downloadPerformancePdf() {
            showLoadingModal();
            window.location.href = '/download/csv';
            console.log('Downloading Performance PDF...');
            setTimeout(hideLoadingModal, 2000);
        }

        function generateTaxReport() {
            showLoadingModal();
            console.log('Generating Tax Report...');
            setTimeout(() => {
                hideLoadingModal();
                alert('Tax Report generated successfully!');
            }, 2000);
        }

        function downloadTaxPdf() {
            showLoadingModal();
            console.log('Downloading Tax PDF...');
            setTimeout(hideLoadingModal, 2000);
        }

        function generateTransactionReport() {
            showLoadingModal();
            console.log('Generating Transaction Summary...');
            setTimeout(() => {
                hideLoadingModal();
                alert('Transaction Summary generated successfully!');
            }, 2000);
        }

        function downloadTransactionPdf() {
            showLoadingModal();
            console.log('Downloading Transaction PDF...');
            setTimeout(hideLoadingModal, 2000);
        }

        // Filter functions
        function applyFilters() {
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            const format = document.getElementById('reportFormat').value;
            
            console.log('Applying filters:', { startDate, endDate, format });
            alert('Filters applied! All reports will use the selected date range and format.');
        }

        function resetFilters() {
            document.getElementById('startDate').value = '';
            document.getElementById('endDate').value = '';
            document.getElementById('reportFormat').value = 'pdf';
            console.log('Filters reset');
        }

        // Utility functions
        function showLoadingModal() {
            const modal = new bootstrap.Modal(document.getElementById('loadingModal'));
            modal.show();
        }

        function hideLoadingModal() {
            const modal = bootstrap.Modal.getInstance(document.getElementById('loadingModal'));
            if (modal) {
                modal.hide();
            }
        }

        // Set default date range (last 30 days)
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const thirtyDaysAgo = new Date(today.getTime() - (30 * 24 * 60 * 60 * 1000));
            
            document.getElementById('endDate').value = today.toISOString().split('T')[0];
            document.getElementById('startDate').value = thirtyDaysAgo.toISOString().split('T')[0];
        });
    </script>
</body>
</html>