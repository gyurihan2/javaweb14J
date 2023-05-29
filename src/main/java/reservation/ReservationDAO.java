package reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import conn.GetConn;

public class ReservationDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	ReservationVO vo;
	
	// 메인 화면의 날짜 선택시  표시할 이미지,상영관, 영화제목(ajax)
	public JSONArray getScheduleMoive(String playDate) {
		JSONArray res =null;
		HashMap<String, String> map = null;
		JSONObject movieObj =null;
		
		try {
			sql="select a.*, c.name as theaterName from movie as a, "
					+ "(select * from schedule where playDate = ? group by theaterIdx) as b, "
					+ "(select * from theater) as c "
					+ "where a.idx=b.movieIdx and c.idx=b.theaterIdx;";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, playDate);
			
			rs = pstmt.executeQuery();
			
			res = new JSONArray();
			
			while(rs.next()) {
				map = new HashMap<>();
				
				map.put("title", rs.getString("title"));
				map.put("mainImg", rs.getString("mainImg"));
				map.put("rating", Float.toString(rs.getFloat("rating")));
				map.put("theaterName",rs.getString("theaterName"));
				
				movieObj = new JSONObject(map);
				res.add(movieObj);
			}
			
			
		}catch (SQLException e) {
			System.out.println("reservation.ReservationDAO.getScheduleMoive SQL 에러 \n"+e.getMessage());
		}finally {
			getConn.rsClose();
		}
		
		return res;
	}
	// 예매하기 -> 영화 회차 출력
	public ArrayList<ScheduleVO> getScheduleMovieOrder(String playDate, String theaterName, String title) {
		ArrayList<ScheduleVO> vos = null;
		ScheduleVO vo = null;
		try {
			sql="select a.*,b.seat from schedule as a,"
					+ "(select idx,seat from theater where name= ?) as b,"
					+ "(select idx from movie where title= ?) as c "
					+ "where a.playDate= ? and a.theaterIdx = b.idx and a.movieIdx=c.idx;";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, theaterName);
			pstmt.setString(2, title);
			pstmt.setString(3, playDate);
			
			rs = pstmt.executeQuery();
			vos= new ArrayList<>();
		
			while(rs.next()) {
				vo = new ScheduleVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMovieIdx(rs.getString("movieIdx"));
				vo.setTheaterIdx(rs.getInt("theaterIdx"));
				vo.setScreenOrder(rs.getInt("screenOrder"));
				vo.setStartTime(rs.getString("startTime"));
				vo.setSeat(rs.getInt("seat"));
				
				vos.add(vo);
			}
			
		}catch (SQLException e) {
			System.out.println("reservation.ReservationDAO.getScheduleMovieOrder SQL 에러 \n"+e.getMessage()+"\n");
		}finally {
			getConn.rsClose();
		}
		
		return vos;
	}
	
	// 회차 별 남은 좌석수 출력
	public int getMovieSeatChk(int scheduleIdx) {
		int res = -1;
		
		try {
			sql="select count(*)as res from reservation where scheduleIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, scheduleIdx);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) res=rs.getInt("res");
		}catch (SQLException e) {
			System.out.println("reservation.ReservationDAO.getMovieSeatChk SQL 에러 \n"+e.getMessage()+"\n");
		}finally {
			getConn.rsClose();
		}
		
		return res;
	}
	// 회차별 좌석 예약 체크
	public int[] getMovieSeatChk(int scheduleIdx, int totSeat) {
		int[] res = new int[totSeat];
		
		try {
			sql="select a.* , count(*) as res, b.price from reservation as a ,"
					+ "(select * from theater)  as b "
					+ "where scheduleIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, scheduleIdx);
			
			
			rs = pstmt.executeQuery();
			rs.next();
			
			if(rs.getInt("res") > 0) {
				rs.beforeFirst();
				
				while(rs.next()) {
					String[] seatInfo = rs.getString("seatInfo").split("/");
					
					for(String temp:seatInfo) {
						res[Integer.parseInt(temp)] = 1;
					}
				}
			}
			
		}catch (SQLException e) {
			System.out.println("reservation.ReservationDAO.getMovieSeatChk SQL 에러 \n"+e.getMessage()+"\n");
		}finally {
			getConn.rsClose();
		}
		
		return res;
	}
	// 영화 가격
	public TheaterVO getMoviePice (String theaterName) {
		TheaterVO vo = null;
		
		try {
			sql="select * from theater where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, theaterName);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new TheaterVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setPrice(rs.getInt("price"));
				vo.setSeat(rs.getInt("seat"));
				vo.setName(rs.getString("name"));
			}
			
		}catch (SQLException e) {
			System.out.println("reservation.ReservationDAO.getMovieSeatChk SQL 에러 \n"+e.getMessage()+"\n");
		}finally {
			getConn.rsClose();
		}
		
		return vo;
	}

}
