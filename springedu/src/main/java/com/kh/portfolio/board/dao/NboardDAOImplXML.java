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

import com.kh.portfolio.board.vo.BoardCategoryVO;
import com.kh.portfolio.board.vo.NboardVO;

@Repository
public class NboardDAOImplXML implements NboardDAO {

	private static final Logger logger
		= LoggerFactory.getLogger(NboardDAOImplXML.class);
	
	@Inject
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<BoardCategoryVO> getCategory3() {
		return sqlSession.selectList("mappers.NboardDAO-mapper.getCategory3" );
	}

	//게시글작성
	@Override
	public int write3(NboardVO nboardVO) {
		return sqlSession.insert("mappers.NboardDAO-mapper.write3", nboardVO);
	}

	//게시글수정
	@Override
	public int modify3(NboardVO nboardVO) {
		return sqlSession.update("mappers.NboardDAO-mapper.modify3", nboardVO);
	}
	//게시글 삭제
	@Override
	public int delete3(String nbnum) {
		return sqlSession.delete("mappers.NboardDAO-mapper.delete3", Long.valueOf(nbnum));
	}

	//게시글조회
	@Override
	public NboardVO view3(String nbnum) {
		return sqlSession.selectOne("mappers.NboardDAO-mapper.view3", Long.valueOf(nbnum));
	}
	//조회수증가
	@Override
	public int updateHit3(String nbnum) {
		return sqlSession.update("mappers.NboardDAO-mapper.updateHit3", Long.valueOf(nbnum));
	}
	//게시글목록 
	//1)전체
	@Override
	public List<NboardVO> list3() {
		return sqlSession.selectList("mappers.NboardDAO-mapper.list3");
	}
	//2)검색어x 페이징
	@Override
	public List<NboardVO> list3(int startRec, int endRec) {
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		return sqlSession.selectList("mappers.NboardDAO-mapper.list4");
	}
	//3)검색어o 페이징
	@Override
	public List<NboardVO> list3(int startRec, int endRec, String searchType, String keyword) {
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		map.put("searchType",searchType);
		if(keyword != null) {
			map.put("list",Arrays.asList(keyword.split("\\s+")));
		}
		map.put("andor","or");
		return sqlSession.selectList("mappers.NboardDAO-mapper.list5", map);
	}
//총레코드수
	@Override
	public int totalRecordCount3(String searchType, String keyword) {
		logger.info("keyword :" + keyword);
		Map<String,Object> map = new HashMap<>();
		map.put("searchType",searchType);
		
		if(keyword != null) {
			map.put("list",Arrays.asList(keyword.split("\\s+")));
		}
		map.put("andor","or");
		logger.info("keyword2 :" + map.get("list"));
		return sqlSession.selectOne("mappers.NboardDAO-mapper.totalRecordCount3",map);
	}

}
