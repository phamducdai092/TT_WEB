package controller;

import bean.User;
import bean.Log;
import dao.UserDAO;
import service.LogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet(value = "/profile")
public class ProfileUserController extends HttpServlet {
    String email, phone, firstName, lastName, birthDate, gender;
    String emailError, phoneError;
    int countError = 0;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String preData, afterData, table, role, actionDetail;
        LogService usl= new LogService();
        Log us=new Log();

        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");
        int userId = u.getId();
        int userRole = u.getRole();

        table = "users";
        us.setTables(table);

        if(userRole ==1){
            role = "adminId = " + userId;
            us.setRole(role);
        }else {
            role = "userId = " + userId;
            us.setRole(role);
        }

        actionDetail = "change_Info";
        us.setActionDetail(actionDetail);

        preData= u.getEmail()+" "+u.getPhone()+" "+u.getFirstName()+" "+u.getLastName()+" "+u.getBirthDate()+" "+u.getGender()+" "+userId;
        us.setBeforeData(preData);

        email = req.getParameter("email");
        phone = req.getParameter("phone");
        int phoneValue = 0;
        if (!phone.isEmpty()) {
            phoneValue = Integer.parseInt(phone); // Chỉ chuyển đổi sang int nếu phone không rỗng
        }
        firstName = req.getParameter("firstName");
        lastName = req.getParameter("lastName");
        birthDate = req.getParameter("birthDate");
        gender = new String(req.getParameter("gender").getBytes("ISO-8859-1"), "UTF-8");
        req.setAttribute("email", email);
        req.setAttribute("phone", phone);
        req.setAttribute("firstName", firstName);
        req.setAttribute("lastName", lastName);
        req.setAttribute("birthDate", birthDate);

        String username = u.getUsername();

        if (!phone.isEmpty() || !email.isEmpty()) {
            UserDAO.changeSpecificInfo(userId, email, phoneValue, firstName, lastName, birthDate, gender);
            afterData=email+" "+phoneValue+" "+firstName+" "+lastName+" "+birthDate+" "+gender;
            us.setAfterData(afterData);
            usl.update(us);
        }

        User user2 = UserDAO.getUserByUsername(username);
        req.getSession().setAttribute("auth", user2);


        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}
