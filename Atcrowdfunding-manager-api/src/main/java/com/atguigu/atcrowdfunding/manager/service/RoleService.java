package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.util.Page;

import java.util.Map;

public interface RoleService {

    //分页查询会员
    Page queryMemberByPage(Map<String,Object> param);
}
