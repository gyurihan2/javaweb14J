package admin.schedule;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;
import admin.theater.TheaterVO;

public class ScheduleTheaterCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String startDate = request.getParameter("startDate") == null ? "" : request.getParameter("startDate");
		String endDate = request.getParameter("endDate") == null ? "" : request.getParameter("endDate");
		
		ScheduleDAO dao = new ScheduleDAO();
		
		ArrayList<TheaterVO> vos = dao.getScheduleTheater(startDate,endDate);
		
		request.setAttribute("vos", vos);
		
	}

}
