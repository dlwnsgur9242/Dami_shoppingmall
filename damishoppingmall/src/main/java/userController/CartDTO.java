package userController;

//DTO: Data Transfer Object, 계층 간의 데이터를 교환하는 역할

public class CartDTO {
	private String name;	//과자명
	private int price;		//가격
	private int count;		//수량
	
	public CartDTO() {}

	public CartDTO(String name, int price, int count) {
		super();
		this.name = name;
		this.price = price;
		this.count = count;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getcount() {
		return count;
	}

	public void setcount(int count) {
		this.count = count;
	}
	
}