package org.imau.springboot.agriprom.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import org.imau.springboot.agriprom.entity.Order;

public interface OrderService extends IService<Order> {
    IPage<Order> searchOrders(String keyword, int page, int size);
    boolean updateOrderStatus(Long id, Integer status);
    boolean deleteOrder(Long id);
} 