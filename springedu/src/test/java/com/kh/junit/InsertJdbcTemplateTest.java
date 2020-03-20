package com.kh.junit;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;

import javax.inject.Inject;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.kh.portfolio.member.dao.MemberDAOImplJDBCTest;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class InsertJdbcTemplateTest {
	private final static Logger logger
	= LoggerFactory.getLogger(MemberDAOImplJDBCTest.class);
	
	@Inject
	JdbcTemplate jt;
	
	@Test
	@Disabled
	void insert() {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into student(id,name,kor,eng,mat) ");
		sql.append("values(?,?,?,?,?) ");
		
		int cnt = jt.update(new PreparedStatementCreator() {			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1,"id1");
				pstmt.setString(2,"홍길동");
				pstmt.setInt(3,100);
				pstmt.setInt(4,90);
				pstmt.setInt(5,80);
				return pstmt;
			}
		});
		assertEquals(1, cnt);		
	}
	
	@Test
	@Disabled
	void insert2() {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into student(id,name,kor,eng,mat) ");
		sql.append("values('id2','홍길순',90,90,90) ");
		
		int cnt = jt.update(sql.toString());
		assertEquals(1, cnt);	
	}
	
	@Test
	@Disabled
	void insert3() {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into student(id,name,kor,eng,mat) ");
		sql.append("values(?,?,?,?,?) ");
		
		int cnt = jt.update(sql.toString(), "id3","홍길서",80,80,80);
		assertEquals(1, cnt);
	}
	
	@Test
	@Disabled
	void insert4() {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into student(id,name,kor,eng,mat) ");
		sql.append("values(?,?,?,?,?) ");
		
		int cnt = jt.update(sql.toString(), new PreparedStatementSetter() {			
			@Override
			public void setValues(PreparedStatement ps) throws SQLException {
				ps.setString(1,"id4");
				ps.setString(2,"홍길남");
				ps.setInt(3,70);
				ps.setInt(4,90);
				ps.setInt(5,80);				
			}
		});
		assertEquals(1, cnt);
	}
	
	@Test
	@Disabled
	void insert5() {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into student(id,name,kor,eng,mat) ");
		sql.append("values(?,?,?,?,?) ");
		
		int cnt = jt.update(
				sql.toString(), 
				new Object[] {"id5","홍길북",70,70,70}, 
				new int[] {Types.VARCHAR,Types.VARCHAR,Types.INTEGER,Types.INTEGER,Types.INTEGER}
		);
		assertEquals(1, cnt);
	}
	
//	@Test
//	void insert6() {
//		StringBuffer sql = new StringBuffer();
//		sql.append("insert into student(id,name,kor,eng,mat) ");
//		sql.append("values(?,?,?,?,?) ");
//		KeyHolder keyHolder = new GeneratedKeyHolder();
//		int cnt = jt.update(new PreparedStatementCreator() {
//			
//			@Override
//			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
//				PreparedStatement pstmt = con.prepareStatement(sql.toString());
//				pstmt.setString(1,"id7");
//				pstmt.setString(2,"홍길동");
//				pstmt.setInt(3,100);
//				pstmt.setInt(4,90);
//				pstmt.setInt(5,80);
//				return pstmt;
//			}
//		},
//			keyHolder
//		);
//		logger.info("keyHolder:"+keyHolder.getKey());
//		assertEquals(1, cnt);		
//	}
}






