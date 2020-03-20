package com.kh.portfolio.board.dao;

import java.util.List;

import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.NboardVO;

public interface NboardDAO {

	//카테고리 읽어오기
	List<BoardCategoryVO> getCategory3();
	
	//게시글 작성
	int write3(NboardVO nboardVO);
//int filewrite2(AboardFileVO aboardFileVO);
	//게시글수정
	int modify3(NboardVO nboardVO);
	
	//게시글 삭제
	int delete3(String nbnum);
//첨부파일 1건 삭제
	//int fileDelete2(String fid);
	//게시글 첨부파일 전체 삭제
	//int filesDelete2(String abnum);
	
	//게시글 보기
	NboardVO view3(String nbnum);
//List<AboardFileVO> fileviews2(String abnum);
	//조회수 1 증가
	int updateHit3(String nbnum);
	
	//게시글 목록
	//전체
	List<NboardVO> list3();
	//검색어 x 페이징
	List<NboardVO> list3(int startRec, int endRec);
	//검색어 o 페이징
	List<NboardVO> list3(int startRec, int endRec, String searchType,String keyword);
	//총레코드수
	int totalRecordCount3(String searchType,String keyword);
	
//게시글 답글작성
	//int reply2(AboardVO aboardVO);
//첨부파일 조회
	//AboardFileVO fileView2(String fid);
}
