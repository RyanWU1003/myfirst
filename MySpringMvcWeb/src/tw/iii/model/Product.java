package tw.iii.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;



@Entity
@Table(name="NewProduct")
public class Product {
	
	@Id @Column(name="productID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private int productID;
    
    @Column(name="productName")
    private String productName;
    
    @Column(name="price")
    private int price;
    
    
    @Column(name="Classification")
    private String Classification;
	
	public String getClassification() {
		return Classification;
	}


	public void setClassification(String classification) {
		Classification = classification;
	}

	
	
	public int getProductID() {
		return productID;
	}


	public void setProductID(int productID) {
		this.productID = productID;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public Product() {
		
	}
	
     public Product(String productname,int price) {
		this.productName=productname;
		this.price = price;    	 
	}
	
	

}
