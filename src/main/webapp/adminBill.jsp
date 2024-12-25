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
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
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
            <div class="content">
                <table id="manageOrderTable">
                    <thead>
                    <tr>
                        <th scope="col">Chỉnh sửa</th>
                        <th scope="col">ID</th>
                        <th scope="col">ID người dùng</th>
                        <th>Tên sản phâm</th>
                        <th>Số lượng</th>
                        <th>Màu sản phẩm</th>
                        <th scope="col">Phương thức thanh toán</th>
                        <th scope="col">Ngày tạo hóa đơn</th>
                        <th scope="col">Tổng tiền đơn hàng</th>
                        <th scope="col">Địa chỉ nhận hàng</th>
                        <th scope="col">Trạng thái đơn hàng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.billList}" var="o">
                        <c:set var="price" value="${o.getTotalPrice()}"/>
                        <c:set var="roundedPrice" value="${Math.round(price)}"/>
                        <tr>
                            <td data-label="#Chỉnh sửa">
                                <button class="change open-dialog-btn" onclick="openDialog(${o.getIdBillDetail()})">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </button>
                            </td>

                            <td data-label="ID">${o.getId()}</td>
                            <td data-label="ID người dùng">${o.getUserId()}</td>
                            <td>${o.getProductName()}</td>
                            <td>${o.getQuantity()}</td>
                            <td>
                                    ${o.productColor == '1' ? 'Trắng' : 'Đen'}
                            </td>
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
                    <tfoot>
                    <tr>
                        <th scope="col">Chỉnh sửa</th>
                        <th scope="col">ID</th>
                        <th scope="col">ID người dùng</th>
                        <th>Tên sản phâm</th>
                        <th>Số lượng</th>
                        <th>Màu sản phẩm</th>
                        <th scope="col">Phương thức thanh toán</th>
                        <th scope="col">Ngày tạo hóa đơn</th>
                        <th scope="col">Tổng tiền đơn hàng</th>
                        <th scope="col">Địa chỉ nhận hàng</th>
                        <th scope="col">Trạng thái đơn hàng</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
    <div class="overlay" onclick="closeDialog()"></div>
    <form method="post" action="adminEditBill" class="dialog">
        <div class="dialog-wrapper">
            <div class="dialog-title">Chỉnh sửa đơn hàng</div>
            <span class="close-btn">X</span>
            <!-- Trường ẩn chứa billId -->
            <input type="hidden" id="billId" name="billId">
            <!-- Trường ẩn chứa billDetailId -->
            <input type="hidden" id="idBillDetail" name="idBillDetail">
            <input type="hidden" id="userId" name="userId">

            <label for="productName">Tên sản phẩm:</label>
            <select id="productName" name="productName" class="form-select">
                <c:forEach items="${requestScope.productList}" var="product">
                    <option value="${product.getId()}"
                        ${product.getId() == productId ? 'selected' : ''}>
                            ${product.getName()}
                    </option>
                </c:forEach>
            </select>

            <div class="form-row">
                <label for="quantity">Số lượng: </label>
                <input type="number" id="quantity" name="quantity" min="1" autofocus="autofocus" class="form-input">
            </div>


            <label for="color">Màu sắc:</label>
            <select id="color" name="color" class="form-select" required>
                <option value="1">Trắng</option>
                <option value="2">Đen</option>
            </select>


            <label for="address">Địa chỉ:</label>
            <input type="text" id="address" name="address" autofocus="autofocus">

            <button type="submit">Lưu thay đổi</button>
        </div>
    </form>
<%
        // Kiểm tra nếu có thông báo thành công trong request
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <script type="text/javascript">
            // Hiển thị thông báo thành công
            alert('<%= message %>');
        </script>
            <%
        }
    %>
    <style>
        .form-select {
            height: 35px;
            padding: 5px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        .form-input {
            width: 100%;
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-row {
            display: grid;
            grid-template-columns: auto 1fr; /* 2 cột: label và input */
            align-items: center; /* Căn giữa theo chiều dọc */
            gap: 10px; /* Khoảng cách giữa các phần tử */
        }
    </style>
        <script>
            // Hàm mở dialog
            function openDialog(idBillDetail) {
                var dialog = document.querySelector('.dialog');
                var overlay = document.querySelector('.overlay');

                // Hiển thị dialog và overlay
                dialog.style.display = 'block';
                overlay.style.display = 'block';

                // Gửi yêu cầu AJAX để lấy thông tin hóa đơn từ server
                $.ajax({
                    url: 'getBillDetails',  // URL để lấy thông tin hóa đơn
                    method: 'GET',
                    data: { id: idBillDetail },
                    success: function(response) {
                        // Điền thông tin vào các trường trong form
                        console.log(response);

                        document.getElementById("productName").value = response.productName;
                        document.getElementById("quantity").value = response.quantity;
                        document.getElementById("address").value = response.address;


                        // Gắn productId vào biến
                        var productId = response.productId;  // Giả sử response.productId là ID sản phẩm

                        // Cập nhật giá trị của dropdown "productName" dựa trên productId
                        var productSelect = document.getElementById("productName");
                        productSelect.value = productId; // Gắn giá trị productId vào dropdown

                        // Lấy ID màu từ phản hồi và chọn màu tương ứng trong dropdown
                        var selectedColorId = response.color;  // Giả sử response.colorId là ID màu từ hóa đơn
                        var colorSelect = document.getElementById("color");
                        document.getElementById("billId").value = response.id;
                        document.getElementById("idBillDetail").value = response.idBillDetail;
                        document.getElementById("userId").value = response.userId;
                        // Duyệt qua các options trong dropdown và chọn màu phù hợp
                        for (var i = 0; i < colorSelect.options.length; i++) {
                            if (colorSelect.options[i].value == selectedColorId) {
                                colorSelect.selectedIndex = i; // Chọn option tương ứng
                                break;
                            }
                        }
                    },
                    error: function(error) {
                        console.error("Error:", error);
                    }
                });
            }

            // Hàm đóng dialog
            function closeDialog() {
                var dialog = document.querySelector('.dialog');
                var overlay = document.querySelector('.overlay');
                dialog.style.display = 'none';
                overlay.style.display = 'none';
            }

            // Đóng dialog khi nhấn nút close
            document.querySelector('.close-btn').addEventListener('click', function () {
                closeDialog();
            });

        </script>

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