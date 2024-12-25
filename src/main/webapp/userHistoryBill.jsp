<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.ImageService" %>
<fmt:setLocale value="vi_VN"/>
<fmt:setBundle basename="java.text.resources"/>

<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Lịch sử mua hàng</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <!-- embed fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="assets/css/reset.css"/>
    <link rel="stylesheet" href="assets/css/profile.css"/>
    <link rel="stylesheet" href="assets/css/index.css"/>
    <link rel="stylesheet" href="assets/css/style.css"/>


    <!-- FONT GOOGLE -->
    <link
            href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;700&display=swap"
            rel="stylesheet"
    />

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

    <!-- Icon -->
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
            integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
    />
    <!-- styles -->
    <link rel="stylesheet" href="./assets/css/style.css"/>
    <link rel="stylesheet" href="assets/css/list.css">
    <link rel="stylesheet" href="./assets/css/custom-datatable.css"/>
    <link rel="stylesheet" href="./assets/css/user-history-bill.css"/>

    <!-- OWL CAROUSEL CSS -->
    <link rel="stylesheet" href="./assets/css/owl.carousel.min.css"/>
    <link rel="stylesheet" href="./assets/css/owl.theme.default.min.css"/>

    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css"/>
</head>
<body>

<!-- HEADER -->
<c:import url="header.jsp"/>

<div class="container">
    <!-- PROFILE -->
    <div class="profile-container">
        <%--            <form action="./profile" method="post" class="form">--%>
        <!-- .dLDnti -->
        <div data-view-id="breadcrumb_container" class="profile-return">
            <!-- .bXIPFu -->
            <div class="profile-return-content">
                <!-- .hfMLFx -->
                <div class="breadcrumb">
                    <a
                            class="breadcrumb-item br1"
                            data-view-id="breadcrumb_item"
                            data-view-index="0"
                            href="/"
                    >
                        <span>Trang chủ</span>
                    </a>
                    <span class="icon icon-next">
                            <i class="fa fa-angle-right"></i>
                        </span>
                    <a
                            href="#"
                            class="breadcrumb-item"
                            data-view-id="breadcrumb_item"
                            data-view-index="1"
                    >
                            <span title="Thông tin tài khoản"
                            >Lịch sử mua hàng</span
                            >
                    </a>
                </div>
            </div>
        </div>
        <div class="row">
            <jsp:include page="sidebar-profile.jsp"/>
            <div class="col-md-10">
                <div class="your__cart ms-2 p-2">
                    <div class="order-history">
                        <c:forEach items="${userBill}" var="entry">
                            <div class="order-item">
                                <div class="order-header">
                                    <p><strong>Mã đơn hàng:</strong> ${entry.key}</p>
                                    <p class="order-status ${entry.value[0].status.toLowerCase().replace(' ', '_')}">
                                        Trạng thái:
                                        <c:choose>
                                            <c:when test="${entry.value[0].status == 'IN_PROGRESS'}">Đang xử lý</c:when>
                                            <c:when test="${entry.value[0].status == 'IN_SHIPPING'}">Đang vận chuyển</c:when>
                                            <c:when test="${entry.value[0].status == 'DONE'}">Hoàn tất</c:when>
                                            <c:when test="${entry.value[0].status == 'CANCEL'}">Đã hủy</c:when>
                                        </c:choose>
                                    </p>
                                    <p><strong>Tổng tiền:</strong> <span
                                            class="total-price">${entry.value[0].totalPrice} VNĐ</span></p>
                                    <p><strong>Ngày tạo:</strong> ${entry.value[0].createDate}</p>
                                </div>
                                <div class="product-list">
                                    <c:forEach items="${entry.value}" var="product">
                                        <div class="product-item">
                                            <div class="product-image">
                                                <img src="${ImageService.getInstance().getImageByProductId(product.productId).get(0).getLink()}"
                                                     alt="${product.productName}"/>
                                            </div>
                                            <div class="product-info">
                                                <p><strong>Tên sản phẩm:</strong> ${product.productName}</p>
                                                <p><strong>Số lượng:</strong> ${product.quantity}</p>
                                                <p><strong>Màu
                                                    sắc:</strong> ${product.productColor == '1' ? 'Trắng' : 'Đen'}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <c:if test="${entry.value[0].status == 'IN_PROGRESS'}">
                                    <button class="cancel-order-btn btn-submit" onclick="cancelOrder(${entry.key})">Hủy
                                        đơn hàng
                                    </button>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="confirmDialog" class="modal-verify">
    <div class="modal-head">
        <h5 class="modal-title"></h5>
        <div class="modal-actions">
            <button id="confirmYes" class="btn-submit">Xác nhận</button>
            <button id="confirmNo" class="btn-submit">Hủy</button>
        </div>
    </div>
</div>


<!-- MAIN JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script>
    function showDialog(message, onConfirm, onlyOk = false) {
        const dialog = document.getElementById("confirmDialog");
        dialog.querySelector("h5").innerText = message;
        dialog.style.display = "block";

        const btnYes = document.getElementById("confirmYes");
        const btnNo = document.getElementById("confirmNo");

        if (onlyOk) {
            btnYes.innerText = "OK";
            btnNo.style.display = "none";
        } else {
            btnYes.innerText = "Xác nhận";
            btnNo.style.display = "inline-block";
        }

        btnYes.onclick = function () {
            dialog.style.display = "none";
            if (onConfirm) onConfirm();
        };

        btnNo.onclick = function () {
            dialog.style.display = "none";
        };
    }

    function cancelOrder(orderId) {
        showDialog("Bạn có chắc chắn muốn hủy đơn hàng này?", function () {
            $.ajax({
                url: "/cancelOrder",
                type: "POST",
                data: {
                    orderId: orderId
                },
                success: function (response) {
                    if (response.success === true) {
                        location.reload(); // Tải lại trang nếu hủy thành công
                    } else {
                        showDialog("Hủy đơn hàng thất bại", null, true); // Thông báo thất bại
                    }
                },
                error: function () {
                    showDialog("Hủy đơn hàng thất bại", null, true); // Thông báo lỗi
                }
            });
        });
    }
</script>
</body>
</html>
