package com.atguigu.atcrowdfunding.manager.controller;

import java.util.ArrayList;
import java.util.LinkedList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
/**
 * 管理员控制器
 * @author gejing
 *
 */
@Controller
@RequestMapping(value="/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/checklogin")
	public String test(User user,Model model){
		System.out.println("loginacct:"+user.getLoginacct()+"\nuserpswd:"+user.getUserpswd());
		
		//testService.insert();
		
		return "success";
	}
	
}
