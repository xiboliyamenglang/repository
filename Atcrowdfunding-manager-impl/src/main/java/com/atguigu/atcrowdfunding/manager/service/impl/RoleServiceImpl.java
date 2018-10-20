package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.manager.dao.RoleMapper;
import com.atguigu.atcrowdfunding.manager.service.RoleService;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    /**
     * 分页查询会员
     * @param param
     * @return
     */
    @Override
    public Page queryMemberByPage(Map<String, Object> param) {
        Page page = new Page((Integer)param.get("pageno") , (Integer)param.get("pagesize"));
        page.setTotalcount(roleMapper.selectCountByCondition(param));



        return null;
    }
}
