package org.imau.springboot.agriprom.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.imau.springboot.agriprom.entity.Product;
import org.imau.springboot.agriprom.mapper.ProductMapper;
import org.imau.springboot.agriprom.service.ProductService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements ProductService {
    private static final String UPLOAD_DIR = "uploads/images/";

    @Override
    public IPage<Product> searchProducts(String keyword, int page, int size) {
        Page<Product> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(keyword)) {
            wrapper.like(Product::getName, keyword)
                  .or()
                  .like(Product::getDescription, keyword);
        }
        return this.page(pageParam, wrapper);
    }

    @Override
    public boolean updateSaleStatus(Long id, boolean isOnSale) {
        Product product = this.getById(id);
        if (product != null) {
            product.setIsOnSale(isOnSale);
            return this.updateById(product);
        }
        return false;
    }

    @Override
    public boolean deleteProduct(Long id) {
        Product product = this.getById(id);
        if (product != null && !product.getIsOnSale()) {
            return this.removeById(id);
        }
        return false;
    }

    @Override
    public String uploadImage(MultipartFile file) throws IOException {
        String fileName = UUID.randomUUID().toString() + getFileExtension(file.getOriginalFilename());
        Path uploadPath = Paths.get(UPLOAD_DIR);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        Path filePath = uploadPath.resolve(fileName);
        Files.copy(file.getInputStream(), filePath);
        return fileName;
    }

    @Override
    public byte[] downloadImage(String imageUrl) throws IOException {
        Path imagePath = Paths.get(UPLOAD_DIR, imageUrl);
        return Files.readAllBytes(imagePath);
    }

    private String getFileExtension(String fileName) {
        if (fileName == null) return "";
        int lastDotIndex = fileName.lastIndexOf(".");
        return lastDotIndex == -1 ? "" : fileName.substring(lastDotIndex);
    }
} 