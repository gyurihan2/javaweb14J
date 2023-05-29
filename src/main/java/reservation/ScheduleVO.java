package reservation;

public class ScheduleVO {
	private int idx, theaterIdx, screenOrder, seat;
	private String movieIdx, playDate,startTime;
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
	public int getSeat() {
		return seat;
	}
	public void setSeat(int seat) {
		this.seat = seat;
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
	@Override
	public String toString() {
		return "ScheduleVO [idx=" + idx + ", theaterIdx=" + theaterIdx + ", screenOrder=" + screenOrder + ", seat=" + seat
				+ ", movieIdx=" + movieIdx + ", playDate=" + playDate + ", startTime=" + startTime + "]";
	}
	
	
	
}
