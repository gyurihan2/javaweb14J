package admin.movie;

import java.io.File;
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
		
		
		MovieVO vo = dao.getMovieDetail(idx);
		String res = dao.setMovieDeleteOk(idx);
		
		String temp[] = vo.getImgFName().split("/");
		String realPath = request.getServletContext().getRealPath("/images/movieChart/");
		
		// 업로드 된 파일 삭제
		for(String fPath : temp) {
			File fileDelete = new File(realPath+fPath);
			if(fileDelete.exists()) {
				fileDelete.delete();
			}
		}
		
		response.getWriter().write(res);
	}

}
