package com.kh.portfolio.member.dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.portfolio.member.vo.MemberVO;

@Repository
public class MemberDAOImplXML implements MemberDAO {
	
	private static final Logger logger 
		= LoggerFactory.getLogger(MemberDAOImplXML.class);
	
	@Inject
	private SqlSession sqlSession;
	
	//회원등록
	@Override
	public int joinMember(MemberVO memberVO) {
		logger.info("MemberDAOImplXML.joinMember(MemberVO memberVO) 호출됨!");
		return sqlSession.insert("mappers.MemberDAO-mapper.joinMember",memberVO);
	}
	//회원 수정
	@Override
	public int modifyMember(MemberVO memberVO) {
		logger.info("MemberDAOImplXML.modifyMember(MemberVO memberVO) 호출됨!");
		return sqlSession.update("mappers.MemberDAO-mapper.modifyMember", memberVO);
	}
	//회원 전체조회
	@Override
	public List<MemberVO> selectAllMember() {
		logger.info("MemberDAOImplXML.selectAllMember() 호출됨!");		
		return sqlSession.selectList("mappers.MemberDAO-mapper.selectAllMember");
	}
	//회원 개별조회
	@Override
	public MemberVO selectMember(String id) {
		logger.info("MemberDAOImplXML.selectMember(String id) 호출됨!");	
		return sqlSession.selectOne("mappers.MemberDAO-mapper.selectMember", id);
	}
	//회원 탈퇴
	@Override
	public int outMember(String id, String pw) {
		logger.info("MemberDAOImplXML.outMember(String id, String pw) 호출됨!");	
		Map<String,String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		return sqlSession.delete("mappers.MemberDAO-mapper.outMember", map);
	}
	//로그인
	@Override
	public MemberVO loginMember(String id, String pw) {
		logger.info("MemberDAOImplXML.loginMember(String id, String pw) 호출됨!");
		MemberVO memberVO = new MemberVO();
		memberVO.setId(id);
		memberVO.setPw(pw);
		return sqlSession.selectOne("mappers.MemberDAO-mapper.loginMember", memberVO);
	}
	//아이디 찾기
	@Override
	public String findID(String tel, Date birth) {
		logger.info("MemberDAOImplXML.findID(String tel, Date birth) 호출됨!");
		MemberVO memberVO = new MemberVO();
		memberVO.setTel(tel);
		memberVO.setBirth(birth);		
		return sqlSession.selectOne("mappers.MemberDAO-mapper.findID", memberVO);
	}
	//비밀번호 변경
	@Override
	public int changePW(String id, String pw) {
		logger.info("MemberDAOImplXML.changePW(String tel, Date pw) 호출됨!");
		MemberVO memberVO = new MemberVO();
		memberVO.setId(id);
		memberVO.setPw(pw);			
		return sqlSession.update("mappers.MemberDAO-mapper.changePW", memberVO);
	}
	//비밀번호 대상 찾기
	@Override
	public int findPW(MemberVO memberVO) {
		logger.info("MemberDAOImplXML.findPW(MemberVO memberVO) 호출됨!");
		return sqlSession.selectOne("mappers.MemberDAO-mapper.findPW", memberVO);
	}
}









