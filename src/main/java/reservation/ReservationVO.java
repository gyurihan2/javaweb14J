package reservation;

public class ReservationVO {
	private int idx, scheduleIdx,seatCnt;
	private String memberMid,seatInfo,reserDate;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getScheduleIdx() {
		return scheduleIdx;
	}
	public void setScheduleIdx(int scheduleIdx) {
		this.scheduleIdx = scheduleIdx;
	}
	public int getSeatCnt() {
		return seatCnt;
	}
	public void setSeatCnt(int seatCnt) {
		this.seatCnt = seatCnt;
	}
	public String getMemberMid() {
		return memberMid;
	}
	public void setMemberMid(String memberMid) {
		this.memberMid = memberMid;
	}
	public String getSeatInfo() {
		return seatInfo;
	}
	public void setSeatInfo(String seatInfo) {
		this.seatInfo = seatInfo;
	}
	public String getReserDate() {
		return reserDate;
	}
	public void setReserDate(String reserDate) {
		this.reserDate = reserDate;
	}
	@Override
	public String toString() {
		return "ReservationVO [idx=" + idx + ", scheduleIdx=" + scheduleIdx + ", seatCnt=" + seatCnt + ", memberMid="
				+ memberMid + ", seatInfo=" + seatInfo + ", reserDate=" + reserDate + "]";
	}

}
