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

	//아이디 중복 체크 후 자료가 있으면 vo로 반환
	public MemberVO getMemberMidChk(String mid) {
		vo = null;
		
		try {
			sql = "select * from member where mid=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setSalt(rs.getString("salt"));
				vo.setName(rs.getString("name"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setIdentiNum(rs.getString("identiNum"));
				vo.setGender(rs.getString("gender"));
				vo.setPhone(rs.getString("phone"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastLogin(rs.getString("lastLogin"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setLevel(rs.getInt("level"));
				vo.setPoint(rs.getInt("point"));
				vo.setTotPoint(rs.getInt("totPoint"));
			}
			
		}catch (SQLException e) {
			System.out.println("member.MemberDAO.getMemberMidChk SQL 에러\n" + e.getMessage());
		}finally {
			getConn.rsClose();
		}
		
		return vo;
	}

	// 닉네임 중복 확인 0: 중복 / 1: 사용가능
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

	// 회원가입 처리
	public int setMemberJoinOk(MemberVO vo) {
		int res =0;
		
		try {
			sql="insert into member values(default,?,?,?,?,?,?,?,?,?,?,?,now(),now(),default,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getSalt());
			pstmt.setString(4, vo.getName());
			pstmt.setString(5, vo.getBirthday());
			pstmt.setString(6, vo.getNickName());
			pstmt.setString(7, vo.getIdentiNum());
			pstmt.setString(8, vo.getGender());
			pstmt.setString(9, vo.getPhone());
			pstmt.setString(10, vo.getAddress());
			pstmt.setString(11, vo.getEmail());
			
			res = pstmt.executeUpdate();
			
		}catch (SQLException e) {
			System.out.println("member.MemberDAO.setMemberJoinOk SQL 에러\n" + e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		
		return res;
	}
	
	// 마지막 접속일 업데이트
	public void setLastLoginUpdate(String mid, String srtNow) {
		
		try {
			sql="update member set lastLogin=? where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, srtNow);
			pstmt.setString(2, mid);
			
			pstmt.executeUpdate();
			
		}catch (SQLException e) {
			System.out.println("member.MemberDAO.setLastLoginUpdate SQL 에러\n" + e.getMessage());
		}finally {
			getConn.pstmtClose();
		}
		
	}
	// 아이디 찾기(이름,이메일 사용)
	public String getMidSearch(String name, String email) {
		String res=null;
		try {
			sql="select mid from member where name=? and email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) res = rs.getString("mid");
			
		}catch (SQLException e) {
			System.out.println("member.MemberDAO.getMidSearch SQL 에러\n" + e.getMessage());
		}finally {
			getConn.rsClose();
		}
		
		return res;
	}
	// 비밀번호 변경
	public String setPwdChange(String mid, String pwd) {
		String res = "0";
		try {
			sql="update member set pwd=? where mid=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pwd);
			pstmt.setString(2, mid);
			
			if(pstmt.executeUpdate()==1) {
				res="1";
			}
		}catch (SQLException e) {
			System.out.println("member.MemberDAO.setPwdChange SQL 에러\n" + e.getMessage());
		}finally {
			getConn.rsClose();
		}
		
		return res;
	}

}
