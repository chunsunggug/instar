package semi.follow;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FollowDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	public static final int NEED_LOGIN = -1;
	public static final int ON_FOLLOW = 1;
	public static final int OFF_FOLLOW = 0;

	public FollowDAO() {
		super();
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

	public int addFollow(String id, String yid) {
		try {
			if (id == null || id.equals("")) {
				return NEED_LOGIN;
			}
			dbConnect();
			String sql = "insert into semi_follow values(semi_follow_idx.nextval,?,?,sysdate)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, yid);
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
	}

	public int delFollow(String id, String yid) {
		try {
			dbConnect();
			String sql = "delete semi_follow where id=? and yid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, yid);
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
	}

	public int checkFollow(String id, String yid) {
		try {
			if (id == null || id.equals("")) {
				return NEED_LOGIN;
			}
			dbConnect();
			String sql = "select * from semi_follow where id=? and yid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, yid);
			rs = ps.executeQuery();
			boolean check=false;
			
			if(rs.next()) {
				check=true;
			}
			if (check) {
				return ON_FOLLOW; //팔로잉 상태
			} else {
				return OFF_FOLLOW; //언팔로잉 상태
			}

		} catch (Exception e) {
			e.printStackTrace();
			return NEED_LOGIN;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
	}
	
	public int allFollow(String id) {
		try {
			if (id == null || id.equals("")) {
				return NEED_LOGIN;
			}
			dbConnect();
			String sql = "select count(*) from semi_follow where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			int cnt=0;
			if(rs.next()) {
				cnt=(int) rs.getInt(1);
			};
			return cnt;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
	}
	
	public int allFolloing(String yid) {
		try {
			dbConnect();
			String sql = "select count(*) from semi_follow where yid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, yid);
			rs = ps.executeQuery();
			int cnt=0;
			if(rs.next()) {
				cnt=(int) rs.getInt(1);
			};
			return cnt;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
	}
	
	/*나를 팔로우 한 사람 리스트 출력*/
	public ArrayList<FollowDTO> followList(String id) {
		try {
			dbConnect();
			String sql = "SELECT S.* FROM (SELECT * FROM SEMI_FOLLOW WHERE YID=? ORDER BY DBMS_RANDOM.VALUE) S WHERE rownum < 4 ORDER BY RDATE DESC";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();

			ArrayList<FollowDTO> flist = new ArrayList<FollowDTO>();

			while (rs.next()) {
				FollowDTO fdto = new FollowDTO();
				fdto.setIdx(rs.getInt("idx"));
				fdto.setId(rs.getString("id"));
				fdto.setYid(rs.getString("yid"));
				fdto.setRdate(rs.getDate("rdate"));
				flist.add(fdto);
			}
			return flist;
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
	
	
	

}
