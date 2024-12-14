<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 11/12/2024
  Time: 10:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<%
    String total = (String) request.getAttribute("total");
    String name = (String) request.getParameter("name");
    String phone = (String) request.getParameter("phone");
    String address = (String) request.getParameter("address");
    String payment = (String) request.getParameter("payment");
    System.out.println("Debug total: " + total + " name: " + name + " phone: " + phone + " address: " + address + " payment: " + payment);

%>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="assets/css/verifyUser.css"/>
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
    <link
            href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;700&display=swap"
            rel="stylesheet"
    />
</head>
<body>
<div class="container">
    <div class="container-verifyContent">
        <div class="container-title">
            <h1>
                <i class="fa-regular fa-circle-check" style="color: #13e916;"></i>
                Xác minh chữ ký
            </h1>
        </div>
        <div class="container-content">
            <h2>Hướng dẫn xác minh đơn hàng bằng chữ ký điện tử</h2>
        </div>
        <div class="container-leftSide">
            <div class="container-leftSide__stepOne">
                <h4>Bước 1: Tải thông tin đơn hàng đã được mã hóa ở dưới đây</h4>
                <form action="hashOrder" method="post">
                    <input type="hidden" name="name" value="${name}"/>
                    <input type="hidden" name="phone" value="${phone}"/>
                    <input type="hidden" name="address" value="${address}"/>
                    <input type="hidden" name="payment" value="${payment}" />
                    <input type="hidden" name="total" value="${total}"/>
                    <button class="btn">
                        <i class="fa-solid fa-download"></i>
                        Thông tin đơn hàng
                    </button>
                </form>
            </div>
            <div class="container-leftSide__stepTwo">
                <h4>Bước 2: Sử dụng tool cùng với key đã được cấp để ký lên file</h4>
                <button class="btn">
                    <i class="fa-solid fa-download"></i>
                    Tải tool
                </button>
            </div>
        </div>
        <div class="container-rightSide">
            <div class="container-leftSide__stepOne">
                <h4>Bước 3: Upload file chữ ký</h4>
                <form action="uploadSignature" method="post" enctype="multipart/form-data" id="uploadForm">
                    <!-- Input file ẩn -->
                    <input type="file" name="signatureFile" id="signatureFile" style="display: none;" />

                    <!-- Nút bấm để mở cửa sổ chọn file -->
                    <button type="button" class="btn" style="margin-top: 18px;" onclick="document.getElementById('signatureFile').click();">
                        <i class="fa-solid fa-upload"></i>
                        Chọn file
                    </button>

                    <!-- Nút bấm để upload -->
                    <button type="button" class="btn" style="margin-top: 18px;" id="uploadButton">
                        <i class="fa-solid fa-cloud-arrow-up"></i>
                        Upload
                    </button>
                    <p id="fileNameDisplay" style="margin-top: 10px; font-weight: bold;"></p>
                </form>
            </div>

            <div class="container-leftSide__stepTwo">
                <form id="verifyForm">
                    <h4>Bước 4: Xác minh chữ ký</h4>
                    <button class="btn" style="margin-top: 18px;" id="submit">
                        <i class="fa-solid fa-certificate"></i>
                        Xác minh
                    </button>
                </form>
            </div>
        </div>
    </div>
    <div class="container-bill">
        <div class="container-bill__detail">
            <h2>Tổng tiền</h2>
            <div class="content">
                <ul>
                    <li>Tổng hóa đơn<span><fmt:formatNumber value="${total}" type="currency"
                                                            currencyCode="VND"/></span></li>
                    <li>Shipping<span>Free</span></li>
                    <li class="last">Thành tiền<span><fmt:formatNumber value="${total}" type="currency"
                                                                       currencyCode="VND"/></span></li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    document.getElementById("uploadButton").addEventListener("click", function (event) {
        const fileInput = document.getElementById("signatureFile");
        const fileNameDisplay = document.getElementById("fileNameDisplay");

        // Kiểm tra nếu chưa chọn file
        if (!fileInput.files[0]) {
            alert("Vui lòng chọn file trước khi upload!");
            return;
        }

        // Ngăn hành vi submit mặc định của form
        event.preventDefault();

        // Tạo FormData để gửi qua AJAX
        const formData = new FormData();
        formData.append("signatureFile", fileInput.files[0]);

        // Gửi AJAX
        fetch("uploadSignature", {
            method: "POST",
            body: formData,
        })
            .then(response => {
                if (response.ok) {
                    // Hiển thị tên file nếu upload thành công
                    fileNameDisplay.textContent = "Đã upload file: " + fileInput.files[0].name;
                    alert("File đã upload thành công!");
                } else {
                    alert("Upload thất bại! Vui lòng thử lại.");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("Đã xảy ra lỗi trong quá trình upload!");
            });
    });
    document.getElementById("submit").addEventListener("click", function (event) {
        event.preventDefault();
        const fileNameDisplay = document.getElementById("fileNameDisplay");

        // Kiểm tra tên file đã upload thành công chưa
        if (!fileNameDisplay.textContent || !fileNameDisplay.textContent.startsWith("Đã upload file")) {
            alert("Vui lòng hoàn thành bước 3 (upload file chữ ký) trước khi xác minh.");
            return;
        }

        // Thực hiện gửi request xác minh
        fetch("verifySignature", {
            method: "POST",
        })
            .then(response => {
                if (response.ok) {
                    alert("Xác minh chữ ký thành công!");
                } else {
                    response.text().then(message => alert(`Xác minh thất bại: ${message}`));
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("Đã xảy ra lỗi trong quá trình xác minh!");
            });
    });


</script>
</html>
