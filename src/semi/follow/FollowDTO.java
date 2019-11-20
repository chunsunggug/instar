package semi.follow;

import java.util.Date;

public class FollowDTO {
	int idx;
	String id;
	String yid;
	Date rdate;
	
	
	public FollowDTO() {	super();	}
	
	
	
	public FollowDTO(String id, String yid) {
		super();
		this.id = id;
		this.yid = yid;
	}



	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
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
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	
	
}
