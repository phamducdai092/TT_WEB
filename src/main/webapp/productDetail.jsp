<%@ page import="java.util.List" %>
<%@ page import="dao.ImageDAO" %>
<%@ page import="bean.*" %>
<%@ page import="service.ProductDetailService" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="dao.DiscountDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    int selectedProductId = Integer.parseInt(request.getParameter("selectedProductId"));
    Product selectedProduct = ProductDetailService.getInstance().getProductById(selectedProductId);
    String selectedBrandName = selectedProduct.getName();
    int selectedQuantity=selectedProduct.getQuantity();
    double discount = (double) request.getAttribute("discount");
    String endDateString = DiscountDAO.getDiscountEndDay(selectedProduct.getDiscountId());
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //dinh dang ngay thang
    Date endDate = new Date();
    try {
        if (endDateString != null && !endDateString.isEmpty()) {
            endDate = dateFormat.parse(endDateString);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    Date currentDate = new Date();
    long daysLeft = 0;
    if (endDate != null) {
        // Calculate the difference in milliseconds
        long diff = endDate.getTime() - currentDate.getTime();
        // Convert milliseconds to days
        daysLeft = diff / (1000 * 60 * 60 * 24);
    }
    List<Image_Product> productImages = (List<Image_Product>) request.getAttribute("productImages");
    List<Product_Color> productColors = (List<Product_Color>) request.getAttribute("productColors");

    List<Review> productReviews = (List<Review>) request.getAttribute("productReviews");
    List<User> users = (List<User>) request.getAttribute("users");

    // Check if selectedProduct is not null before accessing its properties
    String discountPrice;
    if (selectedProduct != null) {
        String basePrice = NumberFormat.getCurrencyInstance(new Locale("vi", "VN")).format(selectedProduct.getTotalPrice());
        if (daysLeft > 0) {
            double priceDiscount = selectedProduct.getTotalPrice() * (1 - discount);
            discountPrice = NumberFormat.getCurrencyInstance(new Locale("vi", "VN")).format(priceDiscount);
        } else {
            discountPrice = basePrice;
        }
    // Calculate discounted price
%>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Chi tiết sản phẩm</title>

    <!-- reset CSS -->
    <link rel="stylesheet" href="./assets/css/reset.css"/>
    <link rel="stylesheet" href="./assets/css/index.css"/>
    <!-- <link rel="stylesheet" href="./assets/css/product.css"> -->

    <!-- embed fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

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
    <link rel="stylesheet" href="./assets/css/productDetail.css"/>

    <!-- OWL CAROUSEL CSS -->
    <link rel="stylesheet" href="./assets/css/owl.carousel.min.css"/>
    <link
            rel="stylesheet"
            href="./assets/css/owl.theme.default.min.css"
    />
</head>
<body>
<!-- HEADER -->
<c:import url="header.jsp"/>

<%
    User u = (User) session.getAttribute("auth");
%>

<!-- PRODUCT DETAIL -->
<div class="product__detail">
    <div class="product">
        <div class="product-title"><%= selectedProduct.getName() %>
        </div>

        <div id="product__detail" class="product-content detail">
            <div class="product__img">
                <div class="product__img-spot">
                    <img id="mainImage" src="<%= productImages.get(0).getLink()%>" alt=""/>
                    <button class="cta-img left" onclick="changeImage(-1)">
                        <i class="fa-solid fa-arrow-left-long"></i>
                    </button>
                    <button class="cta-img right" onclick="changeImage(1)">
                        <i class="fa-solid fa-arrow-right-long"></i>
                    </button>
                </div>
                <div class="product__img-sub">
                    <% for (Image_Product img : productImages) { %>
                    <div class="item">
                        <img class="item-img" src="<%= img.getLink() %>" alt=""/>
                    </div>
                    <% } %>
                </div>
            </div>
            <div class="product__info">
                <div class="product__info-row">
                    <div class="product__info-price">
                        <p class="discount-price"><%= discountPrice %> VND</p>
                        <% if (discount != 0 && daysLeft > 0) { %>
                        <p class="base-price"><%= basePrice %> VND</p>
                        <%}%>
                    </div>
                    <% if (discount != 0 && daysLeft > 0) { %>
                    <p class="discount"><%= (discount * 100) %> %</p>
                    <p class="days-left">Còn <%= daysLeft%> ngày</p>
                    <%}%>
                </div>
                <div class="product__info-row">
                    <div class="product-color title">Màu sắc</div>
                    <div class="product-color-cta">
                        <form action="cart" method="get" class="d-flex flex-row">
                            <c:forEach var="color" items="${productColors}">
                                <label class="option_color" style="background-color: ${color.codeColor}"
                                       title="${color.nameColor}">
                                    <input type="radio" name="selectedCodeColor" hidden=""
                                           value="${color.nameColor}">
                                </label>
                            </c:forEach>
                        </form>
                    </div>
                </div>
                <div class="product__info-row">
                    <div class="product-color title">Thương hiệu:</div>
                    <div class="product-brand title"><%= selectedBrandName %>
                    </div>
                </div>
                <div class="product__info-row">
                    <div class="product_desc">
                        <p class="title">Giới thiệu</p>
                        <p class="introduce">
                            <%= selectedProduct.getDescription()%>
                        </p>
                        <p class="inv_quantity">
                            Số lượng hàng trong kho: <%=selectedQuantity%>
                        </p>
                    </div>
                </div>
                <div class="product__info-row">
                    <div class="quantity">
                        <div class="quantity-cta">
                            <button class="up">
                                <i class="fa-solid fa-caret-up"></i>
                            </button>
                            <p class="count" style="color: #000">1</p>
                            <button class="down">
                                <i class="fa-solid fa-caret-down"></i>
                            </button>
                        </div>
                    </div>
                    <button class="add__cart">
                        Thêm vào giỏ hàng
                        <i class="fa-solid fa-cart-shopping"></i>
                    </button>
                </div>
            </div>
        </div>

        <div id="product__info" class="product-content">
            <p class="title">
                Sự kết hợp hoàn hảo của trống acoustic và trống điện
            </p>
            <p class="desc">
                <%= selectedProduct.getDescription()%>
            </p>
            <img
                    src="<%= productImages.get(0).getLink() %>"
                    alt="Ảnh sản phẩm"
                    class="info-img"
            />
        </div>
    </div>
</div>

<div class="product__review container mt-50 mb-50" id="reviews">
    <div class="row">
        <div class="col-md-12">
            <div class="review__title__container">
                <p class="review__title">ĐÁNH GIÁ SẢN PHẨM</p>
            </div>
            <div class="card">
                <div class="card-body">
                    <h4 id="countReview" class="card-title"><%= productReviews.size()%> đánh giá cho sản
                        phẩm <%= selectedProduct.getName() %>
                    </h4>
                </div>
                <div>
                    <form name="myform">
                        <!-- Your review -->
                        <div class="md-form md-outline">
                            <textarea placeholder="Đánh giá của bạn" class="card-textarea" name="content"></textarea>
                        </div>
                        <div class="text-right inp button-review-container">
                            <input class="button-review" type="button" value="Thêm đánh giá"
                                   onclick="addReview(<%=selectedProductId%>)"></input>
                        </div>
                    </form>
                </div>
            </div>


            <div class="comment-widgets m-b-20">

                <% for (Review review : productReviews) { %>

                <div class="d-flex flex-row comment-row">

                    <div class="p-2"><span class="round"><img src="https://i.imgur.com/uIgDDDd.jpg" alt="user"
                                                              width="50"></span></div>
                    <div class="comment-text w-100">
                        <% for (User user : users) { %>
                        <% if (review.getUserId() == user.getId()) {%>
                        <p class="review__username"><%= user.getUsername()%>
                        </p>
                        <% } %>
                        <% } %>
                        <div class="comment-footer">
                            <span class="dot mb-1"></span>
                            <span class="review__date"><%= review.getDateReview()%></span>
                        </div>
                        <p class="review__content m-b-5 m-t-10"><%= review.getContent()%>
                        </p>
                    </div>
                </div>
                <% } %>
            </div>

        </div>
    </div>
</div>

<div id="notifyLogin">
    Bạn chưa đăng nhập. Vui lòng đăng nhập để thêm đánh giá.
</div>

<div id="notifyInput">
    Vui lòng nhập đánh giá.
</div>

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
                    <li>
                        <a href="#"
                        >Chương trình khách hàng thân thiết</a
                        >
                    </li>
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
            <p>Gọi mua hàng: <span>1800 6715 </span> (Miễn Phí)</p>
            <p>Khiếu nại, Bảo hành: <span>028710 88 333</span></p>
            <p>Thời gian phục vụ: 8h-22h</p>
            <p>Email: <a href="">info@gteam49.vn</a></p>
        </div>
        <div class="footer__items">
            <div class="about__us">
                <h3>Mạng xã hội</h3>
                <div class="about__us__icon">
                    <i
                            class="fa-brands fa-square-facebook"
                            style="color: #0080ff"
                    ></i>
                    <i
                            class="fab fa-youtube-square"
                            style="color: #ff0000"
                    ></i>
                    <i
                            class="fab fa-twitter-square"
                            style="color: #50a3f6"
                    ></i>
                </div>
            </div>
            <div class="about__us">
                <h3>Hệ thống Website</h3>
                <nav>
                    <ul>
                        <li><a href="#">Team 49 Shop</a></li>
                        <li>
                            <a href="#">Team 49 Music University</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="footer__items">
            <h3>Công ty Cổ Phần TM-DV-SX Team 49</h3>
            <div class="desc">
                <p>
                    GPKD số 0304757232 do sở Kế hoạch Đầu tư TPHCM cấp
                    ngày 01/01/2007
                </p>
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
                    <img
                            src="https://vietthuong.vn/assets/frontend/images/thanhtoan.png"
                            alt="Phuong_Thuc_thanh_toan"
                    />
                </a>
            </div>
            <div class="certification">
                <h3>Chứng nhận</h3>
                <a href="">
                    <img
                            src="https://vietthuong.vn/assets/frontend/images/cntb.png"
                            alt=""
                    />
                </a>
            </div>
        </div>
    </div>
    <div class="footer__copyright">
        <p>
            &copy: 2023 Đồ án Lập Trình Web HK5. | Design by
            <span>Team 49</span>
        </p>
    </div>
</footer>

<!-- MAIN JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="./js/product.js"></script>

<!-- OWL CAROUSEL JS -->
<script src="./js/owl.carousel.min.js"></script>
<script>
    let currentIndex = 0;
    let images = [<% for (Image_Product img : productImages) { %>"<%= img.getLink() %>",<% } %>];

    function changeImage(offset) {
        currentIndex += offset;
        if (currentIndex < 0) {
            currentIndex = images.length - 1;
        } else if (currentIndex >= images.length) {
            currentIndex = 0;
        }
        document.getElementById("mainImage").src = images[currentIndex];
    }
</script>
<script>
    $(document).ready(function() {
        $(".option_color").click(function() {
            let selectedCodeColor = $('input[name="selectedCodeColor"]:checked').val();
            let quantity=document.querySelector('.inv_quantity')
            $.ajax({
                url: '<%= request.getContextPath()%>/colorChange',
                method: 'POST',
                data: { selectedCodeColor: selectedCodeColor,
                    id: <%=selectedProduct.getId()%>},
                success: function(response) {
                    quantity.innerHTML = 'Số lượng hàng trong kho: '+response;
                },
                error: function(xhr, status, error) {
                    // Xử lý lỗi
                    console.error('AJAX Error: ' + status + error);
                }
            });
        });
    });
</script>
<script type="text/javascript">
    function addReview(productId) {
        <%if(u == null) {%>
        // window.location.href = 'logIn.jsp';
        // alert("Bạn chưa đăng nhập. Vui lòng đăng nhập để thêm đánh giá.");
        document.getElementById('notifyLogin').style.display = 'block';
        setTimeout(function () {
            document.getElementById('notifyLogin').style.display = 'none';
        }, 2000);
        <% } else {%>
        let xhttp;
        let content = document.myform.content.value;
        let url = "productdetails?content=" + content + "&productId=" + productId;

        if (content.trim() === '') {
            document.getElementById('notifyInput').style.display = 'block';
            setTimeout(function () {
                document.getElementById('notifyInput').style.display = 'none';
            }, 2000);
            return;
        }

        // Tạo đối tượng XMLHttpRequest
        if (window.XMLHttpRequest) {
            xhttp = new XMLHttpRequest();
        } else {
            xhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }

        // Xử lý sự kiện khi trạng thái của XMLHttpRequest thay đổi
        xhttp.onreadystatechange = function () {
            if (xhttp.readyState == 4) {
                let data = xhttp.responseText;
                // Hiển thị đánh giá mới trên trang web
                let row = document.getElementById("reviews");
                row.innerHTML += data;
            }

        }
        // Mở kết nối và gửi dữ liệu đến server
        xhttp.open("POST", url, true);
        xhttp.send();
        <% }%>
    }
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="./js/product.js"></script>

<!-- OWL CAROUSEL JS -->
<script src="./js/owl.carousel.min.js"></script>
<script>
    $(".owl-carousel").owlCarousel({
        loop: true,
        nav: false,
        autoplay: true,
        autoplayTimeout: 3000,
        autoplayHoverPause: true,
        responsive: {
            0: {
                items: 1,
            },
        },
    });
    $(document).ready(function () {
        $('.up').on('click', function () {
            changeQuantity(1);
        });

        $('.down').on('click', function () {
            changeQuantity(-1);
        });

        $('.add__cart').on('click', function () {
            const quantity = parseInt($('.count').text());
            console.log(quantity)
            let selectedCodeColor = $('input[name="selectedCodeColor"]:checked').val();
            if (selectedCodeColor == null) {
                alert('Nếu bạn không chọn màu sắc, mặc định sẽ là màu đầu tiên');
                selectedCodeColor = $('.option_color').first().attr('title');
            }

            $.ajax({
                url: '<%= request.getContextPath()%>/cart',
                type: 'POST',
                data: {
                    selectedCodeColor: selectedCodeColor,
                    quantity: quantity,
                    id: <%=selectedProduct.getId()%>
                },
                success: function (response) {
                    if(response!==''){
                        alert(response)
                    }else {
                        alert('Thêm vào giỏ hàng thành công');
                        window.location.href = '<%= request.getContextPath()%>/cart';
                    }
                },
                error: function (error) {
                    console.error('Error:', error);
                }
            });

        })

        function changeQuantity(amount) {
            var currentCount = parseInt($('.count').text());
            var newCount = currentCount + amount;
            if (newCount < 1) {
                newCount = 1;
            }
            $('.count').text(newCount);
        }
    });
</script>
</body>
</html>
<%
    } else {
        // Handle the case where selectedProduct is null
    }
%>