package app.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import app.dao.BookDAO;
import app.dao.UserDAO;
//import app.ember.EmberModel;
import app.model.Book;
import app.model.User;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class UserController {

	@Autowired
	private UserDAO uDAO;
	
	@Autowired
	private BookDAO bDAO;

	@RequestMapping(path="/user")
	public ModelAndView form() throws ServletException, IOException{
		ModelAndView modelAndView = new ModelAndView("/user/user");

		return modelAndView;
	}

	@ResponseBody
	@RequestMapping(path="/user/listAll", method = RequestMethod.GET)
	public List<User> listAll() throws ServletException, IOException{
		return uDAO.findAll();
	}
	
	@ResponseBody
	@RequestMapping(path="/user/listAllBooks", method = RequestMethod.GET)
	public List<Book> listAllBooks() throws ServletException, IOException{
		return bDAO.findAll();
	}

	@ResponseBody
	@RequestMapping(path="/user/save", method=RequestMethod.POST)
	public User save(@RequestBody Map<String, Object> viewData) throws JsonParseException, JsonMappingException, IOException{
		ObjectMapper JSONObjectMapper = new ObjectMapper();
		User userEntity = JSONObjectMapper.readValue(viewData.get("user").toString(), User.class);
		List<Book> books = getBooks((List<String>)viewData.get("selectedBooks"), JSONObjectMapper);
		
		if(userEntity != null && userEntity.getId() != null) {
			//update Entity authors too
			userEntity.setBooks(books);
		}
		else if(userEntity != null && userEntity.getId() == null) {
			//create authors
			userEntity.getBooks().addAll(books);
		}

		
		uDAO.save(userEntity);

		return userEntity;
	}
	
	@ResponseBody
	@RequestMapping(path="/user/delete", method=RequestMethod.POST)
	public User deleteUser(@RequestBody User user) {
		uDAO.delete(user.getId());
		
		Boolean isDeleted = uDAO.findById(user.getId()) == null;
		
		if(isDeleted) {
			return new User();
		}
		else {
			return user;
		}
	}
	
	private List<Book> getBooks(List<String> booksFromView, ObjectMapper JSONObjectMapper) throws JsonParseException, JsonMappingException, IOException {
		List<Book> books = new ArrayList<Book>();

		for (String bookFromView : booksFromView) {
			Book bookEntity = JSONObjectMapper.readValue(bookFromView.toString(), Book.class);

			books.add(bookEntity);
		}

		return books;
	}
	
}
