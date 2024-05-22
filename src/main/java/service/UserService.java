package service;

import bean.User;
import dao.UserDAO;
import db.JDBIConnector;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class UserService {
    static Map<String, String> data = new HashMap<>();

    public static UserService instance;

    public static UserService getInstance() {
        if (instance == null) instance = new UserService();
        return instance;

    }

    public User checkLogin(String username, String password) {

        User userByEmail = UserDAO.getUserByEmail(username);
        User userByUsername = UserDAO.getUserByUsername(username);

        if (userByEmail != null && userByEmail.getEmail().equals(username) && userByEmail.getPassword().equals(password)
        ) {
            return userByEmail;
        } else if (userByUsername != null && userByUsername.getUsername().equals(username) && userByUsername.getPassword().equals(password)
        ) {
            return userByUsername;
        }
        return null;
    }

    public boolean isValidPassword(String username, String password) {
        User userByEmail = UserDAO.getUserByEmail(username);
        User userByUsername = UserDAO.getUserByUsername(username);

        if (userByEmail != null && userByEmail.getEmail().equals(username) && userByEmail.getPassword().equals(password)
        ) {
            return true;
        } else return userByUsername != null && userByUsername.getUsername().equals(username) && userByUsername.getPassword().equals(password);
    }

    public User checkLoginByUsername(String username) {
        User userByUsername = UserDAO.getUserByUsername(username);
        if (userByUsername != null && userByUsername.getUsername().equals(username)) {
            return userByUsername;
        }
        return null;
    }


    public User getListUserById(int id) {
        return UserDAO.getListUserById(id).get(0);
    }

    public List<User> getAllUser() {
        return UserDAO.getUserList();
    }


    public boolean isPhoneNumberValid(String phoneNumber) {
        return phoneNumber.matches("^(0|\\+84)(3[2-9]|5[689]|7[06-9]|8[1-9]|9\\d)\\d{7}$");
    }

    public boolean isEmailValid(String email) {
        return email.matches("^[A-Za-z\\._\\-0-9]*[@][A-Za-z]*[\\.][a-z]{2,4}$");
    }


    public static void main(String[] args) {
        List<User> users = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from users").mapToBean(User.class).collect(Collectors.toList())
        );
        System.out.println(users);

    }

}
