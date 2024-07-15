package security;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/admin*") // Áp dụng filter cho các URL bắt đầu bằng admin
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Nếu đã đăng nhập và có role là "admin" thì cho phép truy cập trang admin
        if (httpRequest.getSession().getAttribute("auth") != null
                && "admin".equals(httpRequest.getSession().getAttribute("role")))
        {
            chain.doFilter(request, response);
        } else{
            // Nếu không, chuyển hướng về trang loi
            httpResponse.sendRedirect(httpRequest.getContextPath() + "errorAdmin.jsp");
        }

    }

    @Override
    public void destroy() {
    }
}


