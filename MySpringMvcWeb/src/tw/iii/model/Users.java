package tw.iii.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "users")
public class Users {
	
	@Id @Column(name = "USERID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int usersId;
	@Column(name = "USERNAME")
	private String userName;
	@Column(name = "USERPASSWORD")
	private String userPassword;
	public int getUsersId() {
		return usersId;
	}
	public void setUsersId(int userId) {
		this.usersId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public Users() {
		
	}
	public Users(String userName,String userPassword) {
		this.userName = userName;
		this.userPassword = userPassword;
	}
	
}
