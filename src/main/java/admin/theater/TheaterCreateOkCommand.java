package admin.theater;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;

public class TheaterCreateOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name") == null ? "" :  request.getParameter("name");
		String thema = request.getParameter("thema") == null ? "" :  request.getParameter("thema");
		int seat = request.getParameter("seat") == null ? 0 : Integer.parseInt(request.getParameter("seat"));
		int price = request.getParameter("price") == null ? 0 : Integer.parseInt(request.getParameter("price"));

		TheaterDAO dao = new TheaterDAO();
		
		TheaterVO vo = new TheaterVO();
		vo.setName(name);
		vo.setThema(thema);
		vo.setSeat(seat);
		vo.setPrice(price);
		
		String res = dao.setTheaterCreateOk(vo);
		
		response.getWriter().write(res);
	}

}
