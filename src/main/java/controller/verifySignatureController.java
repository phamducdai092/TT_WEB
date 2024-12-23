package controller;

import bean.User;
import dao.KeyDAO;
import util.DigitalSignature;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/verifySignature")
public class verifySignatureController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();
        String uploadedSignature = (String) session.getAttribute("uploadedSignature");
        User user = (User) req.getSession().getAttribute("auth");
        if (uploadedSignature == null || uploadedSignature.isEmpty()||user==null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }else{
            System.out.println("up "+uploadedSignature);
        }

        String src = getServletContext().getRealPath("./hash/orderInf");
        String key=KeyDAO.getKeysByUserId(user.getId()).getPublicKey();
        // Gọi class xử lý xác minh chữ ký
        DigitalSignature verifier = new DigitalSignature();
        verifier.loadPublicKey(key);
        boolean isValid = false;
        try {
            isValid = verifier.verifyFile(src, uploadedSignature);
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        if (isValid) {
            System.out.println(isValid);
            session.setAttribute("isVerify", isValid);
            resp.setStatus(HttpServletResponse.SC_OK);
        }else{
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
