package tw.iii.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class ProductDao implements IProductDao {
	@Autowired
	private SessionFactory sessionfactory;

	public ProductDao(SessionFactory sessionfactory) {
		this.sessionfactory = sessionfactory;
	}
	
	@Override
	public Product insert(Product PD) {
		Session session = sessionfactory.getCurrentSession();
		Product product = session.get(Product.class,PD.getProductID());
		
		if(product==null) {
			
			session.save(PD);		
			System.out.println("Add Success !!");
			return PD;
		}
		return null;
	}
	@Override
	public boolean delete(int productid) {
		Session session = sessionfactory.getCurrentSession();
		Product product = session.get(Product.class,productid);
		
		if(product!=null) {
			session.delete(product);
			return true;
		}		
		  return false;
		  
	}
	@Override
	public Product update(int productid,String productname,int price,String Classification){
		Session session = sessionfactory.getCurrentSession();
		Product product = session.get(Product.class,productid);
		
		if(product!=null) {
			product.setProductName(productname);
			product.setPrice(price);
			product.setClassification(Classification);
			session.save(product);
			
		}
		return product;
	}
	@Override
	public Product select(int productid) {
		Session session = sessionfactory.getCurrentSession();
		Product product = session.get(Product.class,productid);			
		return product;
	}
	
	@Override
	public List<Product> selectAll() {
		Session session = sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product", Product.class);
		return query.list();
	}
	
	@Override
	public List<Product> selectwhere(int max,int min) {
		Session session = sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where price between :xxx and :ooo", Product.class);
		query.setParameter("xxx",min);
		query.setParameter("ooo",max);
		return query.list();
	}

	@Override
	public Object count() {
		Session session = sessionfactory.getCurrentSession();
		String hql = "select count(*) from Product" ;
		   Object count=session.createQuery(hql).uniqueResult();     //uniqueResult()方法返回Object型別
        
		return count;
	}

	@Override
	public Object countwhere(int max,int min) {
		Session session = sessionfactory.getCurrentSession();
		Query<Object> query =  session.createQuery("select count(*) from Product where price between :xxx and :ooo");
		query.setParameter("xxx",min);
		query.setParameter("ooo",max);
		Object count2  = query.uniqueResult();
		return count2;
	}
	@Override
	public boolean checkLogin(String username, String password) {
		Session session = sessionfactory.getCurrentSession();
		Query<Object> query = session.createQuery("from Users where userName=?1 and userPassword=?2");		
		query.setParameter(1, username);
		query.setParameter(2, password);
		
		return query.list().isEmpty()?false:true;
		
	}
	
	
	@Override
	public List<Product> selectclass(String Classification) {
		Session session = sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where  Classification like ?1",Product.class);
		query.setParameter(1,"%"+Classification);
		return query.list();
	}
    
	@Override
	public Object countclass(String Classification) {
		Session session = sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*)  from Product where  Classification like ?1");
		query.setParameter(1,"%"+Classification);	
		Object count3  = query.uniqueResult();
		return count3;
	}
}