package app.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class IndexControl {
	
	@RequestMapping(path="/")
	public ModelAndView sayHello() {
		ModelAndView modelAndView = new ModelAndView("index");
		
		return modelAndView;
	}
	
}
