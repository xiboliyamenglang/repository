package Test;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.MD5Util;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Map;

public class Test {

    public static void main(String[] args) {
        ApplicationContext ioc = new ClassPathXmlApplicationContext("spring/spring*.xml");
        UserService service = ioc.getBean(UserService.class);

        for (int i=1,j=0; i<=100; i++){
            User user = new User();
            user.setLoginacct("test"+i);
            user.setUserpswd(MD5Util.digest("1"));
            user.setUsername("test"+i);
            user.setEmail("test"+i+"@weaver.com");
            user.setCreatetime("2018-09-25 23:41:00");
            Map res = service.insertUser(user);

            if((boolean)res.get("result")){
                System.out.println("插入test"+i+"成功...");
            }
        }
    }
}
