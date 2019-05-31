package utility;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;

public class Utility {
	
	// 직업 코드에 매칭되는 해당 문자열 value를 반환하는 메소드
	public static String getCodeValue(String code){
		String value = null;
		Hashtable codes = new Hashtable();
		codes.put("A01", "회사원");
		codes.put("A02", "전산관련직");
		codes.put("A03", "연구전문직");
		codes.put("A04", "각종학교학생");
		codes.put("A05", "일반자영업");
		codes.put("A06", "공무원");
		codes.put("A07", "의료인");
		codes.put("A08", "법조인");
		codes.put("A09", "종교/언론/예술인");
		codes.put("A10", "기타");
		 
		value = (String)codes.get(code);
		 
		return value;
		}
	
	// getDay()를 통해 받아온 날짜(List 타입)를 가지고서 
	// 날짜 비교( 현재 날짜 혹은 1일전, 2일전까지의 날짜 게시물은 new이미지를 붙인다)
	public static boolean compareDay(String wdate) {
		boolean flag = false;
		List<String> list = getDay();
		
		if(wdate.equals(list.get(0))	// 오늘
			||wdate.equals(list.get(1))	// 1일전
			||wdate.equals(list.get(2))) { // 2일전
				flag=true;
		}
		
		return flag;
	}
	
	// 현재 날짜를 받아서 String으로 고치고 List에 담아 반환하는 메소드
	private static List<String> getDay(){
		List<String> list = new ArrayList<String>();
		// "yyyy-MM-dd"에서 소문자 mm으로 쓰면 안됨
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		for(int i = 0; i<3;i++) {
			list.add(sd.format(cal.getTime()));	// 현재날짜 넣고
			cal.add(Calendar.DATE, -1);	// 그전날짜로 바꾸고 다시 올라가서 그전 날짜 넣고...
										// Calendar.DATE는 상수로서 5, 하루 단위로 -1한다는 의미
			
		}
		
		return list;
	}
	
	public static String checkNull(String str) {
		if (str == null)
			str = "";
		return str;
	}

	/** 
	  * @param totalRecord 전체 레코드수 
	  * @param nowPage     현재 페이지 
	  * @param recordPerPage 페이지당 레코드 수  
	  * @param col 검색 컬럼  
	  * @param word 검색어
	  * @return 페이징 생성 문자열
	  */ 
	public static String paging(int totalRecord, int nowPage, int recordPerPage, String col, String word){ 
	   int pagePerBlock = 5; // 블럭당 페이지 수 
	   int totalPage = (int)(Math.ceil((double)totalRecord/recordPerPage)); // 전체 페이지  
	   int totalGrp = (int)(Math.ceil((double)totalPage/pagePerBlock));// 전체 그룹 
	   int nowGrp = (int)(Math.ceil((double)nowPage/pagePerBlock));    // 현재 그룹 
	   int startPage = ((nowGrp - 1) * pagePerBlock) + 1; // 특정 그룹의 페이지 목록 시작  
	   int endPage = (nowGrp * pagePerBlock);             // 특정 그룹의 페이지 목록 종료   
	    
	   StringBuffer str = new StringBuffer(); 
	   str.append("<div style='text-align:center'>"); 
	   str.append("<ul class='pagination'> ");
	   int _nowPage = (nowGrp-1) * pagePerBlock; // 이전 그룹의 마지막 페이지 값 
	   if (nowGrp >= 2){ 
	     str.append("<li><a href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>이전</A></li>"); 
	   } 
	 
	   for(int i=startPage; i<=endPage; i++){ 
	     if (i > totalPage){ 
	       break; 
	     } 
	 
	     if (nowPage == i){ 
	    	 // 현재 페이지에서 현재 페이지를 누르면 링크에 #만 더 들어갈 뿐이다, #은 빼도 무관
	    	 // 현재 페이지가 아닌 다른 페이지를 누르면 파라미터를 통해 다시 list.jsp를 호출
	       str.append("<li class='active'><a href=>"+i+"</a></li>"); 
	     }else{ 
	       str.append("<li><a href='./list.jsp?col="+col+"&word="+word+"&nowPage="+i+"'>"+i+"</A></li>");   
	     } 
	   } 
	       
	   _nowPage = (nowGrp * pagePerBlock)+1; // 이후 그룹의 첫번째 페이지 값 
	   if (nowGrp < totalGrp) { 
	     str.append("<li><A href='./list.jsp?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>다음</A></li>"); 
	   }
	   str.append("</ul>");
	   str.append("</div>");
	    
	   return str.toString();
	} 
}