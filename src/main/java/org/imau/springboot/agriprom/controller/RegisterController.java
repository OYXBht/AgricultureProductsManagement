package org.imau.springboot.agriprom.controller;

import org.imau.springboot.agriprom.entity.User;
import org.imau.springboot.agriprom.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author: oyxb_HT
 * @Date: 2025/4/15
 * @Description: $
 */
@Controller
@RequestMapping("/register")
public class RegisterController {
    @Autowired
    UserMapper userMapper;

    @RequestMapping
    public String showPage() {
        return "pages/register";
    }

    @PostMapping("/doRegister")
    public String register(User user, Model model) {
        User result = userMapper.getUserByUserName(user.getUserName());
        String errorMsg = "";
        if (result == null) {
            int ok = userMapper.addUser(user);
            return "pages/";
        } else {
            errorMsg = "用户已存在";
        }
        model.addAttribute("errorMsg", errorMsg);
        return "pages/error";
    }
}
