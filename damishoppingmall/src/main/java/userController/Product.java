package userController;

/*product 데이터를 데이터베이스에 세팅하거나 가져오게 해주는 파일*/

public class Product {
	public String Name;
	public String Price;
	public String Img;
	//public String Imgpath;
	
	public String Name() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getPrice() {
		return Price;
	}
	public void setPrice(String price) {
		Price = price;
	}
	public String getImg() {
		return Img;
	}
	public void setImg(String img) {
		Img = img;
	}
	/*
	public String getImgpath() {
		return Imgpath;
	}
	public void setImgpath(String imgpath) {
		Imgpath = imgpath;
	}*/
}