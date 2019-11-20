package semi.relike;

import java.awt.dnd.DnDConstants;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RelikeDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;

	public static final int ERROR = -1;
	public static final int RELIKE_DOWN = 0;
	public static final int RELIKE_UP=1;
	
	public RelikeDAO(){}
	
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
	
	/*좋아요를 누른 계정이 있는지 없는지 확인하는 로직*/
	public boolean checkLike(int idx, String id) {
		try {
			dbConnect();
			String sql = "select * from semi_relike where id = ? and idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setInt(2, idx);
			rs = ps.executeQuery();
			if(rs.next()) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs != null)rs.close();
				if (ps != null)ps.close();
				if (conn != null)conn.close();
			} catch (Exception e2) {
			}
		}
	}
	

	/*좋아요 카운트플러스 또는 카운트마이너스 로직*/
	public void semiLikeCount(int idx, int count) {
		try {
			String sql = "";
			if(count == 0) {
				sql = "update semi_content set relike = relike-1 where idx = ? and relike > 0";
			}else {
				sql = "update semi_content set relike = relike+1 where idx = ?";
			}
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (ps != null)ps.close();
			}catch(Exception e2) {}
		}
	}
	
	
	/*좋아요 삭제하는 로직*/
	public int deleteLike(int idx, String id) {
		try {
			dbConnect();
			String sql = "delete from semi_relike where idx=? and id=?";
			int count = 0;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ps.setString(2, id);
			count = ps.executeUpdate();
			semiLikeCount(idx, RELIKE_DOWN);
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (ps != null)ps.close();
				if (conn != null)conn.close();
			} catch (Exception e) {
			}
		}
	}
	
	/*좋아요  넣는 로직*/
	public int insertLike(int idx, String id) {
		try {
			dbConnect();
			String sql="insert into semi_relike values(?, ?, sysdate)";
			int count = 0;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ps.setString(2, id);
			count = ps.executeUpdate();
			semiLikeCount(idx, RELIKE_UP);
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (ps != null)ps.close();
				if (conn != null)conn.close();
			} catch (Exception e) {
			}
		}
	}
	
	
	/*좋아요 삭제 로직*/
	public void relikeDelete(int idx) {
		try {
			dbConnect();
			String sql = "delete from semi_relike where idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if (ps != null)ps.close();
				if (conn != null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/*<----- 댓글 좋아요 로직 ----->*/
	
	/*댓글 좋아요 했는지 확인하는 로직*/
	public boolean checkCLike(int cidx, String id) {
		try {
			String sql = "select * from semi_clike where id = ? and cidx = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			System.out.println("check id >>> " + id);
			ps.setInt(2, cidx);
			System.out.println("check cidx >>> " + cidx);
			rs = ps.executeQuery();
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs != null)rs.close();
				if (ps != null)ps.close();
			} catch (Exception e2) {
			}
		}
	}
	
	/*댓글좋아요 확인하고 삭제할지 넣을지 확인하는 로직*/
	public int deleteCLike(int cidx, String id, int idx) {
		try {
			dbConnect();
			boolean check = checkCLike(cidx, id);
			System.out.println("boolean check >>> " + check);
			System.out.println("insert idx >>> " + idx);
			String sql="insert into semi_clike values(?, ?, sysdate, ?)";
			int count = 1;
			if (check) {
				sql = "delete from semi_clike where cidx = ? and id = ? and idx = ?";
				count = 0;
			}
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cidx);
			ps.setString(2, id);
			ps.setInt(3, idx);
			ps.executeUpdate();
			semiCLikeCount(cidx, count);
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (ps != null)ps.close();
				if (conn != null)conn.close();
			} catch (Exception e) {
			}
		}
	}
	
	/*좋아요 카운트플러스 또는 카운트마이너스 로직*/
	public void semiCLikeCount(int cidx, int count) {
		try {
			String sql = "";
			if(count == 0) {
				sql = "update semi_comment set clike = clike-1 where cidx = ? and clike > 0";
			}else {
				sql = "update semi_comment set clike = clike+1 where cidx = ?";
			}
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cidx);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (ps != null)ps.close();
			}catch(Exception e2) {}
		}
	}
	
	/*좋아요 삭제 로직*/
	public void clikeDelete(int idx) {
		try {
			dbConnect();
			String sql = "delete from semi_clike where cidx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if (ps != null)ps.close();
				if (conn != null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
}
