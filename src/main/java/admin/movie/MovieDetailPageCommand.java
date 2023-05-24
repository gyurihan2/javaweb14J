package admin.movie;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;

public class MovieDetailPageCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idx = request.getParameter("idx") == null ? "" : request.getParameter("idx");
		
		MovieDAO dao = new MovieDAO();
		
		MovieVO vo = dao.getMovieDetail(idx);
		
		request.setAttribute("vo", vo);
		
	}

}
