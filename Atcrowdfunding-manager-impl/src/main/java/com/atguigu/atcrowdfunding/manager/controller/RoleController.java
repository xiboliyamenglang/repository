package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.manager.service.RoleService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value="/role")
public class RoleController {

    @Autowired
    private RoleService RoleService;

    //跳转角色列表页
    @RequestMapping("/toRole")
    public String toRole(){
        return "role/role";
    }

    //跳转角色赋权页
    @RequestMapping("/toAssignRole")
    public String toAssignRole(){
        return "role/assignRole";
    }

    //分页查询用户
    @ResponseBody
    @RequestMapping(value="/querymember")
    public AjaxResult queryMember(@RequestParam(value = "pageno" , defaultValue = "1") String pageno ,
                                  @RequestParam(value = "pagesize" , defaultValue = "10") String pagesize){
        AjaxResult ajax = new AjaxResult();
        try {
            Map param = new HashMap<String,Object>();
            param.put("pageno",pageno);
            param.put("pagesize",pagesize);

            Page page = RoleService.queryMemberByPage(param);
            ajax.setPage(page);
            ajax.setSuccess(true);
            ajax.setMessage("查询会员成功");

        } catch (Exception e) {
            e.printStackTrace();
            ajax.setSuccess(false);
            ajax.setMessage("查询会员异常:"+e.getMessage());
        }finally {
            return ajax;
        }
    }
}
