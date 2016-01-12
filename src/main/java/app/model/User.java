package app.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class User {
	@Id
	@GeneratedValue
	private Integer id;
	
	@Column(nullable=false)
	private String name;
	
	@OneToMany
	private List<Book> books = new ArrayList<Book>();
	
	public User() {
	}
	
	public User(String name) {
		this.name = name;
	}
	
	public User(String name, Book... books) {
		this.name = name;
		
		for (Book book : books) {
			this.books.add(book);
		}
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<Book> getBooks() {
		return books;
	}
	public void setBooks(List<Book> books) {
		this.books = books;
	}
	
}
