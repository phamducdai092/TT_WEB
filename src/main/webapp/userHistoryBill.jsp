<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<fmt:setLocale value="vi_VN"/>
<fmt:setBundle basename="java.text.resources"/>

<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Lịch sử mua hàng</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

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
                    <table id="orderTable">
                        <thead>
                        <tr>
                            <th>Mã đơn hàng</th>
                            <th>Tên sản phâm</th>
                            <th>Số lượng</th>
                            <th>Màu sản phẩm</th>
                            <th>Ngày mua</th>
                            <th>Họ và tên</th>
                            <th>Số điện thoại</th>
                            <th>Địa chỉ</th>
                            <th>Phương thức thanh toán</th>
                            <th>Trạng thái đơn hàng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="userBill" value="${requestScope.userBill}"/>
                        <c:forEach items="${userBill}" var="order">
                            <tr>
                                <td data-label="Mã đơn hàng">${order.id}</td>
                                <td data-label="Tên sản phâm">${order.productName}</td>
                                <td data-label="Số lượng">${order.quantity}</td>
                                <td data-label="Màu sản phẩm">${order.productColor == '1' ? 'Trắng' : 'Đen'}</td>
                                <td data-label="Ngày mua">${order.createDate}</td>
                                <td data-label="Họ và tên">${order.fullName}</td>
                                <td data-label="Số điện thoại">${order.phone}</td>
                                <td data-label="Địa chỉ">${order.address}</td>
                                <td data-label="Phương thức thanh toán">${order.paymentMethod}</td>
                                <td data-label="Trạng thái đơn hàng">${order.status == 'IN_PROGRESS' ? 'Chờ xử lý' : (order.status == 'DONE' ? 'Đã nhận đơn' : 'Đang giao hàng')}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <th>Mã đơn hàng</th>
                            <th>Tên sản phâm</th>
                            <th>Số lượng</th>
                            <th>Màu sản phẩm</th>
                            <th>Ngày mua</th>
                            <th>Họ và tên</th>
                            <th>Số điện thoại</th>
                            <th>Địa chỉ</th>
                            <th>Phương thức thanh toán</th>
                            <th>Trạng thái đơn hàng</th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- MAIN JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>

<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function () {
        $('#orderTable').DataTable({
            "dom": '<"top"lf>rt<"bottom"ip><"clear">',
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
            },
            "lengthMenu": [5, 10, 25, 50]
        });
    });
</script>
</body>
</html>
