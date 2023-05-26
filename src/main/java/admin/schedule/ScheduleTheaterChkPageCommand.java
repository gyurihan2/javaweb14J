package admin.schedule;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;

public class ScheduleTheaterChkPageCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String theaterName = request.getParameter("theaterName") == null ? "" : request.getParameter("theaterName");
		String playDate = request.getParameter("playDate") == null ? "" : request.getParameter("playDate");
		
		ScheduleDAO dao = new ScheduleDAO();
		ArrayList<ScheduleVO> vos = dao.getScheduleDetailPage(theaterName, playDate);
		
		request.setAttribute("vos", vos);
		
	}

}
