package com.kh.portfolio.board.svc;

import java.util.List;
import java.util.Map;

import com.kh.portfolio.board.vo.AboardFileVO;
import com.kh.portfolio.board.vo.AboardVO;
import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.common.PageCriteria;

public interface AboardSVC {
//카테고리 읽어오기
	List<BoardCategoryVO> getCategory();
	
	//게시글작성
	int write2(AboardVO aboardVO);
	
	//게시글수정
	int modify2(AboardVO aboardVO);
	
	//게시글삭제
	int delete2(String abnum);
	
	//첨부파일 1건 삭제
	int fileDelete2(String fid);
	
	//게시글보기
	Map<String,Object> view2(String abnum);
	
	//게시글목록
	//1)전체
	List<AboardVO> list2();
	//2)검색어 없는 게시글 페이징
	List<AboardVO> list2( int startRec, int endRec);
	//3)검색어 있는 게시글 검색(요청페이지, 검색유형, 검색어)
	List<AboardVO> list2(String reqPage, String searchType, String keyword);
	
	//페이지 제어
	PageCriteria getPageCriteria(String reqPage, String searchType,String keyword);
	
	//게시글답글작성
	int reply2(AboardVO aboardVO);
	//첨부파일조회
	AboardFileVO fileview2(String fid);
}
