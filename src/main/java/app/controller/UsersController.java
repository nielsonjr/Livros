package app.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import app.dao.BookDAO;
import app.dao.UserDAO;
import app.model.Book;
import app.model.User;

@RestController
public class UsersController {

	@Autowired
	private UserDAO uDAO;
	
	@Autowired
	private BookDAO bDAO;
	
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
		modelAndView.addObject("books", bDAO.findAll());
		modelAndView.addObject("user", new User());
		return modelAndView;
	}
	
	@RequestMapping(path="/user/save", method=RequestMethod.POST)
	public ModelAndView save(@ModelAttribute("user") User user,Model model){
		if(user.getId() != null) {
			User userFromDatabase = uDAO.findById(user.getId());
			userFromDatabase.setBooks(user.getBooks());
			userFromDatabase.setName(user.getName());
			uDAO.save(userFromDatabase);
		}
		else {
			uDAO.save(user);
			
		}
		
		return new ModelAndView("redirect:/user");
	}
	
	@RequestMapping(path="/user/update", method=RequestMethod.POST)
	public ModelAndView update(@ModelAttribute("user") User user,Model model){
		uDAO.save(user);

		return new ModelAndView("redirect:/user");
	}
	
	@RequestMapping(path="/user/{id}/excluir", method=RequestMethod.GET)
	public ModelAndView delete(@PathVariable("id") Integer id,Model model){
		System.out.println("Bye, bye");
		uDAO.delete(id);
		
		return new ModelAndView("redirect:/user");
	}
	
	@RequestMapping(path="/user/{id}/update", method=RequestMethod.GET)
	public ModelAndView update(@PathVariable("id") int id, Model model) {

		User user = uDAO.findById(id);
		
		ModelAndView modelAndView = new ModelAndView("/user/updateUser");
		modelAndView.addObject("books", bDAO.findAll());
		modelAndView.addObject("user", user);
		
		return modelAndView;

	}
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) throws Exception {
		binder.registerCustomEditor(List.class, "books", new CustomCollectionEditor(List.class) {
			protected Object convertElement(Object element) {
				if (element instanceof Book) {
					System.out.println("Converting from Book to Book: " + element);
					return element;
				}
				if (element instanceof Integer) {
					Book book = bDAO.findById((Integer)element);
					System.out.println("Looking up staff for id " + element + ": " + book);
					return book;
				}
				if (element instanceof String) {
					Book book = bDAO.findById(Integer.valueOf((String) element));
					System.out.println("Looking up staff for id " + element + ": " + book);
					return book;
				}
				System.out.println("Don't know what to do with: " + element);
				return null;
			}
		});
	}

}
