package org.imau.springboot.agriprom.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.imau.springboot.agriprom.entity.Order;

@Mapper
public interface OrderMapper extends BaseMapper<Order> {
} 