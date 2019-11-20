package semi.comment;

import java.util.Date;

public class CommentDTO {
	private int cidx;
	private int idx;
	private String r_comment;
	private int clike;
	private String id;
	private String yid;
	private int ref;
	private int lev;
	private Date rdate;
	private String nickname;
	
	public CommentDTO() {super();}
	
	public CommentDTO(int cidx, int idx, String r_comment, int clike, String id, String yid, int ref, int lev,
			Date rdate, String nickname) {
		super();
		this.cidx = cidx;
		this.idx = idx;
		this.r_comment = r_comment;
		this.clike = clike;
		this.id = id;
		this.yid = yid;
		this.ref = ref;
		this.lev = lev;
		this.rdate = rdate;
		this.nickname = nickname;
	}
	
	public int getCidx() {
		return cidx;
	}
	public void setCidx(int cidx) {
		this.cidx = cidx;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getR_comment() {
		return r_comment;
	}
	public void setR_comment(String r_comment) {
		this.r_comment = r_comment;
	}
	public int getClike() {
		return clike;
	}
	public void setClike(int clike) {
		this.clike = clike;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getYid() {
		return yid;
	}
	public void setYid(String yid) {
		this.yid = yid;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getLev() {
		return lev;
	}
	public void setLev(int lev) {
		this.lev = lev;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	
}
