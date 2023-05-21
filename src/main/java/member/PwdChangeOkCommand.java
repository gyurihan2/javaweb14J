package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class PwdChangeOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String chgPwd = request.getParameter("chgPwd") == null ? "" : request.getParameter("chgPwd");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberMidChk(mid);
		
		if(vo == null) return;
		
		SecurityUtil security = new SecurityUtil();
		chgPwd = security.encryptSHA256(vo.getSalt()+chgPwd);
		
		String res = dao.setPwdChange(mid,chgPwd);
		
		if(res.equals("1")) {
			response.getWriter().write("1");
		}
	}

}
