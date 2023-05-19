package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conn.GetConn;

public class MemberDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	MemberVO vo;

	public int getMemberMidChk(String mid) {
		int res = 0;
		
		try {
			sql = "select * from member where mid=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			
			rs = pstmt.executeQuery();
			
			if(!rs.next()) res=1;
			
		}catch (SQLException e) {
			System.out.println("member.MemberDAO.getMemberMidChk SQL 에러\n" + e.getMessage());
		}finally {
			getConn.rsClose();
		}
		
		return res;
	}

	public int getMemberNickNameChk(String nickName) {
		int res = 0;
		
		try {
			sql = "select * from member where nickName=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickName);
			
			rs = pstmt.executeQuery();
			
			if(!rs.next()) res=1;
			
		}catch (SQLException e) {
			System.out.println("member.MemberDAO.getMemberNickNameChk SQL 에러\n" + e.getMessage());
		}finally {
			getConn.rsClose();
		}
		
		return res;
	}
}
