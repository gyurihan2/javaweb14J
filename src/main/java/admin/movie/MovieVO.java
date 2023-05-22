package admin.movie;

public class MovieVO {
	private int idx, totalView;
	private float rating;
	private String posterImg,images,title,genre,playTime,openDate,director, actor, content;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getTotalView() {
		return totalView;
	}
	public void setTotalView(int totalView) {
		this.totalView = totalView;
	}
	public float getRating() {
		return rating;
	}
	public void setRating(float rating) {
		this.rating = rating;
	}
	public String getPosterImg() {
		return posterImg;
	}
	public void setPosterImg(String posterImg) {
		this.posterImg = posterImg;
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
	public String getPlayTime() {
		return playTime;
	}
	public void setPlayTime(String playTime) {
		this.playTime = playTime;
	}
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
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
	public String getImages() {
		return images;
	}
	public void setImages(String images) {
		this.images = images;
	}
	
	@Override
	public String toString() {
		return "MovieVO [idx=" + idx + ", totalView=" + totalView + ", rating=" + rating + ", posterImg=" + posterImg
				+ ", images=" + images + ", title=" + title + ", genre=" + genre + ", playTime=" + playTime + ", openDate="
				+ openDate + ", director=" + director + ", actor=" + actor + ", content=" + content + "]";
	}
	
	
}
