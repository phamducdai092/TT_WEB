package controller.admin;

import bean.ImportOrder;
import bean.Product;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.google.gson.Gson;
import dao.ImportOrderDAO;
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

@WebServlet("/getImportData")
public class AdminLoadImportOrder extends HttpServlet {
    private ImportOrder importOrder;
    ImportOrderDAO importOrderDAO;

    @Override
    public void init() throws ServletException {
        importOrder=new ImportOrder();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        importOrderDAO=new ImportOrderDAO();
        List<ImportOrder> importDataList = importOrderDAO.selectAllImportData();
        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        String json = mapper.writeValueAsString(importDataList);
//        Gson gson = new Gson();
//        resp.getWriter().write(gson.toJson(importDataList));

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        resp.getWriter().write(json);
    }


}
