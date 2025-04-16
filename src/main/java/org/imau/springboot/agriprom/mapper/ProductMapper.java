package org.imau.springboot.agriprom.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.imau.springboot.agriprom.entity.Product;

@Mapper
public interface ProductMapper extends BaseMapper<Product> {
} 