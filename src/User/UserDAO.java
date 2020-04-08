package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn; //db에 접근하게 해주는 하나의 객체를 의미 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			//String dbURL = "jdbc:mysql://localhost:3306/BBS?useUnicode=true&characterEncoding=UTF-8";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver"); // mysql에 접속할수있도록 매개체 역할을 하는 하나의 라이브러리 
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//---------------------------로그인 
	public int login(String userID, String userPassword) { //실제로 로그인이 실행되는 함수
	String SQL = "SELECT userPassword FROM USER WHERE userID = ?"; //매개변수가 들어와서 검사하는걸 ?로 대체 
	try {
		pstmt = conn.prepareStatement(SQL);//정해진 문장을 db에 삽입하는 형식으로 인스턴스(pstmt)를 가져옴 
		pstmt.setString(1, userID);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			if(rs.getString(1).equals(userPassword)) 
				return 1;//로그인 성공 	
			
			else
				return 0; //비밀번호 불일치 
		}
		return -1; //아이디가 없다면 결과값이 없으니  if를 건너뛰고 return실행 
	} catch (Exception e) {
		e.printStackTrace();
	}
	return-2; //데이터베이스 오류 
	}
	
	public int join(User User) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)"; // 물음표에 해당 변수들 채워넣음 
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, User.getUserID());
			pstmt.setString(2, User.getUserPassword());
			pstmt.setString(3, User.getUserName());
			pstmt.setString(4, User.getUserGender());
			pstmt.setString(5, User.getUserEmail());
			return pstmt.executeUpdate(); //해당 statement를 실행할 결과를 넣어줌 -1이 아닌경우 성공적인 회원가입 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류 
		
	}
}

