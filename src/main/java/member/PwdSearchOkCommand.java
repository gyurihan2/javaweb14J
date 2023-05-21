package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PwdSearchOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getMemberMidChk(mid);
		
		if(vo == null) {
			response.getWriter().write("0");
		}
		else if(vo.getEmail().equals(email)) {
			response.getWriter().write("1");
		}

	}

}
