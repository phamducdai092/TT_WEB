<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bean.User" %>


<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Our Project 49</title>

    <!-- reset CSS -->
    <link rel="stylesheet" href="assets/css/reset.css" />
    <link rel="stylesheet" href="assets/css/profile.css" />
    <link rel="stylesheet" href="assets/css/index.css" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- <link rel="stylesheet" href="./assets/css/product.css"> -->

    <!-- embed fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />


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

    <!-- OWL CAROUSEL CSS -->
    <link rel="stylesheet" href="./assets/css/owl.carousel.min.css" />
    <link rel="stylesheet" href="./assets/css/owl.theme.default.min.css" />
</head>
<body>

<%
    Object obj = session.getAttribute("auth");
    User user = null;
    if (obj != null)
        user = (User) obj;
%>
<!-- HEADER -->
<c:import url="header.jsp"/>


<div class="container">

    <%
        String email = user.getEmail();
        int phone = user.getPhone();
        String firstName = user.getFirstName();
        String lastName = user.getLastName();
        String birthDay = user.getBirthDate();
        String gender = user.getGender();
    %>
    <!-- PROFILE -->
    <div class="profile-container">
        <%--            <form action="./profile" method="post" class="form">--%>
        <!-- .dLDnti -->
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
                            >Thông tin tài khoản</span
                            >
                    </a>
                </div>
            </div>
        </div>
        <!-- .dLDnti -->
        <div class="row">
            <jsp:include page="sidebar-profile.jsp" />
            <form action="./profile" method="post" class="my-form col-md-9">
                <div id="manage-account" class="account active">
                    <div class="account_title">Thông tin tài khoản</div>
                    <div class="style_info">
                        <div class="info">
                            <div class="info-left">
                                <span class="info-title">Thông tin cá nhân</span>
                                <div class="form-profile">
                                    <%--                                 <form action="./profile" method="post" class="form">--%>
                                    <div class="form-info">
                                        <div class="form-avatar">
                                            <div class="form-avatar-image">
                                                <div>
                                                    <div class="avatar-view">
                                                        <img
                                                                src="https://png.pngtree.com/png-clipart/20210613/original/pngtree-gray-silhouette-avatar-png-image_6404679.jpg"
                                                                alt="avatar"
                                                                class="default"
                                                        />
                                                        <div class="edit">
                                                            <img
                                                                    src="https://frontend.tikicdn.com/_desktop-next/static/img/account/edit.png"
                                                                    class="edit_img"
                                                                    alt=""
                                                            />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-name">
                                            <div class="my-form-control">
                                                <label for="firstName" class="input-label">Họ</label>
                                                <div>
                                                    <div class="input-content">
                                                        <input
                                                                id="firstName"
                                                                class="input-name"
                                                                type="search"
                                                                name="firstName"
                                                                maxlength="128"
                                                                placeholder="Họ"
                                                                value = "<%=firstName%>"
                                                        />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="my-form-control">
                                                <label for="lastName" class="input-label">Tên</label>
                                                <div>
                                                    <div class="input-content">
                                                        <input
                                                                id="lastName"
                                                                class="input-nickname"
                                                                name="lastName"
                                                                maxlength="128"
                                                                placeholder="Tên"
                                                                type="search"
                                                                value="<%=lastName%>"
                                                        />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="my-form-control">
                                        <label for="birthDate" class="input-label">Ngày sinh</label>
                                        <div class="input-content">

                                            <input id="birthDate" type="date" name="birthDate" class="input-date" value="<%=birthDay%>">

                                        </div>
                                    </div>
                                    <div class="my-form-control">
                                        <label class="input-label"
                                        >Giới tính</label
                                        >
                                        <label class="radio">
                                            <input

                                                    type="radio"
                                                    name="gender"
                                                    value="male"
                                                    <%= "male".equals(gender) ? "checked" : "" %>

                                            />
                                            <span class="radio-fake"></span><span class="label">Nam</span>
                                        </label>
                                        <label  class="radio">
                                            <input

                                                    type="radio"
                                                    name="gender"
                                                    value="female"
                                                    <%= "female".equals(gender) ? "checked" : "" %>
                                            />
                                            <span class="radio-fake"></span><span class="label">Nữ</span>
                                        </label>
                                    </div>

                                    <div class="my-form-control">
                                        <label class="input-label">
                                            &nbsp;
                                        </label>
                                        <button
                                                id="save"
                                                type="submit"
                                                class="btn-submit"
                                                onclick="return validateForm()"
                                        >
                                            Lưu thay đổi
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="info-right">
                            <span class="info-title"
                            >Số điện thoại và Email</span
                            >
                                <!-- lCUBE -->
                                <div class="info-contact">
                                    <div class="list-item">
                                        <div class="info">
                                            <i class="fa fa-phone icon-profile"></i>
                                            <div class="detail">
                                                <label for="phone" class="input-label">Số điện thoại</label>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="input-content">
                                                <input
                                                        id="phone"
                                                        class="input-phone"
                                                        type="tel"
                                                        name="phone"
                                                        maxlength="128"
                                                        placeholder="Phone"
                                                        onkeyup="validatePhone()"

                                                        <%
                                                            if (phone == 0) {
                                                        %>
                                                        value = ""

                                                        <%
                                                        } else {
                                                        %>
                                                        value = "0<%=phone%>"
                                                        <%
                                                            }
                                                        %>

                                                />
                                                <span id = "phone-error"></span>

                                            </div>
                                        </div>

                                    </div>
                                    <div class="list-item">
                                        <div class="info">
                                            <i class="fa fa-envelope icon-profile"></i>
                                            <div class="detail">
                                                <label for="email" class="input-label">Địa chỉ email</label>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="input-content">
                                                <input
                                                        id="email"
                                                        class="input-mail"
                                                        type="email"
                                                        name="email"
                                                        maxlength="128"
                                                        placeholder="Email"
                                                        onkeyup="validateEmail()"
                                                        value = "<%=email%>"
                                                />
                                                <span id = "email-error"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <span class="info-title">Bảo mật</span>
                                <div class="info-contact">
                                    <div class="list-item">
                                        <div>
                                            <i class="fa fa-lock icon-profile"></i>
                                            <span>Thiết lập mật khẩu</span>
                                        </div>
                                        <div class="status">
                                            <span></span>
                                            <a href="./resetPassword.jsp" id="updatePasswordLink">
                                                <button class="button active account-password">
                                                    Cập nhật
                                                </button>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>
