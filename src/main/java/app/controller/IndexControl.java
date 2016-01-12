package app.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path="/")
public class IndexControl {
	
	@RequestMapping(path="/hello")
	public String sayHello() {
		return "Hello, world";
	}
	
}
