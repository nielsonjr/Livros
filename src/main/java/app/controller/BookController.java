package app.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import app.dao.BookDAO;
//import app.ember.EmberModel;
import app.model.Book;

@RestController
public class BookController {

	@Autowired
	private BookDAO bDAO;
//	
//	@RequestMapping(path="/book/form")
//	public ModelAndView form() throws ServletException, IOException{
//		ModelAndView modelAndView = new ModelAndView("/book/createBook");
//		List<Book> books = bDAO.findAll();
//		
//		modelAndView.addObject("books", books);
//		modelAndView.addObject("book", new Book());
//    	
//		return modelAndView;
//	}
//	
//	@RequestMapping(path="/book/bookEmber")
//	public ModelAndView emberForm() throws ServletException, IOException{
//		ModelAndView modelAndView = new ModelAndView("/book/createBookEmber");
//		List<Book> books = bDAO.findAll();
//		
//		modelAndView.addObject("book", books);
//    	
//		return modelAndView;
//	}
//	
//	@RequestMapping(path="/book/bookEmber", produces = MediaType.APPLICATION_JSON_VALUE)
//	@ResponseStatus(HttpStatus.OK)
//	public EmberModel listAllBooksToEmber() throws ServletException, IOException{
//		
//		List<Book> books = bDAO.findAll();
//    	return new EmberModel.Builder<Book>(Book.class, books)
//    			.addMeta("book", books)
//    			.build();
//    	
//	}
//	
//	@RequestMapping(path="/book", method=RequestMethod.POST)
//	public ModelAndView save(@ModelAttribute("book") Book book,Model model){
//		bDAO.save(book);
//		return new ModelAndView("redirect:/book/form");
//	}
}
