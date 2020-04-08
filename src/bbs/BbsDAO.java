package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {//DAO 클래스 : 데이터 접근 객체 약자, 그러한 역할 
	private Connection conn; //db에 접근하게 해주는 하나의 객체를 의미 
	//private PreparedStatement pstmt; // 여러개 함수를 사용하게 되는데 데이터베이스 접근에 있어서 마찰이 일어나지 않도록 하기 위해 주석처리  
	private ResultSet rs;
	
	public BbsDAO() {
		
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			//String dbURL = "jdbc:mysql://localhost:3306/BBS?useUnicode=true&characterEncoding=UTF-8";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getDate() { //현재 시간을 가져오는 함수 , 서버의 시간을 넣어줌 
		String SQL = "SELECT NOW()"; //현재시간을 가져오는 MYSQL의 문장
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //con객체를 이용해서 sql문장을 실행준비단계로 만들어줌  
			rs = pstmt.executeQuery(); //실제로 실행했을 때 나오는 결과
			if (rs.next()) {
				return rs.getString(1); //현재의 날짜를 그대로 반환되게 함 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류 
	}
	public int getNext() {  
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";//bbsID를 가져오고 , 글 마지막에 쓰이는 번호가 1이 늘어날테니 내림차순을 사용  
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //con객체를 이용해서 sql문장을 실행준비단계로 만들어줌  
			rs = pstmt.executeQuery(); //실제로 실행했을 때 나오는 결과
			if (rs.next()) {
				return rs.getInt(1) + 1; //현재의 날짜를 그대로 반환되게 함 
			}
			return 1; //첫번째 게시물인 경우 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}
	
	public int write(String bbsTitle, String userID, String bbsContent ) {
		String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";  
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //con객체를 이용해서 sql문장을 실행준비단계로 만들어줌  
			pstmt.setInt(1,  getNext()); //다음번에 씌여질 게시글 번호 
			pstmt.setString(2,  bbsTitle); 
			pstmt.setString(3,  userID); 
			pstmt.setString(4,  getDate()); 
			pstmt.setString(5,  bbsContent); 
			pstmt.setInt(6, 1); //글을 처음에 작성했을떄 글이 보여지는 형태이기 떄문에 1을 넣어줌 
			return pstmt.executeUpdate(); // 성공적으로 수행했다면 0이상의 결과를 반환 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}
	
	//쓰인 글목록을 보여주는 소스 
	public ArrayList<Bbs> getList(int pageNumber){//특정한 리스트를 담아 반환
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10;"; 
		//SQL:특정한 숫자보다 작을때 , 위에서10개까지만 가져오도록 함 
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
			rs = pstmt.executeQuery(); 
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; //데이터베이스 오류 
	}
	
	public boolean nextPage(int pageNumber) {//next페이지가 없다는걸 알려줘야하기떄문에 nextPage함수만듬
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
			rs = pstmt.executeQuery(); 
			
			if (rs.next()) { //10번쨰 + 1 인 게시물인 경우 
				return true; //다음 게시글(페이지)로 넘어갈수 있다는걸 알려줌 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; //다음 게시글이 없을 경우 
	}
	
	public Bbs getBbs(int bbsID) {//글 내용을 불러오는 함수 
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery(); 
			if (rs.next()) { 
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) { //게시글 수정 함수 
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? where bbsID = ?";  
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //con객체를 이용해서 sql문장을 실행준비단계로 만들어줌  
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent); 
			pstmt.setInt(3, bbsID); 
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";  
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //con객체를 이용해서 sql문장을 실행준비단계로 만들어줌  
			pstmt.setInt(1, bbsID); //Available 값을 0으로 바꿈으로써 삭제가 처리됨
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}
}
	

	
	
	
	

