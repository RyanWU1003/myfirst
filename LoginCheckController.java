package tw.iii.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import tw.iii.model.ProductDao;
import tw.iii.model.Users;
import tw.iii.model.UsersDao;

@Controller
public class LoginCheckController {
	@Autowired
	private UsersDao usersDao;
	@Autowired
	private ProductDao pDao;
	
	@RequestMapping(path = "/login.chechController",method = RequestMethod.POST)
	public String checkLoginAction(@RequestParam(name = "userName")String username,@RequestParam(name="password")String password
			,Model m,HttpServletRequest req){
		Map<String, String>errors = new HashMap<String, String>();
		if(username == null ||username.length() == 0) {
			errors.put("username", "帳號不能為空白");
		}
		if(password == null || password.length() == 0) {
			errors.put("password", "請輸入密碼");
		}
		m.addAttribute("errors", errors);
		
		if(errors !=null && !errors.isEmpty()) {
			return "index";
		}
		boolean checkuser = usersDao.login(username, password);
		HttpSession session = req.getSession();
		if(checkuser) {
			session.setAttribute("checkuser", checkuser);
			m.addAttribute("selection","all");
			m.addAttribute("productList",pDao.selectAll());
			m.addAttribute("count",pDao.count());
			return "shop_list";
		}
		errors.put("msg", "帳號或密碼錯誤");
		return "index.jsp";
	}
}
