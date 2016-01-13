package app.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import app.model.User;

@Repository
public interface UserDAO extends org.springframework.data.repository.Repository<User, Integer>{
	User save(User u);
//	void update(User u);
	Boolean delete(Integer u);
//	User merge(User u);
	List<User> findAll();
	User findById(Integer id);
}
