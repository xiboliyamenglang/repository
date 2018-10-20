package com.atguigu.atcrowdfunding.potal.dao;

import com.atguigu.atcrowdfunding.bean.Member;

import java.util.List;
import java.util.Map;

public interface MemberMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Member record);

    int updateByPrimaryKey(Member record);

    Member selectByPrimaryKey(Integer id);

    Member selectByLoginacct(String loginacct);

    List<Member> selectAll();

    Member queryMemberlogin(Map<String, Object> paramMap);
}