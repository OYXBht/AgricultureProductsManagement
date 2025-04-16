package org.imau.springboot.agriprom.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author: oyxb_HT
 * @Date: 2025/4/15
 * @Description: $
 */
@Controller
@RequestMapping("/main")
public class MainContrller {
    @RequestMapping
    public String showPage() {
        return "pages/main";
    }
}
