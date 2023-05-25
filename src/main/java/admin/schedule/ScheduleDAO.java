package admin.schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import admin.theater.TheaterVO;
import conn.GetConn;

public class ScheduleDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	ScheduleVO vo;
	// 해당 날짜에 상영이 가능한 상영관 출력 
	public ArrayList<TheaterVO> getScheduleTheater(String startDate, String endDate) {
		ArrayList<TheaterVO> vos = null;
		
		try {
			sql="select * from theater where idx not in "
					+ "(select theaterIdx from schedule where playDate between ? and ? group by theaterIdx);";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, startDate);
			pstmt.setString(2, endDate);
			
			rs = pstmt.executeQuery();
			vos = new ArrayList<>();
			TheaterVO vo;
			while(rs.next()) {
				vo = new TheaterVO();
				
				vo.setIdx(rs.getInt("idx"));
				vo.setPrice(rs.getInt("price"));
				vo.setSeat(rs.getInt("seat"));
				vo.setName(rs.getString("name"));
				vo.setThema(rs.getString("thema"));
				vo.setWork(rs.getString("work"));
				
				vos.add(vo);
			}
			
			}catch (SQLException e) {
				System.out.println("admin.theater.TheaterDAO.theaterCreateOk SQL 에러\n" + e);
			}finally {
				getConn.rsClose();
			}

		return vos;
	}
	// 영화 일정 등록
	public void setScheduleInsertOk(ScheduleVO vo) {
		try {
			sql="insert into schedule values(default,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getTheaterIdx());
			pstmt.setString(2,vo.getMovieIdx() );
			pstmt.setInt(3,vo.getScreenOrder() );
			pstmt.setString(4,vo.getPlayDate() );
			pstmt.setString(5,vo.getStartTime());
			
			pstmt.executeUpdate();
			
			}catch (SQLException e) {
				System.out.println("admin.theater.TheaterDAO.setScheduleInsertOk SQL 에러\n" + e);
			}finally {
				getConn.pstmtClose();
			}
		
	}
	// 해당 년도-월에 등록된 상영관 확인(MgmtPage)
	public ArrayList<CalendarVO> getSchedule(String ym) {
		ArrayList<CalendarVO> vos = null;
		
		try {
			sql="select name,b.playDate from theater as a, "
					+ "(select theaterIdx,playDate from schedule where playDate like ? group by theaterIdx,playDate) as b "
					+ "where a.idx = b.theaterIdx order by b.playDate,a.name";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ym+"%");
			
			rs = pstmt.executeQuery();
			CalendarVO vo =null;
			vos =  new ArrayList<>();
			
			while(rs.next()) {
				// vo가 Null이거나 상영 시작일이 다른경우 vo생성 및 vos에 추가
				if(vo ==null || !vo.playDate.equals(rs.getString("playDate"))) {
					vo= new CalendarVO();
					vos.add(vo);
					vo.setPlayDate(rs.getString("playDate"));
					vo.setTheaterName(rs.getString("name")+"/");
				}
				// 상영일이 같을 경우 구분자('/') 추가하여 상영관 추가
				else if(vo.playDate.equals(rs.getString("playDate"))) {
					vo.setTheaterName(vo.getTheaterName()+rs.getString("name")+"/");
				}
			}
			
		}catch (SQLException e) {
			System.out.println("admin.theater.TheaterDAO.setScheduleInsertOk SQL 에러\n" + e);
		}finally {
			getConn.rsClose();
		}
		
		return vos;
	}
	// 날짜(년-월-일)에 해당 하는 상영관 일정 확인(전체리스트)
	public ArrayList<ScheduleVO> getScheduleDetailPage(String ymd) {
		ArrayList<ScheduleVO> vos = null;
		
		try {
			sql="select a.idx, a.name, c.title, c.mainImg, c.totalView, c.rating, c.playTime from theater as a, "
					+ "(select * from schedule as c where playDate = ? group by theaterIdx) as b, "
					+ "(select * from movie) as c "
					+ "where a.idx = b.theaterIdx and b.movieIdx = c.idx order by b.playDate,a.name;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ymd);
			
			rs = pstmt.executeQuery();
			vos =  new ArrayList<>();
			
			while(rs.next()) {
				vo = new ScheduleVO();
				vo.setTheatherName(rs.getString("name"));
				vo.setMovieTitle(rs.getString("title"));
				vo.setMovieMainImg(rs.getString("mainImg"));
				vo.setTotalView(rs.getInt("totalView"));
				vo.setMovieRating(rs.getFloat("rating"));
				vo.setMoviePlayTime(rs.getInt("playTime"));
				
				vos.add(vo);
			}
		}catch (SQLException e) {
			System.out.println("admin.theater.TheaterDAO.setScheduleInsertOk SQL 에러\n" + e);
		}finally {
			getConn.rsClose();
		}
		
		return vos;
	}
	
}
