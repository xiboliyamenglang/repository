package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * 管理员控制器
 * @author gejing
 *
 */
@Controller
@RequestMapping(value="/user")
public class UserController {

	public static void main(String[] args) {
		System.out.println("12123");
	}

	//用户Service
	@Autowired
	private UserService userService;

	//跳转用户维护页
	@RequestMapping("/toUser")
	public String toUser(){
		return "user/user";
	}


	/**
	 * 分页查询用户（异步）
	 * @param pageno 当前页码
	 * @param pagesize 页容量
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryuser")
	public Object queryUser(@RequestParam(value = "pageno", defaultValue = "1") Integer pageno,
							@RequestParam(value = "pagesize", defaultValue = "10") Integer pagesize,
							//注意：如果该处condition用了@RequestParam注解，那么前台JS没有传这个参数的话，匹配不到该方法。除非required=false
							@RequestParam(value = "condition", required = false)String condition){
		//System.out.println("----开始寻找用户----");
		AjaxResult result = new AjaxResult();
		try {
			Map param = new HashMap();
			param.put("pageno",pageno);
			param.put("pagesize",pagesize);
			//System.out.println("pageno:"+pageno+" pagesize:"+pagesize);

			if(condition != null && !"".equals(condition)){
				/*  问题：查询条件值本身为%，则会查询出所有的数据（相当于匹配所有）
					例如：concat('%',#{param},'%') => '%%%'
					解决方法：'%\%%'  使用转译字符再进行查询，把%当成字符来查询  */
				if(condition.contains("%")){
					/* 问题：为什么要用4个斜线\来转义百分号% ？
					 * 解答：首先，JAVA中字符串内的斜线\本身需要做转义，那么需要加1个斜线；然后调用字符串的replaceAll方法，内部的正则表达式也需要转义一次，2个斜线各加一个斜线\。
					 * 		 所以最后是4个斜线  */
					condition = condition.replaceAll("%", "\\\\%");
				}
				param.put("condition",condition);
				System.out.println("condition:"+condition);
			}

			Page page = userService.queryPage(param);

			result.setPage(page);
			result.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMessage("分页查询用户失败...");
		}

		return result;//将对象序列化为JSON字符串,以流的形式返回.
	}
	/*跳转用户维护页（同步）
	@RequestMapping("/queryuser")
	public String queryUser(@RequestParam(value = "pageno", defaultValue = "1") Integer pageno,
							@RequestParam(value = "pagesize", defaultValue = "10") Integer pagesize,
							Model model){
		Page page = userService.queryPage(pageno,pagesize);
		model.addAttribute("userpage",page);

		return "user/user";
	}*/

	//跳转用户新增页
	@RequestMapping("/toAddUser")
	public String toAddUser(){
		return "user/addUser";
	}

	/**
	 * 新增用户
	 * @param user 用户对象
	 */
	@ResponseBody
	@RequestMapping("/addUser")
	public AjaxResult addUser(User user){
		AjaxResult result = new AjaxResult();
		Map res = null;
		try {
			res = userService.insertUser(user);

			if((boolean)res.get("result")){
				result.setMessage((String)res.get("msg"));
				result.setSuccess(true);
			}else{
				result.setMessage((String)res.get("msg"));
				result.setSuccess(false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setMessage((String)res.get("msg"));
			result.setSuccess(false);
		}finally{
			return result;
		}
	}

	/**
	 * 检查用户名是否存在
	 * @param loginacct 用户名
	 */
	@ResponseBody
	@RequestMapping("/checkLoginacct")
	public AjaxResult checkLoginacct(String loginacct){
		AjaxResult result = new AjaxResult();
		try {
			User user = userService.selectByLoginacct(loginacct);

			if(user == null || !(user instanceof User)){
				result.setSuccess(false);
			}else{
				result.setSuccess(true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}finally{
			return result;
		}
	}

	//跳转用户修改页
	@RequestMapping("/toEditUser")
	public String toEditUser(@RequestParam(value="id") String id, Model model) throws Exception{
		User user = userService.selectByPrimaryKey(id);

		System.out.println("user:"+user.toString());
		if(user ==null){
			throw new Exception("查找用户发生异常...");
		}

		model.addAttribute("u",user);
		return "user/editUser";
	}

	/**
	 * 修改用户
	 * @param user 用户对象
	 */
	@ResponseBody
	@RequestMapping("/editUser")
	public AjaxResult editUser(User user){
		AjaxResult result = new AjaxResult();
		Map res = null;
		//System.out.println("----1 email:"+user.getEmail()+" loginacct:"+user.getLoginacct()+" username:"+user.getUsername()+" createtime:"+user.getCreatetime()+" id:"+user.getId()+" pswd:"+user.getUserpswd());
		try {
			res = userService.editUser(user);
			//System.out.println("----res:"+(boolean)res.get("result"));

			if((boolean)res.get("result")){
				result.setSuccess(true);
				result.setMessage((String)res.get("msg"));
			}else{
				result.setSuccess(false);
				result.setMessage((String)res.get("msg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setMessage((String)res.get("msg"));
			result.setSuccess(false);
		}finally{
			return result;
		}
	}


	/**
	 * 删除单个用户
	 * @param id 用户id
	 */
	@ResponseBody
	@RequestMapping("/deleteUser")
	public AjaxResult deleteUser(String id){
		AjaxResult result = new AjaxResult();
		Map res = new HashMap();
		try {
			System.out.println("deleteUser:"+id);
			res = userService.deleteUser(id);
			System.out.println("del-result:"+res.get("msg"));

			if((boolean)res.get("result")){
				result.setMessage((String)res.get("msg"));
				result.setSuccess(true);
			}else{
				result.setSuccess(false);
				result.setMessage((String)res.get("msg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setMessage((String)res.get("msg"));
			result.setSuccess(false);
		}finally{
			return result;
		}
	}

	/**
	 * 批量删除用户
	 * @param id 用户id （除了String[]，也可以用Integer[]做接收）
	 */
	@ResponseBody
	@RequestMapping("/deleteBatchUser")
	public AjaxResult deleteBatchUser(String[] id){
		AjaxResult result = new AjaxResult();
		Map res = new HashMap();
		try {
			//System.out.println("length:"+id.length);
			int total = 0;
			for(String d : id){
				res = userService.deleteUser(d);
				if((boolean)res.get("result")){
					total += 1;
				}
			}

			if(total != id.length){
				result.setMessage("删除用户失败");
				result.setSuccess(false);
				throw new Exception("删除用户失败");
			}

			result.setMessage("删除用户成功");
			result.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			result.setMessage((String)res.get("msg"));
			result.setSuccess(false);
		}finally{
			return result;
		}
	}



	
}
