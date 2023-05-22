package admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.theater.TheaterCreateOkCommand;
import admin.theater.TheaterDeleteOkCommand;
import admin.theater.TheaterMgmtPageCommand;
import admin.theater.TheaterModifyOkCommand;

@WebServlet("*.ad")
public class AdminController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInterface command = null;
		String viewPage = "/WEB-INF/adminPage";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		
		HttpSession session = request.getSession();
		// 관리자 Level = 100
		int sLevel = session.getAttribute("sLevel") == null ? 0: (int)session.getAttribute("sLevel");
		
		if(sLevel != 100) {
			request.setAttribute("url", request.getContextPath());
			request.setAttribute("msg", "관리자 전용 페이지 입니다.");
			viewPage = "/include/message.jsp";
		}
		// admin home화면
		else if(com.equals("/MainPage")) {
			viewPage += "/mainPage.jsp";
		}
		// 상영관 관리 페이지
		else if(com.equals("/TheaterMgmtPage")) {
			command= new TheaterMgmtPageCommand();
			command.execute(request, response);
			viewPage += "/theater/theaterMgmtPage.jsp";
		}
		// 상영관 생성 처리
		else if(com.equals("/TheaterCreateOk")) {
			command= new TheaterCreateOkCommand();
			command.execute(request, response);
			return;
		}
		// 상영관 수정 처리
		else if(com.equals("/TheaterModifyOk")) {
			command= new TheaterModifyOkCommand();
			command.execute(request, response);
			return;
		}
		// 상영관 삭제 처리
		else if(com.equals("/TheaterDeleteOk")) {
			command= new TheaterDeleteOkCommand();
			command.execute(request, response);
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
