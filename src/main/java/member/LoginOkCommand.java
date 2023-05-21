package member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class LoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		String idSave = request.getParameter("idSave") == null ? "" : request.getParameter("idSave");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberMidChk(mid);
		
		if(vo == null  || vo.getUserDel().equals("OK")) {
			request.setAttribute("msg", "회원정보가 없습니다.");
			request.setAttribute("url", request.getContextPath()+"/LoginPage.mem");
			return;
		}
		
		String salt = vo.getSalt();
		pwd = salt + pwd;
		
		SecurityUtil security = new SecurityUtil();
		
		pwd = security.encryptSHA256(pwd);
		
		if(!pwd.equals(vo.getPwd())) {
			request.setAttribute("msg", "비밀번호를 확인하세요.");
			request.setAttribute("url", request.getContextPath()+"/LoginPage.mem");
			return;
		}
		
		// 로그인 성공
		
		// 로그인 시 세션 저장
		HttpSession session = request.getSession();
		session.setAttribute("sMid", mid);
		session.setAttribute("sNickName", vo.getNickName());
		session.setAttribute("sLevel", vo.getLevel());
		
		// 로그인 시 최종 접속일 수정
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String strNow = sdf.format(now);
		
		if(!strNow.equals(vo.getLastLogin().substring(0, 10))) dao.setLastLoginUpdate(mid,strNow);
		
		// 아이디 기억 처리(쿠키)
		//아이디 기억 체크가 되어있을경우 쿠키 생성
		if(idSave.equals("on")) {
			Cookie cIdSave = new Cookie("cIdSave",idSave);
			Cookie cMid = new Cookie("cMid",mid);
			cIdSave.setMaxAge(60*60*24*31);
			cMid.setMaxAge(60*60*24*31);
			cMid.setPath("/javaweb14J");
			cIdSave.setPath("/javaweb14J");
			response.addCookie(cIdSave);
			response.addCookie(cMid);
		}
		// 아이디 기억 체크 해제 시 쿠키 삭제
		else{
			Cookie[] cookies = request.getCookies();
			for(int i=0; i<cookies.length;i++) {
				if(cookies[i].getName().equals("cIdSave")) {
					cookies[i].setMaxAge(0);
					response.addCookie(cookies[i]);
				}
				else if(cookies[i].getName().equals("cMid")){
					cookies[i].setMaxAge(0);
					response.addCookie(cookies[i]);
				}
			}
		}
		
		
		request.setAttribute("msg", vo.getNickName() + "님 로그인 되었습니다.");
		request.setAttribute("url", request.getContextPath() + "/index.jsp");

	}

}
