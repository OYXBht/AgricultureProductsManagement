package org.imau.springboot.agriprom;

import org.imau.springboot.agriprom.entity.User;
import org.imau.springboot.agriprom.mapper.UserMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class AgricultureProductsManagementApplicationTests {

	@Test
	void contextLoads() {
	}

	@Autowired
	UserMapper userMapper;

	@Test
	void testMybatis() {
		List<User> users = userMapper.getAllUser();
		users.forEach(System.out::println);
	}

	@Test
	void testMybatis01() {
		User user = new User();
		user.setUserName("admin");
		user.setPassword("123456");
		user.setEmail("admin@imau.com");
		user.setUserType((byte) 1);
		int ok = userMapper.addUser(user);
	}
}
