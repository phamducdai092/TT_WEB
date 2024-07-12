<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="col-md-3">
    <div class="profile-function">
        <div class="profile-function-list-container">
            <ul class="profile-function-list">
                <li>
                    <a class="nav-link" href="profile.jsp">
                        <i class="fa fa-user"></i>
                        <span>Thông tin tài khoản</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="<%= request.getContextPath()%>/history-bill">
                        <i class="fa fa-list-alt"></i>
                        <span>Quản lý đơn hàng</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // jQuery for adding/removing is-active class
        $('.nav-link').on('click', function (e) {
            e.preventDefault(); // Prevent default action (optional)
            $('.nav-link').removeClass('is-active'); // Remove class from all links
            $(this).addClass('is-active'); // Add class to the clicked link
        });
    })
</script>