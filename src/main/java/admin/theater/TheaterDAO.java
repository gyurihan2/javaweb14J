package admin.theater;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class TheaterDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	TheaterVO vo = null;
	// 상영관 생성 (res 0: 실패 1:성공)
	public String setTheaterCreateOk(TheaterVO vo) {
		String res = "0";
			
		try {
				sql="insert into theater values(default,?,?,?,?,default,default,default)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, vo.getPrice());
				pstmt.setInt(2, vo.getSeat());
				pstmt.setString(3, vo.getName());
				pstmt.setString(4, vo.getThema());
				
				if(pstmt.executeUpdate() == 1) res="1";
				
		}catch (SQLException e) {
			System.out.println("admin.theater.TheaterDAO.theaterCreateOk SQL 에러\n" + e);
		}finally {
			getConn.pstmtClose();
		}
		
		return res;
	}
	// 상영관 전체 목록
	public ArrayList<TheaterVO> getTheaterList() {
		ArrayList<TheaterVO> vos = new ArrayList<>();
		
		try {
			sql = "select * from theater";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new TheaterVO();
				
				vo.setIdx(rs.getInt("idx"));
				vo.setPrice(rs.getInt("price"));
				vo.setSeat(rs.getInt("seat"));
				vo.setName(rs.getString("name"));
				vo.setThema(rs.getString("thema"));
				vo.setWork(rs.getString("work"));
				vo.setRegDate(rs.getString("regDate"));
				vo.setModifyDate(rs.getString("modifyDate"));
				
				vos.add(vo);
			}
		}catch (SQLException e) {
			System.out.println("admin.theater.TheaterDAO.getTheaterList SQL 에러\n" + e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		return vos;
	}
	public String setTheaterUpdateOk(TheaterVO vo) {
		String res = "0";
		
		try {
			sql = "update theater set name=?, thema=?, seat=?, price=?, work=? where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getThema());
			pstmt.setInt(3, vo.getSeat());
			pstmt.setInt(4, vo.getPrice());
			pstmt.setString(5, vo.getWork());
			pstmt.setInt(6, vo.getIdx());
			
			if(pstmt.executeUpdate()==1) res="1";
				
			
		}catch (SQLException e) {
			System.out.println("admin.theater.TheaterDAO.setTheaterUpdateOk SQL 에러\n" + e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		
		return res;
	}
	public String setTheaterDeleteOk(int idx) {
		String res = "0";
		try {
			sql="delete from theater where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			if(pstmt.executeUpdate() == 1) res="1";
			
		}catch (SQLException e) {
			System.out.println("admin.theater.TheaterDAO.setTheaterDeleteOk SQL 에러\n" + e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		
		return res;
	}
}
