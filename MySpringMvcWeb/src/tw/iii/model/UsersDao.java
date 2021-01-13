package tw.iii.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UsersDao implements IUsersDao {
	@Autowired
	private SessionFactory sessionfactory;
	public  UsersDao(SessionFactory sessionfactory) {
		this.sessionfactory=sessionfactory;
	}
	@Override
	public boolean login(String username, String password) {
		Session session = sessionfactory.getCurrentSession();
		Query query = session.createQuery("from Users u where u.userName=?1 and u.userPassword=?2");
		query.setParameter(1, username);
		query.setParameter(2, password);
		System.out.println("iii");
		return query.list().isEmpty()?false:true;
	}

}
