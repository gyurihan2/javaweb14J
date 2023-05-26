package admin.schedule;

// 혼합
public class ScheduleVO {
	private int idx,theaterIdx,screenOrder,moviePlayTime,totalView;
	private String movieIdx,playDate,startTime,movieTitle,theatherName,movieMainImg,ymdTime;
	private float movieRating;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getTheaterIdx() {
		return theaterIdx;
	}
	public void setTheaterIdx(int theaterIdx) {
		this.theaterIdx = theaterIdx;
	}
	public int getScreenOrder() {
		return screenOrder;
	}
	public void setScreenOrder(int screenOrder) {
		this.screenOrder = screenOrder;
	}
	public int getMoviePlayTime() {
		return moviePlayTime;
	}
	public void setMoviePlayTime(int moviePlayTime) {
		this.moviePlayTime = moviePlayTime;
	}
	public int getTotalView() {
		return totalView;
	}
	public void setTotalView(int totalView) {
		this.totalView = totalView;
	}
	public String getMovieIdx() {
		return movieIdx;
	}
	public void setMovieIdx(String movieIdx) {
		this.movieIdx = movieIdx;
	}
	public String getPlayDate() {
		return playDate;
	}
	public void setPlayDate(String playDate) {
		this.playDate = playDate;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getMovieTitle() {
		return movieTitle;
	}
	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}
	public String getTheatherName() {
		return theatherName;
	}
	public void setTheatherName(String theatherName) {
		this.theatherName = theatherName;
	}
	public String getMovieMainImg() {
		return movieMainImg;
	}
	public void setMovieMainImg(String movieMainImg) {
		this.movieMainImg = movieMainImg;
	}
	public String getYmdTime() {
		return ymdTime;
	}
	public void setYmdTime(String ymdTime) {
		this.ymdTime = ymdTime;
	}
	public float getMovieRating() {
		return movieRating;
	}
	public void setMovieRating(float movieRating) {
		this.movieRating = movieRating;
	}
	@Override
	public String toString() {
		return "ScheduleVO [idx=" + idx + ", theaterIdx=" + theaterIdx + ", screenOrder=" + screenOrder + ", moviePlayTime="
				+ moviePlayTime + ", totalView=" + totalView + ", movieIdx=" + movieIdx + ", playDate=" + playDate
				+ ", startTime=" + startTime + ", movieTitle=" + movieTitle + ", theatherName=" + theatherName
				+ ", movieMainImg=" + movieMainImg + ", ymdTime=" + ymdTime + ", movieRating=" + movieRating + "]";
	}
	

}
