package com.kh.portfolio.board.svc;

import java.util.List;
import java.util.Map;

import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.NboardVO;
import com.kh.portfolio.common.PageCriteria;

public interface NboardSVC {
//카테고리 읽어오기
	List<BoardCategoryVO> getCategory();
	
	//게시글작성
	int write3(NboardVO nboardVO);
	
	//게시글 수정
	int modify3(NboardVO nboardVO);
	
	//게시글삭제
	int delete3(String nbnum);
	
	//게시글보기
	Map<String,Object> view3(String nbnum);
	
	//게시글목록
	//1)전체
	List<NboardVO> list3();
	//2)검색어x 페이징
	List<NboardVO> list3(int startRec, int endRec);
	//3)검색어o검색
	List<NboardVO> list3(String reqPage, String searchType, String keyword);
	//페이지제어
	PageCriteria getPageCriteria(String reqPage, String searchType,String keyword);
}
