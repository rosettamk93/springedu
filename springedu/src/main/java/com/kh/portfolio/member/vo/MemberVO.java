package com.kh.portfolio.member.vo;

import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Entity
@Data
public class MemberVO {
	@NotNull(message="이메일을 입력하세요.")
	@Pattern(regexp = "^\\w+@\\w+\\.\\w+(\\.\\w+)?$", message = "이메일양식이 잘못되었습니다. ex)aaa.@bbb.com" )
	private String id;				// ID	아이디(이메일)	X			VARCHAR2
	@NotNull(message="비밀번호를 입력하세요.")
	@Size(min = 6, max = 10, message = "비밀번호는 6~10자리로 입력하세요.")
	private String pw;				//PW	비밀번호				VARCHAR2
	@NotNull(message="전화번호를 입력하세요(010-0000-0000)")
	@Pattern(regexp = "^\\d{3}-\\d{3,4}-\\d{4}$", message = "전화번호가 잘못되었습니다. 예)010-1234-5678")
	private String tel; 			//TEL	전화번호				VARCHAR2
	@NotNull(message="닉네임을 입력하세요.")
	@Size(min = 3, max = 10, message = "닉네임은 3~10자리로 입력하세요.")
	private String nickname;	//NICKNAME	별칭				VARCHAR2
	
	private String gender;		//GENDER	성별('남','여')				CHAR
//	@NotNull
//	@Pattern(regexp = "^[^0]+$", message = "선택하세요!")
	private String region;		//REGION	지역				VARCHAR2
	private String region1;
	private String region2;
	private String region3;
	
	@NotNull
//	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date birth;				//BIRTH	생년월일('yyyymmdd')				DATE
	private Timestamp cdate;	//CDATE	생성일시		systimestamp		timestamp
	private Timestamp udate;	//UDATE	변경일시		systimestamp		timestamp
	private int admin;
}
