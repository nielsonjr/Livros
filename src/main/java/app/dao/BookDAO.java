package app.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import app.model.Book;

@Repository
public interface BookDAO extends org.springframework.data.repository.Repository<Book, Integer>{

	Book save(Book book);
	Boolean delete(Book book);
	List<Book> findAll();
	Book findById(Integer id);
}
