package org.imau.springboot.agriprom.entity;

import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Repository;

/**
 * @Author: oyxb_HT
 * @Date: 2025/4/15
 * @Description: $
 */
@Data
@ToString
@Repository
public class User {
    Long userId;
    String userName;
    String email;
    String password;
    Byte userState; // 1-启动 0-禁用
    Byte userType; // 1-管理员 0-普通用户
}
