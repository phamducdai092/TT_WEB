package controller;

import util.DigitalSignature;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.SignatureException;

@WebServlet(value = "/verifySignature")
public class verifySignatureController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uploadedSignature = (String) req.getSession().getAttribute("uploadedSignature");
        if (uploadedSignature == null || uploadedSignature.isEmpty()) {
            resp.getWriter().write("No signature file uploaded!");
            return;
        }

        String src = getServletContext().getRealPath("./hash/orderInf");

        // Gọi class xử lý xác minh chữ ký
        DigitalSignature verifier = new DigitalSignature();
        boolean isValid = false;
        try {
            isValid = verifier.verifyFile(src, uploadedSignature);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        if (isValid) {
            resp.getWriter().write("Signature is valid!");
        } else {
            resp.getWriter().write("Signature is invalid!");
        }
    }
}
