<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Đăng nhập</title>

    <!-- reset CSS -->
    <link rel="stylesheet" href="assets/css/reset.css"/>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

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

    <!-- Icon -->
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
            integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
    />
    <!-- styles -->
    <link rel="stylesheet" href="assets/css/style.css"/>
    <link rel="stylesheet" href="assets/css/log.css"/>
</head>
<body>
<!-- Form -->

<div class="content">
    <c:set var="error" value="${requestScope.error}"/>
    <c:set var="username" value="${requestScope.username}"/>
    <c:set var="email" value="${requestScope.email}"/>
    <c:set var="isNotVerify" value="${requestScope.isNotVerify}"/>
    <c:set var="emailNotExist" value="${requestScope.emailNotExist}"/>
    <c:set var="blocked" value="${sessionScope.blocked}"/>
    <c:set var="failedAttempts" value="${sessionScope.failedAttempts}"/>
    <%
        long currentTimeMillis = System.currentTimeMillis();
    %>
    <c:set var="currentTime" value="<%= currentTimeMillis %>" />
    <c:set var="blockTime" value="${sessionScope.blockTime}"/>
    <c:set var="remainingTime" value="${(blockTime + 60000) - currentTime}"/> <!-- 60000 milliseconds = 1 phút -->

    <!-- Log In -->
    <div class="form-wrapper log-in" id="log-in">
        <a href="./index.jsp" class="back-cta">
            <i class="fa-solid fa-chevron-left"></i>
            Trở về trang chủ
        </a>
        <c:choose>
            <c:when test="${blocked != null and blocked and remainingTime > 0}">
                <!-- Hiển thị thông báo và thời gian còn lại -->
                <form class="failedAttempts-grp">
                    <div class="failedAttempts">Bạn đã nhập sai quá nhiều lần.</div>
                    <div class="failedAttempts">Vui lòng thử lại sau <span id="countdown" class="failedAttempts">${remainingTime/1000}</span> giây.</div>
                </form>
                <script>
                    // Đếm ngược thời gian còn lại
                    let countdown = document.getElementById('countdown');
                    let remainingSeconds = ${remainingTime/1000};
                    let countdownInterval = setInterval(function() {
                        remainingSeconds--;
                        countdown.textContent = Math.floor(remainingSeconds);
                        countdown.textContent = remainingSeconds;

                        if (remainingSeconds <= 0) {
                            clearInterval(countdownInterval);
                            document.getElementById('log-in').innerHTML = `<form action="./log" method="post" class="form" autocomplete="on">
                    <p class="title">Đăng Nhập</p>
                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <c:if test="${error != null}">
                        <p class=" text-danger">${error}</p>
                    </c:if>
                    <!-- Nếu có lỗi xác minh email -->
                    <c:if test="${not empty isNotVerify}">
                        <p class=" text-danger">${emailNotExist}</p>
                    </c:if>
                    <div class="form-grp">
                        <label for="username__login">Tài khoản</label>
                        <div class="user-input">
                            <i class="fa-solid fa-user ic"></i>
                            <input id="username__login" type="text" name="username" required placeholder="Nhập tên tài khoản hoặc email ..." value="${username}"/>
                        </div>
                        <div class="errorMessage"></div>
                    </div>

                    <div class="form-grp">
                        <label for="password__login">Mật khẩu</label>
                        <div class="pw-input">
                            <i class="fa-solid fa-key ic"></i>
                            <input id="password__login" name="password" type="password" required placeholder="Nhập mật khẩu ..." />
                        </div>
                        <div class="errorMessage"></div>
                    </div>

                    <div class="forget-pw">
                        <a class="link" href="forgetPassword.jsp">Quên mật khẩu ?</a>
                    </div>

                    <button type="submit" class="submit sub-btn" id="signin">ĐĂNG NHẬP</button>

                    <div class="footer">
                        <span>Chưa đăng ký tài khoản ?</span>
                        <button type="button" class="link" id="sign-up-link">
                            <a class="link" href="signUp.jsp">Đăng ký</a>
                        </button>
                    </div>
                </form>`;
                        }
                    }, 1000);
                </script>
            </c:when>
            <c:otherwise>
                <!-- Hiển thị form đăng nhập -->
                <form action="./log" method="post" class="form" autocomplete="on">
                    <p class="title">Đăng Nhập</p>
                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <c:if test="${error != null}">
                        <p class=" text-danger">${error}</p>
                    </c:if>
                    <!-- Nếu có lỗi xác minh email -->
                    <c:if test="${not empty isNotVerify}">
                        <p class=" text-danger">${emailNotExist}</p>
                    </c:if>
                    <div class="form-grp">
                        <label for="username__login">Tài khoản</label>
                        <div class="user-input">
                            <i class="fa-solid fa-user ic"></i>
                            <input id="username__login" type="text" name="username" required placeholder="Nhập tên tài khoản hoặc email ..." value="${username}"/>
                        </div>
                        <div class="errorMessage"></div>
                    </div>

                    <div class="form-grp">
                        <label for="password__login">Mật khẩu</label>
                        <div class="pw-input">
                            <i class="fa-solid fa-key ic"></i>
                            <input id="password__login" name="password" type="password" required placeholder="Nhập mật khẩu ..." />
                        </div>
                        <div class="errorMessage"></div>
                    </div>

                    <div class="forget-pw">
                        <a class="link" href="forgetPassword.jsp">Quên mật khẩu ?</a>
                    </div>

                    <button type="submit" class="submit sub-btn" id="signin">ĐĂNG NHẬP</button>
                    <button
                            type="submit"
                            class="submit sub-btn"
                            id="signin"
                    >
                        ĐĂNG NHẬP
                    </button>
                    <p class="divider">or</p>
                    <div class="login-fb-gg">
                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:8080/LoginGoogleHandler&response_type=code
		   &client_id=792220056066-o9nj6cocon8fi0uppnq0u973bd42rl6t.apps.googleusercontent.com&approval_prompt=force"
                           class="login-gg">
                            <img width="129px" height="37px" alt="google-login-button"
                                 src="//bizweb.dktcdn.net/assets/admin/images/login/gp-btn.svg">
                        </a>

                        <a href="" class="login-fb">
                            <img width="129px" height="37px" alt="facebook-login-button"
                                 src="//bizweb.dktcdn.net/assets/admin/images/login/fb-btn.svg">
                        </a>
                    </div>

                    <div class="footer">
                        <span>Chưa đăng ký tài khoản ?</span>
                        <button type="button" class="link" id="sign-up-link">
                            <a class="link" href="signUp.jsp">Đăng ký</a>
                        </button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<script src="js/validation.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // validate cho form đăng nhập
        Validator({
            form: '#log-in',
            parentError: '.form-grp',
            errorSelector: '.errorMessage',
            rules: [
                Validator.isRequired('#username__login'),
                Validator.minLength('#password__login', 6)
            ]
        })
    });
</script>

</body>

</html>