package daoTest;

import com.lingnan.bean.Admin;
import com.lingnan.controller.admin.login;
import com.lingnan.dao.admin.adminDao;
import com.lingnan.service.adminService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.scheduling.annotation.Async;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/spring-main.xml")
public class test {

    @Autowired
    private adminDao ad;


    /*@Test
    public void fun1(){
        adminDao ad = context.getBean("adminDao",adminDao.class);
        System.out.println("ad = " + ad);
        Admin admin = new Admin(1,"a","admin","pm");
        Admin byName = ad.findByName("a");
        System.out.println(byName.getAdminName());
    }
    
    @Test
    public void fun2(){
        adminService as = context.getBean("adminServiceImpl",adminService.class);
        Admin admin = new Admin(1,"admin","aa","pm");
        boolean login = as.login(admin);
        System.out.println("login = " + login);
    }*/



    @Test
    public void findAll(){
        List<Admin> all = ad.findAll();
        System.out.println("all = " + all);
    }

    @Test
    public void addAdmin(){
        Admin admin = new Admin(4,1,"Jei","431423412",
                "超级管理员","1380013800","123456789@163.om");
        ad.addAdmin(admin);
    }

    @Test
    public void updateStatus(){
        Map<String,Object> map = new HashMap<>();
        map.put("aId","10");
        map.put("status",0);

        System.out.println("result = " + ad.updateStatus(map));
    }

    @Test
    public void updateAdmin(){
        Admin admin = new Admin(24,0,"测试管理员14","431423412",
                "超级管理员","1380013800","123456789@163.om");
        int i = ad.updateAdmin(admin);
        System.out.println("i = " + i);
    }

}
