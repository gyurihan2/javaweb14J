package admin.theater;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;

public class TheaterMgmtPageCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TheaterDAO dao = new TheaterDAO();
		
		ArrayList<TheaterVO> vos = dao.getTheaterList();
		
		request.setAttribute("vos", vos);
	}

}
