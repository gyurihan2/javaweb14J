package member;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class MemberJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String[] pwds = request.getParameterValues("pwd");
		String pwd = pwds[0];
		String nickName = request.getParameter("nickName") == null ? "" : request.getParameter("nickName");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String identiNum=request.getParameter("identiNum") == null ? "" : request.getParameter("identiNum");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		String gender = request.getParameter("gender") == null ? "" : request.getParameter("gender");
		String birthday = request.getParameter("birthday") == null ? "" : request.getParameter("birthday");
		String phone = request.getParameter("phone") == null ? "": request.getParameter("phone");
		String address= request.getParameter("address1") == null ? "" : request.getParameter("address1");
		
		MemberDAO dao = new MemberDAO();
		
		// 중복처리 검사
		MemberVO vo = dao.getMemberMidChk(mid);
		if(vo != null) {
			request.setAttribute("msg", "이미 사용중인 아이디있습니다.");
			request.setAttribute("url", request.getContextPath()+"/MemberJoin.mem");
			return;
		}
		
		if(dao.getMemberNickNameChk(nickName) == 0) {
			request.setAttribute("msg", "이미 사용중인 닉네임이있습니다.");
			request.setAttribute("url", request.getContextPath()+"/MemberJoin.mem");
			return;
		}
		
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,8);
		
		pwd = salt +pwd;
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		// 저장
		vo = new MemberVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setNickName(nickName);
		vo.setSalt(salt);
		vo.setName(name);
		vo.setBirthday(birthday);
		vo.setIdentiNum(identiNum);
		vo.setEmail(email);
		vo.setGender(gender);
		vo.setPhone(phone);
		vo.setAddress(address);
		
		int res = dao.setMemberJoinOk(vo);
		
		if(res == 1) request.setAttribute("msg", "회원가입 완료");
		else request.setAttribute("msg", "회원가입 실패");
		
		
		
		request.setAttribute("url", request.getContextPath()+"/LoginPage.mem");

	}

}
