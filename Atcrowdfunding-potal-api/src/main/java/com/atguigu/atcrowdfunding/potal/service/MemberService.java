package com.atguigu.atcrowdfunding.potal.service;

import com.atguigu.atcrowdfunding.bean.Member;

import java.util.Map;

public interface MemberService {

	/**
	 * 会员登录校验
	 * @param paramMap 用户名和密码
	 */
	Member queryMemberlogin(Map<String, Object> paramMap);

	/**
	 * 用户注册
	 * @param member 用户对象
	 */
	int regist(Member member);

	boolean isExistLoginacct(String loginacct);

}
