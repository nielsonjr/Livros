package app.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import app.dao.BookDAO;
import app.model.Author;
//import app.ember.EmberModel;
import app.model.Book;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class BookAngularController {

	@Autowired
	private BookDAO bDAO;

	@RequestMapping(path="/book")
	public ModelAndView form() throws ServletException, IOException{
		ModelAndView modelAndView = new ModelAndView("/book/indexAngularJS");

		return modelAndView;
	}

	@ResponseBody
	@RequestMapping(path="/book/listAll", method = RequestMethod.GET)
	public List<Book> listAll() throws ServletException, IOException{
		return bDAO.findAll();
	}

	@ResponseBody
	@RequestMapping(path="/book/save", method=RequestMethod.POST)
	public Book save(@RequestBody Map<String, Object> book) throws JsonParseException, JsonMappingException, IOException{
		ObjectMapper JSONObjectMapper = new ObjectMapper();
		Book bookEntity = JSONObjectMapper.readValue(book.get("bookJSON").toString(), Book.class);
		List<String> authorsString = getAuthors((List<Map<String, String>>)book.get("authorsJSON"));
		
		if(bookEntity != null && bookEntity.getId() != null) {
			//update Entity authors too
			bookEntity.setAuthors(authorsString);
		}
		else if(bookEntity != null && bookEntity.getId() == null) {
			//create authors
			bookEntity.getAuthors().addAll(authorsString);
		}


		bDAO.save(bookEntity);

		return bookEntity;
	}
	
	@ResponseBody
	@RequestMapping(path="/book/delete", method=RequestMethod.POST)
	public Book deleteBook(@RequestBody Book book) {
		bDAO.delete(book);
		
		Boolean isDeleted = bDAO.findById(book.getId()) == null;
		
		if(isDeleted) {
			return new Book();
		}
		else {
			return book;
		}
	}

	private List<String> getAuthors(List<Map<String, String>> authorsFromView) {
		List<String> authors = new ArrayList<String>();

		for (Map<String,String> authorFromView : authorsFromView) {
			String author = authorFromView.get("name");

			authors.add(author);
		}

		return authors;
	}
}
