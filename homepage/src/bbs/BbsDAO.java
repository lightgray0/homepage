package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;

public class BbsDAO {
	// c r u d list
	public int total(String col, String word) {
		int total = 0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select count(*) ");
		sql.append(" from bbs ");
		
		if (word.trim().length() > 0 && col.equals("title_content")) {
			sql.append(" where title like '%'||?||'%' ");
			sql.append(" or content like '%'||?||'%' ");
		} else if (word.trim().length() > 0) {
			sql.append(" where " + col + " like '%'||?||'%' ");
		}
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			if (word.trim().length() > 0 && col.equals("title_content")) {
				pstmt.setString(1, word);
				pstmt.setString(2, word);
			} else if (word.trim().length() > 0) {
				pstmt.setString(1, word);
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
	
	public void upAnsnum(Map map) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update bbs set ansnum = ansnum + 1 ");
		sql.append(" where grpno = ? and ansnum > ? ");

		int grpno = (Integer) map.get("grpno");
		int ansnum = (Integer) map.get("ansnum");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
	}

	public boolean createReply(BbsDTO dto) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" insert into bbs(bbsno, wname, title, content, passwd, wdate, grpno, indent, ansnum) ");
		sql.append(" values((select nvl(max(bbsno),0) + 1 as bbsno from bbs), ");
		sql.append(" ?, ?, ?, ?, sysdate, ");
		sql.append(" ?, ?, ?) ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setInt(5, dto.getGrpno());
			pstmt.setInt(6, dto.getIndent() + 1);
			pstmt.setInt(7, dto.getAnsnum() + 1);

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

	public BbsDTO readReply(int bbsno) {
		BbsDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT bbsno, grpno, title, indent, ansnum ");
		sql.append(" FROM bbs ");
		sql.append(" WHERE bbsno = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setInt(1, bbsno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setTitle(rs.getString("title"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
			}
		} catch (SQLException e) {
		}
		return dto;
	}

	public void upViewcnt(int bbsno) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update bbs set viewcnt = viewcnt + 1 ");
		sql.append(" where bbsno = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
	}

	public boolean passCheck(Map map) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" select count(bbsno) as cnt ");
		sql.append(" from bbs ");
		sql.append(" where bbsno = ? ");
		sql.append(" and passwd=? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, (Integer) map.get("bbsno"));
			pstmt.setString(2, (String) map.get("passwd"));

			rs = pstmt.executeQuery();

			if (rs.next()) {
				int cnt = rs.getInt("cnt");
				if (cnt > 0)
					flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return flag;
	}
	
	
	public List<BbsDTO> list(Map map){
		List<BbsDTO> list = new ArrayList<BbsDTO>();
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum, r ");
		sql.append(" from( ");
		sql.append("     select bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum, rownum r ");
		sql.append("         from( ");
		sql.append(" 			select bbsno, wname, title, viewcnt, to_char(wdate, 'yyyy-mm-dd') wdate, grpno, ");
		sql.append(" 			indent, ansnum from bbs ");
		
		if(word.trim().length()>0 && col.equals("title_content")) {
			sql.append(" where title like '%'||?||'%' ");
			sql.append(" or content like '%'||?||'%' ");
		}else if(word.trim().length()>0)
			sql.append(" where " + col + " like '%'||?||'%' ");
		
		sql.append(" 			order by grpno desc, ansnum asc ");
		sql.append(" 		) ");
		sql.append(" ) where r>=? and r<=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			
			// 두 개의 경우의 수로 물음표 인덱스가 바뀌기 때문에
			// 자연스럽게 ++i를 통해 자동적으로 하나씩 넘겨가면서 대입할 수 있도록
			int i=0;
			if (word.trim().length() > 0 && col.equals("title_content")) {
				pstmt.setString(++i, word);
				pstmt.setString(++i, word);
			} else if (word.trim().length() > 0) {
				pstmt.setString(++i, word);
			}
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BbsDTO dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setWname(rs.getString("wname"));
				dto.setWdate(rs.getString("wdate"));
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
	
	public boolean delete(int bbsno) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" DELETE ");
		sql.append(" FROM bbs ");
		sql.append(" WHERE bbsno=? ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setInt(1, bbsno);

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

	public boolean update(BbsDTO dto) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" update bbs ");
		sql.append(" set wname=?, ");
		sql.append("     title=?, ");
		sql.append("     content=? ");
		sql.append(" where bbsno=? ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getBbsno());

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

	public BbsDTO read(int bbsno) {
		BbsDTO dto = null;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT bbsno, wname, title, content,  viewcnt, ");
		sql.append(" wdate, grpno, indent, ansnum FROM bbs ");
		sql.append(" WHERE bbsno = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setInt(1, bbsno);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setWdate(rs.getString("wdate"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return dto;
	}
	
	public boolean create(BbsDTO dto) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into bbs(bbsno, wname, title, content, passwd, wdate, grpno) ");
		sql.append(" values((select nvl(max(bbsno),0) + 1 as bbsno from bbs), ");
		sql.append(" ?, ?, ?, ?, sysdate, ");
		sql.append(" (select nvl(max(grpno),0) + 1 as grpno from bbs)) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());

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
}
