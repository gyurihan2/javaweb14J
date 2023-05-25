package admin.schedule;

public class CalendarVO {
	String theaterName, playDate;

	public String getTheaterName() {
		return theaterName;
	}

	public void setTheaterName(String theaterName) {
		this.theaterName = theaterName;
	}

	public String getPlayDate() {
		return playDate;
	}

	public void setPlayDate(String playDate) {
		this.playDate = playDate;
	}

	@Override
	public String toString() {
		return "CalendarVO [theaterName=" + theaterName + ", playDate=" + playDate + "]";
	}

	
}
