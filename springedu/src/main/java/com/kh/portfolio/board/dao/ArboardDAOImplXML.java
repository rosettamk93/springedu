package com.kh.portfolio.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.board.vo.ArboardVO;
import com.kh.portfolio.board.vo.AvoteVO;

@Repository
public class ArboardDAOImplXML implements ArboardDAO {

	final private static Logger logger
	= LoggerFactory.getLogger(ArboardDAOImplXML.class);
	
	@Inject
	SqlSessionTemplate sqlSession;
	
	//댓작
	@Override
	public int write(ArboardVO arboardVO) {

		return sqlSession.insert("mappers.ArboardDAO-mapper.write", arboardVO);
	}

	//댓목
	@Override
	public List<ArboardVO> list(int arbnum, int startRec, int endRec) {
		Map<String, Object> map = new HashMap<>();
		map.put("arbnum",arbnum);
		map.put("startRec",startRec);
		map.put("endRec", endRec);
		return sqlSession.selectList("mappers.ArboardDAO-mapper.list", map);
	}
	//댓수정
	@Override
	public int modify(ArboardVO arboardVO) {

		return sqlSession.update("mappers.ArboardDAO-mapper.modify", arboardVO);
	}
	//댓삭
	@Override
	public int delete(String arnum) {

		return sqlSession.delete("mappers.ArboardDAO-mapper.delete", Long.valueOf(arnum));
	}
	//대댓작
	@Override
	public int reply(ArboardVO arboardVO) {
		
		return sqlSession.insert("mappers.ArboardDAO-mapper.reply", arboardVO);
	}
	//step없뎃
	@Override
	public int updateStep(int argroup, int arstep) {
		Map<String,Object> map = new HashMap<>();
		map.put("argroup", argroup);
		map.put("arstep", arstep);
		return sqlSession.update("mappers.ArboardDAO-mapper.updateStep", map);
	}

	//댓정보 일겅줘
	@Override
	public ArboardVO replyView(long arnum) {

		return sqlSession.selectOne("mappers.ArboardDAO-mapper.replyView", arnum);
	}
	
	//댓호,비호
	//투표여부췤 암더 코리안더 쌰부랍ㅈ대랍래ㅏㅂ래ㅏ
	@Override
	public int checkVote(AvoteVO avoteVO) {
		return sqlSession.selectOne("mappers.ArboardDAO-mapper.checkVote", avoteVO);
	}
	//투표이력없? 추가
	@Override
	public int insertVote(AvoteVO avoteVO) {

		return sqlSession.insert("mappers.ArboardDAO-mapper.insertVote", avoteVO);
	}
	//이력있?변
	@Override
	public int updateVote(AvoteVO avoteVO) {

		return sqlSession.update("mappers.ArboardDAO-mapper.updateVOte", avoteVO);
	}
//이력업? 추변
	@Override
	public int mergeVote(AvoteVO avoteVO) {

		return sqlSession.update("mappers.ArboardDAO-mapper.mergeVote", avoteVO);
	}
	//댓총
	@Override
	public int replyTotalRec(String arbnum) {

		return sqlSession.selectOne("mappers.ArboardDAO-mapper.replyTotalRec", Long.valueOf(arbnum));
	}

}
