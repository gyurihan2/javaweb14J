package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberModifyOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		String birthday = request.getParameter("birthday") == null ? "" : request.getParameter("birthday");
		String phone = request.getParameter("phone") == null ? "": request.getParameter("phone");
		String address= request.getParameter("address1") == null ? "" : request.getParameter("address1");
		
		MemberVO vo = new MemberVO();
		vo.setMid(mid);
		vo.setName(name);
		vo.setEmail(email);
		vo.setBirthday(birthday);
		vo.setPhone(phone);
		vo.setEmail(email);
		vo.setAddress(address);
		
		MemberDAO dao = new MemberDAO();
		
		String res = dao.setMemberModifyOk(vo);
		
		response.getWriter().write(res);
	}

}
