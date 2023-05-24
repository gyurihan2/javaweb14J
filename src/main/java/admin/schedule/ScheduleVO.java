package admin.schedule;

public class ScheduleVO {
	private int idx,theaterIdx,screenOrder;
	private String movieIdx,playDate;
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
	@Override
	public String toString() {
		return "ScheduleVO [idx=" + idx + ", theaterIdx=" + theaterIdx + ", screenOrder=" + screenOrder + ", movieIdx="
				+ movieIdx + ", playDate=" + playDate + "]";
	}
	
	
	
}
