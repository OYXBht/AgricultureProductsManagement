package org.imau.springboot.agriprom.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.imau.springboot.agriprom.entity.Category;
import org.imau.springboot.agriprom.entity.Product;
import org.imau.springboot.agriprom.mapper.CategoryMapper;
import org.imau.springboot.agriprom.service.CategoryService;
import org.imau.springboot.agriprom.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {
    @Autowired
    private ProductService productService;

    @Override
    public IPage<Category> searchCategories(String keyword, int page, int size) {
        Page<Category> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Category> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(keyword)) {
            wrapper.like(Category::getName, keyword)
                  .or()
                  .like(Category::getDescription, keyword);
        }
        return this.page(pageParam, wrapper);
    }

    @Override
    public boolean deleteCategory(Long id) {
        // 检查是否有关联的农产品
        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Product::getCategoryId, id);
        long count = productService.count(wrapper);
        if (count == 0) {
            return this.removeById(id);
        }
        return false;
    }
} 