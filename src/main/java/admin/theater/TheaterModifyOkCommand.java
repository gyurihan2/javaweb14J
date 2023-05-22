package admin.theater;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;

public class TheaterModifyOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String name = request.getParameter("name") == null ? "" :request.getParameter("name");
		String thema = request.getParameter("thema") == null ? "" :request.getParameter("thema");
		int seat = request.getParameter("seat") == null ? 0 : Integer.parseInt(request.getParameter("seat"));
		int price = request.getParameter("price") == null ? 15000 : Integer.parseInt(request.getParameter("price"));
		String work = request.getParameter("work") == null ? "" :request.getParameter("work");
		
		TheaterVO vo =  new TheaterVO();
		vo.setIdx(idx);
		vo.setName(name);
		vo.setThema(thema);
		vo.setSeat(seat);
		vo.setPrice(price);
		vo.setWork(work);
		
		TheaterDAO dao = new TheaterDAO();
		String res = dao.setTheaterUpdateOk(vo);
		
		response.getWriter().write(res);
		
		
	}

}
