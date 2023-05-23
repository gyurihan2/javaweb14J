package admin.movie;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;

public class MovieDeleteOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//영화 코드
		String idx = request.getParameter("idx") == null ? "" : request.getParameter("idx");
		
		MovieDAO dao = new MovieDAO();
		
		String res = dao.setMovieDeleteOk(idx);
		
		response.getWriter().write(res);
	}

}
