package com.kh.portfolio.board.svc;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.portfolio.board.dao.FboardDAO;
import com.kh.portfolio.board.vo.FboardFileVO;
import com.kh.portfolio.board.vo.FboardVO;
import com.kh.portfolio.common.FindCriteria;
import com.kh.portfolio.common.PageCriteria;
import com.kh.portfolio.common.RecordCriteria;

@Service
public class FboardSVCImpl implements FboardSVC {

	public static final Logger logger 
	= LoggerFactory.getLogger(FboardSVCImpl.class);
	
	@Inject
	FboardDAO fboardDAO;
	
	//상품등록
	@Transactional
	@Override
	public int write4(FboardVO fboardVO) {
		//1상품등록
		int cnt = fboardDAO.write4(fboardVO);
		
		logger.info("첨부갯수"+fboardVO.getFilesf().size());
		if(fboardVO.getFilesf() != null && fboardVO.getFilesf().size() > 0)
			fileWritef(fboardVO.getFilesf(), fboardVO.getFnum());
		 return cnt;
	}
private void fileWritef(List<MultipartFile> files, long fnum) {
	for(MultipartFile file : files) { 
		try {
			logger.info("파일첨부:"+file.getOriginalFilename());
			FboardFileVO fboardFileVO = new FboardFileVO();
			fboardFileVO.setFnum(fnum);
			fboardFileVO.setFname(file.getOriginalFilename());
			fboardFileVO.setFsize(file.getSize());
			fboardFileVO.setFtype(file.getContentType());
			fboardFileVO.setFdata(file.getBytes());
			if(file.getSize() > 0) {
				fboardDAO.fileWritef(fboardFileVO);
			}
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
}
	//수정
  @Transactional
	@Override
	public int modify4(FboardVO fboardVO) {
  	int cnt = fboardDAO.modify4(fboardVO);
  	if(fboardVO.getFilesf() != null && fboardVO.getFilesf().size() > 0) {
  		fileWritef(fboardVO.getFilesf(), fboardVO.getFnum());
  	}
		return cnt;
	}

  //삭제
  @Transactional
	@Override
	public int delete4(String fnum) {
  	int cnt = 0;
  	fboardDAO.filesDeletef(fnum);
  	cnt = fboardDAO.delete4(fnum);
		return cnt;
	}
  
  //첨부파일 1개삭제
	@Override
	public int fileDeletef(String fid) {
		return fboardDAO.fileDeletef(fid);
	}

	//상품조회
	@Override
	public Map<String, Object> view4(String fnum) {
		//1 상품가져오기
		FboardVO fboardVO = fboardDAO.view4(fnum);
		//2 사진가져오기
		List<FboardFileVO> filesf = fboardDAO.fileViewsf(fnum);
		
		Map<String,Object> map = new HashMap<>();
		map.put("fboard", fboardVO);
		if(filesf != null && filesf.size() >0) {
			map.put("filesf", filesf);
		}
		
		return map;
	}
	//게시글목록
	//전체
	@Override
	public List<FboardVO> listf() {
		return fboardDAO.listf();
	}
	//2검색어없는 페이징
	@Override
	public List<FboardVO> list(int startRec, int endRec) {
		return null;
	}
	//검색어있는 검색
	@Override
	public List<FboardVO> list(String reqPage, String searchType, String keyword) {
		
		int l_reqPage = 0;
		
		//정보 없음 1
		if(reqPage == null || reqPage.trim().isEmpty()) {
			l_reqPage =  1;
		}else {
			l_reqPage = Integer.parseInt(reqPage);
		}
		
		RecordCriteria recordCriteria = new RecordCriteria(l_reqPage);
		
		return fboardDAO.listf(
				recordCriteria.getStartRec(),
				recordCriteria.getEndRec(),
				searchType, keyword);
	}

	//페이지 컨
	@Override
	public PageCriteria getPageCriteria(String reqPage, String searchType, String keyword) {
		
		PageCriteria 		pc = null;					//한페이지에 보여줄 페이징 계산하는 클래스
		FindCriteria 		fc = null;					//PageCriteira + 검색타입, 검색어		
		
		int totalRec = 0;										//전체레코드 수
		
		int l_reqPage = 0;
		
		//요청 페이지 정보가 없으면 1로 초기화
		if(reqPage == null || reqPage.trim().isEmpty()) {
			l_reqPage =  1;
		}else {
			l_reqPage = Integer.parseInt(reqPage);
		}
			
		totalRec = fboardDAO.totalRecordCount(searchType, keyword);
		
		fc = new FindCriteria(l_reqPage, searchType, keyword);
		pc = new PageCriteria(fc, totalRec);
		logger.info("totalRec:"+totalRec, searchType, keyword);
		logger.info("fc:"+fc.toString());
		logger.info("rc:"+((RecordCriteria)fc).toString());
		logger.info("pc:"+pc.toString());
		return pc;
	}

	@Override
	public FboardFileVO fileViewf(String fid) {
	return fboardDAO.fileviewf(fid);
	}

}
