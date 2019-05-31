package member;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;



public class MemberTest {
	public static void main(String[] args) {
		MemberDAO dao = new MemberDAO();
		
	//	create(dao);
	//	list(dao);
	//	total(dao);
	//	read(dao);
		updatePw(dao);
	}

	private static void updatePw(MemberDAO dao) {
		Map map = new HashMap();
		map.put("id", "user1");
		map.put("pw", "1234");
		
		if(dao.updatePw(map))
			p("비밀번호 변경 성공");
		else
			p("비밀번호 변경 실패");
	}

	private static void read(MemberDAO dao) {
		MemberDTO dto = dao.read("user1");
		p(dto);
	}

	private static void total(MemberDAO dao) {
		Map map = new HashMap();
		map.put("col", "mname");
		map.put("word", "");
		p("전체레코드 갯수: "+dao.total(map));
	}

	private static void list(MemberDAO dao) {
		Map map = new HashMap();
		map.put("col", "mname");
		map.put("word", "개");
		map.put("sno", 1);
		map.put("eno", 5);
		
		List<MemberDTO> list = dao.list(map);
		Iterator<MemberDTO> iter = list.iterator();
		
		while(iter.hasNext()) {
			MemberDTO dto = iter.next();
			p(dto);
			p("===========================");
		}
	}

	private static void p(MemberDTO dto) {
		p("아이디: "+dto.getId());
		p("이름: "+dto.getMname());
		p("이메일: "+dto.getEmail());
		p("전화번호: "+dto.getTel());
		p("직업: "+dto.getJob());
		p("우편번호: "+dto.getZibcode());
		p("주소: "+dto.getAddress1());
		p("상세주소: "+dto.getAddress2());
		p("사진: "+dto.getFname());
	}

	private static void create(MemberDAO dao) {
		MemberDTO dto = new MemberDTO();
		
		dto.setId("user4");
		dto.setPasswd("4444");
		dto.setMname("유저4");
		dto.setTel("444-444-4444");
		dto.setEmail("email4@mail.com");
		dto.setZibcode("44444");
		dto.setAddress1("서울시 종로구 관철동");
		dto.setAddress2("12-1");
		dto.setJob("A04");
		dto.setFname("member1.jpg");
		
		if(dao.create(dto))
			p("생성 성공");
		else
			p("생성 실패");
	}

	private static void p(String string) {
		System.out.println(string);
	}
}
