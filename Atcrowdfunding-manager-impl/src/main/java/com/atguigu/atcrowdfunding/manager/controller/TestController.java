package com.atguigu.atcrowdfunding.manager.controller;

import java.util.ArrayList;
import java.util.LinkedList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.manager.service.TestService;

@Controller
public class TestController {

	@Autowired
	private TestService testService;
	
	@RequestMapping(value="/test")
	public String test(){
		System.out.println("TestController");
		
		testService.insert();
		
		return "success";
	}
	
}
