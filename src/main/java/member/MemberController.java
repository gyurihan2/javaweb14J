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
	
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
