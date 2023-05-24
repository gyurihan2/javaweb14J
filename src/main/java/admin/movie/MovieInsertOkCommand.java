package admin.movie;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.AdminInterface;

public class MovieInsertOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/movieChart/");
		
		int maxSize = 1024 * 1024 * 10; // 서버에 저장할 최대용량
		String encoding="UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath,maxSize,encoding, new DefaultFileRenamePolicy());
		
		Enumeration fileNames = multipartRequest.getFileNames();
		String originalFileName="";
		String filesystemName="";
		String file="";
		String mainImg="noImage.jsp";
		
		// 파일 업로드 경로 확인
		while(fileNames.hasMoreElements()) {
			file = (String)fileNames.nextElement();
			originalFileName += multipartRequest.getOriginalFileName(file)+"/";
			filesystemName += multipartRequest.getFilesystemName(file)+"/";
			mainImg=multipartRequest.getFilesystemName(file);
		}
		originalFileName = originalFileName.substring(0,originalFileName.length()-1);
		filesystemName = filesystemName.substring(0,filesystemName.length()-1);

		String idx = multipartRequest.getParameter("idx") == null ? "" :multipartRequest.getParameter("idx");
		String title = multipartRequest.getParameter("title") == null ? "" :multipartRequest.getParameter("title");
		int  playTime = 0;
		if(!multipartRequest.getParameter("playTime").equals("") ) playTime = Integer.parseInt(multipartRequest.getParameter("playTime")); 
		String openDate = multipartRequest.getParameter("openDate") == null ? "" :multipartRequest.getParameter("openDate");
		String director = multipartRequest.getParameter("director") == null ? "" :multipartRequest.getParameter("director");
		String actor = multipartRequest.getParameter("actor") == null ? "" :multipartRequest.getParameter("actor");
		String content = multipartRequest.getParameter("content") == null ? "" :multipartRequest.getParameter("content");
		String nation = multipartRequest.getParameter("nation") == null ? "" :multipartRequest.getParameter("nation");
		String grade = multipartRequest.getParameter("grade") == null ? "" :multipartRequest.getParameter("grade");
		String[] genreArr = multipartRequest.getParameterValues("genre");
		
		String genreStr ="";
		if(genreArr != null) {
			for(String temp : genreArr) genreStr += temp+"/";
			genreStr = genreStr.substring(0,genreStr.length()-1);
		}

		MovieVO vo = new MovieVO();
		
		vo.setIdx(idx);
		vo.setTitle(title);
		vo.setPlayTime(playTime);
		vo.setOpenDate(openDate);
		vo.setDirector(director);
		vo.setActor(actor);
		vo.setContent(content);
		vo.setNation(nation);
		vo.setGenre(genreStr);
		vo.setGrade(grade);
		vo.setImages(originalFileName);
		vo.setImgFName(filesystemName);
		vo.setMainImg(mainImg);
		
		MovieDAO dao = new MovieDAO();
		
		int res = dao.setMoviceInsertOk(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "영화 등록이 완료되었습니다.");
		}
		else {
			request.setAttribute("msg", "영화등록 실패했습니다.");
			String temp[] = filesystemName.split("/");
			
			// 업로드 된 파일 삭제
			for(String fPath : temp) {
				File fileDelete = new File(realPath+fPath);
				if(fileDelete.exists()) {
					fileDelete.delete();
				}
			}
			
		}
		
		request.setAttribute("url", request.getContextPath()+"/MovieMgmtPage.ad");
	}

}
