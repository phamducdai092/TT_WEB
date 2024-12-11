package controller;

import com.google.gson.Gson;
import dao.ColorDAO;
import db.JDBIConnector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ProductHandleColor", value = "/colorChange")
public class ProductHandleColor extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson= new Gson();
        int pr_id= Integer.parseInt(req.getParameter("id"));
        String colorName= req.getParameter("selectedCodeColor");
        System.out.println("mau nafy" + colorName);
        int color_id= ColorDAO.getColorByName(colorName).getId();

        int quantity= getQuantity(pr_id, color_id);
        resp.setContentType("application/json");
        gson.toJson(quantity, resp.getWriter());
    }
    public int getQuantity(int pr_id, int color_id){
        Integer quantity= JDBIConnector.me().withHandle(handle ->
            handle.createQuery("select quantity from inv_quantity where pr_id=:pr_id and color_id=:color_id")
                    .bind("pr_id", pr_id)
                    .bind("color_id", color_id)
                    .mapTo(Integer.class)
                    .findOne()
                    .orElse(0)
        );
        return quantity;
    }
    public static void main(String[] args) {
//        ProductHandleColor tt=new ProductHandleColor();
//        System.out.println(tt.getQuantity(1,1));;
    }
}
