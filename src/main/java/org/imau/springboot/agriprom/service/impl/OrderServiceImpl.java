package org.imau.springboot.agriprom.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.imau.springboot.agriprom.entity.Order;
import org.imau.springboot.agriprom.mapper.OrderMapper;
import org.imau.springboot.agriprom.service.OrderService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements OrderService {
    @Override
    public IPage<Order> searchOrders(String keyword, int page, int size) {
        Page<Order> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Order> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(keyword)) {
            wrapper.like(Order::getOrderNo, keyword)
                  .or()
                  .like(Order::getReceiverName, keyword)
                  .or()
                  .like(Order::getReceiverPhone, keyword);
        }
        return this.page(pageParam, wrapper);
    }

    @Override
    public boolean updateOrderStatus(Long id, Integer status) {
        Order order = this.getById(id);
        if (order != null && order.getStatus() == 0) { // 只能修改未发货的订单
            order.setStatus(status);
            return this.updateById(order);
        }
        return false;
    }

    @Override
    public boolean deleteOrder(Long id) {
        Order order = this.getById(id);
        if (order != null && order.getStatus() == 3) { // 只能删除已签收的订单
            return this.removeById(id);
        }
        return false;
    }
} 