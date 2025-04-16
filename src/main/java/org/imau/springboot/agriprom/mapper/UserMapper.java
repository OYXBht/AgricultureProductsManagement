package org.imau.springboot.agriprom.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.imau.springboot.agriprom.entity.User;

import java.util.List;

/**
 * @Author: oyxb_HT
 * @Date: 2025/4/15
 * @Description: $
 */
@Mapper
public interface UserMapper {
    public List<User> getAllUser();
    public User getUserById(Long userId);
    public List<User> getUser(User user);
    public User getUserByUserName(String userName);
    public int addUser(User user);
    public int updateUser(User user);
    public int deleteUser(Long userId);
}
