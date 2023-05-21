package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.mem")
public class MemberController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberInterface command = null;
		String viewPage = "/WEB-INF/homePage/member";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		
		// 로그인 페이지
		if(com.equals("/LoginPage")) {
			viewPage += "/loginPage.jsp";
		}
		// 회원 가입 페이지
		else if(com.equals("/SignUpPage")) {
			viewPage += "/signUpPage.jsp";
		}
		// 아이디 중복 체크
		else if(com.equals("/SignUpIdChk")) {
			command = new SignUpIdChkCommand();
			command.execute(request, response);
			viewPage += "/signUpIdChk.jsp";
		}
		// 닉네임 중복 체크
		else if(com.equals("/SignUpNickNameChk")) {
			command = new SignUpNickNameChkCommand();
			command.execute(request, response);
			viewPage += "/signUpNickNameChk.jsp";
		}
		// 회원가입 처리
		else if(com.equals("/MemberJoinOk")) {
			command = new MemberJoinOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// 로그인 처리
		else if(com.equals("/LoginOk")) {
			command = new LoginOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// 아이디 찾기 페이지
		else if(com.equals("/IdSearchPage")) {
			viewPage += "/idSearchPage.jsp";
		}
		// 아이디 찾기 처리
		else if(com.equals("/IdSearchOk")) {
			command = new IdSearchOkCommand();
			command.execute(request, response);
			viewPage += "/idSearchPage.jsp?sw=1";
		}
		// 비밀번호 찾기 페이지
		else if(com.equals("/PwdSearchPage")) {
			viewPage += "/pwdSearchPage.jsp";
		}
		// 비밀번호 찾기 처리(aJax)
		else if(com.equals("/PwdSearchOk")) {
			command = new PwdSearchOkCommand();
			command.execute(request, response);
			return;
		}
		// 비밀번호 변경 처리(aJax)
		else if(com.equals("/PwdChangeOk")) {
			command = new PwdChangeOkCommand();
			command.execute(request, response);
			return;
		}
		// 로그아웃 처리
		else if(com.equals("/LoginOutOk")) {
			command = new LoginOutOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		// myPage 페이지
		else if(com.equals("/MyPageMain")) {
			command = new MyPageMainCommand();
			command.execute(request, response);
			viewPage += "/myPageMain.jsp";
		}
	
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
