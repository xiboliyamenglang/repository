package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.util.Page;

import java.util.Map;

public interface UserService {

	User queryUserlogin(Map<String, Object> paramMap);

	/*@Deprecated //表示方法过时
    Page queryPage(Integer pageIndex, Integer pagesize);*/

	//新方法
    Page queryPage(Map<String,Object> param);

    Map insertUser(User user);

    Map editUser(User user);

    Map deleteUser(String id);

    User selectByLoginacct(String loginacct);

    User selectByPrimaryKey(String id);
}
