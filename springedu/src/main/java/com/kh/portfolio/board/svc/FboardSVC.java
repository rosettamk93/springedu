package com.kh.portfolio.board.svc;

import java.util.List;
import java.util.Map;

import com.kh.portfolio.board.vo.FboardFileVO;
import com.kh.portfolio.board.vo.FboardVO;
import com.kh.portfolio.common.PageCriteria;

public interface FboardSVC {

	//상품등록
	int write4(FboardVO fboardVO);
	
	//게시글 수정
	int modify4(FboardVO fboardVO);
	
	//상품삭제
	int delete4(String fnum);
	
	//첨부파일 1건 삭제
	int fileDeletef(String fid);

	//게시글보기
	Map<String,Object> view4(String fnum);
	
	//상품목록
	//1전체
	List<FboardVO> listf();
	//2검색어x게시글페이징
	List<FboardVO> list( int startRec, int endRec);
//3)검색어 있는 게시글검색(요청페이지, 검색유형, 검색어)
	List<FboardVO> list( String reqPage, String searchType,String keyword);
	
//페이지 제어
	PageCriteria getPageCriteria(String reqPage, String searchType,String keyword);
	
	//첨부파일조회
	FboardFileVO fileViewf(String fid);
	}
