<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Admin</title>

    <!-- reset CSS -->
    <link rel="stylesheet" href="assets/css/reset.css"/>
    <link rel="stylesheet" href="assets/css/index.css"/>
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

    <link rel="stylesheet" href="assets/css/adminProductView.css"/>
    <link rel="stylesheet" href="assets/css/style.css"/>
</head>
<body>
<div class="container">
    <div class="title">Chỉnh sửa sản phẩm</div>
    <c:set var="product" value="${sessionScope.product}"/>
    <c:set var="productId" value="${sessionScope.productId}"/>
    <div class="product-wraper">
        <form method="get" action="changeInforProduct" class="left">
            <p class="product-header">Thông tin sản phẩm</p>
            <div class="product product-name">
                <label for="product-name" class="product-title">Tên sản phẩm:</label>
                <input value="${productId}" hidden="hidden" name="productId">
                <input id="product-name" name="product-name" class="product-sub" value="${product.getName()}"></input>
            </div>
            <div class="product product-discount">
                <label for="product-discount" class="product-title">Giảm giá: </label>
                <input id="product-discount" name="product-discount" class="product-sub"
                       value="${product.getDiscountId()}"></input>
            </div>
            <div class="product product-discount-start">
                <label for="product-discount-start" class="product-title">Ngày bắt đầu: </label>
                <input id="product-discount-start" type="datetime-local" name="product-discount-start"
                       class="product-sub" value="${product.getDiscountStartDay(product.getDiscountId())}"></input>
            </div>
            <div class="product product-discount-end">
                <label for="product-discount-end" class="product-title">Ngày kết thúc: </label>
                <input id="product-discount-end" type="datetime-local" name="product-discount-end" class="product-sub"
                       value="${product.getDiscountEndDay(product.getDiscountId())}"></input>
            </div>
            <div class="product product-category">
                <label class="product-title">Danh mục: </label>
                <select id="selectOption" class="custom-select" name="product-category">
                    <c:forEach var="category" items="${sessionScope.categories}">
                        <c:choose>
                            <c:when test="${product.getCategoryId() == category.getId()}">
                                <option class="product-sub" selected="selected"
                                        value="${product.getCategoryName(product.getCategoryId())}">${product.getCategoryName(product.getCategoryId())}</option>
                            </c:when>
                            <c:otherwise>
                                <option class="product-sub" value="${category.getName()}">${category.getName()}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
                <button type="button" class="add-category btn btn-submit btn-admin">Thêm</button>
            </div>
            <div class="product product-brand">
                <label class="product-title">Thương hiệu: </label>
                <select id="selectBrand" class="custom-select" name="product-brand">
                    <c:forEach var="brand" items="${sessionScope.brands}">
                        <c:choose>
                            <c:when test="${product.getBrandId() == brand.getId()}">
                                <option class="product-sub" selected="selected"
                                        value="${product.getBrandName(product.getBrandId())}">${product.getBrandName(product.getBrandId())}</option>
                            </c:when>
                            <c:otherwise>
                                <option class="product-sub" value="${brand.getName()}">${brand.getName()}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
                <button type="button" class="add-brand btn btn-submit btn-admin">Thêm</button>
            </div>
            <div class="product product-supplier">
                <label class="product-title">Nhà Cung Cấp</label>
                <select id="selectSupplier" class="custom-select" name="product-supplier">
                    <c:forEach var="supplier" items="${sessionScope.suppliers}">
                        <c:choose>
                            <c:when test="${product.getSupplierId() == supplier.getId()}">
                                <option class="product-sub" selected="selected"
                                        value="${product.getSupplierName(product.getSupplierId())}">${product.getSupplierName(product.getSupplierId())}</option>
                            </c:when>
                            <c:otherwise>
                                <option class="product-sub"  value="${supplier.getName()}">${supplier.getName()}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
                <a href="">
                    <button class="btn btn-submit btn-admin">Thêm</button>
                </a>
            </div>
            <div class="product product-quantity">
                <label for="product-quantity" class="product-title">Số lượng: </label>
                <input id="product-quantity" name="product-quantity" class="product-sub"
                       value="${product.getQuantity()}"></input>
            </div>
            <div class="product product-price">
                <label for="product-price" class="product-title">Giá: </label>
                <input id="product-price" name="product-price" class="product-sub"
                       value="${product.getTotalPrice()}"></input>
            </div>
            <div class="product product-desc">
                <label for="product-desc" class="product-title">Thông tin sản phẩm: </label>
                <textarea id="product-desc" name="product-desc" class="desc-area" id=""
                          class="product-sub">${product.getDescription()}</textarea>
            </div>
            <button type="submit" class="btn btn-submit">
                Cập nhập thông tin
            </button>
        </form>
        <form class="right">
            <p class="product-header">Hình ảnh sản phẩm</p>
            <div class="list-img">
                <c:forEach var="o" items="${product.imageProducts(product.getId())}">
                    <div class="item">
                        <a href="adminRemoveImg?imgId=${o.getId()}"> <i
                                class="fa-regular fa-circle-xmark delete-ic"></i></a>
                        <img class="img-product" src="${o.getLink()}" alt="">
                    </div>
                </c:forEach>
            </div>
            <button class="btn btn-admin">
                <a href="addProductImage?productId=${product.getId()}" type="submit" class="btn btn-submit">
                    Thêm hình ảnh
                </a>
            </button>

        </form>
        <form method="get" action="addCategory" class="dialog-category">
            <div class="dialog-wrapper">
                <div class="dialog-title">Thêm danh mục</div>
                <span class="close-btn-cate" onclick="closeDialog()">X</span>
                <label for="input1">Tên danh mục</label>
                <input type="text" id="input1" name="new-category">
                <button type="submit">Thêm</button>
            </div>
        </form>
        <form method="get" action="addBrand" class="dialog-brand">
            <div class="dialog-wrapper">
                <div class="dialog-title">Thêm thương hiệu</div>
                <span class="close-btn-brand" onclick="closeDialog()">x</span>
                <label>Tên thương hiệu</label>
                <input type="text" name="new-brand">
                <button type="submit">Thêm</button>
            </div>
        </form>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var categoryButton = document.querySelector('.add-category');
        var brandButton = document.querySelector('.add-brand');

        var dialogCate = document.querySelector('.dialog-category');
        var dialogBrand = document.querySelector('.dialog-brand');

        var closeBtnCate = dialogCate.querySelector('.close-btn-cate');
        var closeBtnBrand = dialogBrand.querySelector('.close-btn-brand');

        categoryButton.addEventListener('click', function (event) {
            event.preventDefault();
            toggleDialogCateVisibility();
        });

        brandButton.addEventListener('click', function (event) {
            event.preventDefault();
            toggleDialogBrandVisibility();
        });

        closeBtnCate.addEventListener('click', function () {
            toggleDialogCateVisibility();
        });

        closeBtnBrand.addEventListener('click', function () {
            toggleDialogBrandVisibility();
        });

        function toggleDialogCateVisibility() {
            // Hiển thị hoặc ẩn dialog-category tùy thuộc vào trạng thái hiện tại
            if (dialogCate.style.display === 'none' || dialogCate.style.display === '') {
                dialogCate.style.display = 'block';
            } else {
                dialogCate.style.display = 'none';
            }
        }

        function toggleDialogBrandVisibility() {
            // Hiển thị hoặc ẩn dialog-brand tùy thuộc vào trạng thái hiện tại
            if (dialogBrand.style.display === 'none' || dialogBrand.style.display === '') {
                dialogBrand.style.display = 'block';
            } else {
                dialogBrand.style.display = 'none';
            }
        }
    });

</script>
</body>
</html>

