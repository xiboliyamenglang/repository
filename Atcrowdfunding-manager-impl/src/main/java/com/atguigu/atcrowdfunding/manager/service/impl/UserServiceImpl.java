package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.exception.LoginFailException;
import com.atguigu.atcrowdfunding.manager.dao.UserMapper;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.atguigu.atcrowdfunding.util.Page;
import com.atguigu.atcrowdfunding.util.StringUtil;
import com.atguigu.atcrowdfunding.util.TimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service

public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper ;

	/**
	 * 查询管理员登录
	 */
	@Override
	public User queryUserlogin(Map<String, Object> paramMap) {
		User user = userMapper.queryUserlogin(paramMap);
		if(user==null){
			throw new LoginFailException("用户账号或密码不正确!");
		}
		return user;
	}

	/**
	 * （过时方法）分页查找用户
	 * @param pageno 当前页码
	 * @param pagesize 页容量
	 * @return
	 */
	/*@Override
	public Page queryPage(Integer pageno, Integer pagesize) {
		Page page = new Page(pageno,pagesize);
		*//*page.setTotalcount(userMapper.selectAllCount());

		//通过开始索引和页容量，分页搜索用户
		List<User> userList =  userMapper.queryPage(page.getStartIndex(),page.getPagesize());
		page.setObjList(userList);

		System.out.println("pageno:"+pageno+" pagesize:"+pagesize+" totalcount:"+userMapper.selectAllCount()+" totalpage:"+page.getTotalpage()+" usersize:"+userList.size());*//*
		return page;
	}*/

	/**
	 * （新方法）分页查找用户
	 * @param param 分页参数、条件等
	 * @return
	 */
	@Override
	public Page queryPage(Map<String,Object> param) {
		System.out.println("[UserServiceImpl-queryPage]--开始查找用户...");
		Page page = new Page((Integer) param.get("pageno"),(Integer) param.get("pagesize"));
		page.setTotalcount(userMapper.selectAllCount(param));

		//通过开始索引和页容量，分页搜索用户
		param.put("startIndex",page.getStartIndex());
		List<User> userList =  userMapper.queryPage(param);
		page.setObjList(userList);

		System.out.println("pageno:"+param.get("pageno")+" pagesize:"+param.get("pagesize")+" totalcount:"+userMapper.selectAllCount(param)+" totalpage:"+page.getTotalpage()+" usersize:"+userList.size()+" condition:"+param.get("condition"));

		return page;
	}

	/**
	 * 添加用户
	 * @param user 用户对象
	 */
	@Override
	public Map insertUser(User user) {
		Map res = new HashMap();
		try {
			if(user == null || StringUtil.isEmpty(user.getLoginacct())
					   		|| StringUtil.isEmpty(user.getUsername()) ){
				res.put("result",false);
				res.put("msg","用户账号或用户姓名为空，新增用户失败...");
				return res;
			}

			//校验是否已经存在该用户名
			User u = userMapper.selectByLoginacct(user.getUsername());
			if( u == null || !(u instanceof User)){
				res.put("result",false);
				res.put("msg","该用户名已经被使用，请使用其他用户名...");
				return res;
			}

			//创建时间和默认密码
			String createTime = TimeUtil.formatDateToString(new Date());
			user.setCreatetime(createTime);
			user.setUserpswd(MD5Util.digest("1"));
			int column = userMapper.insert(user);

			if(column > 0){
				res.put("result",true);
				res.put("msg","新增用户成功");
			}else{
				res.put("result",false);
				res.put("msg","新增用户失败...");
			}
			return res;

		} catch (Exception e) {
			e.printStackTrace();
			res.put("result",false);
			res.put("msg","新增用户时发生异常...");
			return res;
		}
	}

	/**
	 * 修改用户
	 * @param user 用户对象
	 */
	@Override
	public Map editUser(User user) {
		Map res = new HashMap();
		try {
			if(user == null || StringUtil.isEmpty(user.getLoginacct())
					|| StringUtil.isEmpty(user.getUsername()) ){
				res.put("result",false);
				res.put("msg","用户账号或用户姓名为空，修改用户失败...");
				return res;
			}

			int column = userMapper.updateByPrimaryKey(user);
			System.out.println("column:"+column);

			if(column > 0){
				res.put("result",true);
				res.put("msg","修改用户成功");
			}else{
				res.put("result",false);
				res.put("msg","修改用户失败...");
			}
			return res;

		} catch (Exception e) {
			e.printStackTrace();
			res.put("result",false);
			res.put("msg","修改用户时发生异常...");
			return res;
		}
	}

	/**
	 * 通过id删除用户
	 * @param id 用户id
	 */
	@Override
	public Map deleteUser(String id) {
		Map res = new HashMap();
		try {
			if(id == null || StringUtil.isEmpty(id)){
				res.put("result",false);
				res.put("msg","用户id为空，删除用户失败...");
				return res;
			}

			int column = userMapper.deleteByPrimaryKey(Integer.parseInt(id));
			System.out.println("column:"+column);

			if(column > 0){
				res.put("result",true);
				res.put("msg","删除用户成功");
			}else{
				res.put("result",false);
				res.put("msg","删除用户失败...");
			}
			return res;

		} catch (Exception e) {
			e.printStackTrace();
			res.put("result",false);
			res.put("msg","删除用户时发生异常...");
			return res;
		}
	}

	//通过用户名查找用户
	public User selectByLoginacct(String loginacct){
		if(loginacct == null || "".equals(loginacct)){
			return null;
		}
		return userMapper.selectByLoginacct(loginacct);
	}

	//通过id查找用户
	public User selectByPrimaryKey(String id){
		if(id == null || "".equals(id)){
			return null;
		}

		try {
			return userMapper.selectByPrimaryKey(Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}


}
