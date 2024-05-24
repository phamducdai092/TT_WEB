package controller.admin;

import bean.User;
import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/changeInfoUser")
public class adminChangeInfoUser extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int role = Integer.parseInt(req.getParameter("user-role"));
        int userId = Integer.parseInt(req.getParameter("userId"));




        UserDAO.changeInfoUserWithRole(userId, role);

        User updatedUser = UserDAO.getUserById(userId);
        HttpSession session = req.getSession();
        session.setAttribute("user", updatedUser);
        
        req.getRequestDispatcher("./adminEditUser.jsp").forward(req, resp);
    }
}
