package com.kh.portfolio.board.svc;

import java.util.List;

import javax.inject.Inject;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kh.portfolio.board.dao.ArboardDAO;
import com.kh.portfolio.board.vo.ArboardVO;
import com.kh.portfolio.board.vo.AvoteVO;

@Service
public class ArboardSVCImpl implements ArboardSVC {

	final static Logger logger 
	= LoggerFactory.getLogger(ArboardSVCImpl.class);
	
	@Inject
	ArboardDAO arboardDAO;
	
	//댓작
	@Override
	public int write(ArboardVO arboardVO) {
		
		return arboardDAO.write(arboardVO);
	}
	//댓목
	@Override
	public List<ArboardVO> list(int arbnum, int startRec, int endRec) {
		
		return arboardDAO.list(arbnum, startRec, endRec);
	}
	//댓수정
	@Override
	public int modify(ArboardVO arboardVO) {

		return arboardDAO.modify(arboardVO);
	}
	//댓삭
	@Override
	public int delete(String arnum) {

		return arboardDAO.delete(arnum);
	}
	//대댓작
	@Transactional
	@Override
	public int reply(ArboardVO arboardVO) {
		//부모댓 정보 읽어
		ArboardVO parentArboardVO = arboardDAO.replyView(arboardVO.getAprnum());
		//이전뎃 업뎃
		arboardDAO.updateStep(parentArboardVO.getArgroup(), parentArboardVO.getArstep());
		//3)대댓작
		arboardVO.setArbnum(parentArboardVO.getArbnum());
		arboardVO.setArgroup(parentArboardVO.getArgroup());
		arboardVO.setArstep(parentArboardVO.getArstep());
		arboardVO.setArindent(parentArboardVO.getArindent());
		//부모댓아디
		arboardVO.setAprid(parentArboardVO.getArid());
		//부모댓별
		arboardVO.setAprnickname(parentArboardVO.getArnickname());
		return arboardDAO.reply(arboardVO);
	}
	//댓호.비호
	//투표여부
	@Transactional
	@Override
	public int checkVote(AvoteVO avoteVO) {
		int cnt = 0;
		//이력있?
		if(arboardDAO.checkVote(avoteVO) ==1) {
			cnt = arboardDAO.updateVote(avoteVO);
		}else {
			cnt = arboardDAO.insertVote(avoteVO);
		}
		return cnt;
	}
	//이력업? 추or변
	@Override
	public int mergeVote(AvoteVO avoteVO) {

	return arboardDAO.mergeVote(avoteVO);
	}

	@Override
	public int replyTotalRec(String arbnum) {

		return arboardDAO.replyTotalRec(arbnum);
	}

}
