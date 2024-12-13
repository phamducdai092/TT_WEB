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
    System.out.println("Debug total: " + total);
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
                    <button class="btn">
                        <i class="fa-solid fa-download"></i>
                        Thông tin đơn hàng
                    </button>
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
                    <button class="btn" style="margin-top: 18px;">
                        <i class="fa-solid fa-upload"></i>
                        Upload file
                    </button>
                </div>
                <div class="container-leftSide__stepTwo" >
                    <h4>Bước 4: Xác minh chữ ký</h4>
                    <button class="btn" style="margin-top: 18px;">
                        <i class="fa-solid fa-certificate"></i>
                        Xác minh
                    </button>
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
</html>
