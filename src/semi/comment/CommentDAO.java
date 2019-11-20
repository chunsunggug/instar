package semi.comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

public class CommentDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;

	public CommentDAO() {}
	
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
	
	public int semiInsertComment(CommentDTO dto) {
		try {
			dbConnect();
			int result=0;
			String sql="insert into semi_comment "
					+ "values(semi_comment_cidx.nextval, ?, ?, 0, ?, ?, 0, 0, sysdate, ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, dto.getIdx());
			ps.setString(2, dto.getR_comment());
			ps.setString(3, dto.getId());
			ps.setString(4, dto.getYid());
			ps.setString(5, dto.getNickname());
			result = ps.executeUpdate();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close(); 
			}catch(Exception e2) {}
		}
	}
	
	public ArrayList<CommentDTO> semiListComment(int idx){
		try {
			dbConnect();
			String sql = "select * from semi_comment where idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs = ps.executeQuery();
			ArrayList<CommentDTO> arr = new ArrayList<CommentDTO>();
			
			while(rs.next()) {
				int cidx = rs.getInt("cidx");
				idx = rs.getInt("idx");
				String r_comment = rs.getString("r_comment");
				int clike = rs.getInt("clike");
				String id = rs.getString("id");
				String yid = rs.getString("yid");
				int ref = rs.getInt("ref");
				int lev = rs.getInt("lev");
				Date rdate = rs.getDate("rdate");
				String nickname = rs.getString("nickname");
				
				CommentDTO dto = new CommentDTO(cidx, idx, r_comment, clike, id, yid, ref, lev, rdate, nickname);
			
				arr.add(dto);
			}
			
			return arr;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if (rs != null)rs.close();
				if (ps != null)ps.close();
				if (conn != null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/*게시글(이미지), 좋아요, 댓글,댓글좋아요 삭제로직(게시글(이미지), 좋아요, 댓글삭제 삭제구현)*/
	public int semiDeleteComment(int idx) {
		try {
			dbConnect();
			String sql = "delete from semi_comment where idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			int result = ps.executeUpdate();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if (ps != null)ps.close();
				if (conn != null)conn.close();
			}catch(Exception e2) {}
		}
	}
}
