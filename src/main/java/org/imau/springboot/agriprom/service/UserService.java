package org.imau.springboot.agriprom.service;

import org.imau.springboot.agriprom.entity.User;
import org.imau.springboot.agriprom.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: oyxb_HT
 * @Date: 2025/4/16
 * @Description: $
 */
@Service
public class UserService {
    @Autowired
    UserMapper userMapper;

    public List<User> getAllUser() {
        return userMapper.getAllUser();
    }

    public User getUserById(Long id) {
        return userMapper.getUserById(id);
    }

    public List<User> getUser(User user) {
        return userMapper.getUser(user);
    }

    public User getUserByUserName(String username) {
        return userMapper.getUserByUserName(username);
    }

    public int addUser(User user) {
        return userMapper.addUser(user);
    }

    public int updateUser(User user) {
        return userMapper.updateUser(user);
    }

    public int deleteUser(Long id) {
        return userMapper.deleteUser(id);
    }
}
