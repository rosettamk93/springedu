package com.kh.portfolio.board.dao;

import java.util.List;

import com.kh.portfolio.board.vo.AboardFileVO;
import com.kh.portfolio.board.vo.AboardVO;
import com.kh.portfolio.board.vo.BoardCategoryVO;

public interface AboardDAO {

	//카테고리 읽어오기
	List<BoardCategoryVO> getCategory2();
	
	//게시글 작성
	int write2(AboardVO aboardVO);
	int filewrite2(AboardFileVO aboardFileVO);
	//게시글수정
	int modify2(AboardVO aboardVO);
	
	//게시글 삭제
	int delete2(String abnum);
	//첨부파일 1건 삭제
	int fileDelete2(String fid);
	//게시글 첨부파일 전체 삭제
	int filesDelete2(String abnum);
	
//게시글보기
	AboardVO view2(String abnum);
	List<AboardFileVO> fileviews2(String abnum);
	//조회수 1증가
	int updateHit2(String abnum);
	
	//게시글 목록
//1)전체
	List<AboardVO> list2();
	//2)검색어 없는 게시글페이징
	List<AboardVO> list2( int startRec, int endRec);	
	//3)검색어 있는 게시글검색(전체,제목,내용,작성자ID,별칭)
	List<AboardVO> list2( int startRec, int endRec, String searchType,String keyword);
	//총 레코드수
	int totalRecordCount2(String searchType,String keyword);	

	//게시글 답글작성
	int reply2(AboardVO aboardVO);
	//첨부파일 조회
	AboardFileVO fileView2(String fid);
}

