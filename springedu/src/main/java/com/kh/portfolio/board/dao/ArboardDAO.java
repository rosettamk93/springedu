package com.kh.portfolio.board.dao;

import java.util.List;

import com.kh.portfolio.board.vo.ArboardVO;
import com.kh.portfolio.board.vo.AvoteVO;

public interface ArboardDAO {

	//댓 작성
	int write(ArboardVO arboardVO);
	
	//댓 목록
	List<ArboardVO> list(int arbnum, int startRec, int endRec);
	
	//댓 수정
	int modify(ArboardVO arboardVO);
	
	//댓삭
	int delete(String arnum);
	
	//대댓 작
	int reply(ArboardVO arboardVO);
	
	//이전댓 step 업뎃
	int updateStep(int argroup, int arstep);
	
	//댓정보 읽어와
	ArboardVO replyView(long arnum);
	
	//댓글 업다운
	//투표여부
	int checkVote(AvoteVO avoteVO);
	//없음 추가
	int insertVote(AvoteVO avoteVO);
	//있음 변경
	int updateVote(AvoteVO avoteVO);
	//없음 추or변
	int mergeVote(AvoteVO avoteVO);
	
	//총계
	int replyTotalRec(String arbnum);
	
	
}
