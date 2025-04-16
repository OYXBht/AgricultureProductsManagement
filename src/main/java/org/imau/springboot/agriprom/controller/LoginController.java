package org.imau.springboot.agriprom.controller;

import org.imau.springboot.agriprom.entity.User;
import org.imau.springboot.agriprom.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * @Author: oyxb_HT
 * @Date: 2025/4/15
 * @Description: $
 */
@Controller
@RequestMapping("/")
public class LoginController {
    @Autowired
    UserService userService;

    @RequestMapping
    public String showPage() {
        return "pages/login";
    }

    @PostMapping("/login")
    public String login(User user, HttpSession session, Model model) {
        User result = userService.getUserByUserName(user.getUserName());
        String errorMsg = "";
        if (result != null) {
            if (result.getUserState() != 0) {
                if (result.getPassword().equals(user.getPassword())) {
                    session.setAttribute("loginUser", result);
                    return "/pages/main";
                } else {
                    errorMsg = "密码错误";
                }
            } else {
                errorMsg = "账号停用中";
            }
        } else {
            errorMsg = "用户不存在";
        }
        model.addAttribute("errorMsg", errorMsg);
        return "pages/error";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, Model model) {
        session.invalidate();
        return "pages/login";
    }
}