<!-- MAIN JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="js/profile.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script>
    function validateForm() {
        var firstName = document.getElementById('firstName').value.trim();
        var lastName = document.getElementById('lastName').value.trim();
        var birthDate = document.getElementById('birthDate').value;
        var phone = document.getElementById('phone').value.trim();
        var email = document.getElementById('email').value.trim();
        var gender = document.querySelector('input[name="gender"]:checked');

        // Kiểm tra xem các trường bắt buộc đã được điền đầy đủ
        if (firstName === '' || lastName === '' || birthDate === '' || phone === '' || email === '' || !gender) {
            alert('Vui lòng điền đầy đủ thông tin.');
            return false;
        }

        // Kiểm tra định dạng email
        var emailRegex = /^[A-Za-z\._\-0-9]*[@][A-Za-z]*[\.][a-z]{2,4}$/;
        if (!emailRegex.test(email)) {
            alert('Vui lòng nhập địa chỉ email hợp lệ.');
            return false;
        }

        // Kiểm tra định dạng số điện thoại
        var phoneRegex = /^[0-9]{10}$/;
        if (!phoneRegex.test(phone)) {
            alert('Vui lòng nhập số điện thoại hợp lệ.');
            return false;
        }

        // Nếu tất cả thông tin hợp lệ, cho phép submit form
        return true;
    }
</script>
</body>

</html>