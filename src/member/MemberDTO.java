package member;

import java.util.Date;

public class MemberDTO {
	private int idx;
	private String id;
	private String pwd;
	private String name;
	private String nickname;
	private String guide;
	private String homepage;
	private String img;
	private Date rdate;
	
	
	public MemberDTO() {
		super();
	}
	

	public MemberDTO(int idx, String id, String pwd, String name, String nickname, String img, Date rdate) {
		super();
		this.idx = idx;
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.nickname = nickname;
		this.img = img;
		this.rdate = rdate;
	}




	public MemberDTO(String id, String name, String nickname, String img,String guide,String homepage) {
		this.id = id;
		this.name = name;
		this.nickname = nickname;
		this.img = img;
		this.guide = guide;
		this.homepage = homepage;
	}



	public String getGuide() {
		return guide;
	}


	public void setGuide(String guide) {
		this.guide = guide;
	}


	public String getHomepage() {
		return homepage;
	}


	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}


	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
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


	public String getPwd() {
		return pwd;
	}


	public void setPwd(String pwd) {
		this.pwd = pwd;
	}


	public String getNickname() {
		return nickname;
	}


	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


	public String getImg() {
		return img;
	}


	public void setImg(String img) {
		this.img = img;
	}


	public Date getRdate() {
		return rdate;
	}


	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	
	
}
