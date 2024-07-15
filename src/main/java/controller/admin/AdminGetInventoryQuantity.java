package controller.admin;

import bean.ImportOrder;
import bean.InventoryQuantity;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import dao.ImportOrderDAO;
import dao.InventoryQuantityDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/getInventoryQuantity")
public class AdminGetInventoryQuantity extends HttpServlet {
    InventoryQuantityDAO inventoryQuantityDAO;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        inventoryQuantityDAO =new InventoryQuantityDAO();
        List<InventoryQuantity> importDataList = inventoryQuantityDAO.getAllInventoryQuantity();
        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        String json = mapper.writeValueAsString(importDataList);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
    }


}
