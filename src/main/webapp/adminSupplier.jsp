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
<c:import url="header.jsp"/>
<div class="container" >
    <c:import url="adminSideBar.jsp"/>
    <div class="main-content">
        <div id="manage-product" class="content-wrapper">
            <div class="header-admin">
                <div class="header-title">Quản lý nhà cung cấp</div>
            </div>

            <div class="content">
                <div class="btn-grp">
                    <p>Nhà Cung Cấp</p>
                    <div class="btn-item">
                        <button class="add open-dialog-btn">
                            <i class="fa-solid fa-plus"></i>
                            Thêm nhà cung cấp
                        </button>
                    </div>
                </div>
                <form method="get" action="addSupplier" class="dialog">
                    <input value="${productId}" hidden="hidden" name="productId">
                    <div class="dialog-wrapper">
                        <div class="dialog-title">Thêm nhà cung cấp</div>
                        <span class="close-btn">X</span>
                        <label>Tên</label>
                        <input type="text" name="new-supplier-name" required>
                        <label>Email</label>
                        <input type="email" name="new-supplier-email" placeholder="Eg: abc@gmail.com" required pattern="/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/">
                        <label>Phone</label>
                        <input type="tel" name="new-supplier-phone" placeholder="Eg: 0941457078" pattern="[0-9]{3}[0-9]{3}[0-9]{4}" maxlength="12"  title="Số điện thoại gồm từ 10-12 số" required>
                        <button type="submit">Thêm</button>
                    </div>
                </form>
                <table id="manageSupplierTable">
                    <thead>
                    <tr>
                        <th class="s-cl" scope="col">Ẩn</th>
                        <th class="s-cl" scope="col">Chỉnh sửa</th>
                        <th class="m-cl" scope="col">Mã nhà cung cấp</th>
                        <th class="l-cl" scope="col">Tên nhà cung cấp</th>
                        <th class="m-cl" scope="col">Email</th>
                        <th class="m-cl" scope="col" >Phone</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${sessionScope.supplierList}" var="o">
                        <tr>
                            <td class="s-cl" data-label="Ẩn">
                                <a class="link" href="hiddenSupplier?supplierId=${o.getId()}">
                                    <c:choose>
                                        <c:when test="${o.getStatus() == 1}">
                                            <i class="fa-regular fa-eye"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-regular fa-eye-slash"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </td>
                            <td class="s-cl" data-label="Chỉnh sửa">
                                <a class="link" target="_blank" href="adminViewProduct?productId=${o.getId()}">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                            </td>
                            <td class="m-cl" data-label="Mã nhà cung cấp">${o.getId()}</td>
                            <td class="l-cl" data-label="Tên nhà cung cấp">${o.getName()}</td>
                            <td class="m-cl" data-label="Email">${o.getEmail()}</td>
                            <td class="m-cl" data-label="Phone">${o.getPhone()}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>

<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

<script>
    $(document).ready(function () {
        $('#manageSupplierTable').DataTable({
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