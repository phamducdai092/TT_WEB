<%--
  Created by IntelliJ IDEA.
  User: DucDai
  Date: 12-Dec-24
  Time: 3:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Chữ ký</title>
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
    <link rel="stylesheet" href="./assets/css/sign.css">
    <link rel="stylesheet" href="./assets/css/custom-datatable.css"/>
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css"/>
</head>
<body>

<%
    Object obj = session.getAttribute("auth");
    User user = null;
    if (obj != null)
        user = (User) obj;
%>

<c:import url="header.jsp"/>
<div class="container">
    <div class="profile-container">
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
                            >Chữ ký</span
                            >
                    </a>
                </div>
            </div>
        </div>
        <div class="row">
            <jsp:include page="sidebar-profile.jsp"/>
            <div class="col-md-10">
                <div class="profile-content">
                    <div class="profile-content-header">
                        <h2>Chữ ký</h2>
                    </div>

                    <div class="profile-content-body">
                        <div class="profile-content-left">
                            <div class="form-grp">
                                <label for="publicKey">Public Key</label>
                                <div class="key-input">
                                    <textarea id="publicKey" placeholder="Public Key" readonly>
                                        ${publicKey != null ? publicKey : 'Chưa có Public Key'}
                                    </textarea>
                                </div>
                            </div>
                            <c:if test="${not empty message}">
                                <div class="alert ${message.contains('lỗi') ? 'alert-danger' : 'alert-success'}">
                                        ${message}
                                </div>
                            </c:if>
                            <button class="btn-submit report" type="submit" onclick="reportKey()">Báo cáo lộ Private
                                Key
                            </button>
                        </div>

                        <div class="profile-content-right">
                            <div class="form-grp">
                                <label for="keyLength">Chọn độ dài RSA Key</label>
                                <select id="keyLength" class="form-select">
                                    <option value="1024">1024 bit</option>
                                    <option value="2048">2048 bit</option>
                                    <option value="3072" selected>3072 bit</option>
                                </select>
                            </div>
                            <div class="btn-grp">
                                <button class="btn-submit" type="button" onclick="generateKey()">Tạo Key</button>
                                <button class="btn-submit" id="downloadPrivateKeyBtn" type="button"
                                        style="display: none;"
                                        onclick="downloadPrivateKey()">Tải Private Key
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="your__cart ms-2 p-2">
                    <table id="keysTable" class="display">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Public Key</th>
                            <th>Ngày tạo</th>
                            <th>Ngày hết hạn</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="keys" value="${requestScope.keys}"/>
                        <c:choose>
                            <c:when test="${not empty keys}">
                                <c:forEach var="key" items="${keys}">
                                    <tr class="${key.expireDate != null ? 'expired-row' : ''}">
                                        <td>${key.id}</td>
                                        <td>${fn:substring(key.publicKey, 0, 30)}...</td>
                                        <td>${key.createDate}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${key.expireDate != null}">
                                                    <p class="expired-date">${key.expireDate}</p>
                                                </c:when>
                                                <c:otherwise>
                                                    N/A
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button class="btn btn-info view-details" data-id="${key.id}">Xem
                                                chi tiết
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <h3>Chưa có khóa nào được tạo. Vui lòng tạo khóa trước khi ký đơn hàng.</h3>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                        <tfoot>
                        <tr>
                            <th>ID</th>
                            <th>Public Key</th>
                            <th>Ngày tạo</th>
                            <th>Ngày hết hạn</th>
                            <th>Hành động</th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
            <div class="col-md-10">

            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="keyDetailsModal" tabindex="-1" aria-labelledby="keyDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="keyDetailsModalLabel">Chi tiết khóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div><strong>ID:</strong> <span id="keyId"></span></div>
                <div><strong>Public Key:</strong> <span id="publicKeyDetail"></span></div>
                <div><strong>Ngày tạo:</strong> <span id="createDate"></span></div>
                <div><strong>Ngày hết hạn:</strong> <span id="expireDate"></span></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-submit btn-secondary" data-bs-dismiss="modal">Đóng</button>
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
    var userId = <%= user != null ? user.getId() : "null" %>;

    function generateKey() {
        const keyLength = document.getElementById('keyLength').value;

        $.ajax({
            url: '/generate-key',
            method: 'POST',
            data: {
                keyLength: keyLength,
                userId: userId
            },
            success: function (response) {
                $('#publicKey').val(response.publicKey);
                alert('Tạo key thành công!');

                // Lưu nội dung private key vào window.privateKeyContent
                window.privateKeyFileContent = response.privateKey;

                // Thực hiện hành động download khi người dùng muốn tải private key
                $('#downloadPrivateKeyBtn').css('display', 'inline-block');
            },
            error: function (xhr) {
                const response = JSON.parse(xhr.responseText);
                alert(response.error || 'Có lỗi xảy ra.');
            }
        });
    }

    function reportKey() {
        const confirmed = confirm("Bạn có chắc chắn muốn báo cáo lộ Private Key không?");
        if (confirmed) {
            // Gửi yêu cầu AJAX đến kiểm tra key khả dụng
            $.ajax({
                url: '/report-leaked-private-key',
                method: 'GET',
                success: function (response) {
                    alert(response.message || "Báo cáo thành công!");
                    window.location.href = "/sign-bill";  // Redirect nếu thành công
                },
                error: function (xhr) {
                    const response = JSON.parse(xhr.responseText);
                    alert(response.error || "Có lỗi xảy ra.");
                }
            });
        }
    }

    function downloadPrivateKey() {
        const privateKeyContent = window.privateKeyFileContent || "Your private key content here"; // Nội dung private key
        const fileName = "private_key.txt";
        console.log(privateKeyContent);

        // Chuyển nội dung key thành file tải xuống
        const blob = new Blob([privateKeyContent], {type: 'text/plain'});
        const link = document.createElement('a');
        link.href = URL.createObjectURL(blob);
        link.download = fileName; // Đặt tên file
        link.click(); // Kích hoạt tải file
    }

    $(document).ready(function () {
        // Khởi tạo DataTable
        $('#keysTable').DataTable({
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
            order: [[2, 'desc']], // Sắp xếp theo cột Public Key giảm dần
            columnDefs: [
                {
                    targets: 2, // Chỉ định cột datetime
                    type: 'datetime' // Đảm bảo DataTable nhận diện kiểu datetime
                }
            ]
        });

        // Xử lý sự kiện 'Xem chi tiết'
        $('.view-details').on('click', function () {
            var keyId = $(this).data('id');
            // Lấy thông tin chi tiết khóa từ server (có thể thông qua Ajax)
            $.ajax({
                url: '/get-key-details',  // Địa chỉ API để lấy chi tiết khóa
                method: 'GET',
                data: {id: keyId},
                success: function (data) {
                    // Hiển thị chi tiết khóa trong modal
                    $('#keyId').text(data.id);
                    $('#publicKeyDetail').text(data.publicKey);
                    $('#createDate').text(data.createDate);
                    $('#expireDate').text(data.expireDate);
                    // Mở modal
                    $('#keyDetailsModal').modal('show');
                },
                error: function () {
                    alert('Không thể lấy chi tiết khóa');
                }
            });
        });
    });
</script>

</body>
</html>
