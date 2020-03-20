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

import com.kh.portfolio.board.dao.AboardDAO;
import com.kh.portfolio.board.vo.AboardVO;
import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.AboardFileVO;
import com.kh.portfolio.common.FindCriteria;
import com.kh.portfolio.common.PageCriteria;
import com.kh.portfolio.common.RecordCriteria;

@Service
public class AboardSVCImpl implements AboardSVC {

	public static final Logger logger
		= LoggerFactory.getLogger(AboardSVCImpl.class);
	
	@Inject
	AboardDAO aboardDAO;
	
	//카테고리 읽어오기
	@Override
	public List<BoardCategoryVO> getCategory() {
		return aboardDAO.getCategory2();
	}
	//게시글작성
	@Transactional
	@Override
	public int write2(AboardVO aboardVO) {
		//1) 게시글 작성
		int cnt = aboardDAO.write2(aboardVO);
		
	//2) bnum 가져오기 => mybatis: selectkey 사용
		
			//3) 첨부파일 있는경우
		logger.info("첨부갯수 : " + aboardVO.getFiles().size());
		if(aboardVO.getFiles() !=null && aboardVO.getFiles().size() > 0) {
			fileWrite2(aboardVO.getFiles(), aboardVO.getAbnum());
		}
		return cnt;
	}
	//첨부파일 저장
	private void fileWrite2(List<MultipartFile> files2, long bnum ) {
		for(MultipartFile file : files2) {
			try {
				logger.info("파일첨부:"+file.getOriginalFilename());
				AboardFileVO aboardFileVO = new AboardFileVO();
			//게시글번호
				aboardFileVO.setAbnum(bnum);
				//첨부파일명
				aboardFileVO.setFname(file.getOriginalFilename());
				//첨부파일 크기
				aboardFileVO.setFsize(file.getSize());
				//첨부파일 타입
				aboardFileVO.setFtype(file.getContentType());
				//첨부파일
				aboardFileVO.setFdata(file.getBytes());
				//첨부파일 저장
				if( file.getSize() > 0) {
					aboardDAO.filewrite2(aboardFileVO);
				}
			}catch(IOException e) {
				e.printStackTrace();
			}
		}
	}
	//게시글 수정
	@Transactional
	@Override
	public int modify2(AboardVO aboardVO) {
		//1) 게시글 수정
		int cnt = aboardDAO.modify2(aboardVO);
		//2) 첨부파일 추가
		if(aboardVO.getFiles() !=null && aboardVO.getFiles().size() > 0) {
			fileWrite2(aboardVO.getFiles(), aboardVO.getAbnum());
		}
		return cnt;
	}
//게시글삭제
	@Transactional
	@Override
	public int delete2(String abnum) {
		int cnt = 0;
		aboardDAO.filesDelete2(abnum);
		cnt = aboardDAO.delete2(abnum);
		return cnt;
	}

	//첨부파일 1건 삭제
	@Override
	public int fileDelete2(String fid) {
		return aboardDAO.fileDelete2(fid);
	}

	//게시물보기
	@Transactional
	@Override
	public Map<String, Object> view2(String abnum) {
		//1) 게시글 가져오기
		AboardVO aboardVO = aboardDAO.view2(abnum);
		//2) 첨부파일 가져오기
		List<AboardFileVO> files2 = aboardDAO.fileviews2(abnum);
		//3) 조회수1증가
		aboardDAO.updateHit2(abnum);
		
		Map<String,Object> map = new HashMap<>();
		map.put("aboard", aboardVO);
		if(files2 != null && files2.size() > 0) {
			map.put("files2", files2);
		}
		return map;
	}
	//게시글목록
	//1)전체
	@Override
	public List<AboardVO> list2() {
		return aboardDAO.list2();
	}
	//2) 검색어 없는 게시글 페이징
	@Override
	public List<AboardVO> list2(int startRec, int endRec) {
		// TODO Auto-generated method stub
		return null;
	}
	//3) 검색어 있는 게시글검색(요청페이지,검색유형,검색어)
	@Override
	public List<AboardVO> list2(String reqPage, String searchType, String keyword) {
		
		int l_reqPage2 = 0;
		
		//요청 페이지 정보 없으면 1로 초기화
		if(reqPage == null || reqPage.trim().isEmpty()) {
			l_reqPage2 =  1;
		}else {
			l_reqPage2 = Integer.parseInt(reqPage);
		}
		
		RecordCriteria recordCriteria = new RecordCriteria(l_reqPage2);
		
		return aboardDAO.list2(
				recordCriteria.getStartRec(),
				recordCriteria.getEndRec(),
				searchType, keyword);
	}

	//페이지 제어
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
		
		totalRec = aboardDAO.totalRecordCount2(searchType, keyword);
		
		fc = new FindCriteria(l_reqPage2, searchType, keyword);
		pc = new PageCriteria(fc, totalRec);
		logger.info("totalRec:"+totalRec, searchType, keyword);
		logger.info("fc:"+fc.toString());
		logger.info("rc:"+((RecordCriteria)fc).toString());
		logger.info("pc:"+pc.toString());
		return pc;
	}

	//게시글답글작성
	@Transactional
	@Override
	public int reply2(AboardVO aboardVO) {
		//1) 게시글 답글 작성
		int cnt = aboardDAO.reply2(aboardVO);
		
	//2) bnum 가져오기 => mybatis: selectkey 사용
		
			//3) 첨부파일 있는경우
		logger.info("첨부갯수:"+aboardVO.getFiles().size());
		if(aboardVO.getFiles() != null && aboardVO .getFiles().size() > 0) {
			fileWrite2(aboardVO.getFiles(), aboardVO.getAbnum());
		}
			return cnt;
	}
	
//첨부파일조회
	@Override
	public AboardFileVO fileview2(String fid) {
		return aboardDAO.fileView2(fid);
	}

	
	
}





