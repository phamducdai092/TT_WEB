package controller.logingoogle;

import bean.User;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.UserDAO;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/LoginGoogleHandler"})
public class LoginGoogleHandler extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
// xử lý khi người dùng bấm hủy khi đăng nhập bằng google
        String error = request.getParameter("error");
        if (error != null) {
            request.getRequestDispatcher("./logIn.jsp").forward(request, response);
            return;
        }
// Lấy mã ủy quyền (authorization code) từ yêu cầu của Google
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            request.getRequestDispatcher("./logIn.jsp").forward(request, response);
            return;
        }

        try {
            String accessToken = getToken(code);
            UserGoogleDto user = getUserInfo(accessToken);
            handleUserLogin(user, request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    // Phương thức lấy token truy cập từ Google bằng mã ủy quyền
    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        return jobj.get("access_token").getAsString();
    }

    public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        return new Gson().fromJson(response, UserGoogleDto.class);
    }
//   lưu người dùng vào databaser
    private void handleUserLogin(UserGoogleDto userGoogleDto, HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        User user = UserDAO.getUserByIdGoogle(userGoogleDto.getId());
        HttpSession session = request.getSession();
        if (user == null) {
            UserDAO.registerUserGoogle(userGoogleDto.getId(), userGoogleDto.getName(), userGoogleDto.getGiven_name(), userGoogleDto.getFamily_name());
            user = UserDAO.getUserByIdGoogle(userGoogleDto.getId());
        }
        session.setAttribute("auth", user);
        response.sendRedirect("./index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
