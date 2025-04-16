package org.imau.springboot.agriprom.controller;

import org.imau.springboot.agriprom.entity.User;
import org.imau.springboot.agriprom.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * @Author: oyxb_HT
 * @Date: 2025/4/15
 * @Description: $
 */
@Controller
@RequestMapping("/info")
public class InfoController {
    @Autowired
    UserService userService;

    @RequestMapping
    public String showPage() {
        return "pages/info";
    }

    @GetMapping("/getInfo")
    @ResponseBody
    public User getInfo(@RequestParam Long userId) {
        return userService.getUserById(userId);
    }

    @PostMapping("/update")
    public String updateInfo(User user, HttpSession session) {
        String errorMsg = "";
        User result = userService.getUserById(user.getUserId());
        if (result != null) {
            int ok = userService.updateUser(user);
            session.setAttribute("loginUser", user);
            return "redirect:/info";
        } else {
            errorMsg = "用户不存在";
        }
        return "pages/error";
    }
}
