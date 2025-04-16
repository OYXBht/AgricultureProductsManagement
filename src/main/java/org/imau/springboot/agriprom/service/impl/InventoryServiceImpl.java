package org.imau.springboot.agriprom.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.imau.springboot.agriprom.entity.Inventory;
import org.imau.springboot.agriprom.mapper.InventoryMapper;
import org.imau.springboot.agriprom.service.InventoryService;
import org.imau.springboot.agriprom.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class InventoryServiceImpl extends ServiceImpl<InventoryMapper, Inventory> implements InventoryService {
    @Autowired
    private ProductService productService;

    @Override
    public IPage<Inventory> searchInventories(String keyword, int page, int size) {
        Page<Inventory> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Inventory> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(keyword)) {
            wrapper.exists("SELECT 1 FROM product p WHERE p.id = inventory.product_id AND (p.name LIKE {0} OR p.description LIKE {0})",
                    "%" + keyword + "%");
        }
        return this.page(pageParam, wrapper);
    }

    @Override
    public boolean updateQuantity(Long productId, Integer quantity) {
        LambdaQueryWrapper<Inventory> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Inventory::getProductId, productId);
        Inventory inventory = this.getOne(wrapper);
        if (inventory != null) {
            inventory.setQuantity(quantity);
            return this.updateById(inventory);
        }
        return false;
    }
} 