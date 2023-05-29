package reservation;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MainHomepageCommand;

@WebServlet("*.res")
public class ReservationController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ReservationInterface command = null;
		String viewPage = "/WEB-INF/homePage/reservation";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		
		// 메인 홈페이지
		if(com.equals("/ReservationPage")) {
			command = new ReservationPageCommand();
			command.execute(request, response);
			viewPage +="/reservationPage.jsp";
		}
		else if(com.equals("/ScheduelMoiveChk")) {
			command = new ScheduelMoiveChkCommand();
			command.execute(request, response);
			return;
		}
		// 예매하기 버튼 클릭(회차/시간 확인)
		else if(com.equals("/ReservationMoive")) {
			command = new ReservationMoiveCommand();
			command.execute(request, response);
			viewPage +="/reservationMoive.jsp";
		}
		// 예매하기 페이지 -> 회차 클릭시 남은 좌석수 확인
		else if(com.equals("/MovieSeatChk")) {
			command = new MovieSeatChkCommand();
			command.execute(request, response);
			return;
		}
		// 예매하기 페이지 -> 회차 클릭시 남은 좌석수 확인
		else if(com.equals("/SeatSelectPage")) {
			command = new SeatSelectPageCommand();
			command.execute(request, response);
			viewPage +="/seatSelectPage.jsp";
		}
	
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
