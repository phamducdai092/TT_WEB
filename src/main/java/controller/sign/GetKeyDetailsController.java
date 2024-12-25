package controller.sign;

import bean.Key;
import com.google.gson.Gson;
import service.KeyService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "GetKeyDetailsController", value = "/get-key-details")
public class GetKeyDetailsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int keyId = Integer.parseInt(request.getParameter("id"));
        KeyService keyService = KeyService.getInstance();

        Key key = keyService.getKeyById(keyId);
        if (key != null) {
            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(key));
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}

