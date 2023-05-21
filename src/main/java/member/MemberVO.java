package member;

public class MemberVO {
	private int idx,level,point,totPoint;
	private String mid, pwd, salt, name, nickName, identiNum, gender,birthday,
					phone, address, email, startDate, lastLogin, userDel;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getTotPoint() {
		return totPoint;
	}
	public void setTotPoint(int totPoint) {
		this.totPoint = totPoint;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIdentiNum() {
		return identiNum;
	}
	public void setIdentiNum(String identiNum) {
		this.identiNum = identiNum;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getLastLogin() {
		return lastLogin;
	}
	public void setLastLogin(String lastLogin) {
		this.lastLogin = lastLogin;
	}
	public String getUserDel() {
		return userDel;
	}
	public void setUserDel(String userDel) {
		this.userDel = userDel;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	@Override
	public String toString() {
		return "MemberVO [idx=" + idx + ", level=" + level + ", point=" + point + ", totPoint=" + totPoint + ", mid=" + mid
				+ ", pwd=" + pwd + ", salt=" + salt + ", name=" + name + ", nickName=" + nickName + ", identiNum=" + identiNum
				+ ", gender=" + gender + ", birthday=" + birthday + ", phone=" + phone + ", address=" + address + ", email="
				+ email + ", startDate=" + startDate + ", lastLogin=" + lastLogin + ", userDel=" + userDel + "]";
	}
	
	
	
	
	
	
}
