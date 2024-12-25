package controller;

import bean.*;
import dao.BillDAO;
import service.BrandService;
import service.CategoryService;
import service.ProductDetailService;
import util.HashUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "HomeController", value = "/home")
public class HomeController extends HttpServlet {
    List<String> noti=new ArrayList<>();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doGet(req, resp);
        HttpSession session = req.getSession();
        User user= (User) session.getAttribute("auth");
        System.out.println("Nhan servlet");
        if(user!=null){
            System.out.println("nhan user");
            String role= session.getAttribute("role").toString();
            if(role.equals("admin")){
                noti= new ArrayList<>();
                List<Bill> bills = BillDAO.getInstance().getBillListNotDONEAdmin();
                Map<String,Integer> map=getnotiListUser(bills);
                List<String> res=checkHash(map);
                for(String s:res){
                    System.out.println("res: "+ s);
                }
                session.setAttribute("notification", res);
            }else{
                noti= new ArrayList<>();
                List<Bill> bills = BillDAO.getInstance().getBillsNotDONE(user);
                Map<String,Integer> map=getnotiListUser(bills);
                List<String> res=checkHash(map);
                for(String s:res){
                    System.out.println("res: "+ s);
                }
                session.setAttribute("notification", res);
            }
        }
        try {
            List<Product> productList = ProductDetailService.getInstance().getProductList();
            List<Category> categoryList = CategoryService.getInstance().getAllCategories();
            req.setAttribute("products", productList);
            req.setAttribute("categories", categoryList);
            req.getRequestDispatcher("./index.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect("errorPage.jsp");
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doPost(req, resp);
    }
    private Map<String, Integer> getnotiListUser(List<Bill> bills) {
        Map<String, Integer> note= new HashMap<>();
        int count = 0;
        int tempId = 0;
        String orderDetails = "";
        for (int i = 0; i < bills.size(); i++) {
            if (count == 0) {
                tempId = bills.get(i).getId();
                String name = bills.get(i).getFullName();
                String phone = bills.get(i).getPhone();
                String address = bills.get(i).getAddress();
                String payment = bills.get(i).getPaymentMethod();
                String total = String.valueOf(bills.get(i).getTotalPrice());
                String color= bills.get(i).getProductColor()=="1" ? "Đen":"Trắng";
                orderDetails = name + "," + phone + "," + address + "," + payment + "," + total + "," + bills.get(i).getProductName() + "," + color + "," + bills.get(i).getQuantity();
                if(i<bills.size()-1){
                    if (bills.get(i + 1).getId() == tempId) {
                        count=1;
                    } else {
                        note.put(orderDetails,tempId);
                        noti.add(orderDetails);
                        orderDetails = "";
                        count = 0;
                    }
                }else{
                    noti.add(orderDetails);
                    note.put(orderDetails,tempId);
                }
            } else {
                String color= bills.get(i).getProductColor()=="1" ? "Đen":"Trắng";
                orderDetails += "," + bills.get(i).getProductName() + "," + color + "," + bills.get(i).getQuantity();
                if(i<bills.size()-1){
                    if (bills.get(i + 1).getId() == tempId) {
                        count=1;
                    } else {
                        noti.add(orderDetails);
                        note.put(orderDetails,tempId);
                        orderDetails = "";
                        count = 0;
                    }
                }else{
                    noti.add(orderDetails);
                    note.put(orderDetails,tempId);
                }
            }
        }
        return note;
    }
    public List<String> checkHash(Map<String, Integer> note ){
        List<String> res = new ArrayList<>();
        for(String s: noti){
            int id= note.get(s);
            System.out.println("content: "+ s+ " id: "+ id);
            String hashedOrderDetails = HashUtil.hashMD5(s);
            String realRes= BillDAO.getInstance().getHashCodeById(id);
            System.out.println("real: "+realRes);
            if(!realRes.equals(hashedOrderDetails)){
                res.add("Đơn hàng với mã đơn hàng: "+id+" đã bị thay đổi, vui lòng xem lại!");
            }
        }
        return res;
    }
}
