package gallery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import gallery.GalleryDTO;
import db.DBClose;
import db.DBOpen;

public class GalleryDAO {
	public boolean updateFile(Map map) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		String gno = (String)map.get("gno");
		String fname = (String)map.get("fname");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" update gallery ");
		sql.append(" set fname=? ");
		sql.append(" where gno=? ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			
			pstmt.setString(1, fname);
			pstmt.setString(2, gno);
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0)
				flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	public List imgRead(int gno){
		List list = new ArrayList();
		Connection con = DBOpen.open();
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * FROM  ");
		sql.append("   (  ");
		sql.append("      select    ");
		sql.append("          lag(gno,2)     over (order by gno) pre_gno2,    ");
		sql.append("          lag(gno,1)     over (order by gno ) pre_gno1,   ");
		sql.append("          gno,  ");
		sql.append("          lead(gno,1)    over (order by gno) nex_gno1,    ");
		sql.append("          lead(gno,2)    over (order by gno) nex_gno2,    ");
		
		sql.append("          lag(fname,2)  over (order by gno) pre_file2,     ");
		sql.append("          lag(fname,1)  over (order by gno ) pre_file1,  ");
		sql.append("          fname,   ");
		sql.append("          lead(fname,1) over (order by gno) nex_file1,  ");
		sql.append("          lead(fname,2) over (order by gno) nex_file2   ");
		sql.append("          from (  ");
		sql.append("               SELECT gno, fname   ");
		sql.append("               FROM gallery ");
		sql.append("               ORDER BY gno DESC  ");
		sql.append("          )  ");
		sql.append("   )  ");
		sql.append("   WHERE gno = ? ");
		
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, gno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				int[] noArr = 
					   {
						rs.getInt("pre_gno2"),
						rs.getInt("pre_gno1"),
						rs.getInt("gno"),
						rs.getInt("nex_gno1"),
						rs.getInt("nex_gno2")
					    };
				String[] files = 
					    {
						rs.getString("pre_file2"),
						rs.getString("pre_file1"),
						rs.getString("fname"),
						rs.getString("nex_file1"),
						rs.getString("nex_file2")
						};
				list.add(files);
				list.add(noArr);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DBClose.close(rs, pstmt, con);
		}
				
		return list;
	}
	
	public int total(String col, String word) {
		int total = 0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select count(*) ");
		sql.append(" from gallery ");
		
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
	
	public void upViewcnt(int gno) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update gallery set viewcnt = viewcnt + 1 ");
		sql.append(" where gno = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, gno);

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

		sql.append(" select count(gno) as cnt ");
		sql.append(" from gallery ");
		sql.append(" where gno = ? ");
		sql.append(" and passwd=? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, (Integer) map.get("gno"));
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
	
	public List<GalleryDTO> list(Map map) {
		List<GalleryDTO> list = new ArrayList<GalleryDTO>();

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String col = (String) map.get("col");
		String word = (String) map.get("word");
		int sno = (Integer) map.get("sno");
		int eno = (Integer) map.get("eno");

		StringBuffer sql = new StringBuffer();
		sql.append(" select gno, fname, iname, title, viewcnt, wdate, r ");
		sql.append(" from( ");
		sql.append("     select gno, fname, iname, title, viewcnt, wdate, rownum r ");
		sql.append("         from( ");
		sql.append(" 			select gno, fname, iname, title, viewcnt, to_char(wdate, 'yyyy-mm-dd') wdate ");
		sql.append(" 			from gallery ");

		if (word.trim().length() > 0 && col.equals("title_content")) {
			sql.append(" where title like '%'||?||'%' ");
			sql.append(" or content like '%'||?||'%' ");
		} else if (word.trim().length() > 0) {
			sql.append(" where " + col + " like '%'||?||'%' ");
		}

		sql.append(" 			order by gno desc ");
		sql.append(" 		) ");
		sql.append(" ) where r>=? and r<=? ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			int i = 0;
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
				GalleryDTO dto = new GalleryDTO();
				dto.setGno(rs.getInt("gno"));
				dto.setFname(rs.getString("fname"));
				dto.setIname(rs.getString("iname"));
				dto.setTitle(rs.getString("title"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setWdate(rs.getString("wdate"));

				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return list;
	}

	public boolean delete(int gno) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" DELETE ");
		sql.append(" FROM gallery ");
		sql.append(" WHERE gno=? ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setInt(1, gno);

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

	public boolean update(GalleryDTO dto) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" update gallery ");
		sql.append(" set iname=?, ");
		sql.append("     title=?, ");
		sql.append("     content=? ");
		sql.append(" where gno=? ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getIname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getGno());

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

	public GalleryDTO read(int gno) {
		GalleryDTO dto = null;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT gno, fname, iname, title, content, viewcnt, to_char(wdate,'yyyy-mm-dd') wdate ");
		sql.append(" FROM gallery ");
		sql.append(" WHERE gno = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setInt(1, gno);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new GalleryDTO();
				dto.setGno(rs.getInt("gno"));
				dto.setFname(rs.getString("fname"));
				dto.setIname(rs.getString("iname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setWdate(rs.getString("wdate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return dto;
	}

	public boolean create(GalleryDTO dto) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" insert into gallery(gno, fname, iname, title, content, passwd, wdate) ");
		sql.append(" values((select nvl(max(gno),0)+1 as gno from gallery), ");
		sql.append(" ?,?,?,?,?, sysdate) ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getFname());
			pstmt.setString(2, dto.getIname());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getPasswd());

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
