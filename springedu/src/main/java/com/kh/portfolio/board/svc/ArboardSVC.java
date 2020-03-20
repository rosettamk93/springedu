package com.kh.portfolio.board.svc;

import java.util.List;

import com.kh.portfolio.board.vo.ArboardVO;
import com.kh.portfolio.board.vo.AvoteVO;

public interface ArboardSVC {

	//댓작
	int write(ArboardVO arboardVO);
	
	//댓목
	List<ArboardVO> list(int arbnum, int startRec, int endRec);
	
	//댓수정
	int modify(ArboardVO arboardVO);
	
	//댓삭
	int delete(String arnum);
	
	//대댓작
	int reply(ArboardVO arboardVO);
	
	//댓호불
	//쳌여부
	int checkVote(AvoteVO avoteVO);
	
	int mergeVote(AvoteVO avoteVO);
	int replyTotalRec(String arbnum);
}
