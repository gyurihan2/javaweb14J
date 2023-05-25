package admin.schedule;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminInterface;

public class ScheduleDetailPageCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ymd= request.getParameter("ymd") == null ? "" : request.getParameter("ymd");
		
		String[] ymdArr = ymd.split("-");
		
		int mm = Integer.parseInt(ymdArr[1]);
		if(mm <10) ymdArr[1] = "0"+ ymdArr[1];
		
		ymd="";
		for(String temp : ymdArr) ymd += temp+"-";
		ymd = ymd.substring(0,ymd.length()-1);
		
		// ymd에 해당하는 날의 상영관 정보
		ScheduleDAO dao = new ScheduleDAO();
		ArrayList<ScheduleVO> vos = dao.getScheduleDetailPage(ymd);
		
		if(vos != null) request.setAttribute("vos", vos);
		
		request.setAttribute("url", request.getContextPath()+"/ScheduleMgmtPage.ad");

	}

}
