package reservation;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReservationPageCommand implements ReservationInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] reservationDate = new String[7];
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for(int i=0; i<7; i++) {
			reservationDate[i]=sdf.format(cal.getTime());
			cal.add(Calendar.DATE, 1);
		}
		
		request.setAttribute("reservationDate", reservationDate);
		 
	}

}
