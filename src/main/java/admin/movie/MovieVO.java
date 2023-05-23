package admin.movie;

public class MovieVO {
	private int totalView,playTime;
	private float rating;
	private String idx, mainImg,images,imgFName,title,genre,openDate,grade,nation,director, actor, content;
	public int getTotalView() {
		return totalView;
	}
	public void setTotalView(int totalView) {
		this.totalView = totalView;
	}
	public int getPlayTime() {
		return playTime;
	}
	public void setPlayTime(int playTime) {
		this.playTime = playTime;
	}
	public float getRating() {
		return rating;
	}
	public void setRating(float rating) {
		this.rating = rating;
	}
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getMainImg() {
		return mainImg;
	}
	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}
	public String getImages() {
		return images;
	}
	public void setImages(String images) {
		this.images = images;
	}
	public String getImgFName() {
		return imgFName;
	}
	public void setImgFName(String imgFName) {
		this.imgFName = imgFName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "MovieVO [totalView=" + totalView + ", playTime=" + playTime + ", rating=" + rating + ", idx=" + idx
				+ ", mainImg=" + mainImg + ", images=" + images + ", imgFName=" + imgFName + ", title=" + title + ", genre="
				+ genre + ", openDate=" + openDate + ", grade=" + grade + ", nation=" + nation + ", director=" + director
				+ ", actor=" + actor + ", content=" + content + "]";
	}
}
