package semi.relike;

import java.util.Date;

public class RelikeDTO {

	private String id;
	private int idx;
	private Date rdate;
	
	public RelikeDTO() {super();}
	
	public RelikeDTO(String id, int idx, Date rdate) {
		super();
		this.id = id;
		this.idx = idx;
		this.rdate = rdate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public Date getRdate() {
		return rdate;
	}

	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	
	
}
