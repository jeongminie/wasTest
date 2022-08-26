package com.jeongmini.minggram.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {

	@RequestMapping("/signIn")
	public String loginView() {
		return "user/signIn";
	}
}
