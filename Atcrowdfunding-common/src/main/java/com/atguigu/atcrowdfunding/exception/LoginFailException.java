package com.atguigu.atcrowdfunding.exception;

/**
 * 自定义异常，继承RuntimeException即可
 * @author Administrator
 *
 */
public class LoginFailException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	/**
	 * 带参构造，传入异常信息
	 */
	public LoginFailException(String message){
		super(message);
	}
	
}
