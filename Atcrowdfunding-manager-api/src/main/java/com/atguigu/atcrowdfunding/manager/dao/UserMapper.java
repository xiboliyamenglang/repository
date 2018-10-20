package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    User selectByLoginacct(String loginacct);

    User selectByPrimaryKey(Integer id);

    List<User> selectAll();

    int updateByPrimaryKey(User record);

	User queryUserlogin(Map<String, Object> paramMap);

	int selectAllCount(Map<String, Object> paramMap);

    /**
     * 由于mybatis不知道pageno和pagesize到底与mapper.xml中的哪个参数绑定，故必须用注解@Param将它们绑定（只在mybatis多参数时需要使用）
     */
    /*List<User> queryPage(Integer pageIndex,Integer pagesize);*/
    @Deprecated
    List<User> queryPage(@Param("pageIndex") Integer pageIndex,
                         @Param("pagesize") Integer pagesize);

    //新方法
    List<User> queryPage(Map<String, Object> paramMap);
}