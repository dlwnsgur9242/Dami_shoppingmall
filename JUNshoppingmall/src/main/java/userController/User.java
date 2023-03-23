package userController;

/*user 데이터를 데이터베이스에 세팅하거나 가져오게 해주는 파일*/

public class User {
	public String UserType;
	public String ID;
	public String PW;
	public String UserName;
	public String Email;
	public String Phone;
	public String Address;
	
	public String getUserType() {
		return UserType;
	}
	public void setUserType(String userType) {
		UserType = userType;
	}
	public String getID() {
		return ID;
	}
	public void setID(String id) {
		ID = id;
	}
	public String getPW() {
		return PW;
	}
	public void setPW(String passwd) {
		PW = passwd;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String name) {
		UserName = name;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getPhone() {
		return Phone;
	}
	public void setPhone(String phone) {
		 Phone = phone;
	}
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}
	
}