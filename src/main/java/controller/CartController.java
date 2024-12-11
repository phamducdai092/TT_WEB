package controller;

import bean.Item;
import bean.Product;
import bean.ShoppingCart;
import bean.User;
import com.google.gson.Gson;
import dao.ColorDAO;
import dao.ProductDAO;
import dao.ReviewDAO;
import db.JDBIConnector;
import service.ProductDetailService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "CartController", value = "/cart")
public class CartController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    ProductDetailService productDetailService = new ProductDetailService();


    public CartController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        System.out.println(action);
        if (action == null) {
            doGet_DisplayCart(request, response);
        } else {
            if (action.equalsIgnoreCase("update")) {
                System.out.println("da nhan aj");
                String quantity = request.getParameter("quantity");
                String id = request.getParameter("productId");
                System.out.println("Product ID: " + request.getParameter("quantity") + ", Quantity: " + request.getParameter("productId"));
                List<Item> cart = (List<Item>) session.getAttribute("cart");
                cart.forEach(item -> {
                    if (item.getProduct().getId() == Integer.parseInt(id)) {
                        if (Integer.parseInt(quantity) == 0) {
                            cart.remove(item);
                        } else {
                            item.setQuantity(Integer.parseInt(quantity));
                            item.setPrice(item.getProduct().getTotalPrice());
                        }
                    }
                });
                session.setAttribute("cart", cart);
            } else if (action.equalsIgnoreCase("remove")) {
                doGet_Remove(request, response);
            }
        }
    }


    protected void doGet_DisplayCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    protected void doGet_Remove(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Item> cart = (List<Item>) session.getAttribute("cart");
        int index = isExisting(Integer.parseInt(request.getParameter("id")), cart);
        cart.remove(index);
        session.setAttribute("cart", cart);
        response.sendRedirect("cart");
    }

    protected void doGet_Buy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    private int isExisting(int id, List<Item> cart) {
        for (int i = 0; i < cart.size(); i++) {
            if (cart.get(i).getProduct().getId() == id) {
                return i;
            }
        }
        return -1;
    }

    private boolean checkIsExist(int id, List<Item> cart) {
        return cart.stream()
                .anyMatch(item -> item.getProduct().getId() == id);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Gson gson= new Gson();
        HttpSession session = request.getSession();
        String selectedCodeColor = request.getParameter("selectedCodeColor");
        String quantity = request.getParameter("quantity");
        String id = request.getParameter("id");
        boolean check= checkQuantityValid(Integer.parseInt(id), ColorDAO.getColorByName(selectedCodeColor).getId(), Integer.parseInt(quantity));
        System.out.println(check);
        if(check){
            String error="Số lượng không đủ";
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            gson.toJson(error, response.getWriter());
            return;
        }else {
            if (Objects.isNull(session.getAttribute("cart"))) {
                List<Item> cart = new ArrayList<>();
                Item item = new Item(productDetailService.getProductById(Integer.parseInt(id)), Integer.parseInt(quantity), selectedCodeColor);
                System.out.println("ql: "+quantity);
                cart.add(item);
                session.setAttribute("cart", cart);
            } else {
                List<Item> cart = (List<Item>) session.getAttribute("cart");
                boolean isExist = checkIsExist(Integer.parseInt(id), cart);
                if (isExist) {
                    boolean itemAdded = false;
                    for (Item item : cart) {
                        if (item.getProduct().getId() == Integer.parseInt(id)) {
                            if (item.getColorName().equalsIgnoreCase(selectedCodeColor)) {
                                item.setQuantity(item.getQuantity() + Integer.parseInt(quantity));
                                System.out.println("quantity: "+item.getQuantity());
                                itemAdded = true;
                                break;
                            }
                        }
                    }
                    if (!itemAdded) {
                        Item itemNew = new Item(productDetailService.getProductById(Integer.parseInt(id)), Integer.parseInt(quantity), selectedCodeColor);
                        cart.add(itemNew);
                        System.out.println(itemNew.getQuantity());
                    }
                } else {
                    Item item = new Item(productDetailService.getProductById(Integer.parseInt(id)), Integer.parseInt(quantity), selectedCodeColor);
                    cart.add(item);
                }
                session.setAttribute("cart", cart);
            }
        }

    }
public boolean checkQuantityValid(int pr_id,int color_id,int quantity){
    Integer rs= JDBIConnector.me().withHandle(handle ->
            handle.createQuery("select quantity from inv_quantity where pr_id =:pr_id and color_id=:color_id")
                    .bind("pr_id",pr_id)
                    .bind("color_id",color_id)
                    .mapTo(Integer.class)
                    .findOne()
                    .orElse(0)
    );
    System.out.println(quantity);
    return quantity>rs;
}
}