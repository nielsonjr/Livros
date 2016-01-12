package app.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import app.dao.UserDAO;
import app.model.User;

@RestController
public class UsersController {

	@Autowired
	private UserDAO uDAO;
	
	@RequestMapping(path="/user", method=RequestMethod.GET)
	public ModelAndView list() throws ServletException, IOException{
		ModelAndView modelAndView = new ModelAndView("/user/listAllUsers");
		List<User> users = uDAO.findAll();
		
		modelAndView.addObject("usuarios", users);
		
		return modelAndView;
	}
	
	@RequestMapping(path="/user/form")
	public ModelAndView form() throws ServletException, IOException{
		ModelAndView modelAndView = new ModelAndView("/user/createUser");
		modelAndView.addObject("user", new User());
		return modelAndView;
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView save(@ModelAttribute("user") User user,Model model){
		uDAO.save(user);
		return new ModelAndView("redirect:user");
	}

}
