<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    String role = (String) session.getAttribute("role");
    if ("admin".equals(role)) {
%>

<html lang="en">
<head>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
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
                <div class="header-title">Quản lý thương hiệu</div>
            </div>

            <div class="content">
                <div class="btn-grp">
                    <p>Thương Hiệu</p>
                    <div class="btn-item">
                        <button class="add-brand add open-dialog-btn">
                            <i class="fa-solid fa-plus"></i>
                            Thêm thương hiệu
                        </button>
                    </div>
                </div>
                <form method="get" action="addBrand" class="dialog-brand">
                    <input value="${productId}" hidden="hidden" name="productId">
                    <div class="dialog-wrapper">
                        <div class="dialog-title">Thêm thương hiệu</div>
                        <span class="close-btn-brand" onclick="closeDialog()">x</span>
                        <label>Tên thương hiệu</label>
                        <input type="text" name="new-brand">
                        <button type="submit">Thêm</button>
                    </div>
                </form>
                <table id="manageBrandTable">
                    <thead>
                    <tr>
                        <th class="s-cl" scope="col">Ẩn</th>
                        <th class="s-cl" scope="col">Chỉnh sửa</th>
                        <th class="m-cl" scope="col">Mã Thương Hiệu</th>
                        <th class="l-cl" scope="col">Tên</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${sessionScope.brandList}" var="o">
                        <tr>
                            <td class="s-cl" data-label="Ẩn">
                                <a class="link" href="hiddenBrand?brandId=${o.getId()}">
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
                            <td class="m-cl" data-label="Mã Thương Hiệu">${o.getId()}</td>
                            <td class="l-cl" data-label="Tên">${o.getName()}</td>

                        </tr>
                    </c:forEach>

                    </tbody>
                    <tfoot>
                    <tr>
                        <th class="s-cl" scope="col">Ẩn</th>
                        <th class="s-cl" scope="col">Chỉnh sửa</th>
                        <th class="m-cl" scope="col">Mã Thương Hiệu</th>
                        <th class="l-cl" scope="col">Tên</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    let brandButton = document.querySelector('.add-brand');
    let dialogBrand = document.querySelector('.dialog-brand');
    let closeBtnBrand = dialogBrand.querySelector('.close-btn-brand');

    brandButton.addEventListener('click', function (event) {
        event.preventDefault();
        toggleDialogVisibility(dialogBrand);
    });

    closeBtnBrand.addEventListener('click', function () {
        toggleDialogVisibility(dialogBrand);
    });

    function toggleDialogVisibility(dialog) {
        // Hiển thị hoặc ẩn dialog tùy thuộc vào trạng thái hiện tại
        if (dialog.style.display === 'none' || dialog.style.display === '') {
            dialog.style.display = 'block';
        } else {
            dialog.style.display = 'none';
        }
    }
</script>


<script>
    $(document).ready(function () {
        $('#manageBrandTable').DataTable({
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