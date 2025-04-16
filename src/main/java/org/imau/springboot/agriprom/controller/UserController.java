package org.imau.springboot.agriprom.controller;

import com.zaxxer.hikari.HikariDataSource;
import org.imau.springboot.agriprom.entity.User;
import org.imau.springboot.agriprom.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author: oyxb_HT
 * @Date: 2025/4/15
 * @Description: $
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;
    @Autowired
    private HikariDataSource dataSource;

    @RequestMapping
    public String showPage(Model model) {
        List<User> userList = userService.getAllUser();
        model.addAttribute("userList", userList);
        return "pages/userList";
    }

    @PostMapping("/add")
    public String addUser(User user, Model model) {
        String errorMsg = "";
        User result = userService.getUserByUserName(user.getUserName());
        if (result == null) {
            int ok = userService.addUser(user);
            return "redirect:/user/";

        } else {
            errorMsg = "用户已存在";
        }
        model.addAttribute("errorMsg", errorMsg);
        return "pages/error";
    }

    @PostMapping("/update")
    public String updateUser(User user, Model model) {
        String errorMsg = "";
        User result = userService.getUserById(user.getUserId());
        if (result != null) {
            int ok = userService.updateUser(user);
            return "redirect:/user/";
        } else {
            errorMsg = "用户已存在";
        }
        model.addAttribute("errorMsg", errorMsg);
        return "pages/error";
    }

    @PostMapping("/delete")
    public String deleteUser(User user, Model model) {
        String errorMsg = "";
        System.out.println(user);
        User result = userService.getUserById(user.getUserId());
        System.out.println(result);
        if (result != null) {
            int ok = userService.deleteUser(user.getUserId());
            return "redirect:/user/";
        } else {
            errorMsg = "用户不存在";
        }
        model.addAttribute("errorMsg", errorMsg);
        return "pages/error";
    }

    @GetMapping("/getUser")
    @ResponseBody
    public User getUserJson(@RequestParam Long userId) {
        return userService.getUserById(userId);
    }

    @PostMapping("/search")
    public String getUser(User user, Model model) {
        List<User> userList = userService.getUser(user);
        model.addAttribute("userList", userList);
        return "pages/userList";
    }
}
