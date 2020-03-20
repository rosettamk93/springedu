package com.kh.portfolio.board.svc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kh.portfolio.board.dao.NboardDAO;
import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.NboardVO;
import com.kh.portfolio.common.FindCriteria;
import com.kh.portfolio.common.PageCriteria;
import com.kh.portfolio.common.RecordCriteria;

@Service
public class NboardSVCImpl implements NboardSVC {

	public static final Logger logger
	= LoggerFactory.getLogger(NboardSVCImpl.class);
	
	@Inject
	NboardDAO nboardDAO;
	
	//카테고리 읽어오기
	@Override
	public List<BoardCategoryVO> getCategory() {
		return nboardDAO.getCategory3();
	}
//게시글작성
	@Transactional
	@Override
	public int write3(NboardVO nboardVO) {
		//게시글작성
		int cnt = nboardDAO.write3(nboardVO);
		
		return cnt;
	}
//게시글수정
	@Override
	public int modify3(NboardVO nboardVO) {
		//수정
		int cnt = nboardDAO.modify3(nboardVO);
		return cnt;
	}
//게시글삭제
	@Transactional
	@Override
	public int delete3(String nbnum) {
		int cnt = 0;
		cnt = nboardDAO.delete3(nbnum);
		return cnt;
	}
//게시물보기
	@Transactional
	@Override
	public Map<String, Object> view3(String nbnum) {
		//게시글가져오기
		NboardVO nboardVO = nboardDAO.view3(nbnum);
		nboardDAO.updateHit3(nbnum);
		
		Map<String,Object> map = new HashMap<>();
		map.put("nboard", nboardVO);
		return map;
	}

	//게시글목록
	//1전체
	@Override
	public List<NboardVO> list3() {
		return nboardDAO.list3();
	}
//검색어x페이징
	@Override
	public List<NboardVO> list3(int startRec, int endRec) {
		// TODO Auto-generated method stub
		return null;
	}
//검색어o검색
	@Override
	public List<NboardVO> list3(String reqPage, String searchType, String keyword) {
int l_reqPage2 = 0;
		
		//요청 페이지 정보 없으면 1로 초기화
		if(reqPage == null || reqPage.trim().isEmpty()) {
			l_reqPage2 =  1;
		}else {
			l_reqPage2 = Integer.parseInt(reqPage);
		}
		
		RecordCriteria recordCriteria = new RecordCriteria(l_reqPage2);
		
			return nboardDAO.list3(
					recordCriteria.getStartRec(),
					recordCriteria.getEndRec(),
					searchType,keyword);
	}
	//페이지제어
	@Override
	public PageCriteria getPageCriteria(String reqPage, String searchType, String keyword) {
		PageCriteria 		pc = null;					//한페이지에 보여줄 페이징 계산하는 클래스
		FindCriteria 		fc = null;					//PageCriteira + 검색타입, 검색어		
		
		int totalRec = 0;									//전체레코드 수
				
		int l_reqPage2 = 0;
		
		//요청 페이지 정보가 없으면 1로 초기화
		if(reqPage == null || reqPage.trim().isEmpty()) {
			l_reqPage2 =  1;
		}else {
			l_reqPage2 = Integer.parseInt(reqPage);
		}
		
		totalRec = nboardDAO.totalRecordCount3(searchType, keyword);
		
		fc = new FindCriteria(l_reqPage2, searchType, keyword);
		pc = new PageCriteria(fc, totalRec);
		logger.info("totalRec:"+totalRec, searchType, keyword);
		logger.info("fc:"+fc.toString());
		logger.info("rc:"+((RecordCriteria)fc).toString());
		logger.info("pc:"+pc.toString());
		return pc;
	}

}
