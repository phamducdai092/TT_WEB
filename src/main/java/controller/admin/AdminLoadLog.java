package controller.admin;

import bean.ImportOrder;
import bean.Log;
import bean.Product;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.google.gson.Gson;
import dao.ImportOrderDAO;
import dao.LogDAO;
import dao.ProductDAO;
import db.JDBIConnector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/adminLoadLog")
public class AdminLoadLog extends HttpServlet {
    private Log log;
    LogDAO logDAO;

    @Override
    public void init() throws ServletException {
        log = new Log();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        logDAO = new LogDAO();
        List<Log> logList = logDAO.getAllLogs();
        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        String json = mapper.writeValueAsString(logList);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
    }


}
