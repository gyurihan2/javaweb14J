package reservation;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReservationMoiveCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String playDate = request.getParameter("playDate") == null ?"" :  request.getParameter("playDate");
		String theaterName = request.getParameter("theaterName") == null ?"" :  request.getParameter("theaterName");
		String title = request.getParameter("title") == null ?"" :  request.getParameter("title");
		
		ReservationDAO dao = new ReservationDAO();
		
		ArrayList<ScheduleVO> vos = dao.getScheduleMovieOrder(playDate,theaterName,title);
		
		request.setAttribute("vos", vos);
	}

}
