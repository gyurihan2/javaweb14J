package member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.movie.MovieDAO;
import admin.movie.MovieVO;

public class MainHomepageCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date(System.currentTimeMillis());
		
		String today =  formatter.format(date);
		
		MovieDAO dao = new MovieDAO();
		ArrayList<MovieVO> vos = dao.getMainPageMovie(today);
		
		String mainImagesStr="";
		String titleStr="";
		if(vos !=null) {
			
			for(MovieVO vo : vos) {
				mainImagesStr += vo.getMainImg()+"/";
				titleStr += vo.getTitle()+"/";
			}
			
			mainImagesStr = mainImagesStr.substring(0,mainImagesStr.length()-1);
			titleStr = titleStr.substring(0,titleStr.length()-1);
		}
		
		
		request.setAttribute("mainImagesStr", mainImagesStr);
		request.setAttribute("titleStr", titleStr);
		request.setAttribute("vos", vos);
	}

}
