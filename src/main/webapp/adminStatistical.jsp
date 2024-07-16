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
<div class="container" >
    <c:import url="adminSideBar.jsp"/>
    <div class="main-content">
        <div id="manage-product" class="content-wrapper">
            <div class="header-admin">
                <div class="header-title">Thống kê</div>
            </div>

            <div class="content-header">
                <div class="btn-grp" >
                    <button class="btn " id="btn-show-revenue">Doanh thu</button>
                    <button class="btn " id="btn-show-top-selling-products">Top sản phẩm bán chạy</button>
                    <button class="btn " id="btn-show-out-of-stuck">Sản phẩm sắp hết hàng</button>
                </div>
            </div>
            <div class="content">
                <canvas id="myChart"></canvas>
            </div>
        </div>
    </div>
</div>

<!-- Include jQuery and Chart.js -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>


<!-- Add the AJAX call -->
<script>
    $(document).ready(function() {
        $.ajax({
            url: '/statistics',
            method: 'GET',
            success: function(data) {
                console.log("Data received:", data); // Log received data

                if (data && data.topSellingProducts) {
                    let ctx = document.getElementById('myChart').getContext('2d');
                    let productNames = data.topSellingProducts.map(product => product.name);
                    let productQuantities = data.topSellingProducts.map(product => product.quantity);

                    let maxQuantity = Math.max(...productQuantities);
                    let maxYScale = maxQuantity + 20;

                    console.log("Product Names:", productNames);
                    console.log("Product Quantities:", productQuantities);
                    console.log("Max Y Scale:", maxQuantity);

                    let myChart = new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: productNames,
                            datasets: [{
                                label: '# of Sales',
                                data: productQuantities,
                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            plugins: {
                                datalabels: {
                                    anchor: 'end',
                                    align: 'end',
                                    color: 'black',
                                    font: {
                                        weight: 'bold'
                                    },
                                    formatter: function(value, context) {
                                        return value;
                                    }
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    max: maxYScale
                                }
                            }
                        },
                        plugins: [ChartDataLabels]
                    });
                    console.log("Chart initialized successfully");
                } else {
                    console.error("Invalid data format received");
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX error:", status, error);
            }
        });
    });
</script>


</body>
</html>
