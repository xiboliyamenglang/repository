package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.Role;

import java.util.List;
import java.util.Map;

public interface RoleMapper {
    /*删除*/
    int deleteByPrimaryKey(Integer id);

    /*增加*/
    int insert(Role record);

    /*修改*/
    int updateByPrimaryKey(Role record);

    /*查询*/
    Role selectByPrimaryKey(Integer id);

    List<Role> selectAll();

    List<Role> selectByPage(Map<String,Object> param);

    int selectAllCount();

    int selectCountByCondition(Map<String,Object> param);




}