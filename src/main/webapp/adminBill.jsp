<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.lang.Math" %>
<%
    String role = (String) session.getAttribute("role");
    if ("admin".equals(role)) {
%>

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
<c:import url="./header.jsp"/>
<div class="container">
    <c:import url="./adminSideBar.jsp"/>
    <div class="main-content">
        <div id="manage-bill" class="content-wrapper">
            <div class="header-admin">
                <div class="header-title">Quản lý hóa đơn</div>
            </div>
            <div class="content-header">
                <div class="content-search">
                    <input
                            type="text"
                            placeholder="Tìm kiếm ..."
                            class="input-search"
                    />
                    <i class="icon fa-solid fa-magnifying-glass"></i>
                </div>
            </div>
            <div class="content">
                <table id="manageOrderTable">
                    <thead>
                    <tr>
                        <th scope="col" >Chỉnh sửa</th>
                        <th scope="col" >ID</th>
                        <th scope="col" >ID người dùng</th>
                        <th >Tên sản phâm</th>
                        <th >Số lượng</th>
                        <th >Màu sản phẩm</th>
                        <th scope="col" >Phương thức thanh toán</th>
                        <th scope="col" >Ngày tạo hóa đơn</th>
                        <th scope="col">Tổng tiền đơn hàng</th>
                        <th scope="col" >Địa chỉ nhận hàng</th>
                        <th scope="col" >Trạng thái đơn hàng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.billList}" var="o">
                        <c:set var="price" value="${o.getTotalPrice()}"/>
                        <c:set var="roundedPrice" value="${Math.round(price)}"/>
                        <tr>
                            <td data-label="#Chỉnh sửa">
                                <a class="link" target="_blank" href="adminViewBill?billId=${o.getId()}">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                            </td>
                            <td data-label="ID">${o.getId()}</td>
                            <td data-label="ID người dùng">${o.getUserId()}</td>
                            <td >${o.getProductName()}</td>
                            <td >${o.getQuantity()}</td>
                            <td >${o.getProductColor()}</td>
                            <td data-label="Phương thức thanh toán">${o.getPaymentMethod()}</td>
                            <td data-label="Ngày tạo hóa đơn">${o.getCreateDate()}</td>
                            <td data-label="Tổng tiền đơn hàng">
                                <fmt:formatNumber var="formattedPrice" value="${roundedPrice}" pattern="###,###,###"/>
                                    ${formattedPrice}&nbsp;₫
                            </td>
                            <td data-label="Địa chỉ nhận hàng">${o.getAddress()}</td>
                            <td data-label="Trạng thái đơn hàng">${o.getStatus() == 'IN_PROGRESS' ? 'Chờ xử lý' : (o.getStatus() == 'DONE' ? 'Đã nhận đơn' : 'Đang giao hàng')}</td>
                        </tr>

                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>

<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

<script>
    $(document).ready(function () {
        $('#manageOrderTable').DataTable({
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
<%
    } else {
        response.sendRedirect(request.getContextPath() + "/errorAdmin.jsp");
    }
%>