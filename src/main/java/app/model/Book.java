package app.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
public class Book {
	@Id @GeneratedValue
	private Integer id;
	
	@NotNull
	private String name;
	
	private Integer year;
	
//	@NotEmpty
//	private List<String> authors = new ArrayList<String>();
	
	public Book() {
	}
	
	public Book(String name, Integer year, String... authors) {
		this.name = name;
		this.year = year;
		
//		for (String author : authors) {
//			this.authors.add(author);
//		}
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
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
//	public List<String> getAuthors() {
//		return authors;
//	}
//	public void setAuthors(List<String> authors) {
//		this.authors = authors;
//	}
	
	
}
