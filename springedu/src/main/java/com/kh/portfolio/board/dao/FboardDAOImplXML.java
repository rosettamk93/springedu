package com.kh.portfolio.board.dao;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.board.vo.FboardFileVO;
import com.kh.portfolio.board.vo.FboardVO;

@Repository
public class FboardDAOImplXML implements FboardDAO {
	private static final Logger logger 
	= LoggerFactory.getLogger(FboardDAOImplXML.class);
	
	@Inject
	SqlSessionTemplate sqlSession;
	
	//상품등록
	@Override
	public int write4(FboardVO fboardVO) {
		return sqlSession.insert("mappers.FboardDAO-mapper.write4", fboardVO);
	}

	//사진저장
	@Override
	public int fileWritef(FboardFileVO fboardFileVO) {
		return sqlSession.insert("mappers.FboardDAO-mapper.fileWritef", fboardFileVO);
	}

	//상품수정
	@Override
	public int modify4(FboardVO fboardVO) {
		return sqlSession.update("mappers.FboardDAO-mapper.modify4", fboardVO);
	}

	//상품삭제
	@Override
	public int delete4(String fnum) {
		return sqlSession.delete("mappers.FboardDAO-mapper.delete4", Long.valueOf(fnum));
	}
	//사진 1개삭제
	@Override
	public int fileDeletef(String fid) {
		return sqlSession.delete("mappers.FboardDAO-mapper.fileDeletef", Long.valueOf(fid));
	}
	//게시글 첨부파일 전체 삭제
	@Override
	public int filesDeletef(String fnum) {
		return sqlSession.delete("mappers.FboardDAO-mapper.filesDeletef", Long.valueOf(fnum));
	}

	//상품보기
	@Override
	public FboardVO view4(String fnum) {
		return sqlSession.selectOne("mappers.FboardDAO-mapper.view4", Long.valueOf(fnum));
	}

	@Override
	public List<FboardFileVO> fileViewsf(String fnum) {
		return sqlSession.selectList("mappers.FboardDAO-mapper.fileViewsf", Long.valueOf(fnum));
	}
	//게시글목록
	//1)전체
	@Override
	public List<FboardVO> listf() {
		return sqlSession.selectList("mappers.FboardDAO-mapper.listf1");
	}
	//2)검색어 없는 게시글페이징
	@Override
	public List<FboardVO> listf(int startRec, int endRec) {
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		return sqlSession.selectList("mappers.FboardDAO-mapper.listf2", map);
	}
	//3)검색어 있는 게시글검색(전체,제목,내용,작성자ID,별칭)
	@Override
	public List<FboardVO> listf(int startRec, int endRec, String searchType, String keyword) {
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		map.put("searchType",searchType);
		if(keyword != null) {
			map.put("list",Arrays.asList(keyword.split("\\s+")));
		}
		map.put("andor","or");
		return sqlSession.selectList("mappers.FboardDAO-mapper.listf3", map);
	}

	//총 레코드수
	@Override
	public int totalRecordCount(String searchType, String keyword) {
		logger.info("keyword :" + keyword);
		Map<String,Object> map = new HashMap<>();
		map.put("searchType",searchType);
		
		if(keyword != null) {
			map.put("list",Arrays.asList(keyword.split("\\s+")));
		}
		map.put("andor","or");
		logger.info("keyword2 :" + map.get("list"));
		return sqlSession.selectOne("mappers.FboardDAO-mapper.totalRecordCount", map);
	}
	//첨부파일조회
	@Override
	public FboardFileVO fileviewf(String fid) {
		return sqlSession.selectOne("mappers.FboardDAO-mapper.fileviewf",  Long.valueOf(fid));
	}

}
