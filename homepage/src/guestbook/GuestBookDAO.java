package guestbook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;

public class GuestBookDAO {
	
	public int total(Map map) {
		int total = 0;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from guestbook ");
		
		if(word.trim().length()>0 && col.equals("title_content")) {
			sql.append(" where title like '%'||?||'%' ");
			sql.append(" or content like '%'||?||'%' ");
		}
		else if(word.trim().length()>0) {
			sql.append(" where "+col+" like '%'||?||'%' ");
		}
		try {
			int i = 0;
			pstmt=con.prepareStatement(sql.toString());
			
			if(word.trim().length()>0 && col.equals("title_content")) {
				pstmt.setString(++i, word);
				pstmt.setString(++i, word);
			}
			else if(word.trim().length()>0) {
				pstmt.setString(++i, word);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				total=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return total;
	}
	
	public List<GuestBookDTO> list(Map map) {
		List<GuestBookDTO> list = new ArrayList<GuestBookDTO>();
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select no, name, part, regdate, title, grpno, indent, ansnum, r ");
		sql.append(" from( ");
		sql.append(" 	select no, name, part, regdate, title, grpno, indent, ansnum, rownum r ");
		sql.append(" 	from( ");
		sql.append(" 		select no, name, part, to_char(regdate,'yyyy-mm-dd') regdate, title, grpno, indent, ansnum ");
		sql.append(" 		from guestbook ");
		
		if(word.trim().length()>0 && col.equals("title_content")) {
			sql.append(" where title like '%'||?||'%' ");
			sql.append(" or content like '%'||?||'%' ");
		}
		else if(word.trim().length()>0) {
			sql.append(" where "+col+" like '%'||?||'%' ");
		}
		
		sql.append(" 		order by grpno desc, ansnum asc ");
		sql.append("	) ");
		sql.append(" ) where r>= ? and r<= ? ");
		
		try {
			int i = 0;
			pstmt = con.prepareStatement(sql.toString());
			
			if(word.trim().length()>0 && col.equals("title_content")) {
				pstmt.setString(++i, word);
				pstmt.setString(++i, word);
			}
			else if(word.trim().length()>0) {
				pstmt.setString(++i, word);
			}
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GuestBookDTO dto = new GuestBookDTO();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setPartStr(rs.getString("part"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setTitle(rs.getString("title"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return list;
	}
	
	public boolean createReply(GuestBookDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" insert into guestbook (no, name, gender, title, content, regdate, part, passwd, grpno, indent, ansnum) ");
		sql.append(" values((select nvl(max(no),0)+1 from guestbook), ?,?,?,?,sysdate,?,?, ");
		sql.append(" ?,?,?) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getGender());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getPartStr());
			pstmt.setString(6, dto.getPasswd());
			pstmt.setInt(7, dto.getGrpno());
			pstmt.setInt(8, dto.getIndent()+1);
			pstmt.setInt(9, dto.getAnsnum()+1);
			int cnt = pstmt.executeUpdate();
			
			if (cnt > 0) {
				flag = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	public void upAnsnum(Map map) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update guestbook set ansnum = ansnum + 1 ");
		sql.append(" where grpno=? ");
		sql.append(" and ansnum>? ");
		
		int grpno = (Integer)map.get("grpno");
		int ansnum = (Integer)map.get("ansnum");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			DBClose.close(pstmt, con);
		}
	}
	
	// 부모의 grpno와 indent와 ansnum을 가져올 때 필요한 메소드
	public GuestBookDTO readReply(int no) {
		GuestBookDTO dto = new GuestBookDTO();
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		ResultSet rs = null;
		
		sql.append(" select no, name, gender, title, content, to_char(regdate,'yyyy-mm-dd') regdate, part, passwd, grpno, indent, ansnum from guestbook where no = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPartStr(rs.getString("part"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs,pstmt, con);
		}
		return dto;
	}
	
	/*
	public static String pp(GuestBookDTO dto) {
		StringBuffer str= new StringBuffer();
		
		str.append("번호:"+dto.getNo()+"<br>");
		str.append("이름:"+dto.getName()+"<br>");
		str.append("제목:"+dto.getTitle()+"<br>");
		str.append("내용:"+dto.getContent()+"<br>");
		str.append("분야:"+dto.getPartStr()+"<br>");
		str.append("성별:"+dto.getGender()+"<br>");
		str.append("일자:"+dto.getRegdate()+"<br>");
		str.append("비번:"+dto.getPasswd()+"<br>");
		
		String temp = str.toString();
		
		return temp;
	}
	*/
	
	// c r u d list
	public boolean passwdCheck(Map map) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int no = (Integer)map.get("no");
		String passwd = (String)map.get("passwd");
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from guestbook ");
		sql.append(" where no=? ");
		sql.append(" and passwd=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setInt(1, no);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				int cnt = rs.getInt(1);
				if (cnt > 0) {
					flag = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	public boolean create(GuestBookDTO dto) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" insert into guestbook (no, name, gender, title, content, regdate, part, passwd, grpno) ");
		sql.append(" values((select nvl(max(no),0)+1 from guestbook), ?,?,?,?,sysdate,?,?, ");
		sql.append(" (select nvl(max(grpno),0)+1 from guestbook)) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getGender());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getPartStr());
			pstmt.setString(6, dto.getPasswd());
			int cnt = pstmt.executeUpdate();
			
			if (cnt > 0) {
				flag = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}

	public GuestBookDTO read(int no) {
		GuestBookDTO dto = new GuestBookDTO();
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		ResultSet rs = null;
		
		sql.append(" select no, name, gender, title, content, to_char(regdate,'yyyy-mm-dd') regdate, part, passwd from guestbook where no = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPartStr(rs.getString("part"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setRegdate(rs.getString("regdate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs,pstmt, con);
		}
		return dto;
	}

	public boolean update(GuestBookDTO dto) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" update guestbook ");
		sql.append(" set title = ?, ");
		sql.append("    content = ?, ");
		sql.append("    part = ?, ");
		sql.append("    passwd = ?, ");
		sql.append("    name = ?, ");
		sql.append("    gender = ? ");
		sql.append(" where no = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getPartStr());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getName());
			pstmt.setString(6, dto.getGender());
			pstmt.setInt(7, dto.getNo());
			int cnt = pstmt.executeUpdate();
			
			if (cnt > 0) {
				flag = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}

	public boolean delete(int no) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" delete from guestbook ");
		sql.append(" where no = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setInt(1, no);
			int cnt = pstmt.executeUpdate();
			if (cnt > 0)
				flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	// 페이징 적용전 list()
	/*
	public List<GuestBookDTO> list(Map map) {
		List<GuestBookDTO> list = new ArrayList<GuestBookDTO>();
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select no, name, part, to_char(regdate,'yyyy-mm-dd') regdate, title, grpno, indent, ansnum ");
		sql.append(" from guestbook ");
		
		if(word.trim().length()>0 && col.equals("title_content")) {
			sql.append(" where title like '%'||?||'%' ");
			sql.append(" or content like '%'||?||'%' ");
		}
		else if(word.trim().length()>0) {
			sql.append(" where "+col+" like '%'||?||'%' ");
		}
		
		sql.append(" order by grpno desc, ansnum asc ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			if(word.trim().length()>0 && col.equals("title_content")) {
				pstmt.setString(1, word);
				pstmt.setString(2, word);
			}
			else if(word.trim().length()>0) {
				pstmt.setString(1, word);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GuestBookDTO dto = new GuestBookDTO();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setPartStr(rs.getString("part"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setTitle(rs.getString("title"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return list;
	}
	*/
}
