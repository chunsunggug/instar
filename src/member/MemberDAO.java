package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MemberDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;

	public static final int NOT_ID = 1;
	public static final int NOT_PWD = 2;
	public static final int LOGIN_OK = 3;
	public static final int ERROR = -1;

	public MemberDAO() {

	}

	public void dbConnect() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "scott";
			String pwd = "tiger";
			conn = DriverManager.getConnection(url, user, pwd);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void dbClose() {
		try {
		if(rs!=null)rs.close();
		if(ps!=null)ps.close();
		if(conn!=null)conn.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/** 세미 회원가입 메서드 */
	public int memberJoin(String id, String pwd, String name, String nick) {
		try {
			dbConnect();
			String sql = "insert into semi_member values(SEMI_MEMBER_IDX.nextval,?,?,?,?,' ',' ','nobody.jpg',sysdate)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pwd);
			ps.setString(3, name);
			ps.setString(4, nick);
			int count = ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	/** 아이디 중복검사 관련메서드 */
	public boolean idCheck(String userid) {
		try {
			dbConnect();
			String sql = "select id from semi_member where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs = ps.executeQuery();
			if(rs.next()) {
			return true;	
			}
			return false; 
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	/** 로그인검증메서드 */
	public int loginCheck(String userid, String userpwd) {
		try {
			dbConnect();
			String sql = "select pwd from semi_member where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs = ps.executeQuery();
			if (rs.next()) {
				String dbpwd = rs.getString(1);
				if (dbpwd.equals(userpwd)) {
					return LOGIN_OK;
				} else {
					return NOT_PWD;
				}
			} else {
				return NOT_ID;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	/** 사용자 정보 추출관련메서드*/ 
	public String getUserInfo(String userid) {
		try {
			dbConnect();
			String sql = "select img from semi_member where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs = ps.executeQuery();
			rs.next();
			return rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}
	//아이디 찾기 로직 이름 입력 시 조회.
	public String getFindid(String name) {
		try {
			dbConnect();
			String sql = "select id from semi_member where name=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			rs = ps.executeQuery();
			rs.next();
			return rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	//비밀번호 찾기 로직 이름과 id 입력 시 조회.
	public String getFindpwd(String name, String id) {
		try {
			dbConnect();
			String sql = "select pwd from semi_member where nickname=? and id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, id);
			rs = ps.executeQuery();
			rs.next();
			return rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 로그인 후 세션 값 전달 메소드 id,name,nickname,img 이름값 저장
	public ArrayList<MemberDTO> getUserInfo(MemberDTO dto) {
		dbConnect();
		String sql = "select * from semi_member where id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getId());
			rs = ps.executeQuery();
			rs.next();
			ArrayList<MemberDTO> user = new ArrayList<MemberDTO>();
			String id = rs.getString("id");
			String name = rs.getString("name");
			String nickname = rs.getString("nickname");
			String img = rs.getString("img");
			String guide=rs.getString("guide");
			String homepage=rs.getString("homepage");
			MemberDTO userInfo = new MemberDTO(id,name,nickname,img,guide,homepage);
			user.add(userInfo);
			return user;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				rs.close();
				ps.close();
				conn.close();
			} catch (Exception e) {
			}
		}
	}

	
	//마이 페이지 정보 불러오는 로직
	public ArrayList<MemberDTO> mypage(String myid) {
		dbConnect();
		String sql = "select * from semi_member where id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, myid);
			rs = ps.executeQuery();
			ArrayList<MemberDTO> user = new ArrayList<MemberDTO>();
			if(rs.next()) {
			String id = rs.getString("id");
			String name = rs.getString("name");
			String nickname = rs.getString("nickname");
			String img = rs.getString("img");
			String guide=rs.getString("guide");
			String homepage=rs.getString("homepage");
			MemberDTO userInfo = new MemberDTO(id,name,nickname,img,guide,homepage);
			user.add(userInfo);
			}
			return user;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
			}
		}
	}

	//이름 수정 로직
	public int modifyName(String myid,String name) {
		dbConnect();
		String sql="update semi_member set name=? where id=?";
		int result=0;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, myid);
			 result = ps.executeUpdate();
			return result;
		}catch (Exception e) {
			e.printStackTrace();
			return result;
		}finally {
			try {
				ps.close();
				conn.close();
			} catch (Exception e) {
			}
		}
		
	}

	//닉네임 변경 로직
	public int modifyNick(String myid,String nick) {
		dbConnect();
		String sql="update semi_member set nickname=? where id=?";
		int result=0;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, nick);
			ps.setString(2, myid);
			 result = ps.executeUpdate();
			return result;
		}catch (Exception e) {
			e.printStackTrace();
			return result;
		}finally {
			try {
				ps.close();
				conn.close();
			} catch (Exception e) {
			}
		}
	}

	//홈페이지 변경 로직
		public int modifyHome(String myid,String home) {
			dbConnect();
			String sql="update semi_member set homepage=? where id=?";
			int result=0;
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1, home);
				ps.setString(2, myid);
				 result = ps.executeUpdate();
				return result;
			}catch (Exception e) {
				e.printStackTrace();
				return result;
			}finally {
				try {
					ps.close();
					conn.close();
				} catch (Exception e) {
				}
			}
		}
		
		//소개 변경 로직
		public int modifyGuide(String myid,String guide) {
			dbConnect();
			String sql="update semi_member set guide=? where id=?";
			int result=0;
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1, guide);
				ps.setString(2, myid);
				 result = ps.executeUpdate();
				return result;
			}catch (Exception e) {
				e.printStackTrace();
				return result;
			}finally {
				try {
					ps.close();
					conn.close();
				} catch (Exception e) {
				}
			}
		}
		
		
	//패스워드 변경 로직
	public int modifyPwd(String myid,String pwd) {
		dbConnect();
		String sql="update semi_member set pwd=? where id=?";
		int result=0;
		if(pwd==null||pwd.equals("")||pwd.equals("null")) {
			return -1;
		};
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, pwd);
			ps.setString(2, myid);
			 result = ps.executeUpdate();
			return result;
		}catch (Exception e) {
			e.printStackTrace();
			return result;
		}finally {
			try {
				ps.close();
				conn.close();
			} catch (Exception e) {
			}
		}
	}

	//이미지 변경 로직
	public int modifyImg(String myid,String img) {
		dbConnect();
		String sql="update semi_member set img=? where id=?";
		int result=0;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, img);
			ps.setString(2, myid);
			 result = ps.executeUpdate();
			return result;
		}catch (Exception e) {
			e.printStackTrace();
			return result;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
			}
		}
	}

	public int memberDel(String myid) {
		dbConnect();
		String sql="delete semi_member where id=?";
		int result=0;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, myid);
			result=ps.executeUpdate();
			return result;
		}catch (Exception e) {
			e.printStackTrace();
			return result;	
		}finally {
			try {
			if(ps!=null)ps.close();
			if(conn!=null)conn.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
	}
	
}
