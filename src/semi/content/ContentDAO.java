package semi.content;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

public class ContentDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;

	public static final int ERROR = -1;

	public ContentDAO() {
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

	/* 글쓰기 로직 */
	public int semiWrite(ContentDTO dto) {
		try {
			dbConnect();
			String sql = "insert into semi_content " + "values(semi_content_idx.nextval,?,?,?,0,0,sysdate,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getNickname());
			ps.setString(3, dto.getContent());
			ps.setString(4, dto.getMainimg());
			ps.setString(5, dto.getSubimg1());
			ps.setString(6, dto.getSubimg2());
			ps.setString(7, dto.getSubimg3());

			int result = ps.executeUpdate();

			return result;
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
	

	/*게시글 수정*/
	public int semiContentModify(String content, int idx) {
		try {
			dbConnect();
			String sql = "update semi_content set content = ? where idx = ?";
			int result = 0;
			ps = conn.prepareStatement(sql);
			ps.setString(1, content);
			ps.setInt(2, idx);			
			result = ps.executeUpdate();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if (ps != null)ps.close();
				if (conn != null)conn.close();
			}catch(Exception e2){}
		}
	}
	
	
	/*F페이지 이미지 리스트로 가져오는 로직*/
	public ArrayList<ContentDTO> ypageList(int pnum, int ls,String id){
		try {
			dbConnect();
			int startNum = (pnum - 1) * ls + 1;
			System.out.println("시작 >>> " + startNum);
			int endNum = pnum * ls;
			System.out.println("끝점 >>> " + endNum);
			String sql = "select * from (select rownum as rnum,a.* FROM (select * from SEMI_CONTENT where id=? order by IDX desc)a)b where rnum>=? and rnum<=?";
			//String sql = "select * from semi_content where id = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setInt(2, startNum);
			ps.setInt(3, endNum);
			
			rs = ps.executeQuery();
			ArrayList<ContentDTO> arr = new ArrayList<ContentDTO>();
			while(rs.next()) {
				int idx = rs.getInt("idx");
				String mainimg = rs.getString("mainimg");
				ContentDTO dto = new ContentDTO(idx,mainimg);
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
	
	/* 총 리스트 확인 - 닉네임, 이미지, 컨텐츠, 댓글(내가 팔로우한 사람들만 나오는 리스트 미완성) */
	public ArrayList<ContentDTO> semiList(int pnum, int ls) {
		try {
			dbConnect();
			int startNum = (pnum - 1) * ls + 1;
			System.out.println("시작 >>> " + startNum);
			int endNum = pnum * ls;
			System.out.println("끝점 >>> " + endNum);
			String sql = "select * from (select rownum as rnum,a.* FROM (select * from SEMI_CONTENT order by IDX desc)a)b where rnum>=? and rnum<=?";
			// "SELECT * FROM SEMI_CONTENT where rownum>=? and rownum<=? order by idx desc";
			// WHERE IDX >=? AND IDX <=? ORDER BY idx DESC
			ps = conn.prepareStatement(sql);
			ps.setInt(1, startNum);
			ps.setInt(2, endNum);
			rs = ps.executeQuery();
			ArrayList<ContentDTO> arr = new ArrayList<ContentDTO>();
			while (rs.next()) {
				int idx = rs.getInt("idx");
				String id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String content = rs.getString("content");
				int relike = rs.getInt("relike");
				int readnum = rs.getInt("readnum");
				Date rdate = rs.getDate("rdate");
				String mainimg = rs.getString("mainimg");
				String subimg1 = rs.getString("subimg1");
				String subimg2 = rs.getString("subimg2");
				String subimg3 = rs.getString("subimg3");
				ContentDTO dto = new ContentDTO(idx, id, nickname, content, relike, readnum, rdate, mainimg, subimg1,
						subimg2, subimg3);
				arr.add(dto);
			}
			return arr;
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

	/* 총 게시글 수 확인 로직 페이징용 */
	public int getTotalCnt() {
		try {
			dbConnect();
			String sql = "select count(*) from SEMI_CONTENT";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			return count == 0 ? 1 : count;
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
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

	/* 총 게시글 수 확인 로직 */
	public int getTotalCnt(String id) {
		try {
			dbConnect();
			String sql = "select count(*) from SEMI_CONTENT where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			int count = 0;
			if (rs.next()) {
				count = rs.getInt(1);
			}
			;
			return count;
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
			} catch (Exception e2) {
			}
		}
	}

	/* 디테일 페이지 */
	public ContentDTO semiContent(int idx) {
		try {
			dbConnect();
			String sql = "select * from semi_content where idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs = ps.executeQuery();
			ContentDTO dto = null;
			while (rs.next()) {
				idx = rs.getInt("idx");
				String id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String content = rs.getString("content");
				int relike = rs.getInt("relike");
				int readnum = rs.getInt("readnum");
				Date rdate = rs.getDate("rdate");
				String mainimg = rs.getString("mainimg");
				String subimg1 = rs.getString("subimg1");
				String subimg2 = rs.getString("subimg2");
				String subimg3 = rs.getString("subimg3");

				dto = new ContentDTO(idx, id, nickname, content, relike, readnum, rdate, mainimg, subimg1, subimg2,
						subimg3);
			}
			return dto;
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

	/* 조회수 증가 관련 로직 */
	public void semiReadCount(int idx) {
		try {
			dbConnect();
			String sql = "update semi_content set readnum = (readnum+1) where idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
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

	/* 이미지 파일 이름 찾는 로직 */
	public ArrayList<ContentDTO> semiFileFind(int idx) {
		try {
			dbConnect();
			String sql = "select mainimg, subimg1, subimg2, subimg3 from semi_content where idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs = ps.executeQuery();
			String mainimg = "";
			String subimg1 = "";
			String subimg2 = "";
			String subimg3 = "";

			ArrayList<ContentDTO> arr = new ArrayList<ContentDTO>();

			if (rs.next()) {
				mainimg = rs.getString("mainimg");
				subimg1 = rs.getString("subimg1");
				subimg2 = rs.getString("subimg2");
				subimg3 = rs.getString("subimg3");

				ContentDTO dto = new ContentDTO(mainimg, subimg1, subimg2, subimg3);
				arr.add(dto);
			}

			System.out.println("fileName >>> " + arr.get(0).getMainimg());
			System.out.println("fileName >>> " + arr.get(0).getSubimg1());
			System.out.println("fileName >>> " + arr.get(0).getSubimg2());
			System.out.println("fileName >>> " + arr.get(0).getSubimg3());
			return arr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
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

	/* 게시글(이미지), 좋아요, 댓글,댓글좋아요 삭제로직(모두 삭제구현) */
	public int semiDelete(int idx) {
		try {
			dbConnect();
			String sql = "delete from semi_content where idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			int result = ps.executeUpdate();

			return result;
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


	/*스크랩하는 추가*/
	public int semiAddScrap(int idx,String id,String yid) {
		try {
			dbConnect();
			int result = 0;
			String sql = "insert into semi_scrap values(?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1,idx);
			ps.setString(2,id);
			ps.setString(3,yid);
			result = ps.executeUpdate();
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
	
	/*스크랩하는 삭제*/
	public int semiDelScrap(int idx,String id) {
		try {
			dbConnect();
			int result = 0;
			String sql = "delete from semi_scrap where idx = ? and id = ?";
			result = 0;
			ps = conn.prepareStatement(sql);
			ps.setInt(1,idx);
			ps.setString(2,id);
			result=ps.executeUpdate();
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
	
	/*스크랩된걸 리스트로 가져오는 로직*/
	public ArrayList<ContentDTO> semiScrapList(String id){
		try {
			dbConnect();
			String sql = "select * from semi_scrap where id = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			ArrayList<ContentDTO> arr = new ArrayList<ContentDTO>();			
			while(rs.next()) {
				id = rs.getString("id");
				int idx = rs.getInt("idx");
				ContentDTO dto = new ContentDTO(id,idx);
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
	
	/*스크랩이 되어있는지 확인하는 로직*/
	public boolean checkScrap(int idx, String id) {
		try {
			dbConnect();
			String sql = "select * from semi_scrap where id = ? and idx = ?";
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
			} catch (Exception e2) {}
		}
	}
	
	/*스크랩 이미지 이름 찾는 로직*/
	public String semiScrapImgFind(int idx) {
		try {
			dbConnect();
			String sql = "select mainimg from semi_content where idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs = ps.executeQuery();
			String mainimg = "";
			
			if(rs.next()) {
				mainimg = rs.getString("mainimg");
			}
			
			return mainimg;
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
	
	/* ypage 총 스크랩 수 확인 로직 */
	public int getTotalyscr(String yid) {
		try {
			dbConnect();
			String sql = "select count(*) from SEMI_SCRAP where yid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, yid);
			rs = ps.executeQuery();
			int count = 0;
			if (rs.next()) {
				count = rs.getInt(1);
			};
			return count;
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
			} catch (Exception e2) {
			}
		}
	}
	/* mypage 총 스크랩 수 확인 로직 */
	public int getTotalmscr(String id) {
		try {
			dbConnect();
			String sql = "select count(*) from SEMI_SCRAP where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			int count = 0;
			if (rs.next()) {
				count = rs.getInt(1);
			};
			System.out.println("카운트 갯수"+count);
			return count;
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
			} catch (Exception e2) {
			}
		}
	}
	
	
	
	
}
