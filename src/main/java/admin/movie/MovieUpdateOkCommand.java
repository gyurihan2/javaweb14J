package admin.movie;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;

public class MovieUpdateOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idx = request.getParameter("idx") == null ? "" :request.getParameter("idx");
		String title = request.getParameter("title") == null ? "" :request.getParameter("title");
		String openDate = request.getParameter("openDate") == null ? "" :request.getParameter("openDate");
		String director = request.getParameter("director") == null ? "" :request.getParameter("director");
		String actor = request.getParameter("actor") == null ? "" :request.getParameter("actor");
		String content = request.getParameter("content") == null ? "" :request.getParameter("content");
		String nation = request.getParameter("nation") == null ? "" :request.getParameter("nation");
		String grade = request.getParameter("grade") == null ? "" :request.getParameter("grade");
		int playTime = request.getParameter("playTime") == null ? 0 : Integer.parseInt(request.getParameter("playTime"));
		String mainImg=request.getParameter("mainImg") == null ? "" :request.getParameter("mainImg");
		String[] genreArr = request.getParameterValues("genre");
		
		String genreStr ="";
		if(genreArr != null) {
			for(String temp : genreArr) genreStr += temp+"/";
			genreStr = genreStr.substring(0,genreStr.length()-1);
		}
		
		MovieVO vo = new MovieVO();
		
		vo.setIdx(idx);
		vo.setTitle(title);
		vo.setPlayTime(playTime);
		vo.setOpenDate(openDate);
		vo.setDirector(director);
		vo.setActor(actor);
		vo.setContent(content);
		vo.setNation(nation);
		vo.setGenre(genreStr);
		vo.setGrade(grade);
		vo.setMainImg(mainImg);
		
		MovieDAO dao = new MovieDAO();
		
		int res = dao.setMovieUpdateOk(vo);
		
		if(res == 1) request.setAttribute("msg", "수정되었습니다.");
		else request.setAttribute("msg", "수정 실패.");
		
		request.setAttribute("url", request.getContextPath()+"/MovieDetailPage.ad?idx="+idx);
		
	}

}
