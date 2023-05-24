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
				getConn.pstmtClose();
			}

		return vos;
	}
}
