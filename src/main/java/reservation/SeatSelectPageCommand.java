package reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SeatSelectPageCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int scheduleIdx = request.getParameter("scheduleIdx") == null ? -1 : Integer.parseInt(request.getParameter("scheduleIdx"));
		int totSeat = request.getParameter("totSeat") == null ? 0 : Integer.parseInt(request.getParameter("totSeat"));
		String theaterName = request.getParameter("theaterName") == null ? "" : request.getParameter("theaterName");
		
		ReservationDAO dao = new ReservationDAO();
		
		// 좌석 예약 여부 확인
		int[] seatArr = dao.getMovieSeatChk(scheduleIdx,totSeat);
		TheaterVO vo = dao.getMoviePice(theaterName);
		
		request.setAttribute("seatArr", seatArr);
		request.setAttribute("theaterVO", vo);
		
	}

}
