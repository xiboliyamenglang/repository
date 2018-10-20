package com.atguigu.atcrowdfunding.potal.service.impl;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.exception.LoginFailException;
import com.atguigu.atcrowdfunding.potal.dao.MemberMapper;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.util.StringUtil;
import org.activiti.engine.impl.util.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;

	/**
	 * 查询会员登录
	 */
	@Override
	public Member queryMemberlogin(Map<String, Object> paramMap) {
		Member member = memberMapper.queryMemberlogin(paramMap);
		System.out.println("member==null?"+member==null?" is null":" not null");
		if(member==null){
			throw new LoginFailException("会员账号或密码不正确!");
		}
		return member;
	}

	/**
	 * 用户注册
	 * @param member 用户对象
	 */
	@Override
	public int regist(Member member){
		int column = -1;
		if(member == null || StringUtil.isEmpty(member.getLoginacct())
						  || StringUtil.isEmpty(member.getUserpswd())
						  || StringUtil.isEmpty(member.getUsername())){
			return column;
		}

		return memberMapper.insert(member);
	}

	/**
	 * 判断是否存在该用户名
	 * @param loginacct
	 * @return
	 */
	@Override
	public boolean isExistLoginacct(String loginacct) {
		if(loginacct == null || "".equals(loginacct)){
			return false;
		}

		System.out.println("Service---loginacct:"+loginacct);
		Member member = memberMapper.selectByLoginacct(loginacct);
		System.out.println("Service---member:"+member==null?"null":"not null");

		return member!=null;
	}


}
