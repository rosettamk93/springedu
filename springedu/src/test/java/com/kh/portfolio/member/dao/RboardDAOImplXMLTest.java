package com.kh.portfolio.member.dao;

import javax.inject.Inject;
import javax.inject.Named;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.kh.portfolio.board.dao.RboardDAO;
import com.kh.portfolio.board.vo.VoteVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class RboardDAOImplXMLTest {
	private final static Logger logger
	= LoggerFactory.getLogger(RboardDAOImplXMLTest.class);
	
	@Inject
	RboardDAO rboardDAO;
	
	//투표
	@Test
	@Named("투표")
	public void mergeVote() {
		VoteVO voteVO = new VoteVO();
		voteVO.setRnum(2);
		voteVO.setBnum(110);
		voteVO.setRid("test@test.com");
		voteVO.setVote("2");
		rboardDAO.mergeVote(voteVO);
	}

}













