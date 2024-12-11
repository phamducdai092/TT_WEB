<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Admin</title>
    <!-- reset CSS -->
    <link rel="stylesheet" href="./assets/css/reset.css"/>
    <link rel="stylesheet" href="./assets/css/index.css"/>
    <!-- FONT AWRSOME -->
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    />

    <link
            href="https://fonts.googleapis.com/css2?family=Lato:wght@700&display=swap"
            rel="stylesheet"
    />
    <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
            rel="stylesheet"
    />

    <!-- embed fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>

    <link
            href="https://fonts.googleapis.com/css2?family=Lato:wght@700&display=swap"
            rel="stylesheet"
    />
    <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
            rel="stylesheet"
    />

    <link rel="stylesheet" href="./assets/css/admin.css"/>
    <link rel="stylesheet" href="./assets/css/style.css"/>
    <link rel="stylesheet" href="./assets/css/custom-datatable.css">
</head>
<body>
<c:import url="header.jsp"/>
<div class="container">
    <c:import url="adminSideBar.jsp"/>
    <div class="main-content">
        <div id="manage-product" class="content-wrapper">
            <div class="header-admin">
                <div class="header-title">Thống kê</div>
            </div>

            <div class="content-header">
                <button class="btn btn-item" id="btn-show-revenue">Doanh thu hôm nay</button>
                <button class="btn btn-item" id="btn-show-revenue-7">Doanh thu 7 ngày qua</button>
                <button class="btn btn-item" id="btn-show-revenue-30">Doanh thu 30 ngày qua</button>
                <button class="btn btn-item" id="btn-show-top-selling-products">Top sản phẩm bán chạy</button>
                <button class="btn btn-item" id="btn-show-out-of-stuck">Sản phẩm sắp hết hàng</button>
            </div>
            <div class="content">
                <canvas id="myChart"></canvas>
                <div id="outStockWrapper">
                    <table id="outStock" class="out-of-stock-table collapse">
                        <thead>
                        <tr>
                            <th>ID sản phẩm</th>
                            <th>Màu</th>
                            <th>Số lượng</th>
                        </tr>
                        </thead>
                        <tfoot>
                        <tr>
                            <th>Tên sản phẩm</th>
                            <th>Màu</th>
                            <th>Số lượng</th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include jQuery and Chart.js -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<script>
    $(document).ready(function () {
        let myChart = null; // Variable to store the chart instance

        // Function to fetch data based on dataType
        function fetchData(dataType) {
            $.ajax({
                url: '/statistics',
                method: 'GET',
                data: {
                    dataType: dataType // Pass the dataType parameter
                },
                success: function (data) {
                    console.log("Data received:", data); // Log received data

                    // Destroy previous chart if exists
                    if (myChart) {
                        myChart.destroy();
                    }

                    // Initialize chart based on data type
                    if (dataType.startsWith('revenue')) {
                        initializeRevenueChart(data, dataType); // Initialize revenue chart
                    } else if (dataType === 'topSellingProducts') {
                        initializeTopSellingChart(data); // Initialize top selling products chart
                    } else if (dataType === 'outOfStockProducts') {
                        initializeOutOfStockTable(data); // Initialize out of stock products table
                    }
                },
                error: function (xhr, status, error) {
                    console.error("AJAX error:", status, error);
                }
            });
        }

        // Function to initialize revenue chart
        function initializeRevenueChart(data, dataType) {
            if (data && Array.isArray(data)) {
                let ctx = document.getElementById('myChart').getContext('2d');
                let productId = data.map(product => product.id);
                let productRevenue = data.map(product => product.revenue);
                let totalRevenue = data.reduce((acc, product) => acc + product.saleQuantity * product.totalPrice, 0);

                let maxRevenue = Math.max(...productRevenue);
                let maxYScale = maxRevenue + maxRevenue * 0.3;

                let chartLabel = '';
                if (dataType === 'revenueToday') {
                    chartLabel = 'Doanh thu hôm nay ' + totalRevenue + ' VND';
                } else if (dataType === 'revenue7Days') {
                    chartLabel = 'Doanh thu 7 ngày qua ' + totalRevenue + ' VND';
                } else if (dataType === 'revenue30Days') {
                    chartLabel = 'Doanh thu 30 ngày qua ' + totalRevenue + ' VND';
                }

                myChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: productId, // Assuming you have an array of product IDs or names
                        datasets: [{
                            label: 'Đã bán',
                            data: productRevenue,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        plugins: {
                            title: {
                                display: true,
                                text: chartLabel,
                                font: {
                                    size: 18,
                                    weight: 'bold'
                                },
                                padding: {
                                    top: 10,
                                    bottom: 30
                                }
                            },
                            datalabels: {
                                anchor: 'end',
                                align: 'end',
                                color: 'black',
                                font: {
                                    weight: 'bold'
                                },
                                formatter: function (value, context) {
                                    return value;
                                }
                            }
                        },
                        scales: {
                            x: {
                                title: {
                                    display: true,
                                    text: 'Mã sản phẩm',
                                    font: {
                                        size: 14,
                                        weight: 'bold'
                                    },
                                    padding: {
                                        top: 10,
                                        bottom: 10
                                    }
                                }
                            },
                            y: {
                                title: {
                                    display: true,
                                    text: 'Doanh thu',
                                    font: {
                                        size: 14,
                                        weight: 'bold'
                                    },
                                    padding: {
                                        top: 10,
                                        bottom: 10
                                    }
                                },
                                beginAtZero: true,
                                max: maxYScale
                            }
                        }
                    }
                });

                console.log("Chart initialized successfully");
            } else {
                console.error("Invalid data format received");
            }
        }

        // Function to initialize top selling products chart
        function initializeTopSellingChart(data) {
            if (data && Array.isArray(data)) {
                let ctx = document.getElementById('myChart').getContext('2d');
                let productId = data.map(product => product.id);
                let productQuantities = data.map(product => product.saleQuantity);

                let maxQuantity = Math.max(...productQuantities);
                let maxYScale = maxQuantity + 20;

                myChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: productId, // Assuming you have an array of product IDs or names
                        datasets: [{
                            label: 'Bán được',
                            data: productQuantities,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        plugins: {
                            title: {
                                display: true,
                                text: 'Top sản phẩm bán chạy',
                                font: {
                                    size: 18,
                                    weight: 'bold'
                                },
                                padding: {
                                    top: 10,
                                    bottom: 30
                                }
                            },
                            datalabels: {
                                anchor: 'end',
                                align: 'end',
                                color: 'black',
                                font: {
                                    weight: 'bold'
                                },
                                formatter: function (value, context) {
                                    return value;
                                }
                            }
                        },
                        scales: {
                            x: {
                                title: {
                                    display: true,
                                    text: 'Mã sản phẩm',
                                    font: {
                                        size: 14,
                                        weight: 'bold'
                                    },
                                    padding: {
                                        top: 10,
                                        bottom: 10
                                    }
                                }
                            },
                            y: {
                                title: {
                                    display: true,
                                    text: 'Số lượng bán được',
                                    font: {
                                        size: 14,
                                        weight: 'bold'
                                    },
                                    padding: {
                                        top: 10,
                                        bottom: 10
                                    }
                                },
                                beginAtZero: true,
                                max: maxYScale
                            }
                        }
                    }
                });

                console.log("Chart initialized successfully");
            } else {
                console.error("Invalid data format received");
            }
        }

        // Function to initialize out of stock products table
        function initializeOutOfStockTable(data) {
            if (data && Array.isArray(data)) {
                if ($.fn.DataTable.isDataTable('#outStock')) {
                    // If so, destroy it
                    $('#outStock').DataTable().destroy();
                }

                const hasCollapseClass = $('#outStock').hasClass('collapse');
                const languageConfig = hasCollapseClass ? {} : {
                    "language": {
                        "lengthMenu": "Hiển thị _MENU_ bản ghi mỗi trang",
                        "zeroRecords": "Không tìm thấy bản ghi nào",
                        "info": "Hiển thị trang _PAGE_ của _PAGES_",
                        "infoEmpty": "Không có bản ghi nào",
                        "infoFiltered": "(lọc từ _MAX_ bản ghi)",
                        "search": "Tìm kiếm:",
                        "paginate": {
                            "first": "Đầu",
                            "last": "Cuối",
                            "next": "Tiếp",
                            "previous": "Trước"
                        }
                    }
                };

                $('#outStock').DataTable({
                    data: data,
                    columns: [
                        {data: "pr_id"},
                        {
                            data: "color_id",
                            render: function (data, type, row) {
                                // Chuyển đổi color_id thành tên màu
                                if (data === '1') {
                                    return 'Trắng';
                                } else if (data === '2') {
                                    return 'Đen';
                                } else {
                                    return data; // Giữ nguyên nếu không phải 1 hoặc 2
                                }
                            }
                        },
                        {data: "quantity"}
                    ],
                    ...languageConfig
                });

                console.log("DataTable initialized successfully");
            } else {
                console.error("Invalid data format received");
            }
        }

        // Event handler for 'Sản phẩm bán chạy' button click
        $('#btn-show-top-selling-products').click(function () {
            $('#myChart').removeClass('collapse');
            $('#outStockWrapper').addClass('collapse');
            fetchData('topSellingProducts'); // Call fetchData with dataType
        });

        // Event handler for 'Sản phẩm sắp hết hàng' button click
        $('#btn-show-out-of-stuck').click(function () {
            $('#myChart').addClass('collapse');
            $('#outStockWrapper').removeClass('collapse');
            $('#outStock').removeClass('collapse');
            fetchData('outOfStockProducts'); // Call fetchData with dataType
        });

        // Event handler for 'Doanh thu hôm nay' button click
        $('#btn-show-revenue').click(function () {
            $('#myChart').removeClass('collapse');
            $('#outStockWrapper').addClass('collapse');
            fetchData('revenueToday'); // Call fetchData with dataType
        });

        // Event handler for 'Doanh thu 7 ngày qua' button click
        $('#btn-show-revenue-7').click(function () {
            $('#myChart').removeClass('collapse');
            $('#outStockWrapper').addClass('collapse');
            fetchData('revenue7Days'); // Call fetchData with dataType
        });

        // Event handler for 'Doanh thu 30 ngày qua' button click
        $('#btn-show-revenue-30').click(function () {
            $('#myChart').removeClass('collapse');
            $('#outStockWrapper').addClass('collapse');
            fetchData('revenue30Days'); // Call fetchData with dataType
        });

        // Initially load default data (today revenue products)
        fetchData('revenueToday'); // Load today revenue products by default
    });
</script>

</body>
</html>
