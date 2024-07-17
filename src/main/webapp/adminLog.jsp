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
    <title>Quản lý Logs</title>
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
                <div class="header-title">Quản lý Logs</div>
            </div>
            <table id="example" class="display nowrap" style="width:100%">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>Role</th>
                    <th>Table</th>
                    <th>Action</th>
                    <th>Action Detail</th>
                    <th>AfterData</th>
                    <th>BeforeData</th>
                    <th>CreateDate</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th>Id</th>
                    <th>Role</th>
                    <th>Table</th>
                    <th>Action</th>
                    <th>Action Detail</th>
                    <th>AfterData</th>
                    <th>BeforeData</th>
                    <th>CreateDate</th>
                </tr>
                </tfoot>
            </table>
        </div>

    </div>
</div>

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
                url: 'http://localhost:8080/adminLoadLog',
                dataSrc: ''
            },
            columns: [
                { data: 'id' },
                { data: 'role' },
                { data: 'table' },
                { data: 'action' },
                { data: 'actionDetail' },
                { data: 'afterData' },
                { data: 'beforeData' },
                {data: 'createDate'}
            ]
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