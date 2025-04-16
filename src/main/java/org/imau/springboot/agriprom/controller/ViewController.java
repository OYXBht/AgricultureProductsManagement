package org.imau.springboot.agriprom.controller;

import org.imau.springboot.agriprom.service.CategoryService;
import org.imau.springboot.agriprom.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {
    @Autowired
    private ProductService productService;
    
    @Autowired
    private CategoryService categoryService;

    @GetMapping("/")
    public String index() {
        return "redirect:/products";
    }

    @GetMapping("/products")
    public String products(Model model) {
        model.addAttribute("page", "product/list");
        return "layout/main";
    }

    @GetMapping("/categories")
    public String categories(Model model) {
        model.addAttribute("page", "category/list");
        return "layout/main";
    }

    @GetMapping("/inventories")
    public String inventories(Model model) {
        model.addAttribute("page", "inventory/list");
        return "layout/main";
    }

    @GetMapping("/orders")
    public String orders(Model model) {
        model.addAttribute("page", "order/list");
        return "layout/main";
    }
} 