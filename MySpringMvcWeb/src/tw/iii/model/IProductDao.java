package tw.iii.model;

import java.util.List;

public interface IProductDao {
	public Product insert(Product PD);
	public Product select(int ProductID);
	public List<Product> selectAll();
	public List<Product> selectclass(String Classification);
	public boolean delete(int ProductID);
	public Object count();
	public List<Product> selectwhere(int max,int min) ;
	public Object countwhere(int max,int min);
	public boolean checkLogin(String username, String password);
	public Product update(int productid, String productname, int price, String Classification);
	public Object countclass(String Classification) ;
}
