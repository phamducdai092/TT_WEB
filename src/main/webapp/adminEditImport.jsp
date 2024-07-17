<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String role = (String) session.getAttribute("role");
    if ("admin".equals(role)) {
%>

<html lang="en">
<head>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

    <!-- reset CSS -->
    <link rel="stylesheet" href="./assets/css/reset.css"/>
    <link rel="stylesheet" href="./assets/css/index.css"/>
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
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        #example_wrapper{
            width: 100%;
            padding: 10px;
        }
    </style>
</head>
<body>
<c:import url="header.jsp"/>
<div class="container">
    <c:import url="adminSideBar.jsp"/>
    <div class="main-content">
        <div id="manage-product" class="content-wrapper">
            <div class="header-admin">
                <div class="header-title">Quản lý đơn nhập hàng</div>
            </div>
            <div class="btn-grp">
                <p>Mã Giảm Giá</p>
                <div class="btn-item">
                    <button class="add open-dialog-btn" onclick="openDialogImportOrder()">
                        <i class="fa-solid fa-plus"></i>
                        Thêm đơn nhập hàng
                    </button>
                </div>
            </div>
            <form method="post" action="addImportOrder" class="dialog">
                <div class="dialog-wrapper">
                    <div class="dialog-title">Thêm đơn nhập hàng</div>
                    <span class="close-btn">X</span>
                    <label for="productName">Tên Sản Phẩm:</label>
                    <select id="productName" name="productName">
                        <c:forEach var="product" items="${sessionScope.productList}">
                            <option value="${product.getId()}">${product.getName()}</option>
                        </c:forEach>
                    </select>
                    <label for="colorName">Màu sắc </label>
                    <select id="colorName" name="colorName">
                        <c:forEach var="color" items="${sessionScope.colorList}">
                            <option value="${color.getId()}">${color.getNameColor()}</option>
                        </c:forEach>
                    </select>
                    <label for="quantity">Số Lượng:</label>
                    <div class="quantity-input">
                        <button type="button" class="change-quantity" onclick="decrementQuantity()">-</button>
                        <input type="number" id="quantity" name="quantity" value="1" min="1">
                        <button type="button" class="change-quantity" onclick="incrementQuantity()">+</button>
                    </div>
                    <label>Ngày nhập hàng</label>
                    <input type="datetime-local" name="import-date" required>
                    <br>
                    <button type="submit">Thêm</button>
                </div>
            </form>
            <table id="example" class="display nowrap" style="width:100%">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Color</th>
                    <th>Quantity</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Color</th>
                    <th>Quantity</th>
                    <th>Date</th>
                </tr>
                </tfoot>
            </table>
        </div>

    </div>
</div>
<script>
    let addDiscountButton = document.querySelector('.add');
    let dialogDiscount = document.querySelector('.dialog');
    let closeBtnDiscount = dialogDiscount.querySelector('.close-btn');

    addDiscountButton.addEventListener('click', function (event) {
        event.preventDefault();
        toggleDialogVisibility(dialogDiscount);
    });

    closeBtnDiscount.addEventListener('click', function () {
        toggleDialogVisibility(dialogDiscount);
    });

    function toggleDialogVisibility(dialog) {
        if (dialog.style.display === 'none' || dialog.style.display === '') {
            dialog.style.display = 'block';
        } else {
            dialog.style.display = 'none';
        }
    }
</script>
<script>
    $(document).ready(function () {
        $('#example').DataTable({
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
            "lengthMenu": [5, 10, 25, 50],
            ajax: {
                url: 'http://localhost:8080/getImportData',
                dataSrc: ''
            },
            columns: [
                { data: 'id' },
                { data: 'pr_id' },
                { data: 'color_id' },
                { data: 'quantity' },
                {
                    data: 'timeSet',
                    render: function (data, type, row) {
                        return data ? data[0] + '-' +
                            String(data[1]).padStart(2, '0') + '-' +
                            String(data[2]).padStart(2, '0') + ' ' +
                            String(data[3]).padStart(2, '0') + ':' +
                            String(data[4]).padStart(2, '0') :'';
                    }
                }
            ]
        });
    });
</script>
<script>
    function decrementQuantity() {
        let quantityInput = document.getElementById('quantity');
        if (quantityInput.value > 1) {
            quantityInput.value = parseInt(quantityInput.value) - 1;
        }
    }

    function incrementQuantity() {
        let quantityInput = document.getElementById('quantity');
        quantityInput.value = parseInt(quantityInput.value) + 1;
    }
</script>
</body>
</html>
<%
    } else {
        response.sendRedirect(request.getContextPath() + "/errorAdmin.jsp");
    }
%>