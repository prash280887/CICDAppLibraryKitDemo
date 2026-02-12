package com.javaspringboot.javaspringbootwebapp.WEB;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.javaspringboot.javaspringbootwebapp.Models.LoginUserModel;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;



@Controller
public class Login {

    @GetMapping("/login")
    public String Login() {
        return "login";
    }

    @PostMapping("/login")
    public String LoginPost(@RequestParam String username , @RequestParam String password) {
        LoginUserModel user = new LoginUserModel();
        user.username = username;
        user.password = password;
      System.out.println("Login attempt for user: " + user.username);
        if(user.username.equals("admin") && user.password.equals("password")) {
            return "redirect:/home";
        } else {
            return "redirect:/login?error=true";
        }
    }

    @GetMapping("/home")
    public String Home() {
        return "home";
    }

}
