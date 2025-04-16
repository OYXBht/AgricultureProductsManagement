package org.imau.springboot.agriprom.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import org.imau.springboot.agriprom.entity.Inventory;

public interface InventoryService extends IService<Inventory> {
    IPage<Inventory> searchInventories(String keyword, int page, int size);
    boolean updateQuantity(Long productId, Integer quantity);
} 