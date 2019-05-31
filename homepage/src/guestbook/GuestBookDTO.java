package guestbook;

public class GuestBookDTO {
    private int    no      ;
    private String name    ;
    private String gender  ;
    private String title   ;
    private String content ;
    private String regdate ;
    private String[] part  ;
    private String partStr ;
    private String passwd  ;
    private int		grpno  ;
    private int		indent ;
    private int		ansnum ;
    
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String[] getPart() {
		return part;
	}
	public void setPart(String[] part) {
		this.part = part;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getPartStr() {
		if(part!=null) {
			String partStr = "";
			for(int i = 0;i<part.length;i++) {
				partStr += part[i];
				if(i<part.length-1)
					partStr += ",";
			}
			this.partStr = partStr;
		}
		return partStr;
	}
	public void setPartStr(String partStr) {
		this.partStr = partStr;
	}
	public int getGrpno() {
		return grpno;
	}
	public void setGrpno(int grpno) {
		this.grpno = grpno;
	}
	public int getIndent() {
		return indent;
	}
	public void setIndent(int indent) {
		this.indent = indent;
	}
	public int getAnsnum() {
		return ansnum;
	}
	public void setAnsnum(int ansnum) {
		this.ansnum = ansnum;
	}
}
