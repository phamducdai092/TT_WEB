package controller.admin;

import bean.*;
import dao.*;
import service.LogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/changeInforProduct")
public class AdminChangeInforProduct extends HttpServlet {

    String nameProduct, startDate, endDate, category,
            brand, supplier, desc, priceString;

    int idProduct, quantity, discountId;
    double price;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
         User u = (User) session.getAttribute("auth");

        idProduct = Integer.parseInt(req.getParameter("productId"));

        nameProduct = req.getParameter("product-name");

        discountId = Integer.parseInt(req.getParameter("product-discount"));
        startDate = req.getParameter("product-discount-start");
        endDate = req.getParameter("product-discount-end");

        category = req.getParameter("product-category");
        brand = req.getParameter("product-brand");
        supplier = req.getParameter("product-supplier");
        desc = req.getParameter("product-desc");

        quantity = Integer.parseInt(req.getParameter("product-quantity"));

        priceString = req.getParameter("product-price");
        priceString = priceString.replace(",", ""); // Loại bỏ dấu phẩy
        price = Double.parseDouble(priceString);

        int brandId = 0;
        int categoryId = 0;
        int supplierId = 0;

        List<Supplier> supplierList = SupplierDAO.getListSupplier();
        for (Supplier sup : supplierList) {
            if (sup.getName().equals(supplier)) {
                supplierId = sup.getId();
            }
        }

        List<Category> categoryList = CategoryDAO.getAllCategory();
        for (Category cate : categoryList) {
            if (cate.getName().equals(category)) {
                categoryId = cate.getId();
            }
        }
        List<Brand> brandList = BrandDAO.getAllBrands();
        for (Brand br : brandList) {
            if (br.getName().equals(brand)) {
                brandId = br.getId();
            }
        }
        // ghi loggggggggggggggggggggggggggg
        String preData, afterData, table, role, actionDetail;

        LogService usl = new LogService();
        Log us = new Log();

        int userId = u.getId();


        table = "product_details";
        us.setTables(table);

        role = "adminId = " + userId;
        us.setRole(role);

        actionDetail = "edit Product";
        us.setActionDetail(actionDetail);

        Product p = ProductDAO.getProductId(idProduct);
        afterData = p.getId() + ", " + p.getName() + ", " + p.getDiscountId() + ", " + p.getCategoryId() + ", " +
                p.getBrandId() + ", " + p.getSupplierId() + ", " + p.getQuantity() + ", " + p.getTotalPrice() + ", " + p.getDescription();
        us.setAfterData(afterData);
        DiscountDAO.changeDiscountDate(discountId, startDate, endDate);
        Product product = new Product(idProduct, nameProduct, discountId, categoryId, brandId, supplierId, quantity, price, desc);
        ProductDAO.changeInforProduct(product);
        preData = idProduct + ", " +  nameProduct+ ", " + discountId+ ", " + categoryId+ ", " + brandId+ ", " + supplierId+
                ", " + quantity+ ", " + price+ ", " + desc;
        us.setBeforeData(preData);
        usl.update(us);
        req.getRequestDispatcher("./adminEditProduct.jsp").forward(req, resp);
    }
}
