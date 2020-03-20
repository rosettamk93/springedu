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
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.kh.portfolio.member.dao.MemberDAOImplJDBCTest;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class UpdateJdbcTemplateTest {
	private final static Logger logger
	= LoggerFactory.getLogger(MemberDAOImplJDBCTest.class);

	@Inject
	JdbcTemplate jt;
	
	@Test
	@Disabled
	void update() {
		StringBuffer sql = new StringBuffer();
		sql.append(" update student set name= ?, kor= ?, eng= ?, mat= ? where id=? ");
		int cnt = jt.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, "홍개리");
				pstmt.setInt(2, 80);
				pstmt.setInt(3, 80);
				pstmt.setInt(4, 80);
				pstmt.setString(5, "id0");
				return pstmt;
			}
		});
		assertEquals(1, cnt);
	}
	@Test
	@Disabled
	void update2() {
		StringBuffer sql = new StringBuffer();
		sql.append(" update student set name='홍철이', kor= 99, eng=99,mat=99 where id='id0' ");
		
		int cnt = jt.update(sql.toString());
		assertEquals(1, cnt);
	}
	@Test
	@Disabled
	void update3() {
		StringBuffer sql = new StringBuffer();
		sql.append(" update student set name = ?, kor = ?, eng = ?, mat = ? where id= ? ");
		
		int cnt = jt.update(sql.toString(), "홍수몬", 77, 77, 77, "id0");
		assertEquals(1, cnt);
	}
	@Test
	@Disabled
	void update4() {
		StringBuffer sql = new StringBuffer();
		sql.append(" update student set name = ?, kor = ?, eng = ?, mat = ? where id = ? ");
		
		int cnt = jt.update(sql.toString(), new PreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps) throws SQLException {
				ps.setString(1, "홍기리");
				ps.setInt(2, 88);
				ps.setInt(3, 88);
				ps.setInt(4, 88);
				ps.setString(5, "id0");
			}
		});
		assertEquals(1, cnt);
	}
	@Test
	void update5() {
		StringBuffer sql = new StringBuffer();
		sql.append(" update student set name = ?, kor = ?, eng = ?, mat = ? where id = ? ");
		
		int cnt = jt.update(sql.toString(),
							new Object[] {"홍당무", 100, 100, 100, "id0"},
							new int[] {Types.VARCHAR, Types.INTEGER, Types.INTEGER, Types.INTEGER, Types.VARCHAR}
				);
		assertEquals(1, cnt);
	}
}
