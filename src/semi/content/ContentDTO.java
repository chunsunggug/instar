package semi.content;

import java.util.Date;

public class ContentDTO {

	private int idx;
	private String id;
	private String nickname;
	private String content;
	private int relike;
	private int readnum;
	private Date rdate;
	private String mainimg;
	private String subimg1;
	private String subimg2;
	private String subimg3;
	
	public ContentDTO() {super();}

	public ContentDTO(int idx, String id, String nickname, String content, int relike, int readnum, Date rdate,
			String mainimg, String subimg1, String subimg2, String subimg3) {
		super();
		this.idx = idx;
		this.id = id;
		this.nickname = nickname;
		this.content = content;
		this.relike = relike;
		this.readnum = readnum;
		this.rdate = rdate;
		this.mainimg = mainimg;
		this.subimg1 = subimg1;
		this.subimg2 = subimg2;
		this.subimg3 = subimg3;
	}
	
	public ContentDTO(String mainimg, String subimg1, String subimg2, String subimg3) {
		super();
		this.mainimg = mainimg;
		this.subimg1 = subimg1;
		this.subimg2 = subimg2;
		this.subimg3 = subimg3;
	}

	public ContentDTO(String id, int idx) {
		super();
		this.id = id;
		this.idx = idx;
	}

	public ContentDTO(int idx, String mainimg) {
		super();
		this.idx = idx;
		this.mainimg = mainimg;
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

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getRelike() {
		return relike;
	}

	public void setRelike(int relike) {
		this.relike = relike;
	}

	public int getReadnum() {
		return readnum;
	}

	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}

	public Date getRdate() {
		return rdate;
	}

	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}

	public String getMainimg() {
		return mainimg;
	}

	public void setMainimg(String mainimg) {
		this.mainimg = mainimg;
	}

	public String getSubimg1() {
		return subimg1;
	}

	public void setSubimg1(String subimg1) {
		this.subimg1 = subimg1;
	}

	public String getSubimg2() {
		return subimg2;
	}

	public void setSubimg2(String subimg2) {
		this.subimg2 = subimg2;
	}

	public String getSubimg3() {
		return subimg3;
	}

	public void setSubimg3(String subimg3) {
		this.subimg3 = subimg3;
	}
	
	
	
}
