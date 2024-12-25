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
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" href="./assets/css/custom-datatable.css"/>
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
                                <div class="key-input">
                                    <label class="title">${publicKey != null ? '' : 'Chưa có Public Key'}</label>
                                </div>
                            </div>
                            <c:if test="${not empty message}">
                                <div class="alert ${message.contains('Thông báo') ? 'alert-danger' : 'alert-success'}">
                                        ${message}
                                </div>
                            </c:if>
                            <button class="btn-submit report" type="submit" onclick="reportKey()">Báo cáo lộ Private
                                Key
                            </button>
                        </div>

                        <div class="profile-content-right">
                            <div class="form-grp">
                                <label class="title" for="keyLength">Chọn độ dài RSA Key</label>
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
                    <div class="keys-container">
                        <c:set var="keys" value="${requestScope.keys}" />
                        <c:choose>
                            <c:when test="${not empty keys}">
                                <c:forEach var="key" items="${keys}">
                                    <div class="key-card ${key.expireDate != null ? 'expired-row' : ''}">
                                        <div class="key-info">
                                            <span>ID:</span>
                                            <span>${key.id}</span>
                                        </div>
                                        <div class="key-info">
                                            <span>Public Key:</span>
                                            <span>${fn:substring(key.publicKey, 0, 30)}...</span>
                                        </div>
                                        <div class="key-info">
                                            <span>Ngày tạo:</span>
                                            <span>${key.createDate}</span>
                                        </div>
                                        <div class="key-info">
                                            <span>Ngày hết hạn:</span>
                                            <c:choose>
                                                <c:when test="${key.expireDate != null}">
                                                    <span class="expired-date">${key.expireDate}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="available">Còn khả dụng</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <button class="btn view-details" data-id="${key.id}">
                                            Xem chi tiết
                                        </button>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p class="no-keys-message">Chưa có khóa nào được tạo. Vui lòng tạo khóa trước khi ký đơn hàng.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
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

<div id="confirmDialog" class="modal-verify">
    <div class="modal-head">
        <h5 class="modal-title"></h5>
        <div class="modal-actions">
            <button id="confirmYes" class="btn-submit">Xác nhận</button>
            <button id="confirmNo" class="btn-submit">Hủy</button>
        </div>
    </div>
</div>

<div id="passwordDialog" class="modal-verify" style="display: none;">
    <div class="modal-head">
        <h4>Xác nhận mật khẩu</h4>
        <p>Vui lòng nhập mật khẩu của bạn để tiếp tục:</p>
        <div class="pw-input">
            <i class="fa-solid fa-key ic"></i>
            <input id="confirmPassword" name="password" type="password" required placeholder="Nhập mật khẩu ..." />
        </div>
        <div class="modal-actions">
            <button id="passwordConfirmBtn" class="btn-submit">Xác nhận</button>
            <button id="passwordCancelBtn" class="btn-submit">Hủy</button>
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

                // Hiển thị thông báo thành công
                showDialog('Tạo key thành công!', null, true);
                location.reload();
                // Lưu nội dung private key vào window.privateKeyContent
                window.privateKeyFileContent = response.privateKey;

                // Thực hiện hành động download khi người dùng muốn tải private key
                $('#downloadPrivateKeyBtn').css('display', 'inline-block');
            },
            error: function (xhr) {
                const response = JSON.parse(xhr.responseText);

                // Hiển thị thông báo lỗi
                showDialog(response.error || 'Có lỗi xảy ra.', null, true);
            }
        });
    }

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

    function showPasswordDialog(onConfirm) {
        const dialog = document.getElementById("passwordDialog");
        let password = document.getElementById("confirmPassword");
        password.innerHTML = "";
        dialog.style.display = "block";

        document.getElementById("passwordConfirmBtn").onclick = function () {
            password = password.value;
            if (password.trim() === "") {
                alert("Mật khẩu không được để trống");
                return;
            }
            dialog.style.display = "none";
            onConfirm(password);
        };

        document.getElementById("passwordCancelBtn").onclick = function () {
            dialog.style.display = "none";
        };
    }

    function reportKey() {
        showDialog("Bạn có chắc chắn muốn báo cáo lộ Private Key không?", function () {
            showPasswordDialog(function (password) {
                $.ajax({
                    url: '/report-leaked-private-key',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ password: password }),
                    success: function (response) {
                        showDialog(response.message || "Báo cáo thành công!", null, true);
                        window.location.href = "/sign-bill";
                    },
                    error: function (xhr) {
                        const response = JSON.parse(xhr.responseText);
                        showDialog(response.error || "Có lỗi xảy ra.", null, true);
                    }
                });
            });
        });
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
                    showDialog('Không thể lấy chi tiết khóa', null, true);
                }
            });
        });
    });
</script>

</body>
</html>
