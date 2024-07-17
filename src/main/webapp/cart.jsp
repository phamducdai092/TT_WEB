<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bean.ShoppingCart" %>
<%@ page import="bean.Item" %>
<%@ page import="bean.Product" %>
<%@ page import="java.util.Map" %>
<%@ page import="dao.ImageDAO" %>
<%@ page import="service.ImageService" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="service.ColorService" %>
<% List<Item> shoppingCart = (List<Item>) request.getSession().getAttribute("cart");
    String announce = "";
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
        Giỏ Hàng của bạn
    </title>

    <!-- reset CSS -->
    <link rel="stylesheet" href="assets/css/reset.css"/>
    <link rel="stylesheet" href="assets/css/index.css">
    <link rel="stylesheet" href="assets/css/cart.css">
    <!-- <link rel="stylesheet" href="./assets/css/product.css"> -->

    <!-- embed fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>

    <!-- FONT GOOGLE -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;700&display=swap" rel="stylesheet">

    <!-- FONT AWRSOME -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">


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
    <link rel="stylesheet" href="assets/css/about.css"/>
</head>
<body>
<!-- HEADER -->
<c:import url="header.jsp"/>
<c:set var="shoppingCart" value="${sessionScope.cart}"/>
<!-- CART INFORMATION -->
<section class="cart__details">
    <div data-view-id="breadcrumb__container" class="cart__return">
        <div class="cart__return__content">
            <div class="breadcrumb">
                <a class="breadcrumb__item br1" data-view-id="breadcrumb__item" data-view-index="0" href="index.jsp">
                    <span>Trang chủ</span>
                </a>
                <span class="icon icon__next">
                        <i class="fa fa-angle-right"></i>
                    </span>
                <a href="#" class="breadcrumb__item" data-view-id="breadcrumb__item" data-view-index="1">
                    <span title="Giỏ Hàng">Giỏ Hàng Của Bạn</span>
                </a>
            </div>
        </div>
    </div>

    <section class="cart__content">
        <h3>
            GIỎ HÀNG
            <span>(</span>
            <c:if test="${shoppingCart==null}">
                <span>${0}</span>
            </c:if>
            <c:if test="${shoppingCart!=null}">
                <span>${shoppingCart.size()}</span>
            </c:if>
            <span>)</span>
        </h3>
        <c:if test="${shoppingCart==null}">
            <img class="cart__content-empty" src="other_img/empty-cart.webp" alt="empty cart">
        </c:if>
        <c:if test="${shoppingCart!=null}">
            <div class="left__content">
                <div class="cart__tbody">
                    <c:forEach var="i" items="${shoppingCart}">
                        <div class="cart__item">
                            <div class="cart__item--img">
                                <p class="img">
                                    <img src="${ImageService.getInstance().getImageByProductId((i.getProduct()).getId()).get(0).getLink()}">
                                </p>
                            </div>
                            <div class="cart__item--detail">
                                <c:choose>
                                    <c:when test="${i.checkQuantity()}">
                                    <div class="item--info-product"><p class="name"><a href=""
                                                                                       title="${i.getProduct().getName()} - ${i.getProduct().getId()} / ${i.getColorName()}"
                                                                                       target="_blank">
                                            ${i.getProduct().getName()} - ${i.getProduct().getId()}
                                        / ${fn:escapeXml(i.getColorName())}
                                    </a>
                                    </c:when>
                                        <c:when test="${!i.checkQuantity()}">
                                        <div class="item--info-product"><p class="name"><a href=""
                                                                                           title="MẶT HÀNG NÀY ĐÃ HẾT HÀNG"
                                                                                           target="_blank">
                                                ${i.getProduct().getName()} - ${i.getProduct().getId()}
                                            / ${fn:escapeXml(i.getColorName())}
                                        </a>
                                        </c:when>
                                </c:choose>
                                </p>
                                    <p class="action">
                                        <a
                                            href="<%= request.getContextPath() %>/cart?action=remove&id=${i.getProduct().getId()}"
                                            onclick="return confirm('Bạn có chắc muốn xóa sản phẩm?')">
                                        <button>Xóa</button>
                                    </a>
                                    </p>
                                </div>
                                <div class="box-price"><p class="price pricechange">
                                    <fmt:formatNumber value="${i.getProduct().getTotalPrice()}" type="currency"
                                                      currencySymbol="₫" groupingUsed="true"/></p></div>
                                <div class="quantity-block">
                                    <div class="input-group bootstrap-touchspin">
                                        <div class="input-group-btn">
                                            <button class="increase_pop items-count btn-plus btn "
                                                    data-pid="${i.getQuantity()}"
                                                    type="button">+
                                            </button>
                                            <input type="text" maxlength="12" min="1" disabled=""
                                                   class="form-control quantity-r2 quantity js-quantity-product input-text number-sidebar input_pop input_pop qtyItem102678026 product-qty${i.getProduct().getId()}"
                                                   id="qtyItem102678026" name="Lines" size="4"
                                                   value="${i.getQuantity()}">
                                            <button class="reduced_pop items-count btn-minus btn "
                                                    data-pid="${i.getProduct().getId()}"
                                                    type="button">–
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <% double sumPrice = 0;
                    for (int i = 0; i < shoppingCart.size(); i++) {
                        if(shoppingCart.get(i).getQuantity()!=0)
                        sumPrice += shoppingCart.get(i).getPrice() * shoppingCart.get(i).getQuantity();
                    }
                %>
                <div class="cart__sidebar">
                    <div class="each-row">
                        <div class="box-style fee"><p class="list-info-price"><span>Tạm tính: </span><strong
                                class="totals_price price _text-right text_color_right1"><%=formatCurrency(sumPrice)%>
                        </strong>
                        </p></div>
                        <div class="box-style fee">
                            <div class="total2 clearfix"><span class="text-label">Thành tiền: </span>
                                <div class="amount"><p><strong class="totals_price"><%=formatCurrency(sumPrice)%>
                                </strong>
                                </p></div>
                            </div>
                        </div>
                        <form action="<%= request.getContextPath()%>/bill" method="get">
                            <!-- Include hidden input fields for order details -->
                            <input type="hidden" name="total" value="<%= sumPrice %>">
                            <!-- Add other necessary hidden fields -->

                            <button class="button btn btn-large btn-block btn-danger btn-checkout evo-button"
                                    type="submit">
                                Thanh toán
                            </button>
                        </form>
                        <button class="button btn-proceed-checkout btn btn-large btn-block btn-danger btn-checkouts"
                                title="Tiếp tục mua hàng" type="button"><a href="index.jsp">Tiếp
                            tục mua hàng</a>
                        </button>
                    </div>
                </div>
            </div>
        </c:if>
    </section>


    <!-- FOOTER -->
    <footer>
        <div class="footer__main">
            <div class="footer__items">
                <h3>Thông tin của hàng</h3>
                <nav>
                    <ul>
                        <li><a href="#">Giới thiệu cửa hàng</a></li>
                        <li><a href="#">Hệ thống showrom, đại lý</a></li>
                        <li><a href="#">Liên hệ / Góp ý</a></li>
                        <li><a href="#">Mua trả góp</a></li>
                        <li><a href="#">Chương trình khách hàng thân thiết</a></li>
                        <li><a href="#">Điều khoản sử dụng Website</a></li>
                        <li><a href="#">Tuyển dụng</a></li>
                    </ul>
                </nav>
            </div>
            <div class="footer__items">
                <h3>Hướng dẫn chung</h3>
                <nav>
                    <ul>
                        <li><a href="#">Giao hàng - Đổi trả</a></li>
                        <li><a href="#">Hướng dẫn mua hàng</a></li>
                        <li><a href="#">Thanh toán và bảo mật</a></li>
                        <li><a href="#">Chính sách bảo hành</a></li>
                        <li><a href="#">Bảo trì đàn piano</a></li>
                        <li><a href="#">Kích hoạt bảo hành</a></li>
                    </ul>
                </nav>
            </div>
            <div class="footer__items">
                <h3>Hỗ trợ khách hàng</h3>
                <p>Gọi mua hàng: <span>1800 6715 </span> (Miễn Phí) </p>
                <p>Khiếu nại, Bảo hành: <span>028710 88 333</span></p>
                <p>Thời gian phục vụ: 8h-22h</p>
                <p>Email: <a href="">info@gteam49.vn</a></p>
            </div>
            <div class="footer__items">
                <div class="about__us">
                    <h3>Mạng xã hội</h3>
                    <div class="about__us__icon">
                        <i class="fa-brands fa-square-facebook" style="color: #0080ff;"></i>
                        <i class="fab fa-youtube-square" style="color: #ff0000;"></i>
                        <i class="fab fa-twitter-square" style="color: #50a3f6;"></i>
                    </div>
                </div>
                <div class="about__us">
                    <h3>Hệ thống Website</h3>
                    <nav>
                        <ul>
                            <li><a href="#">Team 49 Shop</a></li>
                            <li><a href="#">Team 49 Music University</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="footer__items">
                <h3>Công ty Cổ Phần TM-DV-SX Team 49</h3>
                <div class="desc">
                    <p>GPKD số 0304757232 do sở Kế hoạch Đầu tư TPHCM cấp ngày 01/01/2007 </p>
                    <p>Địa chỉ: 386 CMT8, P.10, Q.3, TPHCM</p>
                    <p>Điện thoại: <span>1800 6715</span></p>
                    <p>Hotline: <span>028710 88 333</span></p>
                    <p>Email: <a href="#">info@team49.vn</a></p>
                </div>
            </div>
            <div class="footer__items">
                <div class="payment">
                    <h3>cách thức thanh toán</h3>
                    <a href="#">
                        <img src="https://vietthuong.vn/assets/frontend/images/thanhtoan.png"
                             alt="Phuong_Thuc_thanh_toan">
                    </a>
                </div>
                <div class="certification">
                    <h3>Chứng nhận</h3>
                    <a href="">
                        <img src="https://vietthuong.vn/assets/frontend/images/cntb.png" alt="">
                    </a>
                </div>
            </div>
        </div>
        <div class="footer__copyright">
            <p>&copy: 2023 Đồ án Lập Trình Web HK5. | Design by <span>Team 49</span></p>
        </div>
    </footer>
