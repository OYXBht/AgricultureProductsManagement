package org.imau.springboot.agriprom.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import org.imau.springboot.agriprom.entity.Category;

public interface CategoryService extends IService<Category> {
    IPage<Category> searchCategories(String keyword, int page, int size);
    boolean deleteCategory(Long id);
} 