package admin.movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class MovieDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	MovieVO vo = null;
	
	// 영화 Insert 처리
	public int setMoviceInsertOk(MovieVO vo) {
		int res = 0;
		
		try {
			sql="insert into movie values(?,?,?,?,?,?,?,?,?,?,?,?,?,default,default)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, vo.getIdx());
			pstmt.setString(2, vo.getMainImg());
			pstmt.setString(3, vo.getImages());
			pstmt.setString(4, vo.getImgFName());
			pstmt.setString(5, vo.getTitle());
			pstmt.setString(6, vo.getGenre());
			pstmt.setInt(7, vo.getPlayTime());
			pstmt.setString(8, vo.getOpenDate());
			pstmt.setString(9, vo.getNation());
			pstmt.setString(10, vo.getDirector());
			pstmt.setString(11, vo.getActor());
			pstmt.setString(12, vo.getContent());
			pstmt.setString(13, vo.getGrade());
			
			res = pstmt.executeUpdate();

		}catch (SQLException e) {
			System.out.println("admin.movie.MovieDAO.setMoviceInsertOk SQL 에러\n" + e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		
		
		
		return res;
	}

	// 영화 전체 리스트
	public ArrayList<MovieVO> getMovieList(int start, int end) {
		ArrayList<MovieVO> vos=null;
		
		try {
			sql="select * from movie order by openDate desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			vos = new ArrayList<>();
			
			while(rs.next()) {
				vo = new MovieVO();
				vo.setIdx(rs.getString("idx"));
				vo.setMainImg(rs.getString("mainImg"));
				vo.setImages(rs.getString("images"));
				vo.setImgFName(rs.getString("imgFName"));
				vo.setTitle(rs.getString("title"));
				vo.setGenre(rs.getString("genre"));
				vo.setPlayTime(rs.getInt("playTime"));
				vo.setOpenDate(rs.getString("openDate"));
				vo.setNation(rs.getString("nation"));
				vo.setDirector(rs.getString("director"));
				vo.setActor(rs.getString("actor"));
				vo.setContent(rs.getString("content"));
				vo.setGrade(rs.getString("grade"));
				vo.setTotalView(rs.getInt("totalView"));
				vo.setRating(rs.getFloat("rating"));
				
				vos.add(vo);
				
			}
			
		}catch (SQLException e) {
			System.out.println("admin.movie.MovieDAO.getMovieList SQL 에러\n" + e.getMessage());
		}finally {
			getConn.rsClose();
		}
		
		
		return vos;
	}

	// 페이징 처리를 위한 영화 전체 리스트 카운트
	public int getListCnt() {
		int res = 0;
		
		try {
			sql="select count(*) as cnt from movie";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) res = rs.getInt("cnt");
			
		}catch (SQLException e) {
			System.out.println("admin.movie.MovieDAO.getListCnt SQL 에러\n" + e.getMessage());
		}finally {
			getConn.rsClose();
		}
		
		return res;
	}

	// 영화 삭제
	public String setMovieDeleteOk(String idx) {
		String res ="0";
		
		try {
			sql = "delete from movie where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, idx);
			
			if(pstmt.executeUpdate() == 1) {
				res="1";
			}
		}catch (SQLException e) {
			System.out.println("admin.movie.MovieDAO.setMovieDeleteOk SQL 에러\n" + e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		return res;
	}
}
