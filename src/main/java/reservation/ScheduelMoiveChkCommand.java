package reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

public class ScheduelMoiveChkCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String playDate = request.getParameter("playDate") == null ? "": request.getParameter("playDate");
		
		ReservationDAO dao = new ReservationDAO();
		
		JSONArray jsonMovieList = dao.getScheduleMoive(playDate);
		
		response.getWriter().write(jsonMovieList.toString());
	}

}
