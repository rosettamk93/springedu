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

import com.kh.portfolio.board.vo.AboardFileVO;
import com.kh.portfolio.board.vo.AboardVO;
import com.kh.portfolio.board.vo.BoardCategoryVO;


@Repository
public class AboardDAOImplXML implements AboardDAO {

	private static final Logger logger
		= LoggerFactory.getLogger(AboardDAOImplXML.class);
	
	@Inject
	SqlSessionTemplate sqlSession;
	
	//카테고리 읽어오기
	@Override
	public List<BoardCategoryVO> getCategory2() {

		return sqlSession.selectList("mappers.AboardDAO-mapper.getCategory2");
	}

	//게시글작성
	@Override
	public int write2(AboardVO aboardVO) {
		return sqlSession.insert("mappers.AboardDAO-mapper.write2", aboardVO);
	}
	//첨부파일 저장
	@Override
	public int filewrite2(AboardFileVO aboardFileVO) {
		return sqlSession.insert("mappers.AboardDAO-mapper.filewrite2", aboardFileVO);
	}

	@Override
	public int modify2(AboardVO aboardVO) {

		return sqlSession.update("mappers.AboardDAO-mapper.modify2", aboardVO);
	}

	@Override
	public int delete2(String abnum) {

		return sqlSession.delete("mappers.AboardDAO-mapper.delete2", Long.valueOf(abnum));
	}

	@Override
	public int fileDelete2(String fid) {

		return sqlSession.delete("mappers.AboardDAO-mapper.fileDelete2", Long.valueOf(fid));
	}

	@Override
	public int filesDelete2(String abnum) {

		return sqlSession.delete("mappers.AboardDAO-mapper.filesDelete2", Long.valueOf(abnum));
	}

	@Override
	public AboardVO view2(String abnum) {

		return sqlSession.selectOne("mappers.AboardDAO-mapper.view2",Long.valueOf(abnum));
	}

	@Override
	public List<AboardFileVO> fileviews2(String abnum) {

		return sqlSession.selectList("mappers.AboardDAO-mapper.fileviews2", Long.valueOf(abnum));
	}

	@Override
	public int updateHit2(String abnum) {

		return sqlSession.update("mappers.AboardDAO-mapper.updateHit2", Long.valueOf(abnum));
	}

	@Override
	public List<AboardVO> list2() {
		return sqlSession.selectList("mappers.AboardDAO-mapper.list2");
	}

	@Override
	public List<AboardVO> list2(int startRec, int endRec) {
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		return sqlSession.selectList("mappers.AboardDAO-mapper.list3");
	}

	@Override
	public List<AboardVO> list2(int startRec, int endRec, String searchType, String keyword) {
		Map<String,Object> map = new HashMap<>();
		map.put("startRec", startRec);
		map.put("endRec", endRec);
		map.put("searchType",searchType);
		if(keyword != null) {
			map.put("list",Arrays.asList(keyword.split("\\s+")));
		}
		map.put("andor","or");
		return sqlSession.selectList("mappers.AboardDAO-mapper.list4" , map);
	}

	@Override
	public int totalRecordCount2(String searchType, String keyword) {
		logger.info("keyword :" + keyword);
		Map<String,Object> map = new HashMap<>();
		map.put("searchType",searchType);
		
		if(keyword != null) {
			map.put("list",Arrays.asList(keyword.split("\\s+")));
		}
		map.put("andor","or");
		logger.info("keyword2 :" + map.get("list"));
		return sqlSession.selectOne("mappers.AboardDAO-mapper.totalRecordCount2",map);
	}

	@Override
	public int reply2(AboardVO aboardVO) {
		//1) 이전답글 step
		updateStep2(aboardVO.getAbgroup(), aboardVO.getAbstep());
		//2)답글달기
		return sqlSession.insert("mappers.AboardDAO-mapper.reply2", aboardVO);
	}
	
	private int updateStep2(int abgroup, int abstep) {
		Map<String,Object> map = new HashMap<>();
		map.put("abgroup", abgroup);
		map.put("abstep",abstep);
		return sqlSession.update("mappers.AboardDAO-mapper.updateStep2", map);
	}

	@Override
	public AboardFileVO fileView2(String fid) {

		return sqlSession.selectOne("mappers.AboardDAO-mapper.fileView2", Long.valueOf(fid));
	}

}
