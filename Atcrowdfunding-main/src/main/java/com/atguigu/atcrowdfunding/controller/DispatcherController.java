package com.atguigu.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.Const;

/**
 * 全局控制转发器
 * 问：为什么放到main工程中，而不是manager-impl或portal-impl中呢？
 * 答：因为这个控制器是个通过工具，用于全局跳转；既可以给后台用，也可以给前台用。
 * @author gejing
 *
 */
@Controller
public class DispatcherController {
	
	@Autowired
	private UserService userService;

	
	//跳转首页
	@RequestMapping("/index")
	public String index(){
		return "index";
	}
	
	//跳转登录页
	@RequestMapping("/login")
	public String login(){
		return "login";
	}
	
	//跳转管理员主页
	@RequestMapping("/main")
	public String main(){
		return "main";
	}
	
	/*
	 * @RequestParam注解，用于将某个请求的参数名与方法形参进行绑定（value值等于请求参数名）
	 * 一般为了简化，请求的参数名与方法形参相等，就不需要配置@RequestParam注解
	 * */
	@RequestMapping(value="/doLogin")
	public String doLogin(@RequestParam(value="loginacct") String loginacct,
							String userpswd,
							String type,
							HttpSession session){
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("loginacct", loginacct);
		paramMap.put("userpswd", userpswd);
		paramMap.put("type", type);

		User user = userService.queryUserlogin(paramMap);
		session.setAttribute(Const.LOGIN_USER, user);
		
		/* 问：为什么不用转发？
		 * 答：如果通过转发到达main.jsp，那么用户在刷新页面时，刷新的是/doLogin，会重复提交表单；
		 * 	     而如果使用重定向到达main.jsp，用户刷新页面时，刷新的是main.jsp
		 * */
		return "redirect:/main.htm";
	}

}
