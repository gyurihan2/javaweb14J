package admin.movie;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.compiler.NewlineReductionServletWriter;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import admin.AdminInterface;

public class MovieRangeDeleteOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String movieIdxArr = request.getParameter("movieIdxArr");
		 
		 MovieDAO dao = new MovieDAO();
		 
		 //json처리(문자열 타입을 json타입으로 변환(Array))
		 JSONParser jsonParser = new JSONParser();
		 
		 try {
			Object obj = jsonParser.parse(movieIdxArr);
			JSONArray jsonArray = (JSONArray)obj;
			
			if(jsonArray.size() > 0) {
				for(int i=0; i<jsonArray.size(); i++){
          JSONObject jsonObj = (JSONObject)jsonArray.get(i);
          
          String idx = (String)jsonObj.get("idx");
          
          //삭제
          if(dao.setMovieDeleteOk(idx).equals("0")) {
          	// 삭제실패시 리턴(일부 삭제)
          	response.getWriter().write("0");
          	break;
          }
				}
				response.getWriter().write("1");
			}
		 }catch (ParseException e) {
			System.out.println("admin.movie.MovieRangeDeleteOkCommand json에러\n " + e.getMessage());
			response.getWriter().write("0");
			e.printStackTrace();
		 }

	}

}
