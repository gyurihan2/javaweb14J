package reservation;

public class TheaterVO {
	private int idx, price,seat;
	private String thema,work,name,regDate,modifyDate;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSeat() {
		return seat;
	}
	public void setSeat(int seat) {
		this.seat = seat;
	}
	public String getThema() {
		return thema;
	}
	public void setThema(String thema) {
		this.thema = thema;
	}
	public String getWork() {
		return work;
	}
	public void setWork(String work) {
		this.work = work;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	@Override
	public String toString() {
		return "TheaterVO [idx=" + idx + ", price=" + price + ", seat=" + seat + ", thema=" + thema + ", work=" + work
				+ ", name=" + name + ", regDate=" + regDate + ", modifyDate=" + modifyDate + "]";
	}
	
	
	
	
	

}
