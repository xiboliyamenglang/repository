package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * 全局控制转发器
 * 问：为什么放到main工程中，而不是manager-impl或portal-impl中呢？
 * 答：因为这个控制器是个通过工具，用于全局跳转；既可以给后台用，也可以给前台用。
 * @author gejing
 *
 */
@Controller
//@Scope("prototype") 在解决多线程操作同一个数据问题时，不推荐用多实例。建议：被操作的数据不使用成员变量定义，而使用局部变量定义
public class DispatcherController {
	
	@Autowired
	private UserService userService;

	@Autowired
	private MemberService memberService;

	//跳转首页
	@RequestMapping("/index")
	public String index(){
		return "index";
	}
	
	//跳转登录页
	@RequestMapping("login/login")
	public String login(){
		return "login/login";
	}

	//跳转注册页
	@RequestMapping("login/reg")
	public String reg(){
		return "login/reg";
	}
	
	//跳转管理员主页
	@RequestMapping("/main")
	public String main(){
		return "main";
	}

	//跳转测试页面
	@RequestMapping("/itsr")
	public String itsr(){
		System.out.println("跳转test.jsp");
		return "a/test";
	}
	
	//退出系统
	@RequestMapping("/logout")
	public String logout(HttpSession session){
		System.out.println(session.getAttribute(Const.LOGIN_USER)+"退出系统");
		session.invalidate(); //销毁session对象，或清理session域
		
		//return "redirect:/index.htm";
		return "redirect:/login/login.htm";
	}
	
	/*
	 * 异步请求
	 * @ResponseBody注解：结合Jackson组件，将返回结果（对象、数组等）转化成json字符串，以流的形式返回给客户端
	 * */
	@ResponseBody
	@RequestMapping(value="/doLogin")
	public Object doLogin(@RequestParam(value="loginacct") String loginacct,
							String userpswd,
							String usertype,
							HttpSession session){
		AjaxResult result = new AjaxResult();
		System.out.println("loginacct:"+ loginacct+" userpswd:"+userpswd+" usertype:"+usertype);
		try {
			Map<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("loginacct", loginacct);
			paramMap.put("userpswd", MD5Util.digest(userpswd));
			paramMap.put("usertype", usertype);

			if(usertype != null && "user".equals(usertype)){
				User user = userService.queryUserlogin(paramMap);
				session.setAttribute(Const.LOGIN_USER, user);
			}else{
				Member member = memberService.queryMemberlogin(paramMap);
				session.setAttribute(Const.LOGIN_USER, member);
			}
			result.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMessage("登录失败！");
		}
		return result;
	}
	
	/*+
	 * 同步请求
	 * @RequestParam注解，用于将某个请求的参数名与方法形参进行绑定（value值等于请求参数名，表单的name属性值）
	 * 一般为了简化，请求的参数名与方法形参相等，就不需要配置@RequestParam注解
	 * */
	/*@RequestMapping(value="/doLogin")
	public String doLogin(@RequestParam(value="loginacct") String loginacct,
							String userpswd,
							String type,
							HttpSession session){
		//不确定Map要存什么，故用Object
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("loginacct", loginacct);
		paramMap.put("userpswd", userpswd);
		paramMap.put("type", type);

		User user = userService.queryUserlogin(paramMap);
		session.setAttribute(Const.LOGIN_USER, user);*/
		
		/* 问：为什么不用转发？
		 * 答：如果通过转发到达main.jsp，那么用户在刷新页面时，刷新的是/doLogin，会重复提交表单；
		 * 	     而如果使用重定向到达main.jsp，用户刷新页面时，刷新的是main.jsp
		 * */
		//return "redirect:/main.htm";
	//}

}
