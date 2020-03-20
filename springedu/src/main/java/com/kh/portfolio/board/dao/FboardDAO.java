package com.kh.portfolio.board.dao;

import java.util.List;

import com.kh.portfolio.board.vo.FboardFileVO;
import com.kh.portfolio.board.vo.FboardVO;

public interface FboardDAO {

	//상품등록
	int write4(FboardVO fboardVO);
	int fileWritef(FboardFileVO fboardFileVO);
	//상품수정
	int modify4(FboardVO fboardVO);
	
	//상품삭제
	int delete4(String fnum);
	//첨부파일 1건 삭제
	int fileDeletef(String fid);
	//첨부파일 전체삭제
	int filesDeletef(String fnum);
	
	//상품보기
	FboardVO view4(String fnum);
	List<FboardFileVO> fileViewsf(String fnum);
	
	//게시글목록
	//전체
	List<FboardVO> listf();
	//2) 검색어 없는 게시글 페이징
	List<FboardVO> listf(int startRec, int endRec);
	//3) rjatordj검색어 있는 게시글검색(전체,제목,내용,작성자ID,별칭)
	List<FboardVO> listf(int startRec, int endRec, String searchType,String keyword);
	//총레코드수
	int totalRecordCount(String searchType,String keyword);	
	
	//첨부파일조회
	FboardFileVO fileviewf(String fid);
}
