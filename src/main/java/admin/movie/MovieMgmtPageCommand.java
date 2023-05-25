package admin.movie;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;

public class MovieMgmtPageCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MovieDAO dao = new MovieDAO();
		// 페이징 처리
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		int totRecCnt = dao.getListCnt();
		int totPage = (totRecCnt % pageSize)== 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize)+1;
		int startIndexNo = (pag-1)*pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		//블록 페이징 처리
		int blockSize=5;
		int curBlock = (pag-1) / blockSize;
		int lastBlock = (totPage-1)/blockSize;
		ArrayList<MovieVO> vos = new ArrayList<>();
		
		vos = dao.getMovieList(startIndexNo,pageSize);
		
		request.setAttribute("vos", vos);

		request.setAttribute("pag", pag); // 현재 페이지
		request.setAttribute("totPage", totPage); // 총 페이지
		request.setAttribute("pageSize", pageSize); // 한페이지에 표시할 레코드수
		request.setAttribute("curScrStartNo", curScrStartNo); // 현재 화면에 표시할 시작 번호를 구한다.

		request.setAttribute("blockSize", blockSize); // 블록 사이즈
		request.setAttribute("curBlock", curBlock); // 현재 블록 위치
		request.setAttribute("lastBlock", lastBlock); // 마지막 블록 위치

	}

}
