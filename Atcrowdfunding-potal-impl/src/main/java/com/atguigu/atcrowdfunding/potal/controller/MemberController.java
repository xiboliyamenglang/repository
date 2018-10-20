package com.atguigu.atcrowdfunding.potal.controller;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping(value="/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @ResponseBody
    @RequestMapping(value="/regist")
    public AjaxResult regist(Member member){
        AjaxResult result = new AjaxResult();
        try {
            System.out.println("loginacct:"+member.getLoginacct()+" userpswd:"+member.getUserpswd()+" username:"+member.getUsername()+" email:"+member.getEmail()+" accttype:"+member.getAccttype());

            member.setUserpswd(MD5Util.digest(member.getUserpswd()));
            member.setAuthstatus("0");
            member.setUsertype("1");
            member.setCardnum("");
            member.setRealname("");
            int column = memberService.regist(member);
            if(column > 0){
                result.setSuccess(true);
                result.setMessage("注册用户成功");
            }else{
                result.setSuccess(false);
                result.setMessage("注册用户失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
            result.setMessage("注册用户时发生异常");
        } finally {
            return result;
        }
    }

    @ResponseBody
    @RequestMapping(value="/checkLoginacctIsExist")
    public AjaxResult checkLoginacctIsExist(String loginacct){
        AjaxResult result = new AjaxResult();

        try {
            System.out.println("loginacct:"+loginacct);

            if(loginacct == null || "".equals(loginacct)){
               throw new Exception("输入的用户名为空，无法检测是否存在...");
            }

            boolean isExist = memberService.isExistLoginacct(loginacct);
            System.out.println("result:"+isExist);
            if(isExist){
                result.setSuccess(isExist);
                result.setMessage("用户名已经被注册，请换用其他用户名");
            }else{
                result.setSuccess(isExist);
                result.setMessage("用户名未被注册，可以使用");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("注册用户时发生异常...");
        } finally {
            return result;
        }
    }


}
