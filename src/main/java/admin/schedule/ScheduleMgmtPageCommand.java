package admin.schedule;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.AdminInterface;

public class ScheduleMgmtPageCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
		
		// 화면에 보여줄 해당 년/월을 세팅
		Calendar calView = Calendar.getInstance();
		int yy = request.getParameter("yy") == null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
		// 0: 1월 1:2월 ..... 11:12월
		int mm = request.getParameter("mm") == null ? calView.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
		
		if(mm < 0 ) {
			yy--;
			mm =11;
		}
		if(mm > 11 ) {
			yy++;
			mm =0;
		}
		
		// 해당 '년/월'의 1일 기준으로 날짜를 셋팅처리한다.
		calView.set(yy, mm,1);
		
		// 앞에서 셋팅한 해당 '년/월' 1일에 해당하는 요일값 숫자로 가져온다.( 1:일 2:월 .... 7:토)
		int startWeek = calView.get(Calendar.DAY_OF_WEEK);
		//System.out.println("해당월의 첫번째 1일의 요일을 숫자로 변환: " + startWeek);
		
		// 해당 년/월에 마직막 일자를 가져온다.
		int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);
		//System.out.println("해당월의 마지막 요일을 숫자로 변환: " + lastDay);
		
		
		//출력된 달력의 앞/뒷쪽의 빈공간에 해당월의 이전/다음의 날짜를 채워보자
		int prevYear=yy;
		int prevMonth= mm-1;
		
		int nextYear = yy;
		int nextMonth= mm+1;
		
		if(prevMonth == -1) {
			prevYear--;
			prevMonth=11;
		}
		if(nextMonth == 12) {
			nextYear++;
			prevMonth=0;
		}
		
		// 현재월의 이전월에 해당하는 마지막날짜를 구한다.
		Calendar calPre = Calendar.getInstance();
		calPre.set(prevYear, prevMonth,1);
		int preLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		// 현재월의 다음월에 해당하는 마지막날짜를 구한다.
		Calendar calNext = Calendar.getInstance();
		calNext.set(nextYear, nextMonth,1);
		int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);
		
		// 현재달의 전월/다음월의 날짜 표시
		request.setAttribute("prevYear", prevYear);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("preLastDay", preLastDay);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("nextStartWeek", nextStartWeek);
		
		
		// 화면에 보여줄 달력의 해당 내역(년/월/요일 ...) 저장소에 저장하여 보내준다.
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		
		//오늘 날짜
		request.setAttribute("toYear", toYear);
		request.setAttribute("toMonth", toMonth);
		request.setAttribute("toDay", toDay);
		
		// 해당 '년/월'에 존재하는 일정을 DB에서 가져온다.
		HttpSession session = request.getSession();
		String sMid = (String)session.getAttribute("sMid");
		
		String ym = "";
		
		// 2023 - 5 -> 2023 - 05월
		if((mm+1) < 10) {
			ym= yy+ "-0"+(mm+1);
		}
		else {
			ym = yy+"+"+(mm+1);
		}
		
		//ScheduleDAO dao = new ScheduleDAO();
		
		//ArrayList<ScheduleVO> vos =  dao.getSchedule(sMid,ym,0);
		
		//request.setAttribute("vos", vos);
	}

}
