package reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MovieSeatChkCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int scheduleIdx = request.getParameter("scheduleIdx") == null ? 0 : Integer.parseInt(request.getParameter("scheduleIdx"));
		
		ReservationDAO dao = new ReservationDAO();
		int res = dao.getMovieSeatChk(scheduleIdx);
		
		response.getWriter().write(res+"");

	}

}
