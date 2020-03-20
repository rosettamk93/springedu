package com.kh.portfolio.member.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.kh.portfolio.member.vo.MemberVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MemberDAOImplJDBCTest {
	private final static Logger logger
		= LoggerFactory.getLogger(MemberDAOImplJDBCTest.class);
	
	@Inject
	@Qualifier("memberDAOImplJDBC")
	MemberDAO memberDAO;
	
	@Test
	@DisplayName("회원등록")
	@Disabled
	void memberInsert() {
		MemberVO memberVO = new MemberVO();
		
//		sql.append("INSERT INTO member ( id, pw, tel, nickname, gender, region, birth, cdate) ");
//		sql.append("VALUES (?,?,?,?,?,?,?,sysdate) ");
		
		memberVO.setId("test2@naver.com");
		memberVO.setPw("admin1234");
		memberVO.setTel("010-1234-5678");
		memberVO.setNickname("홍길동");
		memberVO.setGender("남");
		memberVO.setRegion("울산");
		memberVO.setBirth(java.sql.Date.valueOf("2020-02-01"));
		int cnt = memberDAO.joinMember(memberVO);
		assertEquals(1, cnt);
	}
	
	@Test
	@DisplayName("회원수정")
	@Disabled
	void joinMember() {
		MemberVO memberVO = new MemberVO();
		memberVO.setId("test2@naver.com");
		memberVO.setTel("010-8888-9999");
		memberVO.setNickname("관리자2");
		memberVO.setGender("여");
		memberVO.setRegion("부산");
		memberVO.setBirth(java.sql.Date.valueOf("2020-02-01"));		
		int cnt = memberDAO.modifyMember(memberVO);
		assertEquals(1, cnt);
	}
	@Test
	@DisplayName("회원 전체조회")
	void selectAllMember() {
		List<MemberVO> list = memberDAO.selectAllMember();
		assertNotNull(list);
		logger.info(list.toString());
	}
	@Test
	@DisplayName("회원 개별조회")
	void selectMember() {
		MemberVO memberVO = memberDAO.selectMember("test@test.com");
		assertEquals("test@test.com", memberVO.getId());
		logger.info(memberVO.toString());
	}
	@Test
	@DisplayName("회원 탈퇴")
	@Disabled
	void outMember() {
		int cnt = memberDAO.outMember("test2@naver.com", "admin1234");
		assertEquals(1,cnt);
	}
	@Test
	@DisplayName("로그인")
	void loginMember() {
		MemberVO memberVO = memberDAO.loginMember("test@test.com", "admin1234");
		assertEquals("test@test.com", memberVO.getId());
		logger.info(memberVO.toString());
	}
	@Test
	@DisplayName("아이디 찾기")
	@Disabled
	void findID() {
		String id = memberDAO.findID("010-1234-5678", java.sql.Date.valueOf("2020-02-01"));
		assertEquals("test@naver.com", id);
	}
	@Test
	@DisplayName("비밀번호 변경")
	@Disabled
	void changePW() {
		int cnt = memberDAO.changePW("test@naver.com", "admin12345");
		assertEquals(1, cnt);
	}
	@Test
	@DisplayName("비밀번호 변경 대상 찾기")
	void findPW() {
		MemberVO memberVO = new MemberVO();
		memberVO.setId("test@test.com");
		memberVO.setTel("010-1234-5678");
		memberVO.setBirth(java.sql.Date.valueOf("2020-02-01"));
		int cnt = memberDAO.findPW(memberVO);
		assertEquals(1, cnt);
	}
}