</section>
<!-- MAIN JS -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
        crossorigin="anonymous"></script>
<script src="js/product.js"></script>
<script src="js/paging.js"></script>

<%!
    private String formatCurrency(double totalPrice) {
        Locale localeVN = new Locale("vi", "VN");
        int price = (int) totalPrice;
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(localeVN);
        return currencyFormatter.format(price);
    }
%>
<script>
    $(document).ready(function () {
        // Xử lý khi nút tăng được nhấn
        $('.increase_pop').on('click', function () {
            var productId = $(this).data('pid');
            console.log('Nút tăng được nhấn cho sản phẩm ID:', productId);
            updateQuantity(productId, 1);
        });

        // Xử lý khi nút giảm được nhấn
        $('.reduced_pop').on('click', function () {
            var productId = $(this).data('pid');
            console.log('Nút giảm được nhấn cho sản phẩm ID:', productId);
            updateQuantity(productId, -1);
        });

        function updateQuantity(productId, amount) {
            var currentQuantity = parseInt($('.product-qty' + productId).val());
            console.log(currentQuantity);
            var newQuantity = currentQuantity + amount;
            console.log('Cập nhật số lượng cho sản phẩm ID:', productId, 'Số lượng hiện tại:', currentQuantity, 'Số lượng mới:', newQuantity);

            if (newQuantity < 1) {
                alert('Số lượng không thể nhỏ hơn 1.');
                return;
            }

            // Gửi yêu cầu Ajax để cập nhật số lượng
            $.ajax({
                url: '<%= request.getContextPath()%>/cart?action=update',
                type: 'GET',

                data: {
                    productId: productId,
                    quantity: newQuantity
                },
                success: function (response) {
                    console.log('Cập nhật thành công cho sản phẩm ID:', productId, 'Phản hồi:', response);
                    window.location.reload();
                },
                error: function (error) {
                    console.log(productId, newQuantity);
                    console.error('Lỗi khi cập nhật số lượng cho sản phẩm ID:', productId, 'Lỗi:', error);
                }
            });
        }
    });
</script>
</body>
</html>