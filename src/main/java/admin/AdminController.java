package admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.movie.MovieDeleteOkCommand;
import admin.movie.MovieDetailPageCommand;
import admin.movie.MovieInsertOkCommand;
import admin.movie.MovieListPageCommand;
import admin.movie.MovieMgmtPageCommand;
import admin.movie.MovieRangeDeleteOkCommand;
import admin.movie.MovieUpdateOkCommand;
import admin.schedule.ScheduleDetailPageCommand;
import admin.schedule.ScheduleInsertOkCommand;
import admin.schedule.ScheduleMgmtPageCommand;
import admin.schedule.ScheduleTheaterChkPageCommand;
import admin.schedule.ScheduleTheaterCommand;
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
		
		//  보안 처리
		if(sLevel != 100) {
			request.setAttribute("url", request.getContextPath());
			request.setAttribute("msg", "관리자 전용 페이지 입니다.");
			viewPage = "/include/message.jsp";
		}
		// admin home화면
		else if(com.equals("/MainPage")) {
			viewPage += "/mainPage.jsp";
		}
		//
		// 상영관 관리
		//
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
		//
		// 영화 관리
		//
		//영화 관리 메인 페이지
		else if(com.equals("/MovieMgmtPage")) {
			command= new MovieMgmtPageCommand();
			command.execute(request, response);
			viewPage += "/movieList/movieMgmtPage.jsp";
		}
		// 영화 추가
		else if(com.equals("/MovieInsertOk")) {
			command= new MovieInsertOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// 영화 삭제 (ajax)
		else if(com.equals("/MovieDeleteOk")) {
			command= new MovieDeleteOkCommand();
			command.execute(request, response);
			return;
		}
		// 영화 일괄 삭제 (ajax)
		else if(com.equals("/MovieRangeDeleteOk")) {
			command= new MovieRangeDeleteOkCommand();
			command.execute(request, response);
			return;
		}
		// 영화 상세보기
		else if(com.equals("/MovieDetailPage")) {
			command= new MovieDetailPageCommand();
			command.execute(request, response);
			viewPage += "/movieList/movieDetailPage.jsp";
		}
		// 영화 리스트 보기
		else if(com.equals("/MovieListPage")) {
			command= new MovieListPageCommand();
			command.execute(request, response);
			viewPage += "/movieList/movieListPage.jsp";
		}
		// 영화 수정 처리
		else if(com.equals("/MovieUpdateOk")) {
			command= new MovieUpdateOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		//
		// 영화 상영 일정
		//
		// 영화 일정 관리 페이지
		else if(com.equals("/ScheduleMgmtPage")) {
			command= new ScheduleMgmtPageCommand();
			command.execute(request, response);
			viewPage += "/schedule/scheduleMgmtPage.jsp";
		}
		// 상영관 조회 페이지
		else if(com.equals("/ScheduleTheater")) {
			command= new ScheduleTheaterCommand();
			command.execute(request, response);
			viewPage += "/schedule/scheduleTheaterPage.jsp";
		}
		// 영화일정 추가
		else if(com.equals("/ScheduleInsertOk")) {
			command= new ScheduleInsertOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// 영화일정 상세 확인(모든 상영관)
		else if(com.equals("/ScheduleDetailPage")) {
			command= new ScheduleDetailPageCommand();
			command.execute(request, response);
			viewPage += "/schedule/scheduleDetailPage.jsp";
		}
		// 영화일정 상세 확인(선택한 상영관)
		else if(com.equals("/ScheduleTheaterChkPage")) {
			command= new ScheduleTheaterChkPageCommand();
			command.execute(request, response);
			viewPage += "/schedule/ScheduleTheaterChkPage.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
