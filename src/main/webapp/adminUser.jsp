<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
    <c:import url="adminSideBar.jsp"/>
    <div class="main-content">
        <div id="manage-user" class="content-wrapper active">
            <div class="header-admin">
                <div class="header-title">Quản lý người dùng</div>
            </div>

            <div class="content">
                <div class="content-header">
                    <c:set var="searchValue" value="${requestScope.searchValue}"/>
                    <form method="post" action="adminSearchUser" class="content-search">
                        <input
                                type="text"
                                name="search-user"
                                placeholder="Tìm kiếm theo tên, tài khoản hoặc email ..."
                                class="input-search"
                                value="${searchValue}"
                        />
                        <i
                                class="icon fa-solid fa-magnifying-glass"
                        ></i>
                    </form>
                </div>
                <table id="manageUserTable">
                    <thead>
                    <tr>
                        <th class="s-cl" scope="col">Chỉnh sửa</th>
                        <th class="s-cl" scope="col">ID</th>
                        <th class="s-cl" scope="col">ID_Google</th>
                        <th class="m-cl" scope="col">Tên</th>
                        <th class="l-cl" scope="col">Tài khoản</th>
                        <th class="l-cl" scope="col">Email</th>
                        <th class="m-cl" scope="col">Số điện thoại</th>
                        <th class="m-cl" scope="col">Trạng thái tài khoản</th>
                        <th class="m-cl" scope="col">Vai trò</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.userList}" var="o">
                        <tr>
                            <td data-label="Chỉnh sửa">
                                <a class="link" target="_blank" href="adminViewUser?userId=${o.getId()}">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                            </td>
                            <td data-label="ID">${o.getId()}</td>
                            <td data-label="ID_Google">${o.getId_google()}</td>
                            <td data-label="Tên">${o.getFullName()}</td>
                            <td data-label="Tài khoản">${o.getUsername()}</td>
                            <td data-label="Email">${o.getEmail()}</td>
                            <td data-label="Số điện thoại">${o.getPhone()}</td>
                            <td data-label="Trạng thái tài khoản">
                                <c:choose>
                                    <c:when test="${o.getStatus() == 1}">
                                        <p>Đã xác thực</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p>Chưa xác thực</p>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td data-label="Vai trò">
                                <c:choose>
                                    <c:when test="${o.getRole() == 1}">
                                        <p>Quản trị viên</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p>Người dùng</p>
                                    </c:otherwise>
                                </c:choose>
                            </td>
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
        $('#manageUserTable').DataTable({
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
