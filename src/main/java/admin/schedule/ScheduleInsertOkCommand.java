package admin.schedule;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;

public class ScheduleInsertOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String startDate = request.getParameter("startDate") == null ? "" : request.getParameter("startDate");
		String endtDate = request.getParameter("endtDate") == null ? "" : request.getParameter("endtDate");
		int theaterIdx = request.getParameter("theaterIdx") == "" ? 0 : Integer.parseInt(request.getParameter("theaterIdx"));
		String movieIdx = request.getParameter("movieIdx") == null ? "" : request.getParameter("movieIdx");
		String[] orderArr = request.getParameterValues("order");
		
		// 날짜 차이 계산
		Date fmt1=null;
		long diffDay =-1;
		
		try {
			fmt1 = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
			Date fmt2 = new SimpleDateFormat("yyyy-MM-dd").parse(endtDate);
			diffDay = (fmt2.getTime() - fmt1.getTime())/(24*60*60*1000);
		} catch (ParseException e) {
			System.out.println("schedule.ScheduleInsertOkCommand SimpleDateFormat 변환 에러\n");
			e.printStackTrace();
		}
		
		
		ScheduleVO vo = null;
		ScheduleDAO dao = null;
		if(orderArr != null && diffDay > -1) {
			vo = new ScheduleVO();
			dao = new ScheduleDAO();
			
			vo.setTheaterIdx(theaterIdx);
			vo.setMovieIdx(movieIdx);
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(fmt1);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			for(int i=0; i<=diffDay; i++) {
				String strDate = sdf.format(cal.getTime());
				cal.add(Calendar.DATE,1);
				
				vo.setPlayDate(strDate);
				
				int order=0;
				for(String startTime : orderArr) {
					vo.setScreenOrder(++order);
					vo.setStartTime(startTime);
					dao.setScheduleInsertOk(vo);
				}
			}
			request.setAttribute("msg", "일정 등록 완료");
			
		}
		else {
			request.setAttribute("msg", "일정 등록 실패");
		}
		
		request.setAttribute("url", request.getContextPath()+"/ScheduleMgmtPage.ad");

	}

}
