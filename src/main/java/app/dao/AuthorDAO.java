package app.dao;

import java.util.List;

import app.model.Author;
import app.model.Book;

public interface AuthorDAO  extends org.springframework.data.repository.Repository<Author, Integer>{ 
	Author save(Author author);
	Author findByName(String name);

}
