package org.imau.springboot.agriprom.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import org.imau.springboot.agriprom.entity.Product;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface ProductService extends IService<Product> {
    IPage<Product> searchProducts(String keyword, int page, int size);
    boolean updateSaleStatus(Long id, boolean isOnSale);
    boolean deleteProduct(Long id);
    String uploadImage(MultipartFile file) throws IOException;
    byte[] downloadImage(String imageUrl) throws IOException;
} 