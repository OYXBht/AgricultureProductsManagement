package org.imau.springboot.agriprom.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import org.imau.springboot.agriprom.entity.Product;
import org.imau.springboot.agriprom.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/api/products")
public class ProductController {
    @Autowired
    private ProductService productService;

    @GetMapping("/search")
    public ResponseEntity<IPage<Product>> searchProducts(
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        return ResponseEntity.ok(productService.searchProducts(keyword, page, size));
    }

    @PostMapping
    public ResponseEntity<Product> createProduct(@RequestBody Product product) {
        productService.save(product);
        return ResponseEntity.ok(product);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Product> updateProduct(@PathVariable Long id, @RequestBody Product product) {
        product.setId(id);
        productService.updateById(product);
        return ResponseEntity.ok(product);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Boolean> deleteProduct(@PathVariable Long id) {
        return ResponseEntity.ok(productService.deleteProduct(id));
    }

    @PutMapping("/{id}/sale-status")
    public ResponseEntity<Boolean> updateSaleStatus(
            @PathVariable Long id,
            @RequestParam boolean isOnSale) {
        return ResponseEntity.ok(productService.updateSaleStatus(id, isOnSale));
    }

    @PostMapping("/upload")
    public ResponseEntity<String> uploadImage(@RequestParam("file") MultipartFile file) throws IOException {
        String imageUrl = productService.uploadImage(file);
        return ResponseEntity.ok(imageUrl);
    }

    @GetMapping("/image/{imageUrl}")
    public ResponseEntity<byte[]> downloadImage(@PathVariable String imageUrl) throws IOException {
        byte[] imageData = productService.downloadImage(imageUrl);
        return ResponseEntity.ok()
                .header("Content-Type", "image/jpeg")
                .body(imageData);
    }
} 