<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="side-bar">
    <div class="user-account">
        <i class="icon fa-solid fa-user"></i>
        <div class="title">Quản trị viên</div>
    </div>
    <ul class="side-bar__list">
        <li class="side-bar__item">
            <i class="icon fa-solid fa-user"></i>

            <button class="manage-user item-cta">
                <a href="adminUserIndex"> Quản lý người dùng</a>
            </button>

        </li>
        <li class="side-bar__item">
            <i class="icon fa-solid fa-drum"></i>

            <button class="manage-product item-cta">
                <a href="adminProductIndex"> Quản lý sản phẩm </a>
            </button>

        </li>
        <li class="side-bar__item">
            <i class="icon fa-solid fa-file-invoice"></i>
            <button class="manage-bill item-cta">
                <a href="adminBillIndex">Quản lý hóa đơn</a>
            </button>
        </li>
        <li class="side-bar__item"></li>
    </ul>
</div>