package app.controller;

import java.io.IOException;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import app.dao.BookDAO;
import app.model.Book;

@RestController
public class BookController {

	@Autowired
	private BookDAO bDAO;
	
	@RequestMapping(path="/book/form")
	public ModelAndView form() throws ServletException, IOException{
		ModelAndView modelAndView = new ModelAndView("/book/createBook");
		modelAndView.addObject("book", new Book());
		modelAndView.addObject("books", bDAO.findAll());
		return modelAndView;
	}
	
	@RequestMapping(path="/book", method=RequestMethod.POST)
	public ModelAndView save(@ModelAttribute("book") Book book,Model model){
		bDAO.save(book);
		return new ModelAndView("redirect:/book/form");
	}
}
