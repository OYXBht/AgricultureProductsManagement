package org.imau.springboot.agriprom.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("`order`")
public class Order {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String orderNo;
    private Long userId;
    private BigDecimal totalAmount;
    private Integer status; // 0:未支付 1:已支付 2:已发货 3:已签收
    private String shippingAddress;
    private String receiverName;
    private String receiverPhone;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
} 